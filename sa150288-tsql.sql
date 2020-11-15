

CREATE FUNCTION [distanca] (@x1 int , @y1 int , @x2 int , @y2 int )  
  RETURNS decimal(10,3) 
  
AS BEGIN
	
	-- Return the result of the function
	RETURN  SQRT(((@x1 - @x2) * (@x1 - @x2) + (@y1 - @y2) * (@y1 - @y2)));

END
go

CREATE PROCEDURE [planiranjeRute] @kurirUsername nchar(100) , @result int  OUTPUT   
   
 AS BEGIN

	
	declare @kurirAdresaId int 
	declare @regBrVozila nchar(100)
	declare @kapacitetVozila decimal
	declare @idMagacina int = -1
	declare @adrMagacina int
	declare @kursor cursor
	declare @cnt int = 0
	declare @resCnt int = 0
	declare @start int
	
	----kod koji sluzi za uzimanje prvog vozila iz magacina trazenog kurira, takodje dohvata i id magacina----------

	select top 1  @regBrVozila=pv.reg_br, @idMagacina=pv.id_mag, @kapacitetVozila=v.nosivost, @adrMagacina=a.id
	from parkirana_vozila pv
	join vozila v on v.reg_br=pv.reg_br
	join magacini m on m.id=pv.id_mag
	join adrese a on m.id_adresa=a.id
	join gradovi g on g.id=a.id_grad
	where g.naziv in 
		(select g1.naziv from gradovi g1
		join adrese a1 on g1.id=a1.id_grad
		join korisnici k on k.id_adresa=a1.id
		join kuriri kur on k.username=kur.username
		where k.username=@kurirUsername
		 ) 
	order by m.id asc, pv.id asc	
	--print @idMagacina

	if(@idMagacina>-1) 
	begin
		--kreiram voznju, status je 1 (aktivna) po defaultu
		insert into voznje(id_magacin, username, reg_br, curr_adr) values (@idMagacina, @kurirUsername, @regBrVozila, @adrMagacina)
		delete from parkirana_vozila where reg_br=@regBrVozila
		update kuriri set reg_br = @regBrVozila, status=1 where username=@kurirUsername
		
	end
	else 
	begin
		set @result=-1
		return
	end


	print @regBrVozila
