--- da bi insert radio, treba promeniti identity za gradove, adrese i magacine u create_database.sql, tako da krecu od odredjenog broja:

--ADRESE

-- CREATE TABLE [adrese]
--( 
--	[id]                 int  NOT NULL  IDENTITY ( 10045,1 ) ,
-- ...

-- GRADOVI

-- CREATE TABLE [gradovi]
--( 
--	[id]                 int  NOT NULL  IDENTITY ( 9060,1 ) ,
-- ...

-- MAGACINI

--CREATE TABLE [magacini]
--( 
--	[id]                 int  NOT NULL  IDENTITY ( 2686,1 ) ,
-- ...





insert into gradovi(naziv, postanski_br) values ( 'Beograd', 11000),
('Uzice', 31000),
('Cacak', 12000),
('Nis', 13000),
('Kraljevo', 14000),
('Novi Sad', 15000),
('Paracin', 16000),
('Kragujevac', 17000),
('Negotin', 18000),
('Valjevo', 19000),
('Vrsac', 20000),
('Leskovac', 21000)


insert into adrese (id_grad,ulica, broj, x, y) values 
(9060, 'Jaksiceva', 15, 1 , 1),
(9060, 'Niksicka', 25, 1 , 2),
(9060, 'Mutapova', 28, 1 , 3),
(9060, 'Kataniceva', 11, 1 , 4),
(9060, 'Novopazarska', 22, 1 , 5),
(9060, 'Simina', 33, 1 , 6),
(9060, 'Zmaj Jovina', 44, 1 , 7),
(9060, 'Kneza MIlosa', 86, 1 , 8),
(9060, 'Balkanska', 11, 1 , 9),
(9060, 'Kralja Milana', 12, 1 , 10),
(9060, 'Knez Mihailova', 122, 1 , 11),
(9060, 'Kaleniceva', 32, 1 , 12),
(9060, 'Petrovacka', 87, 1 , 13),
(9061, 'Jaksiceva', 15, 2 , 1),
(9061, 'Niksicka', 25, 2 , 2),
(9061, 'Mutapova', 28, 2 , 3),
(9061, 'Kataniceva', 11, 2 , 4),
(9061, 'Novopazarska', 22, 2 , 5),
(9061, 'Simina', 33, 2 , 6),
(9061, 'Zmaj Jovina', 44, 2 , 7),
(9061, 'Kneza MIlosa', 86, 2 , 8),
(9061, 'Balkanska', 11, 2 , 9),
(9061, 'Kralja Milana', 12, 2 , 10),
(9061, 'Knez Mihailova', 122, 2 , 11),
(9061, 'Kaleniceva', 32, 2 , 12),
(9061, 'Petrovacka', 87, 2 , 13),

(9062, 'Jaksiceva', 15, 3 , 1),
(9062, 'Niksicka', 25, 3 , 2),
(9062, 'Mutapova', 28, 3 , 3),
(9062, 'Kataniceva', 11, 3 , 4),
(9062, 'Novopazarska', 22, 3 , 5),
(9062, 'Simina', 33, 3 , 6),
(9062, 'Zmaj Jovina', 44, 3 , 7),
(9062, 'Kneza MIlosa', 86, 3 , 8),
(9062, 'Balkanska', 11, 3 , 9),
(9062, 'Kralja Milana', 12, 3 , 10),
(9062, 'Knez Mihailova', 122, 3 , 11),
(9062, 'Kaleniceva', 32, 3 , 12),
(9062, 'Petrovacka', 87, 3 , 13),

(9063, 'Jaksiceva', 15, 4 , 1),
(9063, 'Niksicka', 25, 4 , 2),
(9063, 'Mutapova', 28, 4 , 3),
(9063, 'Kataniceva', 11, 4 , 4),
(9063, 'Novopazarska', 22, 4 , 5),
(9063, 'Simina', 33, 4 , 6),
(9063, 'Zmaj Jovina', 44, 4 , 7),
(9063, 'Kneza MIlosa', 86, 4 , 8),
(9063, 'Balkanska', 11, 4 , 9),
(9063, 'Kralja Milana', 12, 4 , 10),
(9063, 'Knez Mihailova', 122, 4 , 11),
(9063, 'Kaleniceva', 32, 4 , 12),
(9063, 'Petrovacka', 87, 4 , 13),

(9064, 'Jaksiceva', 15, 5 , 1),
(9064, 'Niksicka', 25, 5 , 2),
(9064, 'Mutapova', 28, 5 , 3),
(9064, 'Kataniceva', 11, 5 , 4),
(9064, 'Novopazarska', 22, 5 , 5),
(9064, 'Simina', 33, 5 , 6),
(9064, 'Zmaj Jovina', 44, 5 , 7),
(9064, 'Kneza MIlosa', 86, 5 , 8),
(9064, 'Balkanska', 11, 5 , 9),
(9064, 'Kralja Milana', 12, 5 , 10),
(9064, 'Knez Mihailova', 122, 5 , 11),
(9064, 'Kaleniceva', 32, 5 , 12),
(9064, 'Petrovacka', 87, 5 , 13),


(9065, 'Jaksiceva', 15, 6 , 1),
(9065, 'Niksicka', 25, 6 , 2),
(9065, 'Mutapova', 28, 6 , 3),
(9065, 'Kataniceva', 11, 6 , 4),
(9065, 'Novopazarska', 22, 6 , 5),
(9065, 'Simina', 33, 6 , 6),
(9065, 'Zmaj Jovina', 44, 6 , 7),
(9065, 'Kneza MIlosa', 86, 6 , 8),
(9065, 'Balkanska', 11, 6 , 9),
(9065, 'Kralja Milana', 12, 6 , 10),
(9065, 'Knez Mihailova', 122, 6 , 11),
(9065, 'Kaleniceva', 32, 6 , 12),
(9065, 'Petrovacka', 87, 6 , 13),

(9066, 'Jaksiceva', 15, 7 , 1),
(9066, 'Niksicka', 25, 7 , 2),
(9066, 'Mutapova', 28, 7 , 3),
(9066, 'Kataniceva', 11, 7 , 4),
(9066, 'Novopazarska', 22, 7 , 5),
(9066, 'Simina', 33, 7 , 6),
(9066, 'Zmaj Jovina', 44, 7 , 7),
(9066, 'Kneza MIlosa', 86, 7 , 8),
(9066, 'Balkanska', 11, 7 , 9),
(9066, 'Kralja Milana', 12, 7 , 10),
(9066, 'Knez Mihailova', 122, 7 , 11),
(9066, 'Kaleniceva', 32, 7 , 12),
(9066, 'Petrovacka', 87, 7 , 13),


(9067, 'Jaksiceva', 15, 8 , 1),
(9067, 'Niksicka', 25, 8 , 2),
(9067, 'Mutapova', 28, 8 , 3),
(9067, 'Kataniceva', 11, 8 , 4),
(9067, 'Novopazarska', 22, 8 , 5),
(9067, 'Simina', 33, 8 , 6),
(9067, 'Zmaj Jovina', 44, 8 , 7),
(9067, 'Kneza MIlosa', 86, 8 , 8),
(9067, 'Balkanska', 11, 8 , 9),
(9067, 'Kralja Milana', 12, 8 , 10),
(9067, 'Knez Mihailova', 122, 8 , 11),
(9067, 'Kaleniceva', 32, 8 , 12),
(9067, 'Petrovacka', 87, 8 , 13),

(9068, 'Jaksiceva', 15, 9 , 1),
(9068, 'Niksicka', 25, 9 , 2),
(9068, 'Mutapova', 28, 9 , 3),
(9068, 'Kataniceva', 11, 9 , 4),
(9068, 'Novopazarska', 22, 9 , 5),
(9068, 'Simina', 33, 9 , 6),
(9068, 'Zmaj Jovina', 44, 9 , 7),
(9068, 'Kneza MIlosa', 86, 9 , 8),
(9068, 'Balkanska', 11, 9 , 9),
(9068, 'Kralja Milana', 12, 9 , 10),
(9068, 'Knez Mihailova', 122, 9 , 11),
(9068, 'Kaleniceva', 32, 9 , 12),
(9068, 'Petrovacka', 87, 9 , 13),


(9069, 'Jaksiceva', 15, 10 , 1),
(9069, 'Niksicka', 25, 10 , 2),
(9069, 'Mutapova', 28, 10 , 3),
(9069, 'Kataniceva', 11, 10 , 4),
(9069, 'Novopazarska', 22, 10 , 5),
(9069, 'Simina', 33, 10 , 6),
(9069, 'Zmaj Jovina', 44, 10 , 7),
(9069, 'Kneza MIlosa', 86, 10 , 8),
(9069, 'Balkanska', 11, 10 , 9),
(9069, 'Kralja Milana', 12, 10 , 10),
(9069, 'Knez Mihailova', 122, 10 , 11),
(9069, 'Kaleniceva', 32, 10 , 12),
(9069, 'Petrovacka', 87, 10 , 13),

(9070, 'Jaksiceva', 15, 11 , 1),
(9070, 'Niksicka', 25, 11 , 2),
(9070, 'Mutapova', 28, 11 , 3),
(9070, 'Kataniceva', 11, 11 , 4),
(9070, 'Novopazarska', 22, 11 , 5),
(9070, 'Simina', 33, 11 , 6),
(9070, 'Zmaj Jovina', 44, 11 , 7),
(9070, 'Kneza MIlosa', 86, 11 , 8),
(9070, 'Balkanska', 11, 11 , 9),
(9070, 'Kralja Milana', 12, 11 , 10),
(9070, 'Knez Mihailova', 122, 11 , 11),
(9070, 'Kaleniceva', 32, 11 , 12),
(9070, 'Petrovacka', 87, 11 , 13),

(9071, 'Jaksiceva', 15, 12 , 1),
(9071, 'Niksicka', 25, 12 , 2),
(9071, 'Mutapova', 28, 12 , 3),
(9071, 'Kataniceva', 11, 12 , 4),
(9071, 'Novopazarska', 22, 12 , 5),
(9071, 'Simina', 33, 12 , 6),
(9071, 'Zmaj Jovina', 44, 12 , 7),
(9071, 'Kneza MIlosa', 86, 12 , 8),
(9071, 'Balkanska', 11, 12 , 9),
(9071, 'Kralja Milana', 12, 12 , 10),
(9071, 'Knez Mihailova', 122, 12 , 11),
(9071, 'Kaleniceva', 32, 12 , 12),
(9071, 'Petrovacka', 87, 12 , 13)

insert into korisnici (id_adresa, ime, prezime, password, username, isAdmin) values
(10045, 'Aleksandra', 'Stanojevic', '123', 'aleks0000', 1),
(10046, 'Djordje', 'Malesevic', '123', 'aleks0001', 1),

(10047, 'Marko', 'Maric', '123', 'aleks0002', 0),
(10048, 'Ivan', 'Ivic', '123', 'aleks0003', 0),
(10049, 'Laza', 'Lazic', '123', 'aleks0004', 0),
(10050, 'Sima', 'Simic', '123', 'aleks0005', 0),
(10051, 'Pera', 'Peric', '123', 'aleks0006', 0),
(10052, 'Mika', 'Mikic', '123', 'aleks0007', 0),
(10053, 'Rade', 'Radic', '123', 'aleks0008', 0),
(10054, 'Vasa', 'Vasic', '123', 'aleks0009', 0),
(10055, 'Mika', 'Mikic', '123', 'aleks0010', 0),
(10056, 'Rade', 'Radic', '123', 'aleks0011', 0),
(10057, 'Vasa', 'Vasic', '123', 'aleks0012', 0),

(10058, 'Marko', 'Maric', '123', 'aleks0013', 0),
(10059, 'Ivan', 'Ivic', '123', 'aleks0014', 0),
(10060, 'Laza', 'Lazic', '123', 'aleks0015', 0),
(10061, 'Pera', 'Peric', '123', 'aleks0016', 0),
(10062, 'Mika', 'Mikic', '123', 'aleks0017', 0),
(10063, 'Rade', 'Radic', '123', 'aleks0018', 0),
(10064, 'Vasa', 'Vasic', '123', 'aleks0019', 0),
(10065, 'Mika', 'Mikic', '123', 'aleks0020', 0),
(10066, 'Rade', 'Radic', '123', 'aleks0021', 0),
(10067, 'Vasa', 'Vasic', '123', 'aleks0022', 0),
(10068, 'Rade', 'Radic', '123', 'aleks0023', 0),
(10069, 'Vasa', 'Vasic', '123', 'aleks0024', 0),
(10070, 'Sima', 'Simic', '123', 'aleks0025', 0),


(10080, 'Marko', 'Maric', '123', 'aleks1002', 0),
(10081, 'Ivan', 'Ivic', '123', 'aleks1003', 0),
(10082, 'Laza', 'Lazic', '123', 'aleks1004', 0),
(10083, 'Sima', 'Simic', '123', 'aleks1005', 0),
(10084, 'Pera', 'Peric', '123', 'aleks1006', 0),
(10085, 'Mika', 'Mikic', '123', 'aleks1007', 0),
(10086, 'Rade', 'Radic', '123', 'aleks1008', 0),
(10087, 'Vasa', 'Vasic', '123', 'aleks1009', 0),
(10088, 'Mika', 'Mikic', '123', 'aleks1010', 0),
(10089, 'Rade', 'Radic', '123', 'aleks1011', 0),
(10090, 'Vasa', 'Vasic', '123', 'aleks1012', 0),
(10091, 'Rade', 'Radic', '123', 'aleks1013', 0),
(10092, 'Vasa', 'Vasic', '123', 'aleks1014', 0),


(10093, 'Marko', 'Maric', '123', 'aleks2002', 0),
(10094, 'Ivan', 'Ivic', '123', 'aleks2003', 0),
(10095, 'Laza', 'Lazic', '123', 'aleks2004', 0),
(10096, 'Sima', 'Simic', '123', 'aleks2005', 0),
(10097, 'Pera', 'Peric', '123', 'aleks2006', 0),
(10098, 'Mika', 'Mikic', '123', 'aleks2007', 0),
(10099, 'Rade', 'Radic', '123', 'aleks2008', 0),
(10100, 'Vasa', 'Vasic', '123', 'aleks2009', 0),
(10101, 'Mika', 'Mikic', '123', 'aleks2010', 0),
(10102, 'Rade', 'Radic', '123', 'aleks2011', 0),
(10103, 'Vasa', 'Vasic', '123', 'aleks2012', 0),
(10104, 'Rade', 'Radic', '123', 'aleks2013', 0),
(10105, 'Vasa', 'Vasic', '123', 'aleks2014', 0),


(10106, 'Marko', 'Maric', '123', 'aleks3002', 0),
(10107, 'Ivan', 'Ivic', '123', 'aleks3003', 0),
(10108, 'Laza', 'Lazic', '123', 'aleks3004', 0),
(10109, 'Sima', 'Simic', '123', 'aleks3005', 0),
(10110, 'Pera', 'Peric', '123', 'aleks3006', 0),
(10111, 'Mika', 'Mikic', '123', 'aleks3007', 0),
(10112, 'Rade', 'Radic', '123', 'aleks3008', 0),
(10113, 'Vasa', 'Vasic', '123', 'aleks3009', 0),
(10114, 'Mika', 'Mikic', '123', 'aleks3010', 0),
(10115, 'Rade', 'Radic', '123', 'aleks3011', 0),
(10116, 'Vasa', 'Vasic', '123', 'aleks3012', 0),
(10117, 'Rade', 'Radic', '123', 'aleks3013', 0),
(10118, 'Vasa', 'Vasic', '123', 'aleks3014', 0),


(10119, 'Marko', 'Maric', '123', 'aleks4002', 0),
(10120, 'Ivan', 'Ivic', '123', 'aleks5003', 0),
(10121, 'Laza', 'Lazic', '123', 'aleks6004', 0),
(10122, 'Sima', 'Simic', '123', 'aleks7005', 0),
(10123, 'Pera', 'Peric', '123', 'aleks8006', 0),
(10124, 'Mika', 'Mikic', '123', 'aleks9007', 0),
(10125, 'Rade', 'Radic', '123', 'aleks3108', 0),
(10126, 'Vasa', 'Vasic', '123', 'aleks3109', 0),
(10127, 'Mika', 'Mikic', '123', 'aleks3110', 0),
(10128, 'Rade', 'Radic', '123', 'aleks3111', 0),
(10129, 'Vasa', 'Vasic', '123', 'aleks3112', 0),
(10130, 'Rade', 'Radic', '123', 'aleks3113', 0),
(10131, 'Vasa', 'Vasic', '123', 'aleks3114', 0),

(10132, 'Marko', 'Maric', '123', 'aleks5002', 0),
(10133, 'Ivan', 'Ivic', '123', 'aleks6003', 0),
(10134, 'Laza', 'Lazic', '123', 'aleks666004', 0),
(10135, 'Sima', 'Simic', '123', 'aleks6005', 0),
(10136, 'Pera', 'Peric', '123', 'aleks606', 0),
(10137, 'Mika', 'Mikic', '123', 'aleks6007', 0),
(10138, 'Rade', 'Radic', '123', 'aleks6108', 0),
(10139, 'Vasa', 'Vasic', '123', 'aleks6109', 0),
(10140, 'Mika', 'Mikic', '123', 'aleks6110', 0),
(10141, 'Rade', 'Radic', '123', 'aleks6111', 0),
(10142, 'Vasa', 'Vasic', '123', 'aleks6112', 0),
(10143, 'Rade', 'Radic', '123', 'aleks6113', 0),
(10144, 'Vasa', 'Vasic', '123', 'aleks6114', 0),

(10145, 'Marko', 'Maric', '123', 'aleks7002', 0),
(10146, 'Ivan', 'Ivic', '123', 'aleks7003', 0),
(10147, 'Laza', 'Lazic', '123', 'aleks7004', 0),
(10148, 'Sima', 'Simic', '123', 'aleks6705', 0),
(10149, 'Pera', 'Peric', '123', 'aleks7606', 0),
(10137, 'Mika', 'Mikic', '123', 'aleks7007', 0),
(10138, 'Rade', 'Radic', '123', 'aleks7108', 0),
(10139, 'Vasa', 'Vasic', '123', 'alek7109', 0),
(10140, 'Mika', 'Mikic', '123', 'aleks710', 0),
(10141, 'Rade', 'Radic', '123', 'aleks7111', 0),
(10142, 'Vasa', 'Vasic', '123', 'aleks7112', 0),
(10143, 'Rade', 'Radic', '123', 'aleks7113', 0),
(10144, 'Vasa', 'Vasic', '123', 'aleks7114', 0)

insert into adrese (id_grad,ulica, broj, x, y) values 
(9060, 'AdrM1bg', 111, 1 , 15),
(9060, 'AdrM2bg', 111, 1 , 16),
(9060, 'AdrM3bg', 111, 1 , 17),
(9060, 'AdrM4bg', 111, 1 , 18),
(9060, 'AdrM5bg', 111, 1 , 19),
(9061, 'AdrM1ue', 111, 2 , 15),
(9061, 'AdrM2ue', 111, 2 , 16),
(9061, 'AdrM3ue', 111, 2 , 17),
(9061, 'AdrM4ue', 111, 2 , 18),
(9062, 'AdrM3', 111, 3 , 15),
(9063, 'AdrM4', 111, 4 , 15),
(9064, 'AdrM5', 111, 5 , 15),
(9065, 'AdrM6', 111, 6 , 15),
(9066, 'AdrM7', 111, 7 , 15),
(9067, 'AdrM8', 111, 8 , 15),
(9068, 'AdrM9', 111, 9 , 15),
(9069, 'AdrM10', 111, 10 , 15),
(9070, 'AdrM11', 111, 11 , 15),
(9071, 'AdrM12', 111, 12 , 15)

insert into magacini(id_adresa) values
(10201),
(10202),
(10203),
(10204),
(10205),
(10206),
(10207),
(10208),
(10209),
(10210),
(10211),
(10212),
(10213),
(10214),
(10215),
(10216),
(10217),
(10218),
(10219)


insert into vozila (reg_br, tip_goriva, potrosnja, nosivost) values
('bg000001', 1, 10.0, 100.0),
('bg000002', 1, 10.0, 100.0),
('bg000003', 1, 10.0, 100.0),
('bg000004', 1, 10.0, 100.0),
('bg000005', 1, 10.0, 100.0),
('bg000006', 1, 10.0, 100.0),
('bg000007', 0, 10.0, 100.0),
('bg000008', 0, 10.0, 100.0),
('bg000009', 0, 10.0, 100.0),
('bg000010', 0, 10.0, 100.0),
('bg000020', 0, 10.0, 100.0),
('bg000030', 0, 10.0, 100.0),
('bg000040', 2, 10.0, 100.0),
('bg000050', 2, 10.0, 100.0),
('bg000060', 2, 10.0, 100.0),
('bg000070', 2, 10.0, 100.0),
('bg000080', 2, 10.0, 100.0),
('bg000090', 2, 10.0, 100.0)

insert into vozila (reg_br, tip_goriva, potrosnja, nosivost) values
('bg000101', 1, 10.0, 100.0),
('bg000102', 1, 10.0, 100.0),
('bg000103', 1, 10.0, 100.0),
('bg000104', 1, 10.0, 100.0),
('bg000105', 1, 10.0, 100.0),
('bg000106', 1, 10.0, 100.0),
('bg000107', 0, 10.0, 100.0),
('bg000108', 0, 10.0, 100.0),
('bg000109', 0, 10.0, 100.0),
('bg000110', 0, 10.0, 100.0),
('bg000120', 0, 10.0, 100.0),
('bg000130', 0, 10.0, 100.0),
('bg000140', 2, 10.0, 100.0),
('bg000150', 2, 10.0, 100.0),
('bg000160', 2, 10.0, 100.0),
('bg000170', 2, 10.0, 100.0),
('bg000180', 2, 10.0, 100.0),
('bg000190', 2, 10.0, 100.0)

insert into parkirana_vozila (reg_br, id_mag) values
('bg000001', 2686),
('bg000002', 2687),
('bg000003', 2688),
('bg000004', 2689),
('bg000005',2690),
('bg000006', 2691),
('bg000007', 2692),
('bg000008',2693),
('bg000009', 2694),
('bg000010', 2695),
('bg000020', 2696),
('bg000030',2697),
('bg000040', 2698),
('bg000050',  2699),
('bg000060',  2700),
('bg000070',2701),
('bg000080', 2702),
('bg000090', 2703)

insert into parkirana_vozila (reg_br, id_mag) values
('bg000101', 2686),
('bg000102', 2687),
('bg000103', 2688),
('bg000104', 2689),
('bg000105',2690),
('bg000106', 2691),
('bg000107', 2692),
('bg000108',2693),
('bg000109', 2694),
('bg000110', 2695),
('bg000120', 2696),
('bg000130',2697),
('bg000140', 2698),
('bg000150',  2699),
('bg000160',  2700),
('bg000170',2701),
('bg000180', 2702),
('bg000190', 2703)



insert into kuriri(br_vozacke,username) values
('1230', 'aleks0002'),
('1231', 'aleks0003'),
('1232', 'aleks0014'),
('1233', 'aleks0015'),
( '1234', 'aleks0016'),
( '1235', 'aleks0027'),
('1236', 'aleks0028'),
('1237', 'aleks0039'),
('1238', 'aleks0040'),
( '1239', 'aleks0041'),
( '1240', 'aleks0052'),
('1245', 'aleks0004'),
('1246', 'aleks0005')

insert into kurir_zahtevi(username,br_vozacke) values
('aleks0013', '0006'),
( 'aleks0014', '0017'),
( 'aleks0015', '0029'),
( 'aleks0016', '0043')


--zahtevi ali adrese su adrese magacina (provere radi)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks0013', 10058, 10110, 15.0, 1)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks0013', 10201, 10110, 15.0, 1)

---
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks0017', 10062, 10111, 50.0, 2)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks0018', 10063, 10084, 20.0, 1)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks0006', 10051, 10062, 15.0, 1)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks0007', 10052, 10085, 50.0, 2)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks0008', 10053, 10086, 28.0, 1)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks3006', 10110, 10062, 105.0, 1)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks3007', 10111, 10052, 54.0, 2)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks3008', 10112, 10122, 23.0, 1)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks1002', 10080, 10063, 15.0, 1)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks1003', 10081, 10125, 15.0, 2)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks1004', 10082, 10055, 23.0, 1)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks2006', 10097, 10113, 15.0, 1)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks2007', 10098, 10055, 65.0, 2)
insert into zahtevi_isporuka(username,id_adresa_p,id_adresa_k,tezina,tip_paketa) values
('aleks2008', 10099, 10067, 21.0, 1)

insert into kuriri(br_vozacke,username) values
('2230', 'aleks3009'),
('2231', 'aleks1005'),
('2232', 'aleks2009'),
('2233', 'aleks0019'),
( '2234', 'aleks0010')

