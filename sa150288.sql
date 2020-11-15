
CREATE TABLE [adrese]
( 
	[id]                 int  NOT NULL  IDENTITY ( 1,1 ) ,
	[id_grad]            int  NULL ,
	[ulica]              nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[broj]               int  NULL ,
	[x]                  int  NULL ,
	[y]                  int  NULL 
)
go

ALTER TABLE [adrese]
	ADD CONSTRAINT [PK_adrese] PRIMARY KEY  CLUSTERED ([id] ASC)
go

CREATE TABLE [gradovi]
( 
	[id]                 int  NOT NULL  IDENTITY ( 1,1 ) ,
	[naziv]              nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[postanski_br]       int  NULL 
)
go

ALTER TABLE [gradovi]
	ADD CONSTRAINT [PK_gradovi] PRIMARY KEY  CLUSTERED ([id] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [postanski_br_unique] ON [gradovi]
( 
	[postanski_br]        ASC
)
go

CREATE TABLE [isporuke]
( 
	[id]                 int  NOT NULL  IDENTITY ( 1,1 ) ,
	[username]           nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[cena]               decimal(10,3)  NULL ,
	[status]             int  NULL 
	CONSTRAINT [DF_isporuke_status]
		 DEFAULT  0,
	[vreme_kreiranja]    datetime  NULL ,
	[vreme_prihvatanja]  datetime  NULL ,
	[id_curr_adresa]     int  NULL ,
	[id_voznja]          int  NULL ,
	[u_transportu]       bit  NULL 
	CONSTRAINT [DF_isporuke_u_transportu]
		 DEFAULT  0,
	[id_adresa_p]        int  NULL ,
	[id_adresa_k]        int  NULL ,
	[id_zahtev]          int  NULL 
)
go

ALTER TABLE [isporuke]
	ADD CONSTRAINT [PK_isporuke] PRIMARY KEY  CLUSTERED ([id] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [IX_isporuke] ON [isporuke]
( 
	[id_zahtev]           ASC
)
go

CREATE TABLE [korisnici]
( 
	[id_adresa]          int  NULL ,
	[ime]                nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[prezime]            nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[username]           nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[password]           nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[isAdmin]            int  NOT NULL 
	CONSTRAINT [DF_korisnici_isAdmin]
		 DEFAULT  0
)
go

ALTER TABLE [korisnici]
	ADD CONSTRAINT [PK_korisnici_1] PRIMARY KEY  CLUSTERED ([username] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [IX_korisnici] ON [korisnici]
( 
	[username]            ASC
)
go

CREATE TABLE [kurir_zahtevi]
( 
	[username]           nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[br_vozacke]         nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[approved]           int  NULL 
	CONSTRAINT [DF_kurir_zahtevi_approved]
		 DEFAULT  0
)
go

ALTER TABLE [kurir_zahtevi]
	ADD CONSTRAINT [PK_kurir_zahtevi_1] PRIMARY KEY  CLUSTERED ([username] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [IX_kurir_zahtevi] ON [kurir_zahtevi]
( 
	[br_vozacke]          ASC
)
go

CREATE TABLE [kuriri]
( 
	[username]           nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[br_vozacke]         nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[reg_br]             nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[br_isporucenih_paketa] int  NULL 
	CONSTRAINT [DF_kuriri_br_isporucenih_paketa]
		 DEFAULT  0,
	[profit]             decimal(10,3)  NULL 
	CONSTRAINT [DF_kuriri_profit]
		 DEFAULT  0,
	[status]             int  NULL 
	CONSTRAINT [DF_kuriri_status]
		 DEFAULT  0
)
go

ALTER TABLE [kuriri]
	ADD CONSTRAINT [PK_kuriri_1] PRIMARY KEY  CLUSTERED ([username] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [IX_kuriri_1] ON [kuriri]
( 
	[br_vozacke]          ASC
)
go

CREATE TABLE [kuriri_isporuke]
( 
	[id_isporuka]        int  NOT NULL ,
	[kurir]              nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[rbr]                int  NULL 
)
go

ALTER TABLE [kuriri_isporuke]
	ADD CONSTRAINT [PK_kuriri_isporuke] PRIMARY KEY  CLUSTERED ([id_isporuka] ASC)
go

CREATE TABLE [kuriri_preuzimanje]
( 
	[id_isporuka]        int  NOT NULL ,
	[kurir]              nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[rbr]                int  NULL ,
	[isporukaDanas]      bit  NULL 
)
go

ALTER TABLE [kuriri_preuzimanje]
	ADD CONSTRAINT [PK_kuriri_preuzimanje] PRIMARY KEY  CLUSTERED ([id_isporuka] ASC)
go

CREATE TABLE [kuriri_za_magacin]
( 
	[id_isporuka]        int  NOT NULL ,
	[kurir]              nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

ALTER TABLE [kuriri_za_magacin]
	ADD CONSTRAINT [PK_kuriri_za_magacin] PRIMARY KEY  CLUSTERED ([id_isporuka] ASC)
go

CREATE TABLE [magacini]
( 
	[id]                 int  NOT NULL  IDENTITY ( 1,1 ) ,
	[id_adresa]          int  NULL 
)
go

ALTER TABLE [magacini]
	ADD CONSTRAINT [PK_magacini] PRIMARY KEY  CLUSTERED ([id] ASC)
go

CREATE TABLE [parkirana_vozila]
( 
	[id]                 int  NOT NULL  IDENTITY ( 1,1 ) ,
	[reg_br]             nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[id_mag]             int  NULL 
)
go

ALTER TABLE [parkirana_vozila]
	ADD CONSTRAINT [PK_Table_1] PRIMARY KEY  CLUSTERED ([id] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [IX_Table_1] ON [parkirana_vozila]
( 
	[reg_br]              ASC
)
go

CREATE TABLE [vozila]
( 
	[reg_br]             nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL ,
	[tip_goriva]         int  NULL ,
	[potrosnja]          decimal(10,3)  NULL ,
	[nosivost]           decimal(10,3)  NULL ,
	[trenutni_teret]     decimal(10,3)  NULL 
	CONSTRAINT [DF_vozila_trenutni_kapacitet]
		 DEFAULT  0.000
)
go

ALTER TABLE [vozila]
	ADD CONSTRAINT [PK_vozila_1] PRIMARY KEY  CLUSTERED ([reg_br] ASC)
go

CREATE UNIQUE NONCLUSTERED INDEX [IX_vozila] ON [vozila]
( 
	[reg_br]              ASC
)
go

CREATE TABLE [voznje]
( 
	[id]                 int  NOT NULL  IDENTITY ( 1,1 ) ,
	[id_magacin]         int  NULL ,
	[username]           nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[reg_br]             nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL ,
	[profit]             decimal(10,3)  NULL 
	CONSTRAINT [DF_voznje_profit]
		 DEFAULT  0.000,
	[status]             int  NULL 
	CONSTRAINT [DF_voznje_status]
		 DEFAULT  1,
	[kilometri]          decimal(10,3)  NULL 
	CONSTRAINT [DF_voznje_kilometri]
		 DEFAULT  0.000,
	[curr_adr]           int  NULL 
)
go

ALTER TABLE [voznje]
	ADD CONSTRAINT [PK_voznje] PRIMARY KEY  CLUSTERED ([id] ASC)
go

CREATE TABLE [zahtevi_isporuka]
( 
	[id]                 int  NOT NULL  IDENTITY ( 1,1 ) ,
	[id_adresa_p]        int  NULL ,
	[id_adresa_k]        int  NULL ,
	[tip_paketa]         int  NULL ,
	[tezina]             decimal(10,3)  NULL 
	CONSTRAINT [DF_zahtevi_isporuka_tezina]
		 DEFAULT  10,
	[username]           nchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS  NULL 
)
go

ALTER TABLE [zahtevi_isporuka]
	ADD CONSTRAINT [PK_zahtevi_isporuka] PRIMARY KEY  CLUSTERED ([id] ASC)
go


ALTER TABLE [adrese] WITH CHECK 
	ADD CONSTRAINT [FK_gradovi_adrese] FOREIGN KEY ([id_grad]) REFERENCES [gradovi]([id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [adrese]
	  WITH CHECK CHECK CONSTRAINT [FK_gradovi_adrese]
go


ALTER TABLE [isporuke] WITH CHECK 
	ADD CONSTRAINT [FK_isporuke_korisnici] FOREIGN KEY ([username]) REFERENCES [korisnici]([username])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [isporuke]
	  WITH CHECK CHECK CONSTRAINT [FK_isporuke_korisnici]
go

ALTER TABLE [isporuke] WITH CHECK 
	ADD CONSTRAINT [FK_isporuke_voznje] FOREIGN KEY ([id_voznja]) REFERENCES [voznje]([id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [isporuke]
	  WITH CHECK CHECK CONSTRAINT [FK_isporuke_voznje]
go

ALTER TABLE [isporuke] WITH CHECK 
	ADD CONSTRAINT [FK_isporuke_adrese] FOREIGN KEY ([id_adresa_p]) REFERENCES [adrese]([id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [isporuke]
	  WITH CHECK CHECK CONSTRAINT [FK_isporuke_adrese]
go

ALTER TABLE [isporuke] WITH CHECK 
	ADD CONSTRAINT [FK_isporuke_adrese1] FOREIGN KEY ([id_adresa_k]) REFERENCES [adrese]([id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [isporuke]
	  WITH CHECK CHECK CONSTRAINT [FK_isporuke_adrese1]
go

ALTER TABLE [isporuke] WITH CHECK 
	ADD CONSTRAINT [FK_isporuke_zahtevi_isporuka] FOREIGN KEY ([id_zahtev]) REFERENCES [zahtevi_isporuka]([id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [isporuke]
	  WITH CHECK CHECK CONSTRAINT [FK_isporuke_zahtevi_isporuka]
go

ALTER TABLE [isporuke] WITH CHECK 
	ADD CONSTRAINT [FK_isporuke_adrese2] FOREIGN KEY ([id_curr_adresa]) REFERENCES [adrese]([id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [isporuke]
	  WITH CHECK CHECK CONSTRAINT [FK_isporuke_adrese2]
go


ALTER TABLE [korisnici] WITH CHECK 
	ADD CONSTRAINT [FK_korisnici_adrese] FOREIGN KEY ([id_adresa]) REFERENCES [adrese]([id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [korisnici]
	  WITH CHECK CHECK CONSTRAINT [FK_korisnici_adrese]
go


ALTER TABLE [kurir_zahtevi] WITH CHECK 
	ADD CONSTRAINT [FK_kurir_zahtevi_korisnici] FOREIGN KEY ([username]) REFERENCES [korisnici]([username])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [kurir_zahtevi]
	  WITH CHECK CHECK CONSTRAINT [FK_kurir_zahtevi_korisnici]
go


ALTER TABLE [kuriri] WITH CHECK 
	ADD CONSTRAINT [FK_kuriri_vozila] FOREIGN KEY ([reg_br]) REFERENCES [vozila]([reg_br])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [kuriri]
	  WITH CHECK CHECK CONSTRAINT [FK_kuriri_vozila]
go


ALTER TABLE [kuriri_isporuke] WITH CHECK 
	ADD CONSTRAINT [FK_kuriri_isporuke_isporuke] FOREIGN KEY ([id_isporuka]) REFERENCES [isporuke]([id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [kuriri_isporuke]
	  WITH CHECK CHECK CONSTRAINT [FK_kuriri_isporuke_isporuke]
go

ALTER TABLE [kuriri_isporuke] WITH CHECK 
	ADD CONSTRAINT [FK_kuriri_isporuke_kuriri] FOREIGN KEY ([kurir]) REFERENCES [kuriri]([username])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [kuriri_isporuke]
	  WITH CHECK CHECK CONSTRAINT [FK_kuriri_isporuke_kuriri]
go


ALTER TABLE [kuriri_preuzimanje] WITH CHECK 
	ADD CONSTRAINT [FK_kuriri_preuzimanje_isporuke] FOREIGN KEY ([id_isporuka]) REFERENCES [isporuke]([id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [kuriri_preuzimanje]
	  WITH CHECK CHECK CONSTRAINT [FK_kuriri_preuzimanje_isporuke]
go

ALTER TABLE [kuriri_preuzimanje] WITH CHECK 
	ADD CONSTRAINT [FK_kuriri_preuzimanje_kuriri] FOREIGN KEY ([kurir]) REFERENCES [kuriri]([username])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [kuriri_preuzimanje]
	  WITH CHECK CHECK CONSTRAINT [FK_kuriri_preuzimanje_kuriri]
go


ALTER TABLE [magacini] WITH CHECK 
	ADD CONSTRAINT [FK_magacini_adrese] FOREIGN KEY ([id_adresa]) REFERENCES [adrese]([id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [magacini]
	  WITH CHECK CHECK CONSTRAINT [FK_magacini_adrese]
go


ALTER TABLE [parkirana_vozila] WITH CHECK 
	ADD CONSTRAINT [FK_vozila_parkirana_vozila] FOREIGN KEY ([reg_br]) REFERENCES [vozila]([reg_br])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [parkirana_vozila]
	  WITH CHECK CHECK CONSTRAINT [FK_vozila_parkirana_vozila]
go

ALTER TABLE [parkirana_vozila] WITH CHECK 
	ADD CONSTRAINT [FK_parkirana_vozila_magacini] FOREIGN KEY ([id_mag]) REFERENCES [magacini]([id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [parkirana_vozila]
	  WITH CHECK CHECK CONSTRAINT [FK_parkirana_vozila_magacini]
go


ALTER TABLE [voznje] WITH CHECK 
	ADD CONSTRAINT [FK_voznje_voznje] FOREIGN KEY ([id]) REFERENCES [voznje]([id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [voznje]
	  WITH CHECK CHECK CONSTRAINT [FK_voznje_voznje]
go

ALTER TABLE [voznje] WITH CHECK 
	ADD CONSTRAINT [FK_voznje_vozila] FOREIGN KEY ([reg_br]) REFERENCES [vozila]([reg_br])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [voznje]
	  WITH CHECK CHECK CONSTRAINT [FK_voznje_vozila]
go

ALTER TABLE [voznje] WITH CHECK 
	ADD CONSTRAINT [FK_voznje_magacini] FOREIGN KEY ([id_magacin]) REFERENCES [magacini]([id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [voznje]
	  WITH CHECK CHECK CONSTRAINT [FK_voznje_magacini]
go

ALTER TABLE [voznje] WITH CHECK 
	ADD CONSTRAINT [FK_voznje_kuriri] FOREIGN KEY ([username]) REFERENCES [kuriri]([username])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [voznje]
	  WITH CHECK CHECK CONSTRAINT [FK_voznje_kuriri]
go


ALTER TABLE [zahtevi_isporuka] WITH CHECK 
	ADD CONSTRAINT [FK_zahtevi_isporuka_user] FOREIGN KEY ([username]) REFERENCES [korisnici]([username])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [zahtevi_isporuka]
	  WITH CHECK CHECK CONSTRAINT [FK_zahtevi_isporuka_user]
go

ALTER TABLE [zahtevi_isporuka] WITH CHECK 
	ADD CONSTRAINT [FK_zahtevi_isporuka_adrese] FOREIGN KEY ([id_adresa_p]) REFERENCES [adrese]([id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [zahtevi_isporuka]
	  WITH CHECK CHECK CONSTRAINT [FK_zahtevi_isporuka_adrese]
go

ALTER TABLE [zahtevi_isporuka] WITH CHECK 
	ADD CONSTRAINT [FK_zahtevi_isporuka_adrese1] FOREIGN KEY ([id_adresa_k]) REFERENCES [adrese]([id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [zahtevi_isporuka]
	  WITH CHECK CHECK CONSTRAINT [FK_zahtevi_isporuka_adrese1]
go

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


CREATE TRIGGER tD_adrese ON adrese FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on adrese */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* adrese  zahtevi_isporuka on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0007df11", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="zahtevi_isporuka"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_zahtevi_isporuka_adrese1", FK_COLUMNS="id_adresa_k" */
    IF EXISTS (
      SELECT * FROM deleted,zahtevi_isporuka
      WHERE
        /*  %JoinFKPK(zahtevi_isporuka,deleted," = "," AND") */
        zahtevi_isporuka.id_adresa_k = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete adrese because zahtevi_isporuka exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  zahtevi_isporuka on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="zahtevi_isporuka"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_zahtevi_isporuka_adrese", FK_COLUMNS="id_adresa_p" */
    IF EXISTS (
      SELECT * FROM deleted,zahtevi_isporuka
      WHERE
        /*  %JoinFKPK(zahtevi_isporuka,deleted," = "," AND") */
        zahtevi_isporuka.id_adresa_p = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete adrese because zahtevi_isporuka exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  magacini on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="magacini"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_magacini_adrese", FK_COLUMNS="id_adresa" */
    IF EXISTS (
      SELECT * FROM deleted,magacini
      WHERE
        /*  %JoinFKPK(magacini,deleted," = "," AND") */
        magacini.id_adresa = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete adrese because magacini exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  korisnici on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="korisnici"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_korisnici_adrese", FK_COLUMNS="id_adresa" */
    IF EXISTS (
      SELECT * FROM deleted,korisnici
      WHERE
        /*  %JoinFKPK(korisnici,deleted," = "," AND") */
        korisnici.id_adresa = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete adrese because korisnici exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  isporuke on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese2", FK_COLUMNS="id_curr_adresa" */
    IF EXISTS (
      SELECT * FROM deleted,isporuke
      WHERE
        /*  %JoinFKPK(isporuke,deleted," = "," AND") */
        isporuke.id_curr_adresa = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete adrese because isporuke exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  isporuke on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese1", FK_COLUMNS="id_adresa_k" */
    IF EXISTS (
      SELECT * FROM deleted,isporuke
      WHERE
        /*  %JoinFKPK(isporuke,deleted," = "," AND") */
        isporuke.id_adresa_k = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete adrese because isporuke exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  isporuke on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese", FK_COLUMNS="id_adresa_p" */
    IF EXISTS (
      SELECT * FROM deleted,isporuke
      WHERE
        /*  %JoinFKPK(isporuke,deleted," = "," AND") */
        isporuke.id_adresa_p = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete adrese because isporuke exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* gradovi  adrese on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="gradovi"
    CHILD_OWNER="", CHILD_TABLE="adrese"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_gradovi_adrese", FK_COLUMNS="id_grad" */
    IF EXISTS (SELECT * FROM deleted,gradovi
      WHERE
        /* %JoinFKPK(deleted,gradovi," = "," AND") */
        deleted.id_grad = gradovi.id AND
        NOT EXISTS (
          SELECT * FROM adrese
          WHERE
            /* %JoinFKPK(adrese,gradovi," = "," AND") */
            adrese.id_grad = gradovi.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last adrese because gradovi exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_adrese ON adrese FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on adrese */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* adrese  zahtevi_isporuka on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00096384", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="zahtevi_isporuka"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_zahtevi_isporuka_adrese1", FK_COLUMNS="id_adresa_k" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,zahtevi_isporuka
      WHERE
        /*  %JoinFKPK(zahtevi_isporuka,deleted," = "," AND") */
        zahtevi_isporuka.id_adresa_k = deleted.id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update adrese because zahtevi_isporuka exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* adrese  zahtevi_isporuka on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="zahtevi_isporuka"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_zahtevi_isporuka_adrese", FK_COLUMNS="id_adresa_p" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,zahtevi_isporuka
      WHERE
        /*  %JoinFKPK(zahtevi_isporuka,deleted," = "," AND") */
        zahtevi_isporuka.id_adresa_p = deleted.id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update adrese because zahtevi_isporuka exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* adrese  magacini on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="magacini"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_magacini_adrese", FK_COLUMNS="id_adresa" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insid = inserted.id
        FROM inserted
      UPDATE magacini
      SET
        /*  %JoinFKPK(magacini,@ins," = ",",") */
        magacini.id_adresa = @insid
      FROM magacini,inserted,deleted
      WHERE
        /*  %JoinFKPK(magacini,deleted," = "," AND") */
        magacini.id_adresa = deleted.id
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade adrese update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* adrese  korisnici on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="korisnici"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_korisnici_adrese", FK_COLUMNS="id_adresa" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insid = inserted.id
        FROM inserted
      UPDATE korisnici
      SET
        /*  %JoinFKPK(korisnici,@ins," = ",",") */
        korisnici.id_adresa = @insid
      FROM korisnici,inserted,deleted
      WHERE
        /*  %JoinFKPK(korisnici,deleted," = "," AND") */
        korisnici.id_adresa = deleted.id
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade adrese update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* adrese  isporuke on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese2", FK_COLUMNS="id_curr_adresa" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,isporuke
      WHERE
        /*  %JoinFKPK(isporuke,deleted," = "," AND") */
        isporuke.id_curr_adresa = deleted.id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update adrese because isporuke exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* adrese  isporuke on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese1", FK_COLUMNS="id_adresa_k" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,isporuke
      WHERE
        /*  %JoinFKPK(isporuke,deleted," = "," AND") */
        isporuke.id_adresa_k = deleted.id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update adrese because isporuke exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* adrese  isporuke on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese", FK_COLUMNS="id_adresa_p" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,isporuke
      WHERE
        /*  %JoinFKPK(isporuke,deleted," = "," AND") */
        isporuke.id_adresa_p = deleted.id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update adrese because isporuke exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* gradovi  adrese on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="gradovi"
    CHILD_OWNER="", CHILD_TABLE="adrese"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_gradovi_adrese", FK_COLUMNS="id_grad" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_grad)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,gradovi
        WHERE
          /* %JoinFKPK(inserted,gradovi) */
          inserted.id_grad = gradovi.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_grad IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update adrese because gradovi does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_gradovi ON gradovi FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on gradovi */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* gradovi  adrese on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00010670", PARENT_OWNER="", PARENT_TABLE="gradovi"
    CHILD_OWNER="", CHILD_TABLE="adrese"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_gradovi_adrese", FK_COLUMNS="id_grad" */
    IF EXISTS (
      SELECT * FROM deleted,adrese
      WHERE
        /*  %JoinFKPK(adrese,deleted," = "," AND") */
        adrese.id_grad = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete gradovi because adrese exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_gradovi ON gradovi FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on gradovi */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* gradovi  adrese on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="000165a9", PARENT_OWNER="", PARENT_TABLE="gradovi"
    CHILD_OWNER="", CHILD_TABLE="adrese"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_gradovi_adrese", FK_COLUMNS="id_grad" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insid = inserted.id
        FROM inserted
      UPDATE adrese
      SET
        /*  %JoinFKPK(adrese,@ins," = ",",") */
        adrese.id_grad = @insid
      FROM adrese,inserted,deleted
      WHERE
        /*  %JoinFKPK(adrese,deleted," = "," AND") */
        adrese.id_grad = deleted.id
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade gradovi update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_isporuke ON isporuke FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on isporuke */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* isporuke  kuriri_preuzimanje on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00091b6b", PARENT_OWNER="", PARENT_TABLE="isporuke"
    CHILD_OWNER="", CHILD_TABLE="kuriri_preuzimanje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_preuzimanje_isporuke", FK_COLUMNS="id_isporuka" */
    IF EXISTS (
      SELECT * FROM deleted,kuriri_preuzimanje
      WHERE
        /*  %JoinFKPK(kuriri_preuzimanje,deleted," = "," AND") */
        kuriri_preuzimanje.id_isporuka = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete isporuke because kuriri_preuzimanje exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* isporuke  kuriri_isporuke on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="isporuke"
    CHILD_OWNER="", CHILD_TABLE="kuriri_isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_isporuke_isporuke", FK_COLUMNS="id_isporuka" */
    IF EXISTS (
      SELECT * FROM deleted,kuriri_isporuke
      WHERE
        /*  %JoinFKPK(kuriri_isporuke,deleted," = "," AND") */
        kuriri_isporuke.id_isporuka = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete isporuke because kuriri_isporuke exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  isporuke on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese2", FK_COLUMNS="id_curr_adresa" */
    IF EXISTS (SELECT * FROM deleted,adrese
      WHERE
        /* %JoinFKPK(deleted,adrese," = "," AND") */
        deleted.id_curr_adresa = adrese.id AND
        NOT EXISTS (
          SELECT * FROM isporuke
          WHERE
            /* %JoinFKPK(isporuke,adrese," = "," AND") */
            isporuke.id_curr_adresa = adrese.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last isporuke because adrese exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* zahtevi_isporuka  isporuke on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="zahtevi_isporuka"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_zahtevi_isporuka", FK_COLUMNS="id_zahtev" */
    IF EXISTS (SELECT * FROM deleted,zahtevi_isporuka
      WHERE
        /* %JoinFKPK(deleted,zahtevi_isporuka," = "," AND") */
        deleted.id_zahtev = zahtevi_isporuka.id AND
        NOT EXISTS (
          SELECT * FROM isporuke
          WHERE
            /* %JoinFKPK(isporuke,zahtevi_isporuka," = "," AND") */
            isporuke.id_zahtev = zahtevi_isporuka.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last isporuke because zahtevi_isporuka exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  isporuke on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese1", FK_COLUMNS="id_adresa_k" */
    IF EXISTS (SELECT * FROM deleted,adrese
      WHERE
        /* %JoinFKPK(deleted,adrese," = "," AND") */
        deleted.id_adresa_k = adrese.id AND
        NOT EXISTS (
          SELECT * FROM isporuke
          WHERE
            /* %JoinFKPK(isporuke,adrese," = "," AND") */
            isporuke.id_adresa_k = adrese.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last isporuke because adrese exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  isporuke on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese", FK_COLUMNS="id_adresa_p" */
    IF EXISTS (SELECT * FROM deleted,adrese
      WHERE
        /* %JoinFKPK(deleted,adrese," = "," AND") */
        deleted.id_adresa_p = adrese.id AND
        NOT EXISTS (
          SELECT * FROM isporuke
          WHERE
            /* %JoinFKPK(isporuke,adrese," = "," AND") */
            isporuke.id_adresa_p = adrese.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last isporuke because adrese exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* voznje  isporuke on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="voznje"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_voznje", FK_COLUMNS="id_voznja" */
    IF EXISTS (SELECT * FROM deleted,voznje
      WHERE
        /* %JoinFKPK(deleted,voznje," = "," AND") */
        deleted.id_voznja = voznje.id AND
        NOT EXISTS (
          SELECT * FROM isporuke
          WHERE
            /* %JoinFKPK(isporuke,voznje," = "," AND") */
            isporuke.id_voznja = voznje.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last isporuke because voznje exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* korisnici  isporuke on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="korisnici"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_korisnici", FK_COLUMNS="username" */
    IF EXISTS (SELECT * FROM deleted,korisnici
      WHERE
        /* %JoinFKPK(deleted,korisnici," = "," AND") */
        deleted.username = korisnici.username AND
        NOT EXISTS (
          SELECT * FROM isporuke
          WHERE
            /* %JoinFKPK(isporuke,korisnici," = "," AND") */
            isporuke.username = korisnici.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last isporuke because korisnici exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_isporuke ON isporuke FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on isporuke */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* isporuke  kuriri_preuzimanje on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000b0948", PARENT_OWNER="", PARENT_TABLE="isporuke"
    CHILD_OWNER="", CHILD_TABLE="kuriri_preuzimanje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_preuzimanje_isporuke", FK_COLUMNS="id_isporuka" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,kuriri_preuzimanje
      WHERE
        /*  %JoinFKPK(kuriri_preuzimanje,deleted," = "," AND") */
        kuriri_preuzimanje.id_isporuka = deleted.id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update isporuke because kuriri_preuzimanje exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* isporuke  kuriri_isporuke on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="isporuke"
    CHILD_OWNER="", CHILD_TABLE="kuriri_isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_isporuke_isporuke", FK_COLUMNS="id_isporuka" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,kuriri_isporuke
      WHERE
        /*  %JoinFKPK(kuriri_isporuke,deleted," = "," AND") */
        kuriri_isporuke.id_isporuka = deleted.id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update isporuke because kuriri_isporuke exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* adrese  isporuke on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese2", FK_COLUMNS="id_curr_adresa" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_curr_adresa)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,adrese
        WHERE
          /* %JoinFKPK(inserted,adrese) */
          inserted.id_curr_adresa = adrese.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_curr_adresa IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update isporuke because adrese does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* zahtevi_isporuka  isporuke on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="zahtevi_isporuka"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_zahtevi_isporuka", FK_COLUMNS="id_zahtev" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_zahtev)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,zahtevi_isporuka
        WHERE
          /* %JoinFKPK(inserted,zahtevi_isporuka) */
          inserted.id_zahtev = zahtevi_isporuka.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_zahtev IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update isporuke because zahtevi_isporuka does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* adrese  isporuke on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese1", FK_COLUMNS="id_adresa_k" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_adresa_k)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,adrese
        WHERE
          /* %JoinFKPK(inserted,adrese) */
          inserted.id_adresa_k = adrese.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_adresa_k IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update isporuke because adrese does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* adrese  isporuke on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_adrese", FK_COLUMNS="id_adresa_p" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_adresa_p)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,adrese
        WHERE
          /* %JoinFKPK(inserted,adrese) */
          inserted.id_adresa_p = adrese.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_adresa_p IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update isporuke because adrese does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* voznje  isporuke on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="voznje"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_voznje", FK_COLUMNS="id_voznja" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_voznja)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,voznje
        WHERE
          /* %JoinFKPK(inserted,voznje) */
          inserted.id_voznja = voznje.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_voznja IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update isporuke because voznje does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* korisnici  isporuke on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="korisnici"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_korisnici", FK_COLUMNS="username" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,korisnici
        WHERE
          /* %JoinFKPK(inserted,korisnici) */
          inserted.username = korisnici.username
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.username IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update isporuke because korisnici does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_korisnici ON korisnici FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on korisnici */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* korisnici  zahtevi_isporuka on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00043e53", PARENT_OWNER="", PARENT_TABLE="korisnici"
    CHILD_OWNER="", CHILD_TABLE="zahtevi_isporuka"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_zahtevi_isporuka_user", FK_COLUMNS="username" */
    IF EXISTS (
      SELECT * FROM deleted,zahtevi_isporuka
      WHERE
        /*  %JoinFKPK(zahtevi_isporuka,deleted," = "," AND") */
        zahtevi_isporuka.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete korisnici because zahtevi_isporuka exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* korisnici  kurir_zahtevi on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="korisnici"
    CHILD_OWNER="", CHILD_TABLE="kurir_zahtevi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kurir_zahtevi_korisnici", FK_COLUMNS="username" */
    IF EXISTS (
      SELECT * FROM deleted,kurir_zahtevi
      WHERE
        /*  %JoinFKPK(kurir_zahtevi,deleted," = "," AND") */
        kurir_zahtevi.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete korisnici because kurir_zahtevi exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* korisnici  isporuke on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="korisnici"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_korisnici", FK_COLUMNS="username" */
    IF EXISTS (
      SELECT * FROM deleted,isporuke
      WHERE
        /*  %JoinFKPK(isporuke,deleted," = "," AND") */
        isporuke.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete korisnici because isporuke exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  korisnici on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="korisnici"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_korisnici_adrese", FK_COLUMNS="id_adresa" */
    IF EXISTS (SELECT * FROM deleted,adrese
      WHERE
        /* %JoinFKPK(deleted,adrese," = "," AND") */
        deleted.id_adresa = adrese.id AND
        NOT EXISTS (
          SELECT * FROM korisnici
          WHERE
            /* %JoinFKPK(korisnici,adrese," = "," AND") */
            korisnici.id_adresa = adrese.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last korisnici because adrese exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_korisnici ON korisnici FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on korisnici */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insusername nchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* korisnici  zahtevi_isporuka on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0004c582", PARENT_OWNER="", PARENT_TABLE="korisnici"
    CHILD_OWNER="", CHILD_TABLE="zahtevi_isporuka"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_zahtevi_isporuka_user", FK_COLUMNS="username" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,zahtevi_isporuka
      WHERE
        /*  %JoinFKPK(zahtevi_isporuka,deleted," = "," AND") */
        zahtevi_isporuka.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update korisnici because zahtevi_isporuka exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* korisnici  kurir_zahtevi on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="korisnici"
    CHILD_OWNER="", CHILD_TABLE="kurir_zahtevi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kurir_zahtevi_korisnici", FK_COLUMNS="username" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,kurir_zahtevi
      WHERE
        /*  %JoinFKPK(kurir_zahtevi,deleted," = "," AND") */
        kurir_zahtevi.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update korisnici because kurir_zahtevi exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* korisnici  isporuke on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="korisnici"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_korisnici", FK_COLUMNS="username" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,isporuke
      WHERE
        /*  %JoinFKPK(isporuke,deleted," = "," AND") */
        isporuke.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update korisnici because isporuke exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* adrese  korisnici on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="korisnici"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_korisnici_adrese", FK_COLUMNS="id_adresa" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_adresa)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,adrese
        WHERE
          /* %JoinFKPK(inserted,adrese) */
          inserted.id_adresa = adrese.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_adresa IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update korisnici because adrese does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_kurir_zahtevi ON kurir_zahtevi FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on kurir_zahtevi */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* korisnici  kurir_zahtevi on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00015e72", PARENT_OWNER="", PARENT_TABLE="korisnici"
    CHILD_OWNER="", CHILD_TABLE="kurir_zahtevi"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kurir_zahtevi_korisnici", FK_COLUMNS="username" */
    IF EXISTS (SELECT * FROM deleted,korisnici
      WHERE
        /* %JoinFKPK(deleted,korisnici," = "," AND") */
        deleted.username = korisnici.username AND
        NOT EXISTS (
          SELECT * FROM kurir_zahtevi
          WHERE
            /* %JoinFKPK(kurir_zahtevi,korisnici," = "," AND") */
            kurir_zahtevi.username = korisnici.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last kurir_zahtevi because korisnici exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_kuriri ON kuriri FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on kuriri */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* kuriri  voznje on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00041dfa", PARENT_OWNER="", PARENT_TABLE="kuriri"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_kuriri", FK_COLUMNS="username" */
    IF EXISTS (
      SELECT * FROM deleted,voznje
      WHERE
        /*  %JoinFKPK(voznje,deleted," = "," AND") */
        voznje.username = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete kuriri because voznje exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* kuriri  kuriri_preuzimanje on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="kuriri"
    CHILD_OWNER="", CHILD_TABLE="kuriri_preuzimanje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_preuzimanje_kuriri", FK_COLUMNS="kurir" */
    IF EXISTS (
      SELECT * FROM deleted,kuriri_preuzimanje
      WHERE
        /*  %JoinFKPK(kuriri_preuzimanje,deleted," = "," AND") */
        kuriri_preuzimanje.kurir = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete kuriri because kuriri_preuzimanje exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* kuriri  kuriri_isporuke on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="kuriri"
    CHILD_OWNER="", CHILD_TABLE="kuriri_isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_isporuke_kuriri", FK_COLUMNS="kurir" */
    IF EXISTS (
      SELECT * FROM deleted,kuriri_isporuke
      WHERE
        /*  %JoinFKPK(kuriri_isporuke,deleted," = "," AND") */
        kuriri_isporuke.kurir = deleted.username
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete kuriri because kuriri_isporuke exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* vozila  kuriri on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="vozila"
    CHILD_OWNER="", CHILD_TABLE="kuriri"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_vozila", FK_COLUMNS="reg_br" */
    IF EXISTS (SELECT * FROM deleted,vozila
      WHERE
        /* %JoinFKPK(deleted,vozila," = "," AND") */
        deleted.reg_br = vozila.reg_br AND
        NOT EXISTS (
          SELECT * FROM kuriri
          WHERE
            /* %JoinFKPK(kuriri,vozila," = "," AND") */
            kuriri.reg_br = vozila.reg_br
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last kuriri because vozila exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_kuriri_isporuke ON kuriri_isporuke FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on kuriri_isporuke */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* kuriri  kuriri_isporuke on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000293ca", PARENT_OWNER="", PARENT_TABLE="kuriri"
    CHILD_OWNER="", CHILD_TABLE="kuriri_isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_isporuke_kuriri", FK_COLUMNS="kurir" */
    IF EXISTS (SELECT * FROM deleted,kuriri
      WHERE
        /* %JoinFKPK(deleted,kuriri," = "," AND") */
        deleted.kurir = kuriri.username AND
        NOT EXISTS (
          SELECT * FROM kuriri_isporuke
          WHERE
            /* %JoinFKPK(kuriri_isporuke,kuriri," = "," AND") */
            kuriri_isporuke.kurir = kuriri.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last kuriri_isporuke because kuriri exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* isporuke  kuriri_isporuke on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="isporuke"
    CHILD_OWNER="", CHILD_TABLE="kuriri_isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_isporuke_isporuke", FK_COLUMNS="id_isporuka" */
    IF EXISTS (SELECT * FROM deleted,isporuke
      WHERE
        /* %JoinFKPK(deleted,isporuke," = "," AND") */
        deleted.id_isporuka = isporuke.id AND
        NOT EXISTS (
          SELECT * FROM kuriri_isporuke
          WHERE
            /* %JoinFKPK(kuriri_isporuke,isporuke," = "," AND") */
            kuriri_isporuke.id_isporuka = isporuke.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last kuriri_isporuke because isporuke exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_kuriri_isporuke ON kuriri_isporuke FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on kuriri_isporuke */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid_isporuka int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* kuriri  kuriri_isporuke on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002d10a", PARENT_OWNER="", PARENT_TABLE="kuriri"
    CHILD_OWNER="", CHILD_TABLE="kuriri_isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_isporuke_kuriri", FK_COLUMNS="kurir" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(kurir)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,kuriri
        WHERE
          /* %JoinFKPK(inserted,kuriri) */
          inserted.kurir = kuriri.username
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update kuriri_isporuke because kuriri does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* isporuke  kuriri_isporuke on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="isporuke"
    CHILD_OWNER="", CHILD_TABLE="kuriri_isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_isporuke_isporuke", FK_COLUMNS="id_isporuka" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_isporuka)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,isporuke
        WHERE
          /* %JoinFKPK(inserted,isporuke) */
          inserted.id_isporuka = isporuke.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update kuriri_isporuke because isporuke does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_kuriri_preuzimanje ON kuriri_preuzimanje FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on kuriri_preuzimanje */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* kuriri  kuriri_preuzimanje on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002aa3a", PARENT_OWNER="", PARENT_TABLE="kuriri"
    CHILD_OWNER="", CHILD_TABLE="kuriri_preuzimanje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_preuzimanje_kuriri", FK_COLUMNS="kurir" */
    IF EXISTS (SELECT * FROM deleted,kuriri
      WHERE
        /* %JoinFKPK(deleted,kuriri," = "," AND") */
        deleted.kurir = kuriri.username AND
        NOT EXISTS (
          SELECT * FROM kuriri_preuzimanje
          WHERE
            /* %JoinFKPK(kuriri_preuzimanje,kuriri," = "," AND") */
            kuriri_preuzimanje.kurir = kuriri.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last kuriri_preuzimanje because kuriri exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* isporuke  kuriri_preuzimanje on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="isporuke"
    CHILD_OWNER="", CHILD_TABLE="kuriri_preuzimanje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_preuzimanje_isporuke", FK_COLUMNS="id_isporuka" */
    IF EXISTS (SELECT * FROM deleted,isporuke
      WHERE
        /* %JoinFKPK(deleted,isporuke," = "," AND") */
        deleted.id_isporuka = isporuke.id AND
        NOT EXISTS (
          SELECT * FROM kuriri_preuzimanje
          WHERE
            /* %JoinFKPK(kuriri_preuzimanje,isporuke," = "," AND") */
            kuriri_preuzimanje.id_isporuka = isporuke.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last kuriri_preuzimanje because isporuke exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_kuriri_preuzimanje ON kuriri_preuzimanje FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on kuriri_preuzimanje */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid_isporuka int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* kuriri  kuriri_preuzimanje on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002d3cf", PARENT_OWNER="", PARENT_TABLE="kuriri"
    CHILD_OWNER="", CHILD_TABLE="kuriri_preuzimanje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_preuzimanje_kuriri", FK_COLUMNS="kurir" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(kurir)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,kuriri
        WHERE
          /* %JoinFKPK(inserted,kuriri) */
          inserted.kurir = kuriri.username
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update kuriri_preuzimanje because kuriri does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* isporuke  kuriri_preuzimanje on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="isporuke"
    CHILD_OWNER="", CHILD_TABLE="kuriri_preuzimanje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_preuzimanje_isporuke", FK_COLUMNS="id_isporuka" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_isporuka)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,isporuke
        WHERE
          /* %JoinFKPK(inserted,isporuke) */
          inserted.id_isporuka = isporuke.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update kuriri_preuzimanje because isporuke does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_magacini ON magacini FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on magacini */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* magacini  voznje on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00031c34", PARENT_OWNER="", PARENT_TABLE="magacini"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_magacini", FK_COLUMNS="id_magacin" */
    IF EXISTS (
      SELECT * FROM deleted,voznje
      WHERE
        /*  %JoinFKPK(voznje,deleted," = "," AND") */
        voznje.id_magacin = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete magacini because voznje exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* magacini  parkirana_vozila on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="magacini"
    CHILD_OWNER="", CHILD_TABLE="parkirana_vozila"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_parkirana_vozila_magacini", FK_COLUMNS="id_mag" */
    IF EXISTS (
      SELECT * FROM deleted,parkirana_vozila
      WHERE
        /*  %JoinFKPK(parkirana_vozila,deleted," = "," AND") */
        parkirana_vozila.id_mag = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete magacini because parkirana_vozila exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  magacini on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="magacini"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_magacini_adrese", FK_COLUMNS="id_adresa" */
    IF EXISTS (SELECT * FROM deleted,adrese
      WHERE
        /* %JoinFKPK(deleted,adrese," = "," AND") */
        deleted.id_adresa = adrese.id AND
        NOT EXISTS (
          SELECT * FROM magacini
          WHERE
            /* %JoinFKPK(magacini,adrese," = "," AND") */
            magacini.id_adresa = adrese.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last magacini because adrese exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_magacini ON magacini FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on magacini */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* magacini  voznje on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0003ebf0", PARENT_OWNER="", PARENT_TABLE="magacini"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_magacini", FK_COLUMNS="id_magacin" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insid = inserted.id
        FROM inserted
      UPDATE voznje
      SET
        /*  %JoinFKPK(voznje,@ins," = ",",") */
        voznje.id_magacin = @insid
      FROM voznje,inserted,deleted
      WHERE
        /*  %JoinFKPK(voznje,deleted," = "," AND") */
        voznje.id_magacin = deleted.id
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade magacini update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* magacini  parkirana_vozila on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="magacini"
    CHILD_OWNER="", CHILD_TABLE="parkirana_vozila"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_parkirana_vozila_magacini", FK_COLUMNS="id_mag" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,parkirana_vozila
      WHERE
        /*  %JoinFKPK(parkirana_vozila,deleted," = "," AND") */
        parkirana_vozila.id_mag = deleted.id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update magacini because parkirana_vozila exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* adrese  magacini on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="magacini"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_magacini_adrese", FK_COLUMNS="id_adresa" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_adresa)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,adrese
        WHERE
          /* %JoinFKPK(inserted,adrese) */
          inserted.id_adresa = adrese.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_adresa IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update magacini because adrese does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_parkirana_vozila ON parkirana_vozila FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on parkirana_vozila */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* magacini  parkirana_vozila on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002923e", PARENT_OWNER="", PARENT_TABLE="magacini"
    CHILD_OWNER="", CHILD_TABLE="parkirana_vozila"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_parkirana_vozila_magacini", FK_COLUMNS="id_mag" */
    IF EXISTS (SELECT * FROM deleted,magacini
      WHERE
        /* %JoinFKPK(deleted,magacini," = "," AND") */
        deleted.id_mag = magacini.id AND
        NOT EXISTS (
          SELECT * FROM parkirana_vozila
          WHERE
            /* %JoinFKPK(parkirana_vozila,magacini," = "," AND") */
            parkirana_vozila.id_mag = magacini.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last parkirana_vozila because magacini exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* vozila  parkirana_vozila on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="vozila"
    CHILD_OWNER="", CHILD_TABLE="parkirana_vozila"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_vozila_parkirana_vozila", FK_COLUMNS="reg_br" */
    IF EXISTS (SELECT * FROM deleted,vozila
      WHERE
        /* %JoinFKPK(deleted,vozila," = "," AND") */
        deleted.reg_br = vozila.reg_br AND
        NOT EXISTS (
          SELECT * FROM parkirana_vozila
          WHERE
            /* %JoinFKPK(parkirana_vozila,vozila," = "," AND") */
            parkirana_vozila.reg_br = vozila.reg_br
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last parkirana_vozila because vozila exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_parkirana_vozila ON parkirana_vozila FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on parkirana_vozila */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* magacini  parkirana_vozila on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002f690", PARENT_OWNER="", PARENT_TABLE="magacini"
    CHILD_OWNER="", CHILD_TABLE="parkirana_vozila"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_parkirana_vozila_magacini", FK_COLUMNS="id_mag" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_mag)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,magacini
        WHERE
          /* %JoinFKPK(inserted,magacini) */
          inserted.id_mag = magacini.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_mag IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update parkirana_vozila because magacini does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* vozila  parkirana_vozila on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="vozila"
    CHILD_OWNER="", CHILD_TABLE="parkirana_vozila"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_vozila_parkirana_vozila", FK_COLUMNS="reg_br" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(reg_br)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,vozila
        WHERE
          /* %JoinFKPK(inserted,vozila) */
          inserted.reg_br = vozila.reg_br
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.reg_br IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update parkirana_vozila because vozila does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_vozila ON vozila FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on vozila */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* vozila  voznje on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002f278", PARENT_OWNER="", PARENT_TABLE="vozila"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_vozila", FK_COLUMNS="reg_br" */
    IF EXISTS (
      SELECT * FROM deleted,voznje
      WHERE
        /*  %JoinFKPK(voznje,deleted," = "," AND") */
        voznje.reg_br = deleted.reg_br
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete vozila because voznje exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* vozila  parkirana_vozila on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="vozila"
    CHILD_OWNER="", CHILD_TABLE="parkirana_vozila"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_vozila_parkirana_vozila", FK_COLUMNS="reg_br" */
    IF EXISTS (
      SELECT * FROM deleted,parkirana_vozila
      WHERE
        /*  %JoinFKPK(parkirana_vozila,deleted," = "," AND") */
        parkirana_vozila.reg_br = deleted.reg_br
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete vozila because parkirana_vozila exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* vozila  kuriri on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="vozila"
    CHILD_OWNER="", CHILD_TABLE="kuriri"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_vozila", FK_COLUMNS="reg_br" */
    IF EXISTS (
      SELECT * FROM deleted,kuriri
      WHERE
        /*  %JoinFKPK(kuriri,deleted," = "," AND") */
        kuriri.reg_br = deleted.reg_br
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete vozila because kuriri exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_vozila ON vozila FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on vozila */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insreg_br nchar(100),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* vozila  voznje on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000331a8", PARENT_OWNER="", PARENT_TABLE="vozila"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_vozila", FK_COLUMNS="reg_br" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(reg_br)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,voznje
      WHERE
        /*  %JoinFKPK(voznje,deleted," = "," AND") */
        voznje.reg_br = deleted.reg_br
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update vozila because voznje exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* vozila  parkirana_vozila on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="vozila"
    CHILD_OWNER="", CHILD_TABLE="parkirana_vozila"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_vozila_parkirana_vozila", FK_COLUMNS="reg_br" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(reg_br)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,parkirana_vozila
      WHERE
        /*  %JoinFKPK(parkirana_vozila,deleted," = "," AND") */
        parkirana_vozila.reg_br = deleted.reg_br
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update vozila because parkirana_vozila exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* vozila  kuriri on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="vozila"
    CHILD_OWNER="", CHILD_TABLE="kuriri"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_kuriri_vozila", FK_COLUMNS="reg_br" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(reg_br)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,kuriri
      WHERE
        /*  %JoinFKPK(kuriri,deleted," = "," AND") */
        kuriri.reg_br = deleted.reg_br
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update vozila because kuriri exists.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_voznje ON voznje FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on voznje */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* voznje  voznje on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00064c78", PARENT_OWNER="", PARENT_TABLE="voznje"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_voznje", FK_COLUMNS="id" */
    IF EXISTS (
      SELECT * FROM deleted,voznje
      WHERE
        /*  %JoinFKPK(voznje,deleted," = "," AND") */
        voznje.id = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete voznje because voznje exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* voznje  isporuke on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="voznje"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_voznje", FK_COLUMNS="id_voznja" */
    IF EXISTS (
      SELECT * FROM deleted,isporuke
      WHERE
        /*  %JoinFKPK(isporuke,deleted," = "," AND") */
        isporuke.id_voznja = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete voznje because isporuke exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* kuriri  voznje on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="kuriri"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_kuriri", FK_COLUMNS="username" */
    IF EXISTS (SELECT * FROM deleted,kuriri
      WHERE
        /* %JoinFKPK(deleted,kuriri," = "," AND") */
        deleted.username = kuriri.username AND
        NOT EXISTS (
          SELECT * FROM voznje
          WHERE
            /* %JoinFKPK(voznje,kuriri," = "," AND") */
            voznje.username = kuriri.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last voznje because kuriri exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* magacini  voznje on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="magacini"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_magacini", FK_COLUMNS="id_magacin" */
    IF EXISTS (SELECT * FROM deleted,magacini
      WHERE
        /* %JoinFKPK(deleted,magacini," = "," AND") */
        deleted.id_magacin = magacini.id AND
        NOT EXISTS (
          SELECT * FROM voznje
          WHERE
            /* %JoinFKPK(voznje,magacini," = "," AND") */
            voznje.id_magacin = magacini.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last voznje because magacini exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* vozila  voznje on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="vozila"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_vozila", FK_COLUMNS="reg_br" */
    IF EXISTS (SELECT * FROM deleted,vozila
      WHERE
        /* %JoinFKPK(deleted,vozila," = "," AND") */
        deleted.reg_br = vozila.reg_br AND
        NOT EXISTS (
          SELECT * FROM voznje
          WHERE
            /* %JoinFKPK(voznje,vozila," = "," AND") */
            voznje.reg_br = vozila.reg_br
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last voznje because vozila exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* voznje  voznje on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="voznje"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_voznje", FK_COLUMNS="id" */
    IF EXISTS (SELECT * FROM deleted,voznje
      WHERE
        /* %JoinFKPK(deleted,voznje," = "," AND") */
        deleted.id = voznje.id AND
        NOT EXISTS (
          SELECT * FROM voznje
          WHERE
            /* %JoinFKPK(voznje,voznje," = "," AND") */
            voznje.id = voznje.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last voznje because voznje exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_voznje ON voznje FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on voznje */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insid int,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* voznje  voznje on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00078575", PARENT_OWNER="", PARENT_TABLE="voznje"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_voznje", FK_COLUMNS="id" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,voznje
      WHERE
        /*  %JoinFKPK(voznje,deleted," = "," AND") */
        voznje.id = deleted.id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update voznje because voznje exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* voznje  isporuke on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="voznje"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_voznje", FK_COLUMNS="id_voznja" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,isporuke
      WHERE
        /*  %JoinFKPK(isporuke,deleted," = "," AND") */
        isporuke.id_voznja = deleted.id
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update voznje because isporuke exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* kuriri  voznje on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="kuriri"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_kuriri", FK_COLUMNS="username" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(username)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,kuriri
        WHERE
          /* %JoinFKPK(inserted,kuriri) */
          inserted.username = kuriri.username
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.username IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update voznje because kuriri does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* magacini  voznje on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="magacini"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_magacini", FK_COLUMNS="id_magacin" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id_magacin)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,magacini
        WHERE
          /* %JoinFKPK(inserted,magacini) */
          inserted.id_magacin = magacini.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id_magacin IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update voznje because magacini does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* vozila  voznje on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="vozila"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_vozila", FK_COLUMNS="reg_br" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(reg_br)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,vozila
        WHERE
          /* %JoinFKPK(inserted,vozila) */
          inserted.reg_br = vozila.reg_br
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.reg_br IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update voznje because vozila does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* voznje  voznje on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="voznje"
    CHILD_OWNER="", CHILD_TABLE="voznje"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_voznje_voznje", FK_COLUMNS="id" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(id)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,voznje
        WHERE
          /* %JoinFKPK(inserted,voznje) */
          inserted.id = voznje.id
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.id IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update voznje because voznje does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_zahtevi_isporuka ON zahtevi_isporuka FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on zahtevi_isporuka */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* zahtevi_isporuka  isporuke on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0004ce15", PARENT_OWNER="", PARENT_TABLE="zahtevi_isporuka"
    CHILD_OWNER="", CHILD_TABLE="isporuke"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_isporuke_zahtevi_isporuka", FK_COLUMNS="id_zahtev" */
    IF EXISTS (
      SELECT * FROM deleted,isporuke
      WHERE
        /*  %JoinFKPK(isporuke,deleted," = "," AND") */
        isporuke.id_zahtev = deleted.id
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete zahtevi_isporuka because isporuke exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  zahtevi_isporuka on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="zahtevi_isporuka"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_zahtevi_isporuka_adrese1", FK_COLUMNS="id_adresa_k" */
    IF EXISTS (SELECT * FROM deleted,adrese
      WHERE
        /* %JoinFKPK(deleted,adrese," = "," AND") */
        deleted.id_adresa_k = adrese.id AND
        NOT EXISTS (
          SELECT * FROM zahtevi_isporuka
          WHERE
            /* %JoinFKPK(zahtevi_isporuka,adrese," = "," AND") */
            zahtevi_isporuka.id_adresa_k = adrese.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last zahtevi_isporuka because adrese exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* adrese  zahtevi_isporuka on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="adrese"
    CHILD_OWNER="", CHILD_TABLE="zahtevi_isporuka"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_zahtevi_isporuka_adrese", FK_COLUMNS="id_adresa_p" */
    IF EXISTS (SELECT * FROM deleted,adrese
      WHERE
        /* %JoinFKPK(deleted,adrese," = "," AND") */
        deleted.id_adresa_p = adrese.id AND
        NOT EXISTS (
          SELECT * FROM zahtevi_isporuka
          WHERE
            /* %JoinFKPK(zahtevi_isporuka,adrese," = "," AND") */
            zahtevi_isporuka.id_adresa_p = adrese.id
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last zahtevi_isporuka because adrese exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* korisnici  zahtevi_isporuka on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="korisnici"
    CHILD_OWNER="", CHILD_TABLE="zahtevi_isporuka"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="FK_zahtevi_isporuka_user", FK_COLUMNS="username" */
    IF EXISTS (SELECT * FROM deleted,korisnici
      WHERE
        /* %JoinFKPK(deleted,korisnici," = "," AND") */
        deleted.username = korisnici.username AND
        NOT EXISTS (
          SELECT * FROM zahtevi_isporuka
          WHERE
            /* %JoinFKPK(zahtevi_isporuka,korisnici," = "," AND") */
            zahtevi_isporuka.username = korisnici.username
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last zahtevi_isporuka because korisnici exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