--print @idMagacina
--	print @adrMagacina
	-----------------------------------------------------------------------------------------------------
	

	--------------------------------------------------------------------------------------------------------
	---kod koji pravi kursor koji prolazi kroz tabelu paketa iz grada i uzima one koji mogu da stanu u vozilo
	--a njihove idjeve stavlja u  tabelu kuriri_preuzimanje

	
	set @kursor = cursor for
		select i.id, z.tezina
		from isporuke i
		join adrese a on i.id_curr_adresa=a.id
		join gradovi g on g.id=a.id_grad
		join zahtevi_isporuka z on i.id_zahtev=z.id 
		where g.naziv in 
		(select g1.naziv from gradovi g1
		join adrese a1 on g1.id=a1.id_grad
		join korisnici k on k.id_adresa=a1.id
		join kuriri kur on k.username=kur.username
		where k.username=@kurirUsername 
		 ) and i.id_curr_adresa not in (select maga.id_adresa from magacini maga ) and i.status=1
	  order by vreme_prihvatanja asc


	declare @trenutnaIsporuka int
	declare @trenutnaTezina decimal(10,3) 
	declare @ukupnaTezina  decimal(10,3)
	

	open @kursor
	fetch next from @kursor 
	into  @trenutnaIsporuka, @trenutnaTezina

	WHILE @@FETCH_STATUS = 0
	BEGIN  
		set @ukupnaTezina  = (select trenutni_teret from vozila where reg_br=@regBrVozila)
		if(@ukupnaTezina+@trenutnaTezina<@kapacitetVozila)
		begin
			insert into kuriri_preuzimanje values (@trenutnaIsporuka, @kurirUsername, @cnt, 1)
	
			set @resCnt = @resCnt+1
			--update isporuke set status=2 where id=@trenutnaIsporuka
			set @ukupnaTezina = @ukupnaTezina+@trenutnaTezina
			update vozila set trenutni_teret = @ukupnaTezina  where reg_br=@regBrVozila
			set @cnt=@cnt+1;
		end
		else break

	 FETCH NEXT FROM @kursor INTO  @trenutnaIsporuka, @trenutnaTezina
	
	END;
	CLOSE @kursor ; 
	

	--------------------------------------------------------------------------------------------------------

	--------kod koji dohvata sve pakete iz magacina iz kog je kurir krenuo, poredjane po vremenu prohvatanja
	---a njihove idjeve stavlja u tabelu kuriri_preuzimanje
	---ovaj kod izvrsavamo samo ako je ostalo mesta u vozilu
	set @ukupnaTezina  = (select trenutni_teret from vozila where reg_br=@regBrVozila)

	if (@ukupnaTezina<@kapacitetVozila)
	begin


		set @kursor = cursor for
		select  i.id, z.tezina
		from isporuke i
		join zahtevi_isporuka z on i.id_zahtev=z.id
		join adrese a on a.id = i.id_curr_adresa
		where i.id_curr_adresa=@adrMagacina	 -- tj adresa magacina
		order by vreme_prihvatanja asc

		open @kursor
		FETCH NEXT FROM @kursor INTO  @trenutnaIsporuka, @trenutnaTezina

		WHILE @@FETCH_STATUS = 0
		BEGIN  
			set @ukupnaTezina  = (select trenutni_teret from vozila where reg_br=@regBrVozila)
			if(@ukupnaTezina+@trenutnaTezina<@kapacitetVozila)
			begin
				insert into kuriri_preuzimanje values (@trenutnaIsporuka, @kurirUsername, @cnt, 1)
				set @resCnt = @resCnt+1
				--update isporuke set status=2 where id=@trenutnaIsporuka
				set @ukupnaTezina = @ukupnaTezina+@trenutnaTezina
				update vozila set trenutni_teret = @ukupnaTezina where reg_br=@regBrVozila
				set @cnt=@cnt+1;
			end
	
		 FETCH NEXT FROM @kursor INTO  @trenutnaIsporuka, @trenutnaTezina
	
		END;
		CLOSE @kursor ; 

	end
	
	if @resCnt>0 
	begin
		
		set @start = (select top 1 id_isporuka
		from kuriri_preuzimanje
		where kurir=@kurirUsername
		order by rbr desc)

		update vozila set trenutni_teret = 0 where reg_br=@regBrVozila
		
	--	update voznje set curr_adr = (select top 1 a.id from kuriri_preuzimanje kp
	--	join isporuke i on i.id=kp.id_isporuka
	--	join adrese a on i.id_curr_adresa=a.id
	--	where kurir=@kurirUsername
	--	order by rbr asc) where username=@kurirUsername and status=1

		exec sortiranje_po_distanci @kurirUsername, @start 

		set @result = 0
		return
	end
	else begin
		set @result = -1
		return
	end
--------------------------------------------------------------------------------------------------

	DEALLOCATE @kursor;
END
go

CREATE PROCEDURE [izracunajDistancu] @x1 int , @y1 int , @x2 int , @y2 int , @dist int  OUTPUT   
   
 AS BEGIN
	set @dist =  SQRT(((@x1 - @x2) * (@x1 - @x2) + (@y1 - @y2) * (@y1 - @y2)));
	return @dist
END
go

CREATE PROCEDURE [sortiranje_po_distanci] @kurir nchar(100) , @idStartnaIsporuka int   
   
 AS BEGIN
	declare @kursor cursor
	declare @idIsporuka int
	declare @x int
	declare @y int
	declare @x1 int
	declare @y1 int
	declare @cnt int
	declare @startid int

	
			CREATE TABLE #Distance
			(
				idIsporuka int,
				distanca DECIMAL(10,3)

			)


	set @startid = @idStartnaIsporuka;
	set @x = (select a.x from adrese a join isporuke i on a.id=i.id_curr_adresa where i.id=@startid) --startna adr
	set @y = (select a.y from adrese a join isporuke i on a.id=i.id_curr_adresa where i.id=@startid)

	DECLARE @i INT = 0;
	set @cnt = (select count(*) from kuriri_preuzimanje)


	select id_isporuka
	into #Privremena 
	from kuriri_preuzimanje where kurir=@kurir


	WHILE @i < @cnt
		BEGIN
			

			set @kursor = cursor for
			select id_isporuka from #Privremena 

			open @kursor
			fetch next from @kursor 
			into  @idIsporuka

	

			WHILE @@FETCH_STATUS = 0
			BEGIN  
		
		
				set @x1 = (select a.x from adrese a join isporuke i on a.id=i.id_adresa_k where i.id=@idIsporuka) --krajnje adr
				set @y1 = (select a.y from adrese a join isporuke i on a.id=i.id_adresa_k where i.id=@idIsporuka)

				print( dbo.distanca(@x, @y, @x1, @y1));
				insert into #Distance (idIsporuka, distanca) values (@idIsporuka, (select dbo.distanca(@x, @y, @x1, @y1)))
		 				
			 FETCH NEXT FROM @kursor INTO  @idIsporuka
			END;
			CLOSE @kursor ; 

			declare @id int

			set @id = (select top 1 idIsporuka from #Distance where distanca=(select min(distanca) from #Distance)) --id najblize
			print(@id)
			insert into kuriri_isporuke values (@id,@kurir, @i)

			delete from #Privremena where id_isporuka=@id;

			set @startid = @id;
			set @x = (select a.x from adrese a join isporuke i on a.id=i.id_adresa_k where i.id=@startid) --startna adr je sada krajnja nove
			set @y = (select a.y from adrese a join isporuke i on a.id=i.id_adresa_k where i.id=@startid)

			delete from #Distance

	  SET @i = @i + 1;
	  END;  --kraj petlje

END
go

CREATE PROCEDURE [preuzimanjeIzGrada] @kurirUsername nchar(100) , @idGrad int   
   
 AS BEGIN
	declare @kurirAdresaId int
	declare @regBrVozila nchar(100)
	declare @kapacitetVozila decimal
	declare @idMagacina int = -1
	declare @adrMagacina int
	declare @kursor cursor
	declare @cnt int = 0


	set @regBrVozila = (select reg_br from kuriri where username=@kurirUsername)
	set @kapacitetVozila = (select nosivost from vozila where reg_br=@regBrVozila)

	--------------------------------------------------------------------------------------------------------
	---kod koji pravi kursor koji prolazi kroz tabelu paketa iz grada i uzima one koji mogu da stanu u vozilo i ciji je status 1
	--a njihove idjeve stavlja u  tabelu kuriri_preuzimanje
	
	set @kursor = cursor for
		select i.id, z.tezina
		from isporuke i
		join adrese a on i.id_adresa_p=a.id --moglo bi i curr adresa
		join gradovi g on g.id=a.id_grad
		join zahtevi_isporuka z on i.id_zahtev=z.id 
		where g.id=@idGrad and i.status=1 and i.id_curr_adresa not in (select maga.id_adresa from magacini maga ) --iz trazenog grada a da nije u magacinu
	  order by vreme_prihvatanja asc


	declare @trenutnaIsporuka int
	declare @trenutnaTezina decimal 
	declare @ukupnaTezina  decimal
	

	open @kursor
	fetch next from @kursor 
	into  @trenutnaIsporuka, @trenutnaTezina

	WHILE @@FETCH_STATUS = 0
	BEGIN  
		set @ukupnaTezina  = (select trenutni_teret from vozila where reg_br=@regBrVozila)
		if(@ukupnaTezina+@trenutnaTezina<@kapacitetVozila)
		begin
			insert into kuriri_preuzimanje values (@trenutnaIsporuka, @kurirUsername, @cnt, 0)
			--update isporuke set status=2 where id=@trenutnaIsporuka
			set @ukupnaTezina = @ukupnaTezina+@trenutnaTezina
			update vozila set trenutni_teret = @ukupnaTezina  where reg_br=@regBrVozila
			set @cnt=@cnt+1;
		end
		else break

	 FETCH NEXT FROM @kursor INTO  @trenutnaIsporuka, @trenutnaTezina
	
	END;
	CLOSE @kursor ; 

	-------------------------------------------------------------------------------------------------------------------
	--kod koji iz dohvata magacin iz grada u kom se nalazimo

	select top 1  @idMagacina=m.id, @adrMagacina=m.id_adresa
	from magacini m 
	join adrese a on m.id_adresa=a.id
	join gradovi g on g.id=a.id_grad
	where g.id=@idGrad
	order by m.id asc
	--print @idMagacina

	if(@idMagacina=-1) return

	--------kod koji dohvata sve pakete iz izabranog magacina, poredjane po vremenu prihvatanja
	---a njihove idjeve stavlja u tabelu kuriri_preuzimanje
	---ovaj kod izvrsavamo samo ako je ostalo mesta u vozilu

	if (@ukupnaTezina<@kapacitetVozila)
	begin


		set @kursor = cursor for
		select  i.id, z.tezina
		from isporuke i
		join zahtevi_isporuka z on i.id_zahtev=z.id
		join adrese a on a.id = i.id_curr_adresa
		where i.id_curr_adresa=@adrMagacina	 -- tj adresa magacina
		order by vreme_prihvatanja asc

		open @kursor
		FETCH NEXT FROM @kursor INTO  @trenutnaIsporuka, @trenutnaTezina

		WHILE @@FETCH_STATUS = 0
		BEGIN  
			set @ukupnaTezina  = (select trenutni_teret from vozila where reg_br=@regBrVozila)
			if(@ukupnaTezina+@trenutnaTezina<@kapacitetVozila)
			begin
				insert into kuriri_preuzimanje values (@trenutnaIsporuka, @kurirUsername, @cnt, 0)
				--update isporuke set status=2 where id=@trenutnaIsporuka
				set @ukupnaTezina = @ukupnaTezina+@trenutnaTezina
				update vozila set trenutni_teret = @ukupnaTezina where reg_br=@regBrVozila
				set @cnt=@cnt+1;
			end
	
		 FETCH NEXT FROM @kursor INTO  @trenutnaIsporuka, @trenutnaTezina
	
		END;
		CLOSE @kursor ; 

	end
	

	---------------------------------------------------------------------------

	DEALLOCATE @kursor;
END
go

CREATE PROCEDURE [nextStop] @kurirUsername nchar(100) , @result int  OUTPUT   
   
 AS BEGIN
	declare @cntPreuzimanja int
	declare @cntIsporuke int
	declare @isporukaId int
	declare @startAdrId int
	declare @currAdrId int
	declare @distanca decimal(10,3)
	declare @uMagacinu int = 0
	declare @kursor cursor
	declare @idGradIsporuke int
	declare @tezina decimal(10,3)
	declare @regBrVozila nchar(100)
	declare @cntIsporukaZaGrad int
	declare @profit decimal(10,3)
	declare @cenaGoriva int
	declare @tipGoriva int
	declare @idVoznje int
	declare @potrosnja decimal(10,3)

	declare @trenutnaTezina decimal(10,3) 
	

	set @idVoznje = (select id from voznje where username=@kurirUsername and status=1)
	set @regBrVozila = (select reg_br from kuriri where username=@kurirUsername)
	
	set @cntPreuzimanja = (select count (*) from kuriri_preuzimanje kp where kp.kurir=@kurirUsername)
	set @cntIsporuke = (select count (*) from kuriri_isporuke kp where kp.kurir=@kurirUsername)
	set @startAdrId = (select curr_adr from voznje where id=@idVoznje)

	if @cntPreuzimanja>0  ---iteriramo kroz tabelu kuriri_preuzimanje
	begin
		--uzimamo id isporuke koju treba da preuzmemo
		set @isporukaId = (select top 1 kp.id_isporuka from kuriri_preuzimanje kp where kp.kurir=@kurirUsername order by kp.rbr asc)

		--curr_adr voznje je sada adresa sa koje smo preuzeli

		set @currAdrId = (select i.id_curr_adresa from isporuke i where i.id=@isporukaId)
		update voznje set curr_adr=@currAdrId where id=@idVoznje

		--u voznji povecati kilometrazu

		set @distanca = dbo.distanca(
		(select x from adrese where id=@startAdrId) ,
		(select y from adrese where id=@startAdrId) ,
		(select x from adrese where id=@currAdrId) ,
		(select y from adrese where id=@currAdrId) )
		update voznje set kilometri=kilometri + @distanca where id=@idVoznje

		--provera da li kupimo iz magacina

		set @uMagacinu = (select count(*) from magacini m 
		join adrese a on m.id_adresa=a.id
		where a.id=@currAdrId)

		if(@uMagacinu>0)
		begin
			set @kursor = cursor for
			select id_isporuka from kuriri_preuzimanje kp
			join isporuke i on kp.id_isporuka=i.id
			join adrese a on a.id=i.id_curr_adresa
			where kp.kurir=@kurirUsername 

			open @kursor
			fetch next from @kursor into @isporukaId

			while @@FETCH_STATUS=0
			begin
			--isporuka je sada u transportu
			update isporuke set u_transportu=1, status=2 where id=@isporukaId

			--ubacujemo isporuku u kuriri_za_magacin ako isporuka nije za danasnje isporucivanje
			if (select isporukaDanas from kuriri_preuzimanje where kurir=@kurirUsername and id_isporuka=@isporukaId)=0
			begin
				insert into kuriri_za_magacin values (@isporukaId, @kurirUsername)
			end
			
			--namestamo id_voznje za isporuku
			update isporuke set id_voznja = @idVoznje where id=@isporukaId
			

			--povecavamo teret vozila
			set @trenutnaTezina = (
				select  z.tezina
				from isporuke i
				join zahtevi_isporuka z on i.id_zahtev=z.id		
				where i.id=@isporukaId)
			
			update vozila set trenutni_teret = trenutni_teret+@trenutnaTezina where reg_br=@regBrVozila


			fetch next from @kursor into @isporukaId
			end
		
			--brisemo sve pokupljene
			delete from kuriri_preuzimanje where kurir=@kurirUsername 
		
			
		end 
		else
		begin
			--isporuka je sada u transportu
			update isporuke set u_transportu=1, status=2 where id=@isporukaId

			--ubacujemo isporuku u kuriri_za_magacin
			if (select isporukaDanas from kuriri_preuzimanje where kurir=@kurirUsername and id_isporuka=@isporukaId)=0
			begin
				insert into kuriri_za_magacin values (@isporukaId, @kurirUsername)
			end

			--namestamo id_voznje za isporuku
			update isporuke set id_voznja = @idVoznje where id=@isporukaId

			--povecavamo teret vozila
			set @trenutnaTezina = (
				select  z.tezina
				from isporuke i
				join zahtevi_isporuka z on i.id_zahtev=z.id		
				where i.id=@isporukaId)
			update vozila set trenutni_teret = trenutni_teret+@trenutnaTezina where reg_br=@regBrVozila

			--brisemo
			delete from kuriri_preuzimanje where id_isporuka=@isporukaId and kurir=@kurirUsername 
			
		end

		set @result=-2
		return
	end
	else if @cntIsporuke>0
	begin

		--uzimamo id isporuke koju treba da isporucimo
		set @isporukaId = (select top 1 kp.id_isporuka from kuriri_isporuke kp where kp.kurir=@kurirUsername order by kp.rbr asc)

		--sacuvamo id grada isporuke

		set @idGradIsporuke = (select top 1 g.id from gradovi g 
		join adrese a on a.id_grad=g.id
		join isporuke i on i.id_adresa_k=a.id 
		where i.id=@isporukaId)

		--curr_adr voznje je sada adresa na koju smo isporucili

		set @currAdrId = (select i.id_adresa_k from isporuke i where i.id=@isporukaId)
		update voznje set curr_adr=@currAdrId where id=@idVoznje

		--u voznji povecati kilometrazu

		set @distanca = dbo.distanca(
		(select x from adrese where id=@startAdrId) ,
		(select y from adrese where id=@startAdrId) ,
		(select x from adrese where id=@currAdrId) ,
		(select y from adrese where id=@currAdrId) )
		update voznje set kilometri=kilometri + @distanca where id=@idVoznje

		--takodje u voznji povecati profit

		set @profit = (select cena from isporuke where id=@isporukaId)
		update voznje set profit = profit+@profit where id=@idVoznje

		--uzimamo tezinu isporuke i smanjujemo trenutni teret vozila
		set @tezina = ( select tezina from zahtevi_isporuka zi join isporuke i on i.id_zahtev=zi.id where i.id=@isporukaId)
		update vozila set trenutni_teret = trenutni_teret-@tezina  where reg_br=@regBrVozila

		--povecavamo kuriru broj isporucenih paketa
		update kuriri set br_isporucenih_paketa=br_isporucenih_paketa+1 where username=@kurirUsername

		--curr adr za ovu isporuku je sada krajna adresa te isporuke
		--uTransportu za ovu isporuku postavljamo na 0, a status na 3=isporucena
		update isporuke set u_transportu=0, status=3,id_curr_adresa=@currAdrId where id=@isporukaId

		--brisemo iz tabele kuriri_isporuke datu isporuku
		delete from kuriri_isporuke where id_isporuka=@isporukaId

		--ako vise nema isporuka za ovaj grad, pozivamo proceduru preuzimanjeIzGrada za dati grad
		set @cntIsporukaZaGrad = (select count(*) from kuriri_isporuke ki 
		join isporuke i on ki.id_isporuka=i.id
		join adrese a on i.id_adresa_k=a.id
		join gradovi g on a.id_grad=g.id
		where g.id=@idGradIsporuke)

		exec preuzimanjeIzGrada @kurirUsername, @idGradIsporuke

		set @result=@isporukaId
		return

	end
	else if @cntIsporuke=0
	begin

		set @kursor = cursor for
			select id_isporuka from kuriri_za_magacin kp
			where kp.kurir=@kurirUsername 

			 --curr adr je sada adresa magacina
			set @currAdrId = (select
			a.id from adrese a
			join magacini m on a.id=m.id_adresa
			join voznje v on v.id_magacin=m.id
			where v.id=@idVoznje)

			open @kursor
			fetch next from @kursor into @isporukaId

			while @@FETCH_STATUS=0
			begin
			--isporuka je sada u magacinu a ne u transportu
			--adresa isporuke je adresa magacina
			update isporuke set id_curr_adresa= @currAdrId, u_transportu=0  where id=@isporukaId

			fetch next from @kursor into @isporukaId
		end  

		--obrisati iz kuriri_za_magacin
		delete from kuriri_za_magacin where kurir=@kurirUsername

		--u voznji povecati kilometrazu

		set @distanca = dbo.distanca(
		(select x from adrese where id=@startAdrId) ,
		(select y from adrese where id=@startAdrId) ,
		(select x from adrese where id=@currAdrId) ,
		(select y from adrese where id=@currAdrId) )
		update voznje set kilometri=kilometri + @distanca where id=@idVoznje

		--sracunati zaradu voznje

		set @tipGoriva = (select tip_goriva from vozila where reg_br=@regBrVozila)
		set @potrosnja = (select potrosnja from vozila where reg_br=@regBrVozila)

		if @tipGoriva=0
		begin
			set @cenaGoriva=15
		end
		else if @tipGoriva=1
		begin
			set @cenaGoriva=32
		end
		else if @tipGoriva=2
		begin
			set @cenaGoriva=36
		end

		update voznje set profit = profit - (kilometri*@cenaGoriva*@potrosnja) where id=@idVoznje

		--tu zaradu dodeliti kuriru

		update kuriri set profit = profit + (select profit from voznje where id=@idVoznje)  where username=@kurirUsername

		--update status kurira na 0=ne vozi
		update kuriri set status = 0 where username=@kurirUsername 

		--update status voznje na 0 
		update voznje set status = 0 where id=@idVoznje

		---moguce da treba i isprazniti i parkirati vozilo
		update vozila set trenutni_teret=0.000 where reg_br=@regBrVozila
		insert into parkirana_vozila values (@regBrVozila, (select id_magacin from voznje where id=@idVoznje))


		set @result=-1
		return

	end

	close @kursor
	deallocate @kursor

END
go

CREATE PROCEDURE [magaciniUGradu] @idAdresa int , @brMagacina int  OUTPUT   
   
 AS BEGIN
	declare @idGrad int

    -- Insert statements for procedure here
	SELECT @idGrad = id_grad
	FROM adrese
	WHERE id= @idAdresa;

	SELECT @brMagacina = count(*)
	FROM magacini m join adrese a on m.id_adresa=a.id
	WHERE a.id_grad = @idGrad

END
go

CREATE TRIGGER [create_kurir_from_zahtev] ON kurir_zahtevi
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

BEGIN
		declare @username nchar(100)
		declare @brVozacke nchar(100)
		declare @approved int

		select @approved= i.approved from inserted i

		if(@approved=1)
		begin
			select @username = username from inserted
			set @brVozacke = (select br_vozacke from kurir_zahtevi where username = @username)
			insert into kuriri (username, br_vozacke) values (@username, @brVozacke)
			delete from kurir_zahtevi where username=@username
			
		end
    END
 
go


ENABLE TRIGGER [create_kurir_from_zahtev] ON kurir_zahtevi
go

CREATE TRIGGER [provera_jedinstvenog_vozila] ON kuriri
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

begin

 declare @cnt int
 declare @regBr nchar(100)
  declare @username nchar(100)

 if UPDATE(reg_br) 
 begin
	set @regBr = (select reg_br from inserted )
	set @username = (select username from inserted)

	if @regBr<>null
	begin

	set @cnt= (select count(*) from kuriri k where k.username=@username and k.reg_br=@regBr)
		if @cnt>0
			print('Vec postoji vozac koji vozi ovo vozilo')
			rollback transaction

	end

	
 end


end
 
go


ENABLE TRIGGER [provera_jedinstvenog_vozila] ON kuriri
go

CREATE TRIGGER [obrisi_zahtev] ON kuriri
   WITH 
 EXECUTE AS CALLER  AFTER INSERT 
  
  AS

BEGIN
		declare @username nchar(100)
		select @username= i.username from inserted i

		begin
			delete from kurir_zahtevi where username=@username
			
		end
    END
 
go


ENABLE TRIGGER [obrisi_zahtev] ON kuriri
go

CREATE TRIGGER [TR_TransportOffer_Creation] ON zahtevi_isporuka
   WITH 
 EXECUTE AS CALLER  AFTER INSERT 
  
  AS

Begin 
	Declare @username nchar(100) 
	Declare @adresaP int
	Declare @adresaK int
	Declare @cena decimal(10,3)
	Declare @xp int
	Declare @yp int
	Declare @xk int
	Declare @yk int
	Declare @rastojanje decimal(10,3)
	Declare @tip int
	Declare @tezina decimal(10,3)
	Declare @idZahtev int

	select @idZahtev = id from inserted

	select @tezina = tezina from inserted 
	select @tip = tip_paketa from inserted
	select @username = username from inserted
	select @adresaP = id_adresa_p from inserted
	select @adresaK = id_adresa_k from inserted
	set @xp = (select x from adrese where id=@adresaP)
	set @yp = (select y from adrese where id=@adresaP)
	set @xk = (select x from adrese where id=@adresaK)
	set @yk = (select y from adrese where id=@adresaK)
	set @rastojanje = SQRT((@xp - @xk) * (@xp - @xk) + (@yp - @yk) * (@yp - @yk))
	 
	 if(@tip=0)
	 begin
	  set @cena = 115*@rastojanje
	 end

	 if(@tip=1)
	 begin
		set @cena = (175 + 100*@tezina)*@rastojanje
	 end


	if(@tip=2)
		 begin
			set @cena = (250 + 100*@tezina)*@rastojanje
		 end

	if(@tip=3)
		 begin
			set @cena = (350 + 500*@tezina)*@rastojanje
		 end

	insert into isporuke (username, cena, vreme_kreiranja, id_adresa_p, id_adresa_k, id_zahtev, id_curr_adresa) 
	values(@username, @cena, GETDATE(), @adresaP, @adresaK, @idZahtev, @adresaP)
	
End

 
go


ENABLE TRIGGER [TR_TransportOffer_Creation] ON zahtevi_isporuka
go

CREATE TRIGGER [TR_TransportOffer_Update] ON zahtevi_isporuka
   WITH 
 EXECUTE AS CALLER  AFTER UPDATE 
  
  AS

Begin 
	Declare @username nchar(100) 
	Declare @adresaP int
	Declare @adresaK int
	Declare @cena int
	Declare @xp int
	Declare @yp int
	Declare @xk int
	Declare @yk int
	Declare @rastojanje decimal
	Declare @tip int
	Declare @tezina decimal

	select @tezina = tezina from inserted 
	select @tip = tip_paketa from inserted
	select @username = username from inserted
	select @adresaP = id_adresa_p from inserted
	select @adresaK = id_adresa_k from inserted
	set @xp = (select x from adrese where id=@adresaP)
	set @yp = (select y from adrese where id=@adresaP)
	set @xk = (select x from adrese where id=@adresaK)
	set @yk = (select y from adrese where id=@adresaK)
	set @rastojanje = SQRT((@xp - @xk) * (@xp - @xk) + (@yp - @yk) * (@yp - @yk))
	 
	 if(@tip=0)
	 begin
	  set @cena = 115*@rastojanje
	 end

	 if(@tip=1)
	 begin
		set @cena = (175 + 100*@tezina)*@rastojanje
	 end


	if(@tip=2)
		 begin
			set @cena = (250 + 100*@tezina)*@rastojanje
		 end

	if(@tip=3)
		 begin
			set @cena = (350 + 500*@tezina)*@rastojanje
		 end

	update isporuke set  cena= @cena, id_curr_adresa=@adresaP where username=@username
	
End

 
go


ENABLE TRIGGER [TR_TransportOffer_Update] ON zahtevi_isporuka
go




