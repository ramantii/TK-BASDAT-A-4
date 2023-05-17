-- basdat A4
-- 2106706193 - Kevin Marcellius Alrino
-- 2106638495 - Ramanti Prajna Pratisthita
-- 2106720903 - Julian Justin Orvino
-- 2006483025 - Muhammad Farrel Sava Archini   

CREATE SCHEMA SEPAKBOLA;

SET SEARCH_PATH TO SEPAKBOLA;

CREATE TABLE User_System (
  Username VARCHAR(50) PRIMARY KEY,
  Password VARCHAR(20) NOT NULL
);

CREATE TABLE Tim (
    Nama_Tim VARCHAR(50) PRIMARY KEY,
    Universitas VARCHAR(50) NOT NULL
);

CREATE TABLE Pemain (
  ID_Pemain UUID PRIMARY KEY,
  Nama_Tim VARCHAR(50) REFERENCES Tim(Nama_Tim),
  Nama_Depan VARCHAR(50) NOT NULL,
  Nama_Belakang VARCHAR(50) NOT NULL,
  Nomor_HP VARCHAR(15) NOT NULL,
  Tgl_Lahir DATE NOT NULL,
  Is_Captain BOOLEAN NOT NULL,
  Posisi VARCHAR(50) NOT NULL,
  NPM VARCHAR(20) NOT NULL,
  Jenjang VARCHAR(20) NOT NULL
);

CREATE TABLE Non_Pemain (
  ID UUID PRIMARY KEY,
  Nama_Depan VARCHAR(50) NOT NULL,
  Nama_Belakang VARCHAR(50) NOT NULL,
  Nomor_HP VARCHAR(15) NOT NULL,
  Email VARCHAR(50) NOT NULL,
  Alamat VARCHAR(255) NOT NULL
);

CREATE TABLE Wasit (
  ID_Wasit UUID PRIMARY KEY,
  Lisensi VARCHAR(50) NOT NULL,
  FOREIGN KEY (ID_Wasit) REFERENCES Non_Pemain (ID)
);

CREATE TABLE Status_Non_Pemain (
  ID_Non_Pemain UUID NOT NULL,
  Status VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID_Non_Pemain, Status),
  FOREIGN KEY (ID_Non_Pemain) REFERENCES Non_Pemain (ID)
);

CREATE TABLE Stadium (
  ID_Stadium UUID PRIMARY KEY,
  Nama VARCHAR(50) NOT NULL,
  Alamat VARCHAR(255) NOT NULL,
  Kapasitas INT NOT NULL
);

CREATE TABLE Perlengkapan_Stadium (
    ID_Stadium UUID REFERENCES Stadium(ID_Stadium),
    Item VARCHAR(255) NOT NULL,
    Kapasitas INT NOT NULL,
    PRIMARY KEY (ID_Stadium, Item, Kapasitas)
);

CREATE TABLE Pertandingan (
    ID_Pertandingan UUID PRIMARY KEY,
    Start_Datetime TIMESTAMP NOT NULL,
    End_Datetime TIMESTAMP NOT NULL,
    Stadium UUID REFERENCES Stadium(ID_Stadium)
);

CREATE TABLE Peristiwa (
    ID_Pertandingan UUID NOT NULL,
    Datetime TIMESTAMP NOT NULL,
    Jenis VARCHAR(50) NOT NULL,
    ID_Pemain UUID,
    PRIMARY KEY (ID_Pertandingan, Datetime),
    FOREIGN KEY (ID_Pertandingan) REFERENCES Pertandingan(ID_Pertandingan),
    FOREIGN KEY (ID_Pemain) REFERENCES Pemain(ID_Pemain)
);

CREATE TABLE Wasit_Bertugas (
  ID_Wasit UUID REFERENCES Wasit(ID_Wasit),
  ID_Pertandingan UUID REFERENCES Pertandingan(ID_Pertandingan),
  Posisi_Wasit VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID_Wasit, ID_Pertandingan)
);

CREATE TABLE Penonton (
    ID_Penonton UUID PRIMARY KEY,
    Username VARCHAR(50) REFERENCES User_System(Username),
    FOREIGN KEY (ID_Penonton) REFERENCES Non_Pemain(ID)
);

CREATE TABLE Pembelian_Tiket (
  Nomor_Receipt VARCHAR(50) PRIMARY KEY,
  ID_Penonton UUID,
  Jenis_Tiket VARCHAR(50) NOT NULL,
  Jenis_Pembayaran VARCHAR(50) NOT NULL,
  ID_Pertandingan UUID,
  FOREIGN KEY (ID_Penonton) REFERENCES Penonton (ID_Penonton),
  FOREIGN KEY (ID_Pertandingan) REFERENCES Pertandingan (ID_Pertandingan)
);


CREATE TABLE Panitia (
    ID_Panitia UUID PRIMARY KEY REFERENCES Non_Pemain(ID),
    Jabatan VARCHAR(50) NOT NULL,
    Username VARCHAR(50) REFERENCES User_System(Username)
);

CREATE TABLE Pelatih (
   ID_Pelatih UUID PRIMARY KEY,
   Nama_Tim VARCHAR(50) REFERENCES Tim(Nama_Tim),
   FOREIGN KEY (ID_Pelatih) REFERENCES Non_Pemain(ID)
);


CREATE TABLE Spesialisasi_Pelatih (
  ID_Pelatih UUID REFERENCES Pelatih(ID_Pelatih),
  Spesialisasi VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID_Pelatih, Spesialisasi)
);


CREATE TABLE Tim_Pertandingan (
    Nama_Tim VARCHAR(50) REFERENCES Tim(Nama_Tim),
    ID_Pertandingan UUID REFERENCES Pertandingan(ID_Pertandingan),
    Skor VARCHAR(50) NOT NULL,
    Primary Key (Nama_Tim, ID_Pertandingan)
);

CREATE TABLE Manajer (
  ID_Manajer UUID PRIMARY KEY REFERENCES Non_Pemain(ID),
  Username VARCHAR(50) REFERENCES User_System(Username)
);

CREATE TABLE Tim_Manajer (
    ID_Manajer UUID REFERENCES Manajer(ID_Manajer),
    Nama_Tim VARCHAR(50) REFERENCES Tim(Nama_Tim),
    PRIMARY KEY (ID_Manajer, Nama_Tim)
);

CREATE TABLE Peminjaman (
    ID_Manajer UUID REFERENCES Manajer(ID_Manajer),
    Start_Datetime TIMESTAMP NOT NULL,
    End_Datetime TIMESTAMP NOT NULL,
    ID_Stadium UUID REFERENCES Stadium(ID_Stadium),
    PRIMARY KEY (ID_Manajer, Start_Datetime)
);

CREATE TABLE Rapat (
    ID_Pertandingan UUID,
    Datetime TIMESTAMP NOT NULL,
    Perwakilan_Panitia UUID NOT NULL,
    Manajer_Tim_A UUID NOT NULL,
    Manajer_Tim_B UUID NOT NULL,
    Isi_Rapat TEXT NOT NULL,
    PRIMARY KEY (Datetime, Perwakilan_Panitia, Manajer_Tim_A, Manajer_Tim_B),
    FOREIGN KEY (ID_Pertandingan) REFERENCES Pertandingan(ID_Pertandingan),
    FOREIGN KEY (Perwakilan_Panitia) REFERENCES Panitia(ID_Panitia),
    FOREIGN KEY (Manajer_Tim_A) REFERENCES Manajer(ID_Manajer),
    FOREIGN KEY (Manajer_Tim_B) REFERENCES Manajer(ID_Manajer)
);


INSERT INTO user_system VALUES ('mdeleek0','5TEkV32rYjO'),
	('nmcgerraghty1','g7ZDCzRmoDG'),
	('drepper2','ASsY2y34LJH'),
	('aager3','fXeYZNUc'),
	('twormald4','tNxzvbt1'),
	('jheaffey5','tRaFqMRdCH'),
	('kosheilds6','aFuVkd4qJMrH'),
	('parr7','qVYiRzeyfLR'),
	('qpriestner8','aXioKqCBp'),
	('sboltwood9','4GDMt3Pz2N'),
	('loatesa','oHRY9TLzVSE'),
	('cgaufordb','Luj8jx1xzF'),
	('gslobomc','5IVzmZ5Jgcc8'),
	('labreyd','nVCVPl1M'),
	('sfeyere','1q8kxLQ3FbU8'),
	('cparncuttf','U2vWFIU5'),
	('omattheeuwg','HzlWGKNBVgo'),
	('rratledgeh','qmjIVM'),
	('rchalcoti','yfSClWvXB'),
	('xwhitmorej','8rPFRQ52I'),
	('pkerfootk','3PXN2K'),
	('hskydalll','O67GvCVm2A'),
	('nmoodycliffem','m4qzAgU3'),
	('binskippn','rjQw95bZjWh'),
	('rjacobseno','GArxAy5RBS0'),
	('sbriggep','1NOEzW1sEXr'),
	('gparsonsq','ExCsf6UY'),
	('amusprattr','py7j9IPp'),
	('mgoomess','WWI1BjS0YZ'),
	('mbenkint','zdGLhdEF'),
	('clamswoodu','m47OfdOiSgu'),
	('cpesikv','LWkSdZUIUsaY'),
	('scarwithanw','evwl4A2'),
	('ewhifenx','NtOHaiQ6'),
	('sstuddy','v5KGUq'),
	('ihemphillz','Gx7vPdsh'),
	('fashling10','5YuNsakW8'),
	('ddulieu11','p8yy3zYUpI'),
	('mkauscher12','9BYb6Zj'),
	('zmccaughey13','6uPq9yQTIug'),
	('abenoey14','wjOxNypq'),
	('kfairbrace15','8beL2qYZ6Hq'),
	('ddepka16','AX18DqUto'),
	('fscargle17','rzsPBoX'),
	('bvanderkruis18','fsbPrl8'),
	('rhartly19','TsCJsu'),
	('adeniso1a','srj38oM0'),
	('ajikovsky1b','gvZUOi1W2lMy'),
	('bsawbridge1c','C8svEUfWG5sH'),
	('ymassinger1d','iMMXaPVj2');


INSERT INTO tim (nama_tim, universitas) VALUES ('Coppertone Kids', 'Northwood University');
INSERT INTO tim (nama_tim, universitas) VALUES ('Trelstar', 'Warner Pacific College');
INSERT INTO tim (nama_tim, universitas) VALUES ('WhiskCare 357', 'Azerbaijan National Conservatorie');
INSERT INTO tim (nama_tim, universitas) VALUES ('Xanax', 'Shahid Bahonar University of Kerman');
INSERT INTO tim (nama_tim, universitas) VALUES ('COREG', 'Southern Connecticut State University');
INSERT INTO tim (nama_tim, universitas) VALUES ('Gowoonsesang', 'Jinan University');
INSERT INTO tim (nama_tim, universitas) VALUES ('Aderall', 'National Ribat University');
INSERT INTO tim (nama_tim, universitas) VALUES ('CLINIMIX', 'Oklahoma State University - Oklahoma City');
INSERT INTO tim (nama_tim, universitas) VALUES ('Pravastatin', 'Adamawa State University');
INSERT INTO tim (nama_tim, universitas) VALUES ('Tylenol', 'University of Eastern Africa, Baraton');

INSERT INTO pemain (id_pemain, nama_tim, nama_depan, nama_belakang, nomor_hp, tgl_lahir, is_captain, posisi, npm, jenjang) VALUES
('c62af131-9ad5-4f1c-a3d2-e5a55a353d4a', 'Aderall', 'Eryn', 'Adderson', '8091884938', '2005-12-14', 'FALSE', 'Midfielder', '3256943764', 'S1'),
	('036040c1-ebe7-469f-949f-0f257a2a561a', 'Aderall', 'Corella', 'Ades', '2423019461', '2006-02-25', 'TRUE', 'Goalkeeper', '3471335935', 'S2'),
	('89b404ab-fc64-4b18-827a-35542f6f7bb7', 'Aderall', 'Rick', 'Ailmer', '9552510796', '2005-04-11', 'FALSE', 'Goalkeeper', '3094981704', 'S2'),
	('3f76b077-e8a6-4a5c-93bb-7bc56fa1993f', 'Aderall', 'Daisy', 'Akast', '2609281735', '2004-06-29', 'FALSE', 'Goalkeeper', '9755019359', 'D3'),
	('b2cfbca0-8383-4556-bfee-6be0c3f97d8e', 'Aderall', 'Emilia', 'Allchin', '8827855209', '2007-08-24', 'TRUE', 'Defender', '2951622597', 'S2'),
	('12b6dd17-75af-4b93-b0ec-037df6d32b5a', 'Aderall', 'Kele', 'Ambresin', '5603765449', '2004-11-10', 'TRUE', 'Midfielder', '486208028', 'D2'),
	('65588f39-9b39-4803-8ff7-9e42bae72e5d', 'Aderall', 'Ellene', 'Anglim', '1533676651', '2007-08-01', 'FALSE', 'Midfielder', '5593458308', 'S2'),
	('d672b14b-de96-49b2-ba45-a911d70defd4', 'Aderall', 'Pippa', 'Anten', '6504602072', '2006-10-13', 'FALSE', 'Forward', '7927803255', 'S1'),
	('8884529c-7cc8-48ce-93da-10afb19bed05', 'Aderall', 'Berky', 'Antoniewski', '7889362203', '2005-08-09', 'FALSE', 'Defender', '4818669555', 'D4'),
	('a5f60d5f-9d7b-468d-969a-cc9c4ab97f0e', 'Aderall', 'Poppy', 'Aronoff', '3808506995', '2007-03-09', 'FALSE', 'Goalkeeper', '2888168618', 'S1'),
	('3d0c116d-a847-432b-b8b5-61facc8ffe2c', 'Aderall', 'Ariadne', 'Arthan', '2607863204', '2004-08-11', 'TRUE', 'Forward', '8266841071', 'S3'),
	('10a42b90-b499-4481-b962-967349761582', 'Aderall', 'Rhiamon', 'Artois', '6766301910', '2004-12-23', 'FALSE', 'Midfielder', '2960221869', 'D2'),
	('2b614ad0-3f31-43d0-be7d-f9a206507d48', 'Aderall', 'Tyrus', 'Ashwell', '4624413931', '2005-02-28', 'TRUE', 'Defender', '8244378921', 'D2'),
	('1c5d4cf8-c241-46c2-9043-de32a23ea491', 'Aderall', 'Vanda', 'Astbery', '2448944028', '2005-08-07', 'FALSE', 'Forward', '1027978517', 'S2');
INSERT INTO pemain (id_pemain, nama_tim, nama_depan, nama_belakang, nomor_hp, tgl_lahir, is_captain, posisi, npm, jenjang) VALUES
	('959b8584-ed9c-4c47-9f4a-783f907a81ce', 'CLINIMIX', 'Lorettalorna', 'Atkins', '5759858810', '2004-03-22', 'TRUE', 'Goalkeeper', '3889365779', 'D1'),
	('4208adf0-f55e-4dc8-a9e0-8adf2d50cef1', 'CLINIMIX', 'Leila', 'Aubray', '6303040912', '2005-09-17', 'FALSE', 'Defender', '1301467995', 'S1'),
	('d6971986-d852-4fdc-8f5c-41a1712ed3c1', 'CLINIMIX', 'Malissa', 'Baford', '8394281891', '2005-07-18', 'TRUE', 'Forward', '76172171', 'D4'),
	('cdc60d78-01da-4b83-903e-f78841fd8981', 'CLINIMIX', 'Amara', 'Bagniuk', '7891810809', '2005-11-03', 'TRUE', 'Goalkeeper', '8531713889', 'S3'),
	('b49d0648-173e-4b6d-bfb4-d3863f6b9f9e', 'CLINIMIX', 'Dorotea', 'Baike', '9382924580', '2006-10-06', 'TRUE', 'Defender', '8992726465', 'D4'),
	('99e40c90-1108-4e6c-8bdf-3f3bf8464da3', 'CLINIMIX', 'Anton', 'Bamford', '4175382999', '2007-04-27', 'FALSE', 'Forward', '3014784435', 'D2'),
	('fc401e10-68d2-46be-8093-8f82e7e04b4c', 'CLINIMIX', 'Caro', 'Bamlett', '9798614689', '2004-10-09', 'TRUE', 'Goalkeeper', '1247731480', 'D4'),
	('72ea746d-a70d-46d7-8104-b62daf1ebb1c', 'CLINIMIX', 'Elana', 'Barclay', '7717519818', '2007-02-05', 'FALSE', 'Defender', '2308639911', 'D4'),
	('88fa5564-1002-43cd-8094-cab38255e2dc', 'CLINIMIX', 'Sybil', 'Barrus', '3165746306', '2004-06-03', 'TRUE', 'Goalkeeper', '6484005486', 'D2'),
	('595a13fa-3455-40b7-a321-8e19a00a85b4', 'CLINIMIX', 'Blanca', 'Barthelet', '6532265250', '2005-08-19', 'TRUE', 'Forward', '2550679962', 'S1'),
	('e775808a-c2c7-47b9-9029-b7e3022949b3', 'CLINIMIX', 'Renae', 'Bartle', '5447609254', '2004-07-12', 'FALSE', 'Goalkeeper', '9387071650', 'D3'),
	('36798d18-805f-4839-81cf-3af66317f6b2', 'CLINIMIX', 'Yanaton', 'Bartoszinski', '2013246299', '2006-06-15', 'FALSE', 'Goalkeeper', '8532349714', 'S1'),
	('1b0608ab-1913-4511-9acf-66ed34bb6e1f', 'CLINIMIX', 'Babbette', 'Bartul', '6377197845', '2004-11-23', 'FALSE', 'Defender', '6802741776', 'D1'),
	('858b8338-6a5c-4779-9a44-219ee4b21ad7', 'CLINIMIX', 'Ajay', 'Barzen', '5503676645', '2005-07-04', 'TRUE', 'Goalkeeper', '1501362151', 'D4'),
	('c3a801b0-e4fb-4d58-a18b-c47c993c524f', 'Coppertone Kids', 'Giorgio', 'Battill', '1101410328', '2006-09-09', 'FALSE', 'Midfielder', '8137910913', 'S2'),
	('57decc9f-b9be-443d-9507-037959435b55', 'Coppertone Kids', 'Klara', 'Bauser', '9399527337', '2006-11-26', 'TRUE', 'Forward', '4759654259', 'D3'),
	('e3be4805-7ec5-4993-8a8b-ab2983151068', 'Coppertone Kids', 'Andreana', 'Beades', '4188675991', '2004-01-28', 'FALSE', 'Defender', '7118819638', 'D4'),
	('861bafd2-bb99-400b-b461-e17550207b7b', 'Coppertone Kids', 'Kristopher', 'Beaten', '6975297127', '2006-07-09', 'TRUE', 'Midfielder', '6760849906', 'D1'),
	('9ec61f99-4cf9-476b-86a2-0d4db8a279af', 'Coppertone Kids', 'Meir', 'Bessell', '1859040932', '2006-10-24', 'FALSE', 'Defender', '6098479267', 'S1'),
	('feba1dba-3cff-4df6-86b3-c6377a8986da', 'Coppertone Kids', 'Fanny', 'Beven', '5771449192', '2006-02-17', 'FALSE', 'Goalkeeper', '992708370', 'S2'),
	('827776c6-3700-44cd-9df2-396b14288c37', 'Coppertone Kids', 'Genevieve', 'Bilofsky', '7073161326', '2006-02-22', 'FALSE', 'Defender', '4614400019', 'S2'),
	('c61645f8-57de-4f54-a4cd-aa5a1f5dff59', 'Coppertone Kids', 'Shaine', 'Blackwell', '6871296678', '2004-08-01', 'TRUE', 'Goalkeeper', '7068066798', 'D3'),
	('19463f2d-4e1c-4fe7-9bb0-68a415dd27f3', 'Coppertone Kids', 'Susie', 'Bletsor', '3545741293', '2007-05-11', 'FALSE', 'Goalkeeper', '8324218432', 'D2'),
	('26e9886d-0043-42c4-88b8-756a8c45e818', 'Coppertone Kids', 'Baron', 'Bloom', '3759157441', '2005-03-03', 'TRUE', 'Goalkeeper', '7388419659', 'S1'),
	('a314de05-7cac-45dd-864c-6f9c62d1ce53', 'Coppertone Kids', 'Harlie', 'Boarder', '8709426935', '2006-11-23', 'FALSE', 'Forward', '3352047944', 'S3'),
	('0cf7d247-4015-42fd-b8e1-fa5b8131ad90', 'Coppertone Kids', 'Trudie', 'Boffey', '1144068758', '2004-06-15', 'FALSE', 'Forward', '1671182537', 'D3'),
	('f2d0c7ba-52c2-4b0e-be8b-ee09bc0b53a7', 'Coppertone Kids', 'Liane', 'Bole', '5942145648', '2007-04-28', 'FALSE', 'Goalkeeper', '5389204123', 'S2'),
	('ce741ecf-ecab-458c-ac09-93c30f4fea4f', 'Coppertone Kids', 'Gail', 'Bortoli', '8137657328', '2007-07-13', 'FALSE', 'Defender', '6550673097', 'D1'),
	('7cc42ea9-c6de-432d-a545-39d1615e61a5', 'COREG', 'Alexandros', 'Bortolotti', '7216375682', '2006-02-04', 'TRUE', 'Forward', '997049367', 'S1'),
	('56fd00a4-6225-4ff2-9bd8-3cc5a989bee5', 'COREG', 'Ruthann', 'Bottoner', '1995293876', '2004-01-27', 'FALSE', 'Midfielder', '420184686', 'S3'),
	('da49d098-686a-45c2-be3b-b441eb9bdde5', 'COREG', 'Niel', 'Bowser', '8922543711', '2004-09-29', 'FALSE', 'Goalkeeper', '2140892461', 'D1'),
	('020575e1-fd6c-4152-9ab5-82ee8a100647', 'COREG', 'Marjory', 'Boxen', '6947486894', '2005-01-16', 'TRUE', 'Forward', '2332040579', 'S2'),
	('d2ba8218-3962-4737-a379-c26326b731cd', 'COREG', 'Jay', 'Boydell', '7316941298', '2004-04-07', 'TRUE', 'Defender', '7591421239', 'S3'),
	('b6f48383-afa7-44c8-9c35-a4267fd72563', 'COREG', 'Odelia', 'Braune', '8928758673', '2006-06-05', 'TRUE', 'Midfielder', '6392017941', 'D3'),
	('77ec0819-c45c-40d7-8b9a-41b45d6ad094', 'COREG', 'Meaghan', 'Brocklehurst', '2865177517', '2006-12-31', 'TRUE', 'Defender', '4232319425', 'D3'),
	('92b3c4ca-12f1-4597-aa42-3a7bc2e135c0', 'COREG', 'Gustie', 'Brockwell', '3212364254', '2004-03-09', 'FALSE', 'Goalkeeper', '6273596050', 'D2'),
	('b0d03db8-0a24-4ab0-9307-e1d53dda329f', 'COREG', 'Regan', 'Broose', '6254272778', '2004-02-22', 'FALSE', 'Midfielder', '6146441937', 'D4'),
	('6b7fa84c-3cc6-4830-a601-be432a48768c', 'COREG', 'Parry', 'Buckhurst', '5947127424', '2006-07-17', 'FALSE', 'Goalkeeper', '104661550', 'D1'),
	('e8518487-33a1-4720-bbe6-6ab345713c74', 'COREG', 'Mylo', 'Buff', '6374532481', '2005-08-25', 'FALSE', 'Defender', '278103758', 'D4'),
	('2abb35e3-3592-4ed5-acf5-6e39ecf2e5af', 'COREG', 'Torry', 'Bullant', '4739906657', '2007-05-16', 'FALSE', 'Forward', '2700965051', 'D1'),
	('7996e605-b50f-428f-95b2-98225e72df5c', 'COREG', 'Minerva', 'Burch', '8332601971', '2007-08-14', 'TRUE', 'Forward', '483847623', 'D1'),
	('ae6807b0-b6b7-4b53-89bc-56dd869c77ec', 'COREG', 'Riva', 'Bursnoll', '8606256807', '2005-06-17', 'FALSE', 'Midfielder', '7069465262', 'S1'),
	('459fe833-876f-40e6-a2bd-92022f62a0aa', 'Gowoonsesang', 'Julietta', 'Byrth', '5709827159', '2005-07-31', 'FALSE', 'Forward', '5470275361', 'S1'),
	('e0a8abd3-108b-4a54-a953-540111d83528', 'Gowoonsesang', 'Francoise', 'Calafato', '3007326864', '2006-08-30', 'FALSE', 'Forward', '7706193853', 'D3'),
	('3af5b51d-7ad9-4053-a984-9e6f89e30c08', 'Gowoonsesang', 'Daphna', 'Callen', '8163186864', '2006-07-06', 'FALSE', 'Defender', '5093164925', 'D3'),
	('3fb62225-4ce5-4855-8470-811cd1758efc', 'Gowoonsesang', 'Gipsy', 'Canwell', '8085728059', '2006-07-09', 'FALSE', 'Forward', '3748520123', 'D2'),
	('a38cee94-e0e0-40e4-9ae0-6677bd1b5b53', 'Gowoonsesang', 'Louie', 'Capon', '3767748460', '2005-11-23', 'FALSE', 'Defender', '334270499', 'D3'),
	('986e9373-9f1c-421c-84ce-82b854966d5c', 'Gowoonsesang', 'Raymund', 'Carbett', '6172481804', '2004-02-03', 'TRUE', 'Defender', '7971699069', 'S3'),
	('39c682f8-adaa-4b1f-b4fd-0a82f63076da', 'Gowoonsesang', 'Torre', 'Cardinale', '7144663831', '2005-02-24', 'TRUE', 'Goalkeeper', '3001094486', 'D2'),
	('c48ab2a3-3aac-429c-935b-6ade82dbc7dc', 'Gowoonsesang', 'Newton', 'Care', '2294255165', '2005-01-26', 'TRUE', 'Forward', '4162181268', 'S3'),
	('b3b5bc0e-f308-43dd-a960-cd553638a09f', 'Gowoonsesang', 'Lionel', 'Carlyon', '4212263632', '2006-11-20', 'TRUE', 'Midfielder', '260128783', 'D4'),
	('6d9f2b26-42b5-41e4-a12b-5cd819a8c762', 'Gowoonsesang', 'Rodrique', 'Carmo', '7519751006', '2006-06-25', 'FALSE', 'Goalkeeper', '241023629', 'S2'),
	('a4a774f2-2f06-49ff-94eb-0aa29e19d808', 'Gowoonsesang', 'Berget', 'Carvilla', '3328834167', '2004-11-11', 'FALSE', 'Midfielder', '3964776572', 'D4'),
	('64567537-f4f7-48e6-b481-3046b4480209', 'Gowoonsesang', 'Rhiamon', 'Case', '4612916694', '2006-05-31', 'FALSE', 'Midfielder', '349056595', 'D4'),
	('0e0545c2-f6e4-4be6-93fe-a87b86e65744', 'Gowoonsesang', 'Rosaline', 'Christofle', '8317860874', '2007-02-09', 'FALSE', 'Forward', '6846896449', 'D1'),
	('1a7973bb-3158-4037-abb0-6ef75f472f40', 'Gowoonsesang', 'Malachi', 'Cicchetto', '4385449417', '2006-08-02', 'FALSE', 'Defender', '3163409644', 'D3'),
	('80ad87ed-15ff-4eec-8021-a412781d2ddc', 'Pravastatin', 'Urbanus', 'Claige', '9185009086', '2007-07-21', 'TRUE', 'Goalkeeper', '809724669', 'D3'),
	('0304b0be-a4b1-457e-a3ac-05221a4a65fc', 'Pravastatin', 'Lucille', 'Cleminshaw', '8418763114', '2006-01-28', 'TRUE', 'Defender', '1673490034', 'D2'),
	('9e9f5381-a242-437a-8f28-f8ac0e74b1ee', 'Pravastatin', 'Dex', 'Clinch', '8969772749', '2006-01-13', 'FALSE', 'Forward', '2785720458', 'S1'),
	('e6c95554-5c84-4154-8a05-4b99fe263634', 'Pravastatin', 'Liv', 'Clines', '9426945237', '2004-01-13', 'TRUE', 'Goalkeeper', '860498573', 'D2'),
	('c9020e69-7f7a-4611-96a0-356ab0040916', 'Pravastatin', 'Adeline', 'Cliss', '2675894671', '2006-07-21', 'FALSE', 'Goalkeeper', '7124055415', 'D3'),
	('dd423959-6559-464e-89f5-9a4f47967685', 'Pravastatin', 'Phylis', 'Cobbold', '9712092986', '2004-09-02', 'TRUE', 'Defender', '6513224373', 'D4'),
	('48c80b19-bd40-412d-b2aa-099ae435340b', 'Pravastatin', 'Rabbi', 'Cochran', '9448066674', '2004-12-27', 'TRUE', 'Forward', '6545565281', 'S3'),
	('63f25597-d002-49e0-8400-2c2304271ca0', 'Pravastatin', 'Martainn', 'Cockren', '2703704063', '2006-05-29', 'FALSE', 'Defender', '6325950674', 'D1'),
	('95f7417c-e002-4ca7-acb2-02e57891e4fb', 'Pravastatin', 'Cliff', 'Collaton', '9146860214', '2005-07-08', 'TRUE', 'Defender', '5856205863', 'S3'),
	('c33727fe-ab45-4398-b9b1-0f77bc43bb23', 'Pravastatin', 'Cecilla', 'Collinge', '7533494376', '2006-04-01', 'FALSE', 'Midfielder', '7006710022', 'S3'),
	('97f1f362-43cc-46a6-8ace-023d067777a5', 'Pravastatin', 'Betty', 'Coonan', '5909953527', '2004-04-11', 'FALSE', 'Forward', '9267426087', 'D2'),
	('a5dcce26-6d3e-42ac-8707-1bcd5e065f11', 'Pravastatin', 'Van', 'Copson', '7915680594', '2006-11-16', 'FALSE', 'Midfielder', '6085285841', 'S2'),
	('235c9305-61af-48d2-8114-a92568e82fb7', 'Pravastatin', 'Mitchael', 'Corker', '9693621853', '2005-04-14', 'TRUE', 'Defender', '5698013373', 'S1'),
	('0005cae8-eca9-48cd-a668-2b3407bda323', 'Pravastatin', 'Hesther', 'Correa', '9958085364', '2007-04-13', 'TRUE', 'Defender', '7007663133', 'D1'),
	('1275c479-278a-41f5-a593-b983740043a8', 'Trelstar', 'Hyacinthie', 'Corson', '1472303327', '2005-01-21', 'TRUE', 'Forward', '1135140197', 'D3'),
	('4082f3be-b1e6-4439-8eca-077eb07cd463', 'Trelstar', 'Hamish', 'Cracie', '5453238164', '2004-01-18', 'FALSE', 'Midfielder', '463487281', 'D3'),
	('a44e1c15-f304-41ce-95d2-34400217bb40', 'Trelstar', 'Cullen', 'Craigmile', '2181941534', '2007-05-28', 'TRUE', 'Goalkeeper', '2472571119', 'S2'),
	('f76d0bc4-6d31-4b33-a04a-47f085d42e16', 'Trelstar', 'Jolynn', 'Cristofolo', '7038215821', '2007-02-10', 'FALSE', 'Goalkeeper', '5210019187', 'D3'),
	('ed97621a-b13d-43be-b5f4-496762fed2d5', 'Trelstar', 'Inness', 'Croal', '5882255879', '2004-12-08', 'FALSE', 'Goalkeeper', '7763637129', 'S1'),
	('01d47e8e-1959-4dfc-b0cc-23eaf3d4f800', 'Trelstar', 'Gavrielle', 'Cuffe', '6427850433', '2007-04-23', 'FALSE', 'Goalkeeper', '7634812102', 'S1'),
	('78fdc3ff-e182-4bc8-8250-1a4088cf8099', 'Trelstar', 'Morgun', 'Cully', '8132687525', '2004-10-17', 'FALSE', 'Defender', '8717626633', 'D2'),
	('cc01853f-fd49-4a14-b090-cfc6aec696b7', 'Trelstar', 'Lea', 'Cundict', '2986505444', '2005-01-29', 'TRUE', 'Defender', '3967004724', 'S3'),
	('580f6c12-a27c-469d-8c74-8047cda8e17d', 'Trelstar', 'Bunnie', 'Curteis', '8985469017', '2004-06-18', 'FALSE', 'Forward', '4875381077', 'D4'),
	('463cb4c4-3768-4908-bdb0-5e0d5b4a0e20', 'Trelstar', 'Mattias', 'Cutmere', '4991864434', '2004-06-19', 'FALSE', 'Goalkeeper', '5320570945', 'S2'),
	('c8e3f691-52c9-41b2-b8a5-e710647a06a4', 'Trelstar', 'Bobby', 'Dabnor', '4062427032', '2005-04-04', 'TRUE', 'Defender', '4715758997', 'S2'),
	('173febee-b0f3-4e38-bd61-fbb3136bdd56', 'Trelstar', 'Jane', 'Dallman', '7735046453', '2007-07-17', 'TRUE', 'Midfielder', '3548538150', 'S1'),
	('6719500a-3040-47cb-971d-825332b82d98', 'Trelstar', 'Lion', 'Damsell', '7036625817', '2006-05-18', 'TRUE', 'Goalkeeper', '106886622', 'S2'),
	('867b776f-7fae-4f08-817f-95b51ddedd39', 'Trelstar', 'Evangelin', 'Danell', '4583871471', '2005-06-25', 'TRUE', 'Forward', '1886937516', 'S1'),
	('a8f8be6e-390f-464a-bb0d-18d8cc8ff9aa', 'Tylenol', 'Der', 'Darkins', '5212786003', '2006-12-19', 'TRUE', 'Forward', '671640992', 'S3'),
	('1ce31381-cd2a-4bb7-b144-fdbeae32635f', 'Tylenol', 'Curt', 'Darnborough', '7188846264', '2005-12-03', 'TRUE', 'Goalkeeper', '6826672685', 'D4'),
	('5a3817be-ad52-4223-a17b-37b115cc6fac', 'Tylenol', 'Alonzo', 'Dartnell', '3292553664', '2004-12-10', 'FALSE', 'Goalkeeper', '6172667602', 'D4'),
	('838940ec-95aa-48ba-b311-2290f0ba1ca7', 'Tylenol', 'Nariko', 'Daysh', '3815860478', '2005-10-19', 'FALSE', 'Defender', '2056924196', 'S2'),
	('2b8116b0-228e-42a0-b339-e821f54e05f9', 'Tylenol', 'Vanya', 'De Andreis', '7654883582', '2006-11-07', 'TRUE', 'Forward', '264354435', 'S2'),
	('51bfe765-e575-48de-9679-5396d58dca5f', 'Tylenol', 'Farlay', 'Dedenham', '7766455471', '2006-12-09', 'TRUE', 'Midfielder', '2665746484', 'D3'),
	('dbdcbeae-1ea7-498c-a8d4-ac6bf2acfbae', 'Tylenol', 'Fee', 'Deeming', '6175663890', '2004-07-17', 'TRUE', 'Defender', '7605096860', 'S1'),
	('d1c2e5bc-ea4d-4944-bd8e-1657523f60e7', 'Tylenol', 'Larina', 'Denslow', '9462585192', '2004-02-23', 'FALSE', 'Forward', '1450661114', 'S2'),
	('8a9e598f-2f8a-4ecd-ac0a-f3c2626eb485', 'Tylenol', 'Kasey', 'Derisly', '6102858166', '2007-04-15', 'TRUE', 'Forward', '7949456337', 'D2'),
	('b8b8fa79-c6d2-4c22-8d84-b95901a3d422', 'Tylenol', 'Danica', 'Di Angelo', '7705558662', '2005-01-14', 'TRUE', 'Midfielder', '8382817599', 'S2'),
	('7aab8b80-2147-45db-9eb4-ce0346ccbfd9', 'Tylenol', 'Miof mela', 'Dicte', '3873894172', '2004-11-09', 'TRUE', 'Defender', '6003811595', 'S2'),
	('82e95da7-9e1d-4e41-90c6-94f5ddf21701', 'Tylenol', 'Guillemette', 'Digle', '8186856144', '2004-09-26', 'FALSE', 'Forward', '129848506', 'D2'),
	('16d91f39-c902-4f47-b795-f328e6fb65c6', 'Tylenol', 'Denise', 'Dinnis', '9278311745', '2005-02-24', 'TRUE', 'Goalkeeper', '5967327258', 'D3'),
	('c8d45bd2-d88e-4d2e-b90d-a79e2d53c4eb', 'Tylenol', 'Teddie', 'Doers', '4402009297', '2006-03-20', 'FALSE', 'Defender', '2451747404', 'D1'),
	('afdad935-657a-4120-8140-b54b35c69676', 'WhiskCare 357', 'Ben', 'Dover', '5247284991', '2006-05-26', 'FALSE', 'Forward', '7141242937', 'S3'),
	('69a14353-d51d-41a6-83d6-5111678390a1', 'WhiskCare 357', 'Misha', 'Downe', '9019532139', '2006-07-14', 'FALSE', 'Forward', '5074084458', 'S1'),
	('f3afe08e-41f0-43a9-92ac-e92df594cf5f', 'WhiskCare 357', 'Janella', 'Dragonette', '1753602099', '2005-09-30', 'TRUE', 'Midfielder', '4533201318', 'D3'),
	('9d62c3f7-c5df-4131-8924-556fe25c7494', 'WhiskCare 357', 'Carling', 'Drain', '4136710952', '2005-01-18', 'TRUE', 'Defender', '2884922032', 'S1'),
	('65f576e7-7532-4b01-acb3-583c8a5f95b6', 'WhiskCare 357', 'Haley', 'Dubbin', '9741775527', '2007-03-03', 'TRUE', 'Midfielder', '4649608600', 'D2'),
	('843c2085-e13f-4c47-bff1-62fb8e96f0c7', 'WhiskCare 357', 'Rickey', 'Duckwith', '1439726412', '2005-12-24', 'TRUE', 'Forward', '7298880810', 'S2'),
	('ad4301dd-7f20-4ab7-883f-47a93ab80779', 'WhiskCare 357', 'Cordelie', 'Dudderidge', '6955019744', '2005-11-25', 'TRUE', 'Defender', '4648661796', 'D2'),
	('a2332d4a-e631-4b7d-a09f-a0d35cb6cae6', 'WhiskCare 357', 'Agathe', 'Dulake', '2196397726', '2004-01-19', 'TRUE', 'Goalkeeper', '1120506077', 'S3'),
	('d5a0a13b-b102-4859-a048-052dae9e86a1', 'WhiskCare 357', 'Ernestine', 'Dullingham', '4398474161', '2006-08-11', 'FALSE', 'Goalkeeper', '8085952378', 'D2'),
	('4ab855be-2038-4b74-8281-765b1aba04c6', 'WhiskCare 357', 'Antonina', 'Dumberell', '9422429957', '2006-05-07', 'TRUE', 'Forward', '883041766', 'S2'),
	('e88ced43-455a-4443-ba58-dbb28a0ce11c', 'WhiskCare 357', 'Phaedra', 'Dumingos', '3623995019', '2004-04-02', 'FALSE', 'Forward', '802437133', 'S1'),
	('82d5b843-8f3d-4448-8c45-a20136f398f7', 'WhiskCare 357', 'Drona', 'Dunican', '9024447680', '2005-08-11', 'TRUE', 'Midfielder', '9103791793', 'S1'),
	('ce3c8ef9-f7f9-4df1-a1f4-94a69a00f5cc', 'WhiskCare 357', 'Eva', 'Durrell', '5203821313', '2006-04-30', 'FALSE', 'Defender', '8527191172', 'S3'),
	('f5f28fd0-e332-481e-91c1-e21b3f940edc', 'WhiskCare 357', 'Temp', 'Durtnal', '8716191655', '2006-07-09', 'FALSE', 'Forward', '4795311110', 'S1'),
	('90e93470-7aa4-431c-bb68-4f91e7c58f8f', 'Xanax', 'Reginald', 'Duxbarry', '7012899096', '2004-12-23', 'FALSE', 'Forward', '2468125738', 'S3'),
	('77d4924a-f70c-46f1-b7a0-bb58d952d629', 'Xanax', 'Adele', 'Dyer', '9586337918', '2006-06-25', 'TRUE', 'Midfielder', '3678052916', 'D3'),
	('bfd88fc2-ca08-4ef8-8be1-7751bd136c14', 'Xanax', 'Chicky', 'Dyster', '7831324144', '2004-11-02', 'FALSE', 'Midfielder', '3741216410', 'D4'),
	('1cec48dc-8769-4009-903a-3da9834fbfce', 'Xanax', 'Alikee', 'Eadon', '7742482665', '2007-01-01', 'TRUE', 'Goalkeeper', '5268915622', 'D1'),
	('a4482805-3992-4577-9e27-5f9c48251ec4', 'Xanax', 'Harley', 'Eaves', '1946308288', '2005-09-15', 'FALSE', 'Goalkeeper', '4562149000', 'D3'),
	('bf3252ec-3bbd-4446-af88-ecbd802b2567', 'Xanax', 'Georgianne', 'Edmondson', '7884183530', '2007-07-14', 'FALSE', 'Forward', '631879005', 'D1'),
	('ed1d2801-90cd-4fe3-9ef5-3fd9796ee7ac', 'Xanax', 'Ricki', 'Elverston', '5559071945', '2007-05-25', 'FALSE', 'Forward', '3311026527', 'S2'),
	('196478ff-052c-4b85-b384-ffd6e24fc7d1', 'Xanax', 'Moss', 'Escot', '2924004368', '2005-09-15', 'FALSE', 'Midfielder', '5949335902', 'D4'),
	('726c78b2-725f-4986-9596-3801ba811720', 'Xanax', 'Ermina', 'Eshmade', '2846241370', '2004-06-16', 'FALSE', 'Defender', '9134541470', 'S2'),
	('e06bb7ef-e459-4f68-8876-0ef6d4385f96', 'Xanax', 'Corissa', 'Euston', '8138444851', '2006-06-11', 'FALSE', 'Forward', '6864517284', 'S2'),
	('a26cdbec-03ed-4226-a6b6-2d2bb57029fc', 'Xanax', 'Diego', 'Fenby', '1897292775', '2007-04-12', 'FALSE', 'Midfielder', '195136888', 'D3'),
	('4c2152b4-c1a2-4bb9-adf3-edec3525445a', 'Xanax', 'Doy', 'Fender', '6195878980', '2005-12-29', 'TRUE', 'Forward', '7427244508', 'S3'),
	('0a705df4-7320-4001-bb4c-e9a70ad0353e', 'Xanax', 'Debora', 'Ferenczi', '3743712043', '2004-04-15', 'TRUE', 'Defender', '7565283827', 'S1'),
	('9b007e9c-2608-4feb-9e41-204a7379be13', 'Xanax', 'Gwyneth', 'Fern', '6687843209', '2006-07-19', 'FALSE', 'Forward', '3154582894', 'S3');



INSERT INTO pemain (id_pemain, nama_depan, nama_belakang, nomor_hp, tgl_lahir, is_captain, posisi, npm, jenjang) VALUES
	('bbf937c1-09c5-48c5-a93a-afa69a1984eb', 'Jennifer', 'Fideler', '2296082936', '2006-04-19', 'TRUE', 'Midfielder', '5802304227', 'D3'),
	('678769e9-7103-4e31-8135-93d5e97bf2e2', 'Wendy', 'Fidelus', '1778515045', '2004-10-28', 'TRUE', 'Midfielder', '4991665493', 'S3'),
	('9eb7dc17-9a40-4f3c-b5a9-d15a2814a3b3', 'Hakim', 'Fincken', '3597892268', '2005-12-22', 'TRUE', 'Forward', '6224500924', 'D3'),
	('f7f194cc-3d74-4c27-9b97-dabea0cf1df1', 'Westley', 'Fitkin', '6733939648', '2004-04-29', 'FALSE', 'Forward', '1793018685', 'D3'),
	('6c55eecb-0a1f-49c1-8a7d-bbe830903d2a', 'Wolfgang', 'Foggo', '8896285092', '2004-02-08', 'TRUE', 'Defender', '2268565017', 'D3'),
	('5c1b02b7-f571-4181-8c2c-babb10c2e08f', 'Skell', 'Fortnum', '7109537081', '2006-02-27', 'TRUE', 'Midfielder', '4217844441', 'S2'),
	('692db0f2-c297-415f-9e11-6f61404ab0c7', 'Dorotea', 'Foster-Smith', '2348413488', '2007-02-09', 'TRUE', 'Goalkeeper', '4042708439', 'S3'),
	('81bd112a-8908-4155-8733-afb786bab13e', 'Tessie', 'Foster-Smith', '1202188734', '2005-08-24', 'TRUE', 'Forward', '9523324128', 'S3'),
	('948705e5-eb20-4e63-920e-9832eecfa84f', 'Aguie', 'Foxton', '6151425170', '2004-10-30', 'TRUE', 'Defender', '8238997674', 'S3'),
	('541780c4-8486-49a3-98b2-b7382a573464', 'Ingamar', 'Franiak', '7467794614', '2005-03-04', 'FALSE', 'Goalkeeper', '3010478208', 'D3'),
	('4b06efb2-7d92-45aa-ae75-64625939d722', 'Robb', 'Freyn', '1732311166', '2006-05-10', 'FALSE', 'Midfielder', '6313156064', 'S1'),
	('6f114e46-0153-4f85-982c-c2731aae999e', 'Aurelia', 'Fulle', '3967592813', '2006-01-23', 'TRUE', 'Midfielder', '4225282201', 'D3'),
	('3932f7df-9d27-4679-a6f5-6f7dd1bf1117', 'Shay', 'Gaffney', '8004354572', '2004-11-11', 'TRUE', 'Goalkeeper', '3028374358', 'D3'),
	('16407d68-6dda-4eb5-9d5b-169e4cdbb6c3', 'Kelvin', 'Gardner', '4862446074', '2004-12-03', 'FALSE', 'Midfielder', '3085782737', 'S3'),
	('aa60d531-1d3f-41dc-b351-5bd965ea7659', 'Emerson', 'Gavozzi', '5442012033', '2005-07-01', 'TRUE', 'Forward', '6025815690', 'S3'),
	('8519964a-77d3-40e8-afcd-d4adf6eeeeae', 'Jandy', 'Gaynor', '9092216324', '2004-01-15', 'FALSE', 'Defender', '6542590579', 'S3'),
	('fdbb0a9a-8e4c-4cf5-bb09-7c56f640b124', 'Bartlett', 'Geck', '6448767659', '2004-11-18', 'FALSE', 'Forward', '5733431415', 'D3'),
	('13351b0e-6ba4-4d46-a2c6-f364a9dd261c', 'Rochell', 'Genney', '1092885654', '2004-12-28', 'FALSE', 'Midfielder', '966106288', 'S1'),
	('0579dd84-96f4-4265-9528-af8094fdd433', 'Sheffield', 'Geroldo', '8756100379', '2007-03-24', 'TRUE', 'Forward', '8736689890', 'D1'),
	('d687b56b-cd98-4ae5-88d2-6d6f4d423a9d', 'Elena', 'Getten', '5121509543', '2006-03-03', 'FALSE', 'Goalkeeper', '3030475832', 'S2'),
	('f47e17b5-f7f8-42ab-b363-147132e25143', 'Pippo', 'Gheraldi', '3863013049', '2006-09-28', 'FALSE', 'Forward', '4756900623', 'D4'),
	('085b19b5-0b42-42bd-a763-dead27404276', 'Graig', 'Ghiriardelli', '8365857543', '2004-12-23', 'TRUE', 'Midfielder', '9611940823', 'D4'),
	('1ca8a829-5135-4ed5-a75f-62f67c112f8c', 'Dicky', 'Gildersleaves', '1472894680', '2006-10-02', 'TRUE', 'Goalkeeper', '5095578972', 'S1'),
	('1092d6eb-86cb-4643-ac49-0d759a5f12cc', 'Guss', 'Gillbe', '4427787364', '2004-08-25', 'TRUE', 'Midfielder', '789461099', 'S3'),
	('508436af-a4c5-4ecc-845c-825e6023a942', 'Jillene', 'Girardey', '7074488936', '2004-05-28', 'TRUE', 'Midfielder', '102386234', 'D4'),
	('90f6016b-7505-43b1-a38d-c9c236d596cd', 'Ilysa', 'Glastonbury', '4646586232', '2004-04-01', 'TRUE', 'Forward', '9572407953', 'S2'),
	('4137ffd4-d5c4-42c1-9dc3-9fc8d58302f6', 'Laina', 'Glenfield', '7552071216', '2005-01-22', 'TRUE', 'Defender', '4147442048', 'S3'),
	('3c4c8b55-b0be-4103-a14c-28e12e5b91fa', 'Jolynn', 'Glowacz', '7067017373', '2007-03-13', 'FALSE', 'Defender', '275760294', 'S2'),
	('045cc4aa-3046-46fa-8e3b-f807f6016ac2', 'Stephan', 'Gobat', '5639009661', '2005-07-03', 'FALSE', 'Forward', '2898607363', 'S1'),
	('e0089989-73ee-437c-b989-4b92fef3c3de', 'Jaine', 'Godilington', '2506432282', '2004-09-09', 'TRUE', 'Midfielder', '3737264953', 'D2'),
	('ecc2d5a4-c2b2-4d44-bc44-d008f484c97b', 'Vivyanne', 'Golborne', '1008013556', '2004-06-28', 'FALSE', 'Forward', '5442640751', 'S1'),
	('fdade0d8-0ddc-4ced-bbbb-7ef0ab46e86b', 'Caron', 'Gonzalo', '5289746934', '2004-07-12', 'TRUE', 'Midfielder', '4174167931', 'D3'),
	('f8e2ae98-8691-403b-a1a4-6c2a497f8a9c', 'Chantal', 'Gooddie', '7489871159', '2005-12-29', 'FALSE', 'Forward', '63603837', 'D1'),
	('63f71cce-7cea-4f5a-8840-536288268183', 'Nikita', 'Goodlatt', '7041180307', '2006-05-27', 'FALSE', 'Forward', '9106131611', 'S2'),
	('9d968228-2650-491e-99c8-fdf74861920c', 'Alvera', 'Goodlife', '6368685227', '2005-10-17', 'TRUE', 'Goalkeeper', '6556193305', 'S2'),
	('cad3f334-edd2-491b-be04-667152b46c1d', 'Christye', 'Gregoretti', '1902177217', '2005-07-15', 'FALSE', 'Defender', '8567684242', 'S1'),
	('1ceeb366-84ee-4d39-9ca3-ec03488d9527', 'Melina', 'Grinley', '8394499139', '2004-02-19', 'FALSE', 'Defender', '1802297553', 'S2'),
	('a386c93b-ce47-4ac7-9bb8-38cd25120bd5', 'Faye', 'Gristhwaite', '5884185336', '2004-02-27', 'TRUE', 'Goalkeeper', '5953171293', 'S2'),
	('c68644df-9438-41ab-9ea5-43a220a4bec4', 'Rourke', 'Guitonneau', '8143535915', '2005-02-21', 'FALSE', 'Midfielder', '6563629288', 'D3'),
	('3eaeaf7e-ae0f-4471-941b-069e01bf63db', 'Eustacia', 'Gullick', '2441304007', '2004-09-28', 'FALSE', 'Forward', '4237297675', 'D1'),
	('d2c23cfa-75a1-401f-a9e7-9ff30ed2752f', 'Sloane', 'Hackleton', '6588922673', '2005-06-07', 'TRUE', 'Forward', '5489790083', 'D4'),
	('5bf626d3-156e-4dff-b4c1-6fb34aeb6e12', 'Maggy', 'Hadgraft', '6906910983', '2006-10-24', 'FALSE', 'Midfielder', '4390628976', 'D2'),
	('a93759ac-5914-466c-bbec-990512eeb54c', 'Loydie', 'Hallifax', '4029645197', '2005-01-22', 'FALSE', 'Midfielder', '4416395868', 'S1'),
	('698bc1ea-18fa-4fa0-9e2d-6c313b54ce69', 'Grange', 'Hambly', '4882352355', '2006-01-06', 'FALSE', 'Midfielder', '7194544555', 'D1'),
	('ab11f806-3860-4006-af72-0f54d266229d', 'Lauren', 'Hannaford', '3359313550', '2007-06-16', 'FALSE', 'Defender', '1180337417', 'D4'),
	('26863300-0b44-4990-b8fd-6c47def505ae', 'Davin', 'Hansod', '9167007045', '2004-09-18', 'FALSE', 'Defender', '3172056961', 'D2'),
	('6ce91942-bcb3-4eb3-b8d0-70ad947d5a2f', 'Micheil', 'Harflete', '5319622403', '2004-10-29', 'FALSE', 'Forward', '6332914300', 'D1'),
	('b90751f8-c5ca-4ac6-88f2-9e36c79664df', 'Jamill', 'Haselgrove', '1207327241', '2007-02-28', 'TRUE', 'Defender', '2793712949', 'S1'),
	('d89f0d93-0971-4fd8-8bc6-fafd9bf6ec68', 'Janice', 'Hasell', '9269365543', '2005-06-07', 'TRUE', 'Goalkeeper', '5777623557', 'S1'),
	('4e33fa7e-8636-4254-8dd0-cc2641739a33', 'Jania', 'Hatfull', '2219564271', '2007-07-26', 'TRUE', 'Defender', '5137018732', 'S1'),
	('be41f01e-2600-44d2-8db8-62814ea5271b', 'Stephanus', 'Hazeup', '7191511105', '2005-04-18', 'FALSE', 'Midfielder', '2100552724', 'S3'),
	('ba08e25e-c0e2-4b00-8654-ac14e4dd7579', 'Ike', 'Heavy', '9564390400', '2006-05-16', 'FALSE', 'Forward', '1273917502', 'D3'),
	('e97b2655-5a49-45fc-8be8-5afc1a65afc5', 'Eldredge', 'Heditch', '3899851360', '2005-11-23', 'TRUE', 'Midfielder', '4362821899', 'D2'),
	('08d659c3-e4b6-49f5-845f-db6df10b6482', 'Gerianne', 'Highwood', '8818265455', '2006-12-23', 'FALSE', 'Goalkeeper', '4195348013', 'S3'),
	('57882d33-fb6c-48a0-a888-94cf9469b3f8', 'Olav', 'Hoogendorp', '9047177483', '2004-11-03', 'FALSE', 'Midfielder', '2141346711', 'S3'),
	('97bd1039-c4c0-4d51-8151-ddce97a2f936', 'Ricky', 'Houlworth', '6079058316', '2007-08-15', 'FALSE', 'Midfielder', '9783876546', 'D4'),
	('1be0c59d-c4f2-4a5a-9103-e2260cde2e69', 'Florencia', 'Howchin', '8823312669', '2005-12-15', 'FALSE', 'Forward', '5749343529', 'D4'),
	('2f02c3ec-d325-479d-bd45-7f18400bb6ec', 'Nicolina', 'Hrishchenko', '6557804764', '2005-02-22', 'FALSE', 'Midfielder', '7116837396', 'D4'),
	('13b3dd5c-33fd-482f-bb06-f1752ac5dee1', 'Lillian', 'Hryncewicz', '8293695293', '2005-09-30', 'TRUE', 'Goalkeeper', '9923127400', 'S3'),
	('861a1144-0f31-4d13-8808-c4a3e34f03b7', 'Paulie', 'Huckel', '7567481980', '2004-10-06', 'FALSE', 'Forward', '6958557441', 'S2'),
	('64d78cb8-38c4-4638-a682-d4e7004bc8b4', 'Konstantin', 'Hugueville', '2814630750', '2006-04-30', 'TRUE', 'Midfielder', '8039607612', 'D3'),
	('dfec6350-f0de-4fad-b339-acc213b40eed', 'Jordain', 'Iggo', '7271817462', '2007-01-07', 'FALSE', 'Forward', '893559385', 'S2'),
	('b9160c5a-eaaf-40da-bbbd-80f48daf7f51', 'Arch', 'Insull', '9154835224', '2006-01-31', 'TRUE', 'Defender', '9652584207', 'S2'),
	('29e91c10-8a96-43b8-a888-0970560033de', 'Dene', 'Ivan', '1391572338', '2004-06-04', 'FALSE', 'Forward', '7323720001', 'D2'),
	('563db783-eba8-4cd5-8664-5df5d0fa69ae', 'Harley', 'Ivatt', '9426521050', '2004-05-07', 'TRUE', 'Goalkeeper', '6952546324', 'D1'),
	('0fba35fd-ae3a-45a4-9507-81610845f7a2', 'Joannes', 'Jeaffreson', '5459137203', '2005-07-31', 'FALSE', 'Forward', '4662181895', 'S1'),
	('420815cc-43c1-4d89-9712-3f3c63294458', 'Tandy', 'Jeannel', '8972224974', '2004-09-02', 'FALSE', 'Goalkeeper', '9305905382', 'S2'),
	('484f4f08-dee9-4fb2-86dd-33e695d440d2', 'Melonie', 'Jekel', '7149727905', '2007-08-15', 'FALSE', 'Defender', '2091380350', 'D2'),
	('fd7d7c05-1b13-47a5-bc28-44682e8ce542', 'Jonathan', 'Jobbins', '4917223920', '2005-01-04', 'TRUE', 'Defender', '6683282471', 'D3'),
	('da285a27-a339-48c0-87b6-d895ece7a1c3', 'Delphine', 'Joplin', '1837260919', '2005-03-02', 'TRUE', 'Midfielder', '7734849210', 'S1'),
	('0ea8d3c6-ab50-4148-a7e6-e14a94fbf351', 'Noak', 'Jorden', '4932576358', '2006-02-09', 'TRUE', 'Goalkeeper', '5594058893', 'D3'),
	('9f43e46d-eff3-4cc1-acbe-77fa346e6c56', 'Cary', 'Joreau', '1265057187', '2004-10-07', 'FALSE', 'Defender', '7489105439', 'D3'),
	('0bb44e1a-245d-4478-9a5c-8e48480e0498', 'Basilio', 'Josey', '7863477806', '2006-05-29', 'TRUE', 'Midfielder', '5067857129', 'D3'),
	('69ad1d9f-6081-4c7b-b0cb-e1f3747b5d13', 'Kara-lynn', 'Joutapavicius', '6148600521', '2006-04-29', 'FALSE', 'Midfielder', '761613773', 'D2'),
	('40fd5674-5938-419e-9f76-5ab25d403545', 'Fremont', 'Kaas', '6927234066', '2005-06-02', 'TRUE', 'Forward', '9448402201', 'S1'),
	('48fa9c67-0bf3-4dee-94d0-16608ecf013e', 'Xena', 'Kadwallider', '1625934509', '2005-09-04', 'FALSE', 'Forward', '4976896277', 'D1'),
	('fd45868c-555e-431a-840a-51d265d07aa7', 'Cathrine', 'Karpeev', '8939506298', '2004-11-20', 'TRUE', 'Defender', '1605917338', 'D4'),
	('9fcaef07-4fb8-4daa-b493-ad7538b8910a', 'Aryn', 'Keady', '9061556484', '2005-08-27', 'TRUE', 'Goalkeeper', '1951011929', 'S3'),
	('2a45151c-ebd4-4ace-9cfe-e9b97d9ca972', 'Phaidra', 'Keggins', '2747632223', '2006-07-02', 'TRUE', 'Defender', '2761855027', 'S1'),
	('90c5f3e4-fc05-4f86-a952-e21e78ae6855', 'Avery', 'Kenneford', '6982485995', '2006-10-29', 'TRUE', 'Midfielder', '2197972987', 'S2'),
	('c05b05c6-bec5-459d-8075-48a73c0809c4', 'Bernete', 'Kenrack', '1082120041', '2004-05-27', 'FALSE', 'Midfielder', '7627554497', 'S3'),
	('4b6467fd-f4c8-40b1-ae72-cad0c0ea3e90', 'Malinde', 'Keppie', '3311486775', '2006-11-10', 'TRUE', 'Goalkeeper', '6251378913', 'D2'),
	('d8ed8f98-cce8-463e-80af-345e05ab72ad', 'Gaby', 'Kikke', '9855225198', '2004-12-19', 'TRUE', 'Defender', '4773639229', 'D2'),
	('fed6e731-9f3b-460d-aa4c-18d274112bc1', 'Franky', 'Kildale', '3553152524', '2007-03-16', 'TRUE', 'Goalkeeper', '5295450694', 'S1'),
	('7b117ee2-0c78-4977-9b51-e8b25e162cd8', 'Deirdre', 'Killingbeck', '4467530979', '2007-04-30', 'FALSE', 'Forward', '135226171', 'D4'),
	('abe742e2-9e03-4e38-a85b-eead40fc69f8', 'Daphene', 'King', '6957080118', '2007-05-07', 'TRUE', 'Midfielder', '7707468767', 'S3'),
	('e916c880-85af-4bff-b5b6-70a4018435ee', 'Patrice', 'Kinig', '7044243196', '2004-04-05', 'FALSE', 'Forward', '4602399320', 'S1'),
	('cd2de6e3-a18d-4a46-871b-5381daa4b82d', 'Christye', 'Kinsley', '4668446799', '2004-08-22', 'TRUE', 'Defender', '3128116865', 'S2'),
	('ac54e231-a608-4886-b43f-f2b34336ef56', 'Juliane', 'Kivelhan', '4337338987', '2004-05-30', 'TRUE', 'Goalkeeper', '5666468316', 'S3'),
	('076cfc64-270c-450e-a092-d6e3300e146d', 'Milt', 'Klewi', '8538531653', '2007-07-27', 'FALSE', 'Midfielder', '42360277', 'D2'),
	('99ba674f-73db-41df-bbae-37240271fa8d', 'Darryl', 'Klimek', '9253620232', '2004-03-03', 'TRUE', 'Forward', '5051233384', 'S3'),
	('29f87425-e941-4836-821a-0c6ecbaa93ac', 'Bastien', 'Klos', '4628069051', '2006-04-02', 'TRUE', 'Defender', '3146383012', 'D2'),
	('e104f580-ab6a-4fa1-aa5b-73896b69ffd8', 'Englebert', 'Klulisek', '9631411087', '2006-12-02', 'FALSE', 'Defender', '8327586122', 'D4'),
	('8f7b616a-fac8-4b9a-8987-f6c918c0815a', 'Cathryn', 'Ladds', '9112591922', '2004-01-08', 'FALSE', 'Goalkeeper', '4627668309', 'S3'),
	('77b7105b-3a2e-4bd7-a7b2-72c07f5f7d92', 'Cinderella', 'Lammertz', '9115165406', '2006-04-24', 'FALSE', 'Midfielder', '5563890503', 'D4'),
	('7f0382d8-c61e-47ae-933d-32c542871cbe', 'Iris', 'Lanfere', '1546067003', '2007-06-14', 'TRUE', 'Goalkeeper', '4731348978', 'D4'),
	('268c34d5-443c-499c-a53a-cd7800f3eec8', 'Con', 'Langhorn', '6218265545', '2007-05-15', 'FALSE', 'Forward', '9369946187', 'S2'),
	('2fd148c5-1e63-4666-b0c1-0f0f2d1f2a0c', 'Torrey', 'Lanston', '5126114351', '2007-06-18', 'FALSE', 'Midfielder', '9055521957', 'D4'),
	('8f1053cf-b2b2-4c04-9dd2-1683790ff140', 'Wittie', 'Lascell', '7277993818', '2006-07-21', 'TRUE', 'Defender', '6659392467', 'D3'),
	('2332eb06-25a5-4319-864c-dfed015bd84f', 'Cathe', 'Late', '2902931477', '2007-03-06', 'TRUE', 'Goalkeeper', '7115125295', 'S3'),
	('ea062c3f-fc1b-44d3-8bc9-df48415ef0da', 'Jethro', 'Lefeuvre', '4139189597', '2005-08-13', 'TRUE', 'Midfielder', '9338056805', 'S2'),
	('82d6e7f4-67ab-491c-9a58-b46890fa1894', 'Adah', 'Lemmen', '3985723092', '2004-04-23', 'TRUE', 'Forward', '2629690326', 'D2'),
	('7ab4d9f6-bc1e-40c6-981d-899881a897f6', 'Constantin', 'Leversha', '2015778322', '2004-11-06', 'TRUE', 'Goalkeeper', '4789392864', 'D3'),
	('dccea2a2-839f-46ae-ace1-a80b9de26d31', 'Gustie', 'Linskey', '1052226650', '2004-06-20', 'FALSE', 'Forward', '1670711552', 'S3'),
	('a35473f3-1c90-4984-9206-f9c4430e1d07', 'Vick', 'Littlewood', '5202729542', '2004-01-19', 'FALSE', 'Midfielder', '2683210620', 'S3'),
	('b3c5bf74-a580-43c0-a3a1-208a34d8646e', 'Frannie', 'Llewellyn', '2983093525', '2006-12-23', 'FALSE', 'Defender', '3445196346', 'S3'),
	('a28b9df2-7fff-4868-aae1-49501e57cce1', 'Renae', 'Llywarch', '9124646199', '2004-12-16', 'FALSE', 'Forward', '7269397627', 'S2'),
	('16b7db65-43c9-4aa8-9ba5-15d6f0f56c03', 'Maurizia', 'Loch', '2293108410', '2006-07-25', 'FALSE', 'Forward', '4576634232', 'D3'),
	('6c02eace-7773-48ab-b71d-f177030c2b25', 'Sashenka', 'Loisi', '2044817275', '2007-02-27', 'TRUE', 'Forward', '380021471', 'D1'),
	('ed04cf63-7e4c-4f49-ba5f-82f45c6a87d3', 'Shurwood', 'Loker', '3033167086', '2005-09-23', 'FALSE', 'Defender', '2332497552', 'D4'),
	('54f8fba2-20e8-4ee5-8480-b9e2b1445cae', 'Rudiger', 'Lorek', '9532589575', '2005-05-24', 'TRUE', 'Defender', '7065729656', 'D4'),
	('4af41ea0-7540-445d-bae1-3ad42aaccc7b', 'Ewart', 'Lubbock', '9892709524', '2006-12-27', 'TRUE', 'Goalkeeper', '4743420237', 'S3'),
	('2c218fbb-caa3-4626-9093-014a50b14213', 'Davidson', 'Luttgert', '4734014136', '2006-08-07', 'FALSE', 'Forward', '5234341933', 'D3'),
	('8e5489aa-40ec-4dd6-9029-05fa6f409cda', 'Willy', 'Lyon', '4782410045', '2005-06-05', 'TRUE', 'Midfielder', '7061288752', 'D3'),
	('d0659e11-3d92-4d93-b843-5a8ebfcc3472', 'Meredith', 'Mabbs', '9925439603', '2006-06-07', 'TRUE', 'Goalkeeper', '6445974244', 'S1'),
	('8b974ad5-fc92-4c81-905d-a4aba44d8d2e', 'Hiram', 'Mabon', '1521625733', '2005-06-11', 'FALSE', 'Goalkeeper', '7739104183', 'S3'),
	('f1c3f7b5-272f-48b5-8cdf-6375fbeb5c54', 'Chandler', 'MacCafferky', '7295629406', '2004-07-27', 'FALSE', 'Forward', '5193383580', 'S3'),
	('c4673f6a-f8f8-4ddc-98f3-3c449cc48921', 'Shermie', 'MacCall', '4829720047', '2004-02-21', 'FALSE', 'Forward', '4711005633', 'D3'),
	('dfed9caa-9ac4-4479-87da-2b84028a20b5', 'Cooper', 'MacConnal', '1351218427', '2004-05-16', 'FALSE', 'Midfielder', '2706320249', 'D4'),
	('92b8cd6a-fe3b-4e68-a25d-652c57cf1064', 'Corby', 'MacLeese', '3304478592', '2006-02-09', 'FALSE', 'Midfielder', '8065734030', 'S2'),
	('aa65e313-2fbe-4fab-9ae9-85ccc3793765', 'Nikolaos', 'MacRorie', '5135212744', '2005-09-28', 'FALSE', 'Forward', '5726971345', 'D4'),
	('bb26d64e-d4df-4c50-a89e-0a15cc65dc19', 'Wilfred', 'Marfell', '5401398619', '2004-11-10', 'TRUE', 'Goalkeeper', '9249745265', 'S3'),
	('87798993-b9a8-40af-bca5-ba1347c96b60', 'Alene', 'Margery', '9968475942', '2006-09-26', 'TRUE', 'Midfielder', '5615821221', 'D1'),
	('621b69ed-836f-44d9-aeca-36f30481d57b', 'Emera', 'Marshall', '8912856026', '2006-08-26', 'FALSE', 'Forward', '4053150221', 'S1'),
	('762c4f05-69f7-4466-ac97-f86c4a9ae374', 'Egon', 'Masey', '3706415527', '2005-02-18', 'FALSE', 'Forward', '390787353', 'S2'),
	('8feca802-54b0-4a65-989f-e6d4133b0496', 'Gerianne', 'Masser', '8034206652', '2004-12-06', 'TRUE', 'Goalkeeper', '3723796656', 'D3'),
	('37ad2c87-ec40-4b2d-9394-c5c1efa6868c', 'Georgetta', 'Mastrantone', '3901203349', '2006-07-04', 'TRUE', 'Forward', '7476614577', 'S3'),
	('010ee726-35e3-4183-8f60-0fe3c19ef2ca', 'Karlyn', 'Mateev', '8044103847', '2006-12-01', 'FALSE', 'Midfielder', '6322497634', 'D4'),
	('43bc1267-b2a1-4011-b6b6-5eeebba6f1c4', 'Antone', 'Mattersey', '4699983915', '2004-07-02', 'FALSE', 'Defender', '6455144384', 'D4'),
	('369bf0ec-0e1e-4ab6-83df-324177b0d9cc', 'Nananne', 'Matusov', '7235382452', '2004-11-23', 'FALSE', 'Forward', '5923723832', 'D1'),
	('f757cb4d-ab03-4ac3-9d8c-149084bd4603', 'Ira', 'Mawford', '9355950361', '2007-08-10', 'FALSE', 'Midfielder', '3969535808', 'D3'),
	('15cae313-6128-485d-bccf-7720565730bf', 'Lelia', 'Maxweell', '2152865449', '2005-10-18', 'FALSE', 'Goalkeeper', '8557011482', 'D4'),
	('ca2fa3ed-fdb8-4455-b6df-2fbe4a0e82dd', 'Ivie', 'McAlpine', '2787548397', '2004-08-13', 'FALSE', 'Defender', '7425639289', 'S1'),
	('6f5af7c0-9681-4731-9098-4e2ef19ad551', 'Niels', 'McAne', '3559952580', '2005-07-28', 'TRUE', 'Goalkeeper', '5809391540', 'D3'),
	('e47e40f4-792c-49e2-ae8e-ef9cb7bf3b90', 'Renato', 'McCard', '9252598872', '2004-07-30', 'TRUE', 'Forward', '9216949988', 'D1'),
	('e70c3cc6-b71b-456e-a954-7284ba815e38', 'Maura', 'McCombe', '7299455612', '2005-05-13', 'FALSE', 'Goalkeeper', '3093954339', 'D2'),
	('7dc19c75-2390-45a8-bdd2-67a76f0a9192', 'Gaelan', 'McCowan', '2992986591', '2004-01-03', 'FALSE', 'Defender', '74803921', 'D3'),
	('d7b0544d-1101-491e-b222-2dc11caa15da', 'Dom', 'McCreagh', '9025924252', '2006-04-19', 'TRUE', 'Defender', '8273176878', 'D1'),
	('8eeb374d-4670-4eef-afc7-57aadfa82764', 'Bertrando', 'McElhinney', '4105293636', '2006-10-30', 'TRUE', 'Defender', '5633405633', 'D1'),
	('10d16b10-64ac-4ea0-8828-6cfec615d6f9', 'Bailie', 'McGirl', '1027454930', '2006-10-09', 'TRUE', 'Goalkeeper', '8668760874', 'D1'),
	('a59cbfc4-27e9-4e3e-abd8-9b9ce5c051f4', 'Marcel', 'McIlenna', '2331889065', '2005-03-07', 'FALSE', 'Forward', '512027528', 'D3'),
	('2c706f4a-d57b-4009-99c8-b0317d0e6678', 'Miguel', 'McNess', '4127107224', '2007-07-09', 'FALSE', 'Goalkeeper', '8948895605', 'S1'),
	('8ca2fb05-c7d2-44e9-852c-06f441264032', 'Gertrud', 'McQuirter', '7993504977', '2006-05-15', 'FALSE', 'Midfielder', '2051790787', 'D1'),
	('daca9daf-eb84-4f97-bede-b659a1d9e759', 'Beltran', 'McRae', '7919205126', '2006-04-08', 'TRUE', 'Forward', '4521512100', 'S1'),
	('47c5efce-fb9e-4a60-944c-4334265094d6', 'Kaylil', 'Meaker', '1089498496', '2005-03-21', 'FALSE', 'Midfielder', '5793758844', 'D1'),
	('54bbfa94-5e38-4ad4-8328-d72a0b52a807', 'Dinah', 'Meiklem', '1222821871', '2006-12-21', 'TRUE', 'Midfielder', '9872537313', 'S3'),
	('ec209351-ed78-49eb-a18b-7f433edc6252', 'Hilton', 'Merriday', '7931971468', '2004-03-01', 'FALSE', 'Goalkeeper', '6486573112', 'D1'),
	('be41966c-1f50-4976-b83c-e50d6daacbd2', 'Lela', 'Merrilees', '5615169864', '2005-01-06', 'FALSE', 'Goalkeeper', '9815875299', 'S3'),
	('5052bb18-ddd0-4a33-811e-66ed7be1ebc5', 'Tripp', 'Mintoff', '2909305798', '2004-01-24', 'TRUE', 'Forward', '3914697024', 'D4'),
	('754d85ff-38e9-48fc-aecd-91a003c547af', 'Rae', 'Mixter', '7157679209', '2004-01-12', 'TRUE', 'Midfielder', '4786125598', 'D4'),
	('a636b328-3c53-43e8-acaa-e3d7a2144cc9', 'Clemmy', 'Monkhouse', '1019118700', '2005-11-05', 'TRUE', 'Defender', '9798021185', 'S1'),
	('51bef157-53e8-400e-804b-63c128972b35', 'Adolph', 'Mor', '2155299484', '2005-07-06', 'FALSE', 'Midfielder', '333467728', 'D4'),
	('7f8e1caf-ecb9-4db1-9ce7-1f7f80204dd7', 'Shelby', 'Mora', '5294464362', '2004-08-19', 'TRUE', 'Forward', '7843159290', 'D1'),
	('a12e329d-7f62-4fe1-a365-9bc278099d5a', 'Vally', 'Mordan', '7704105205', '2004-11-20', 'FALSE', 'Goalkeeper', '9157160015', 'D2'),
	('5b7646e8-7d77-4508-a90d-62951303aaee', 'Devondra', 'Moreinis', '8172169414', '2005-04-21', 'TRUE', 'Midfielder', '3552453113', 'D1'),
	('5a848f8a-fed8-40d8-8f6f-3e16c41ea1b7', 'Rooney', 'Mullane', '4935878221', '2006-12-05', 'FALSE', 'Forward', '7113576699', 'D1'),
	('4ebde06c-9896-4916-86cc-1eaf4dde5719', 'Sandro', 'Murphy', '7181628384', '2007-03-02', 'TRUE', 'Defender', '5529559395', 'D2'),
	('fbea3f25-5656-4b57-a058-fac556ca0bc5', 'Ashley', 'Mussettini', '3188125748', '2007-06-28', 'FALSE', 'Forward', '4808300761', 'D2'),
	('45ca4321-d1da-4d72-9aed-863512fd6cfd', 'Umeko', 'Myrie', '2663472126', '2006-11-13', 'TRUE', 'Defender', '4488786812', 'S2'),
	('daa676ce-d35e-400d-8988-141e0c8a1a6a', 'Salvatore', 'Narup', '8795150976', '2005-12-12', 'TRUE', 'Defender', '4167214393', 'S1'),
	('77f951a2-88c5-4ec5-9f5f-0ca024dbd80e', 'Ainslee', 'Nevett', '6246911034', '2004-01-28', 'FALSE', 'Forward', '5321205248', 'S1'),
	('faec3fd8-a62f-4cd1-91d0-ff89367c7c45', 'Vicky', 'Newlan', '4121370371', '2005-07-15', 'TRUE', 'Midfielder', '6814130173', 'S1'),
	('4832d185-5572-4a23-b9cc-405fd7786791', 'Maureen', 'Noot', '1993038753', '2007-03-10', 'FALSE', 'Forward', '4300535140', 'D3'),
	('43317e71-b3d3-4647-81b0-06c84d288f77', 'Bobbi', 'Norgan', '1485195828', '2007-05-17', 'TRUE', 'Forward', '1807310604', 'D4'),
	('7d80b55f-336d-4184-a299-70c757ff7f9d', 'Sallee', 'Norres', '2128144707', '2004-12-07', 'FALSE', 'Goalkeeper', '3372269233', 'D4'),
	('b58f2bfd-0855-4968-8903-0a02bb025be6', 'Pavia', 'Odogherty', '1826047049', '2006-10-23', 'FALSE', 'Goalkeeper', '5160648682', 'D2'),
	('13f5bf74-7267-4e1c-90db-fb2322de03fd', 'Hadria', 'Olenchikov', '7604349502', '2004-05-02', 'TRUE', 'Midfielder', '5094070169', 'D2'),
	('ae4a1da4-5b69-40b8-b359-170f43eb2813', 'Eward', 'Olerenshaw', '1986369079', '2007-03-18', 'TRUE', 'Forward', '1384967842', 'S3'),
	('59803372-1f89-4f27-b14c-460a5949a1bb', 'Larissa', 'Ollie', '1046293928', '2005-10-13', 'TRUE', 'Defender', '9349075806', 'D2'),
	('fb7af722-5239-46f3-8c09-816e844972ae', 'Selie', 'Olliver', '7621427637', '2006-03-13', 'TRUE', 'Goalkeeper', '1709946040', 'D4'),
	('5a733730-39c2-4736-a183-16e67cb488dc', 'Dexter', 'Osmint', '3674710039', '2007-02-19', 'TRUE', 'Goalkeeper', '7296285923', 'S2'),
	('56e79632-e369-4bd6-9d62-ade7f3e589a8', 'Mackenzie', 'Ould', '5918417596', '2004-04-07', 'TRUE', 'Forward', '8506740487', 'D2'),
	('9c995feb-d890-437d-b3f4-b1e99ba45252', 'Lacee', 'Outibridge', '5658502504', '2005-08-13', 'FALSE', 'Midfielder', '7142384840', 'S2'),
	('960c0d66-2c5b-4f3e-8290-ff3a844a0d38', 'Jenica', 'Owtram', '9208949919', '2004-12-02', 'FALSE', 'Forward', '7667503877', 'D2'),
	('2f6a1591-6259-4534-a96e-69a0230e0b0e', 'Piggy', 'Oxx', '5674933403', '2007-01-21', 'TRUE', 'Midfielder', '8595423008', 'D1'),
	('8acbb468-b07a-4bd8-b14c-b930d027627d', 'Van', 'Pakenham', '2959244538', '2006-06-10', 'TRUE', 'Forward', '3601981629', 'S2'),
	('3ae08c82-42ff-4bbc-b230-27b9b7119e92', 'Aimee', 'Paur', '4832630214', '2004-06-25', 'TRUE', 'Forward', '8211941236', 'S3'),
	('3522e776-92c2-4aef-a2b7-19f167298cf9', 'Zachery', 'Pavlata', '5032403138', '2006-04-25', 'TRUE', 'Forward', '4112598068', 'S2'),
	('ab71d448-1e82-4632-987d-123ef8a5e8f3', 'Barbe', 'Peele', '5854051826', '2007-07-23', 'FALSE', 'Midfielder', '6199256328', 'S1'),
	('4e6ac404-8057-413d-9d04-aabe86bb8650', 'Worth', 'Pendle', '3361016047', '2004-03-03', 'FALSE', 'Defender', '7211596287', 'D2'),
	('22f3690c-0c9d-43b9-8ac6-40c7e2536598', 'Donielle', 'Penni', '6144840039', '2005-09-09', 'FALSE', 'Defender', '7550235023', 'D3'),
	('a7a9e4fa-6886-44a3-a3af-adeb8fbf4b0a', 'Beitris', 'Pentony', '8629512622', '2005-06-20', 'FALSE', 'Midfielder', '3520158566', 'S1'),
	('e1af23c3-2197-4b6b-9e32-b314ddc9558a', 'Sheeree', 'Percy', '3653524495', '2004-03-02', 'TRUE', 'Goalkeeper', '4720719740', 'D4'),
	('e0addfb0-5f1b-461d-aea5-dee678970e24', 'Hatti', 'Perkis', '1924435134', '2005-09-25', 'FALSE', 'Goalkeeper', '8503311704', 'D2'),
	('4825a0c8-2f31-4b3f-9b06-26ab8722b71c', 'Latia', 'Pessel', '4793844115', '2005-08-19', 'FALSE', 'Midfielder', '1963200292', 'D4'),
	('842773c8-65cf-4478-a4d6-a9aa346d5b5c', 'Jonis', 'Philippault', '8062236681', '2004-06-03', 'TRUE', 'Midfielder', '7153227717', 'D4'),
	('a9784206-31e4-4143-911d-994bf25051fe', 'Rolando', 'Philpault', '2532807989', '2004-01-06', 'TRUE', 'Midfielder', '6394237361', 'S3'),
	('fa456d2f-c46e-454d-b3eb-0291d0b886a3', 'Emlynn', 'Pimbley', '1842934277', '2004-09-02', 'TRUE', 'Midfielder', '5716640060', 'S3'),
	('d8ebedbb-b2c4-40b7-8f1b-fa76604f67ba', 'Ameline', 'Pirelli', '2815956047', '2006-04-22', 'FALSE', 'Midfielder', '9090100016', 'S1'),
	('b4544b99-53d1-4278-a11e-ec2e54ca5cad', 'Teodora', 'Plackstone', '2507438173', '2006-07-22', 'TRUE', 'Goalkeeper', '2945064189', 'D1'),
	('051490e5-f91d-40a1-b9bd-6570ec59a41d', 'Clemmy', 'Pointon', '6189115749', '2005-11-22', 'FALSE', 'Goalkeeper', '4999844583', 'D2'),
	('0c5b02cb-8ef1-4810-9cb1-0ac31c8e1bbf', 'Megan', 'Polamontayne', '8179877768', '2005-02-01', 'TRUE', 'Forward', '8508672519', 'D3'),
	('ad07966e-9829-4a4b-a38c-a3ec69596bbb', 'Antonietta', 'Polden', '7641492752', '2006-04-03', 'TRUE', 'Defender', '7853998589', 'D2'),
	('c17916a2-4239-4f58-a4f7-e248d2b0f230', 'Carr', 'Potten', '8271747045', '2004-12-28', 'TRUE', 'Forward', '609458620', 'D1'),
	('715a47dd-043a-42e6-91ad-2e3db59e0707', 'Maxy', 'Pounds', '2866207664', '2007-07-04', 'FALSE', 'Defender', '3570772136', 'S3'),
	('65e9b713-f949-4a80-adf4-6140c140113d', 'Wenda', 'Poundsford', '5656258936', '2006-08-06', 'FALSE', 'Midfielder', '6244665961', 'D1'),
	('47cdd83e-04fa-439a-b6ec-28f48ecd0f49', 'Belicia', 'Probat', '5876728772', '2005-06-15', 'FALSE', 'Forward', '3340417296', 'S3'),
	('cd6b783b-6006-4f2c-acec-1e57cd514cad', 'Oneida', 'Quince', '9589119961', '2005-03-02', 'TRUE', 'Defender', '2028395656', 'S3'),
	('487a0e8b-821a-4b08-b1c0-9d5d16b92a88', 'Boigie', 'Rapier', '5319966426', '2007-07-23', 'FALSE', 'Defender', '8038917502', 'S2'),
	('078bdbb8-af75-4c18-af50-758f99adc2f2', 'Giana', 'Rathbourne', '1445332775', '2004-12-18', 'TRUE', 'Midfielder', '4920570910', 'D2'),
	('215293c6-ad6c-4353-a86b-6d49d6a550c0', 'Sher', 'Rearie', '1328150554', '2006-12-18', 'TRUE', 'Forward', '6074674574', 'S3'),
	('d4c5944c-3b13-4e71-aea4-fe30a545dcdc', 'Torie', 'Reay', '5938092375', '2004-08-27', 'TRUE', 'Midfielder', '4243336776', 'D3'),
	('2fc40e62-373e-46a4-ae27-574c13d5cda7', 'Marysa', 'Redmond', '2366477135', '2004-11-02', 'FALSE', 'Defender', '4047091839', 'S1'),
	('8b098a81-6081-414d-bcec-43b603628dea', 'Stacee', 'Renner', '3831422993', '2004-01-31', 'TRUE', 'Forward', '3536060765', 'D4'),
	('0efe2fed-95da-4159-98ae-d814dc2667f7', 'Fred', 'Reoch', '4786204621', '2007-08-07', 'FALSE', 'Midfielder', '8005091524', 'D4'),
	('3320b7d3-681d-43fd-b872-c8cbbdc9c2cf', 'Raychel', 'Revening', '5695900725', '2005-10-27', 'TRUE', 'Defender', '4543203631', 'S2'),
	('2780b52a-2c6a-47bc-9433-d146430edc1c', 'Noll', 'Rickesies', '3157352002', '2007-04-01', 'FALSE', 'Defender', '7340643052', 'S3'),
	('1ceb77e9-31df-41f9-8ba6-8cdf22c36bd1', 'Hube', 'Ripper', '3709522340', '2007-01-21', 'TRUE', 'Defender', '5359940255', 'D3'),
	('df7100ed-c61d-4e22-ab1d-019430589623', 'Farica', 'Robertazzi', '6127851840', '2007-04-12', 'FALSE', 'Defender', '2931503444', 'S1'),
	('cf020824-1f90-4642-bbd2-acb0002aa537', 'Charissa', 'Robinet', '2935319733', '2005-01-05', 'TRUE', 'Goalkeeper', '6393365846', 'S3'),
	('41d5b232-5f3b-4079-975f-97d4e1904e17', 'Olly', 'Rolling', '3659545875', '2007-05-13', 'FALSE', 'Defender', '7211259361', 'D2'),
	('b780cde9-6061-44d9-befd-51e6e013adf5', 'Shelly', 'Rolling', '9403077354', '2005-10-01', 'FALSE', 'Forward', '1579897584', 'D1'),
	('dbd836bb-f5fa-4fde-8a85-b74dc53ffa15', 'Fowler', 'Romanet', '5387771739', '2006-07-10', 'TRUE', 'Forward', '9387760170', 'D2'),
	('2dc4b1bc-f58e-4034-bc4e-8f02aa98f89d', 'Vikky', 'Ronaghan', '4132941230', '2006-12-04', 'TRUE', 'Defender', '8492581867', 'D1'),
	('bb5cca27-a173-4fb8-bd32-50bf46557467', 'Trenna', 'Rosendale', '3554393888', '2005-05-24', 'TRUE', 'Midfielder', '2343859213', 'D2'),
	('aa1d8f66-6412-4e70-9fd8-bb50bde32020', 'Paulita', 'Rosenhaupt', '9384822134', '2005-07-28', 'FALSE', 'Midfielder', '3312564395', 'D2'),
	('69ab8976-8d70-48e6-9018-8f36a5c6d1f4', 'Aylmer', 'Rosewell', '5713007181', '2007-03-06', 'FALSE', 'Forward', '8761114731', 'D2'),
	('53972a5e-4a27-49cc-b338-dbbea68e23b6', 'Torrey', 'Rumsby', '5945138780', '2006-04-06', 'FALSE', 'Defender', '4222668087', 'D2'),
	('0ffd9bdb-72be-4ac4-b1c2-2a8d64b690bd', 'Olly', 'Ruspine', '2461181305', '2004-06-27', 'FALSE', 'Goalkeeper', '8991459722', 'D1'),
	('43c7861e-e355-4da7-b897-cdcd27c5f075', 'Meir', 'Russan', '9845193334', '2005-02-20', 'TRUE', 'Forward', '6397726851', 'S2'),
	('bdff6e04-2297-425c-8f98-98dcb3e9b8eb', 'Vinny', 'Saintpierre', '2358167115', '2004-10-21', 'TRUE', 'Midfielder', '5270227533', 'D2'),
	('80817ccb-bf6c-4cad-92fa-b8c60fb84005', 'Heida', 'Salack', '9551239284', '2005-09-25', 'TRUE', 'Forward', '5033985248', 'S2'),
	('5296fe9d-decb-425b-924b-ccc43813cd2e', 'Skipper', 'Sale', '7877825922', '2004-07-22', 'FALSE', 'Goalkeeper', '4114952322', 'D4'),
	('bacef0a3-537b-4a7a-bf70-9398e14f0c26', 'Darleen', 'Sallter', '5652297372', '2005-10-11', 'FALSE', 'Defender', '2303020557', 'D1'),
	('a5f2489a-ce46-40a8-bce4-5fc6649fa53e', 'Arel', 'Sapshed', '6037126456', '2004-03-07', 'TRUE', 'Defender', '7697923041', 'S3'),
	('931c5f1c-3ad3-4ece-b1f0-c6d3640c3752', 'Wallache', 'Schiersch', '4881984965', '2005-08-16', 'TRUE', 'Forward', '3633797211', 'S1'),
	('c4247235-79b7-4880-bd3b-ab10f36da9e6', 'Raleigh', 'Schoales', '3285940063', '2007-08-15', 'TRUE', 'Forward', '3586875479', 'D3'),
	('750a2420-22e4-41cc-8d2f-79fa4cc65636', 'Zerk', 'Schuchmacher', '4616819459', '2007-03-07', 'TRUE', 'Midfielder', '3096014752', 'D4'),
	('7bf61363-a57d-4993-924b-a72c398e3395', 'Reeta', 'Schult', '5694973317', '2004-06-19', 'FALSE', 'Defender', '3351656998', 'D2'),
	('c52d5d41-549e-466b-8e40-414921541db7', 'Cassi', 'Schuricke', '6633206735', '2007-08-13', 'FALSE', 'Midfielder', '7038516337', 'D3'),
	('334c3e1c-c288-4e58-921f-99d59f1d3593', 'Johnette', 'Scotney', '7397234107', '2007-06-05', 'TRUE', 'Goalkeeper', '1988140552', 'D2'),
	('084b2b32-7dcd-4228-90c8-5a5b6965630c', 'Granville', 'Seamans', '5355072630', '2007-03-21', 'TRUE', 'Goalkeeper', '9081905937', 'D4'),
	('a88cae4d-02f2-4e28-af5f-58f6a1d68d20', 'Quint', 'Seaward', '2125380821', '2006-05-22', 'FALSE', 'Defender', '5706581118', 'S3'),
	('c3acbea6-c0da-435e-88e0-4e01d7490d10', 'Emili', 'Shann', '7807227248', '2004-05-16', 'TRUE', 'Goalkeeper', '6945190447', 'D4'),
	('2415004b-f603-4345-b6a2-6bc1654d0855', 'Leonardo', 'Shayler', '2663091416', '2004-07-05', 'FALSE', 'Defender', '383727278', 'D4'),
	('5321897a-a2e7-425f-84e5-7c86ef868c2e', 'Laraine', 'Sheldrick', '8211305016', '2004-04-03', 'FALSE', 'Defender', '8171624650', 'S2'),
	('f57ce596-ce5f-4bf6-9c31-2ed62803e7ec', 'Jeanelle', 'Sheriff', '9412799574', '2005-04-06', 'TRUE', 'Goalkeeper', '8752812154', 'S1'),
	('680e5c4d-ce7b-4d86-93c8-d887117e4230', 'Lorin', 'Shutler', '3078118820', '2006-11-21', 'FALSE', 'Forward', '9868807840', 'D3'),
	('e5ac331f-7c1a-4281-906e-8f70ec6a8102', 'Cletus', 'Silby', '7276084947', '2007-05-06', 'FALSE', 'Midfielder', '2582825859', 'D4'),
	('00830eac-caf9-4878-8429-78e8e7d6cf24', 'Vasilis', 'Simion', '4286492637', '2007-04-23', 'FALSE', 'Defender', '4568640504', 'D2'),
	('d370505e-d939-4e0f-876c-4891a673087e', 'Tanya', 'Simmank', '4275088630', '2007-05-30', 'FALSE', 'Defender', '201622483', 'D4'),
	('c9859456-ff2a-47bc-acef-d7e8264cb885', 'Davin', 'Simmon', '6533520545', '2005-05-13', 'TRUE', 'Defender', '7895922599', 'S3'),
	('a2e61f2f-b751-4d43-ba12-f71c68475d3a', 'Elliott', 'Simner', '3323619243', '2004-10-10', 'FALSE', 'Forward', '5113941220', 'D1'),
	('0eeede64-87a5-4742-b132-59b70733002c', 'Corabel', 'Simonitto', '5179614818', '2006-09-29', 'TRUE', 'Defender', '3055524152', 'S2'),
	('554a48a0-dce0-468c-94cc-5b357870e5e3', 'Quillan', 'Skarin', '2772533143', '2007-06-24', 'TRUE', 'Defender', '4374629491', 'D4'),
	('a778be58-6217-4c35-a506-737b3e272386', 'Wiley', 'Slack', '1061754528', '2005-01-11', 'TRUE', 'Defender', '1021267902', 'S2'),
	('8be51d0d-2399-4c8d-8c20-32f0be2a192c', 'Shayna', 'Smeed', '7555545521', '2006-01-05', 'TRUE', 'Goalkeeper', '3959982348', 'D1'),
	('c24e36f3-9139-4c1c-bf69-785b03acf346', 'Jose', 'Sonner', '7425613959', '2007-01-19', 'TRUE', 'Midfielder', '5948518957', 'S1'),
	('f2c06cb1-9c00-442f-8ca7-3396bc7e0a5f', 'Merralee', 'Spurge', '6772612439', '2005-03-21', 'TRUE', 'Defender', '2319254528', 'S2'),
	('5e71587f-dbbb-456f-be14-eae1eb13e923', 'Cordey', 'Stallan', '3393387895', '2004-09-29', 'FALSE', 'Forward', '4673387112', 'D3'),
	('353e69f4-5823-4735-a147-0e9c4a2e13c8', 'Betsey', 'Stangoe', '5127114062', '2004-05-02', 'FALSE', 'Goalkeeper', '9610255175', 'D1'),
	('aa520d8f-6775-4499-a368-7efb8e900cab', 'Mela', 'Stather', '3469933704', '2007-05-07', 'TRUE', 'Defender', '9810828632', 'D2'),
	('391f37c5-04d4-4cbb-b59b-18d361993660', 'Addie', 'Stelljes', '6558115078', '2007-08-29', 'FALSE', 'Goalkeeper', '2120377065', 'S1'),
	('acaa56f4-e2fb-4a31-a228-b6d01c6fb04e', 'Terza', 'Stiegars', '4915349425', '2005-10-18', 'TRUE', 'Midfielder', '287146766', 'S1'),
	('182fb120-fb1a-43d9-b9eb-da506fd96a1b', 'Moore', 'Stollmeyer', '9809683238', '2006-04-05', 'TRUE', 'Defender', '4743945771', 'D1'),
	('713488ab-02d7-48a2-8a06-21c5261210ae', 'Fergus', 'Storm', '4737877794', '2004-04-21', 'FALSE', 'Midfielder', '6939510087', 'S3'),
	('680dd842-ee08-4863-bbcf-6156fcee44bf', 'Sybille', 'Stothart', '3508115744', '2005-05-02', 'TRUE', 'Defender', '7930690466', 'S1'),
	('0be13341-fed4-40a0-977f-1d194f008a30', 'Scotti', 'Stothert', '7854479051', '2005-05-08', 'FALSE', 'Forward', '4489217951', 'S1'),
	('7e164396-ac37-4bc5-bdae-755daa118d1e', 'Davita', 'Stothert', '2445041542', '2006-05-03', 'TRUE', 'Forward', '3440658422', 'D1'),
	('c6ef5077-c518-4e38-9577-eff4f6568df1', 'Goldia', 'Stoute', '7492082115', '2005-04-29', 'FALSE', 'Goalkeeper', '3381527886', 'D2'),
	('33677dc0-1abe-4ced-85ae-e5bc4487b2f9', 'Clementine', 'Swindlehurst', '6884744721', '2006-03-04', 'FALSE', 'Goalkeeper', '8509367620', 'S3'),
	('30b2902b-ccd0-4b18-8ec5-391d8a47acca', 'Chick', 'Talby', '4786845098', '2006-07-10', 'FALSE', 'Forward', '7002215884', 'S1'),
	('ee59dc25-1d48-4658-8cae-9e95243a6cdd', 'Ynes', 'Tenpenny', '3649582439', '2007-04-26', 'FALSE', 'Midfielder', '7988423843', 'D3'),
	('37429e55-e18d-4596-83a6-e3ddea200bc4', 'Costa', 'Tetley', '2185555918', '2005-09-17', 'FALSE', 'Goalkeeper', '6296147198', 'D1'),
	('6a546a0c-5576-4048-b9fa-da2f88e918d6', 'Liv', 'Thorald', '7746568498', '2004-03-19', 'TRUE', 'Midfielder', '6318146016', 'S1'),
	('5bd989fa-e02a-461d-8bd7-de678b53f992', 'Lola', 'Thornborrow', '6913066014', '2007-08-28', 'TRUE', 'Defender', '4851357397', 'D2'),
	('4b44f1ad-b3e8-41c0-a48a-3e4ed143b62f', 'Lucio', 'Thrift', '7925309181', '2006-05-09', 'FALSE', 'Goalkeeper', '6327954901', 'S3'),
	('1a6d1612-f5e8-4e4d-abe3-b94a05d9956c', 'Rem', 'Tissell', '1806685095', '2006-10-05', 'TRUE', 'Forward', '4673857046', 'D4'),
	('90372cd4-1b11-4d0a-b95a-72edd8b8fb94', 'Carling', 'Titman', '4901265115', '2004-01-24', 'FALSE', 'Goalkeeper', '2530036829', 'D3'),
	('b3076c7d-61a8-459f-ba28-4745f2f51674', 'Aldridge', 'Tivolier', '4278564046', '2004-11-08', 'FALSE', 'Midfielder', '6928981717', 'D1'),
	('79b17984-c02c-4785-8fbc-5d8a59cf8243', 'Fara', 'Tonnesen', '8239330993', '2005-01-14', 'TRUE', 'Defender', '6471774842', 'D3'),
	('efbdc930-3b2f-47e4-b735-48b33ae20007', 'Siusan', 'Toomey', '5568232128', '2005-07-18', 'TRUE', 'Goalkeeper', '4686763134', 'S3'),
	('7714836b-dee3-4119-b77a-3b5710c81a9e', 'Roze', 'Toulamain', '4476847790', '2005-01-31', 'FALSE', 'Defender', '2527272533', 'S3'),
	('2f8a9e0f-4b1b-4240-9c16-3228d2a02ba3', 'Yoshiko', 'Treadaway', '1357487043', '2005-02-11', 'TRUE', 'Midfielder', '5703376580', 'D1'),
	('d1cf6e7e-f589-4c92-a6e8-47bfda81ed43', 'Linn', 'Tremaine', '8592875832', '2006-02-17', 'TRUE', 'Forward', '306577852', 'D2'),
	('c7c35b22-6293-4e9e-a71a-23a3135c8a4a', 'Holt', 'Tripean', '1906266603', '2006-11-12', 'TRUE', 'Defender', '2371868108', 'S1'),
	('09bf135d-d222-4560-8b6e-469426409ef9', 'Garrik', 'Tue', '5472827857', '2005-06-16', 'TRUE', 'Goalkeeper', '5189670090', 'S2'),
	('bec0c3e1-2caf-46a6-82f6-736efc501d70', 'Corrine', 'Twizell', '9021054644', '2006-01-12', 'TRUE', 'Forward', '6090851213', 'S1'),
	('6fcfc29e-7a8d-4e7c-a4e8-656c214a3af1', 'Kristal', 'Twoohy', '4857328448', '2004-11-26', 'TRUE', 'Defender', '3254673247', 'D4'),
	('90157da0-e4be-452f-9b70-43a613f503aa', 'Barclay', 'Uzzell', '7377828419', '2004-04-12', 'FALSE', 'Goalkeeper', '9489222119', 'D4'),
	('395c1ce0-4ac9-4197-ac4b-c5fbbf886f3b', 'Cara', 'Valentine', '3259673439', '2005-09-26', 'TRUE', 'Forward', '650697553', 'D1'),
	('04f66242-e3bb-4e13-a86f-67dcf912fb5c', 'Burt', 'Verecker', '3337951181', '2004-02-01', 'TRUE', 'Goalkeeper', '7503147989', 'D4'),
	('61ffef9f-3c2e-4233-8db1-38cb1aee9b71', 'Belicia', 'Viccars', '7965046882', '2005-09-30', 'TRUE', 'Midfielder', '7221670927', 'D3'),
	('2adac585-e481-460b-ab81-684a9c3c0826', 'Licha', 'Viveash', '2059129500', '2005-01-05', 'TRUE', 'Midfielder', '7876599893', 'S2'),
	('f98f33ca-18f1-4c25-bcfa-b4f1302d70dc', 'Willard', 'Vuittet', '1085124032', '2005-09-19', 'TRUE', 'Midfielder', '2366227671', 'D1'),
	('92855a9a-0382-4c72-aa10-54c6cd755ba2', 'Trixie', 'Wabe', '5452905916', '2006-04-09', 'FALSE', 'Defender', '2769232975', 'D1'),
	('b1613b3d-9c89-4526-83d2-f650823e1de5', 'Tabbatha', 'Wackly', '4991757935', '2006-05-03', 'TRUE', 'Midfielder', '629169985', 'D1'),
	('79fc5e9d-22d2-4788-91b4-3a383c6a7a23', 'Armstrong', 'Wadman', '1978779970', '2006-05-16', 'FALSE', 'Forward', '4325901329', 'S2'),
	('adce5be6-ea08-432b-a458-0f7d90131bfe', 'Cortie', 'Wainer', '9805281066', '2007-02-11', 'FALSE', 'Forward', '7023772464', 'S2'),
	('56b082b9-f6f4-40db-a29d-f8051ab549e7', 'Kristoffer', 'Wakeford', '8735953168', '2005-05-03', 'TRUE', 'Defender', '1627100784', 'D4'),
	('75ef61a3-b665-4c15-b10e-6abf6f106bdc', 'Steffie', 'Wassung', '7305079857', '2005-02-15', 'TRUE', 'Midfielder', '4611226514', 'D1'),
	('faf615ed-ace9-4e63-96ef-7d40728d7ae5', 'Merry', 'Wheatland', '1237119980', '2007-07-19', 'FALSE', 'Forward', '290980755', 'S3'),
	('97f73142-8eee-437a-ae08-704b2fa0106f', 'Britni', 'Wherry', '9451246639', '2004-11-08', 'TRUE', 'Midfielder', '6623296336', 'S3'),
	('2ef70a70-2765-4b53-b243-7cc5e35ff300', 'Inesita', 'Whitley', '1637416572', '2005-11-28', 'TRUE', 'Midfielder', '3990635468', 'D3'),
	('7ab83f7f-67fa-4c7a-9904-9b1a54c46e7d', 'Vinita', 'Wigglesworth', '4307863439', '2006-09-24', 'TRUE', 'Defender', '8300940650', 'D2'),
	('8589a238-793c-42e3-b01c-d9e08673539d', 'Ebeneser', 'Willcot', '3428852563', '2007-05-17', 'TRUE', 'Forward', '1677618086', 'D1'),
	('159e38c6-da92-418a-8acd-79a79230ff73', 'Phyllis', 'Willicott', '9633863889', '2007-04-23', 'TRUE', 'Forward', '2938128592', 'D3'),
	('43292661-a2b4-4be6-a937-9fe291de46e0', 'Gillie', 'Willment', '9869075704', '2007-06-27', 'FALSE', 'Forward', '2713770610', 'D4'),
	('11c5321a-aa77-4e6e-a7d0-0572d12b9410', 'Archibald', 'Willoughby', '3159984994', '2007-01-15', 'FALSE', 'Goalkeeper', '5978598215', 'S3'),
	('05b41bed-42c4-41fd-b83d-2f224593a352', 'Phaedra', 'Windrass', '2355426370', '2004-11-14', 'TRUE', 'Goalkeeper', '679883622', 'D1'),
	('a2527e00-6933-46df-afbe-59b1090bf277', 'Nelly', 'Winterflood', '5772673377', '2005-07-27', 'TRUE', 'Defender', '2489789708', 'D3'),
	('697fe54e-da82-4b83-b983-1fc1deb90b84', 'Page', 'Wither', '6882285216', '2007-04-03', 'TRUE', 'Forward', '6167656304', 'D4'),
	('1b245c43-87f2-4f62-90e6-5c1bd233e490', 'Blayne', 'Wolverson', '5458239730', '2005-05-16', 'TRUE', 'Goalkeeper', '4418179186', 'S2'),
	('f148edd9-3d18-4410-abd3-c42c2eb32499', 'Barnabe', 'Wrathmell', '2813350272', '2006-06-03', 'FALSE', 'Goalkeeper', '675106680', 'D1'),
	('f09353e0-64ea-4e1e-b30c-5d95714ce283', 'Mariam', 'Wrightson', '4008733409', '2004-06-05', 'FALSE', 'Midfielder', '3226466984', 'D4'),
	('53466975-599f-4289-a781-07fef8e023fa', 'Gaylene', 'Wroughton', '5451790530', '2005-12-15', 'FALSE', 'Defender', '5345542589', 'S2'),
	('c2403831-eb45-472c-ae8f-6631324b955a', 'Wandis', 'Yokley', '4195793187', '2006-11-21', 'TRUE', 'Goalkeeper', '8926426149', 'D4'),
	('d4d528b8-d679-4518-9736-0c573b88bdc0', 'Noni', 'Zannelli', '1773683037', '2004-11-05', 'FALSE', 'Forward', '1938129164', 'D2');


INSERT INTO non_pemain (id, nama_depan, nama_belakang, nomor_hp, email, alamat) VALUES
	('baca91c4-8fc2-4775-ac71-f3b2afeeb9e6', 'Vick', 'Geill', '6682431803', 'vgeill0@ehow.com', '489 Crownhardt Place'),
	('4813b3d9-ba73-4b9f-bc25-863a1ac72ac5', 'Flemming', 'Okker', '3102279912', 'fokker1@vk.com', '91150 Del Mar Junction'),
	('f16595d9-7c7c-4abf-9ec6-2ea692338f3b', 'Junette', 'Stockhill', '2772992667', 'jstockhill2@house.gov', '57 Cordelia Court'),
	('226e8462-8318-4b88-9593-e1ce23eb6f54', 'Rania', 'Curee', '4157820861', 'rcuree3@netscape.com', '47 Hanover Point'),
	('0e95aa6a-f266-432d-9055-ab6c9ed7f002', 'Cammy', 'Fernando', '4333153459', 'cfernando4@fastcompany.com', '7191 Hoffman Junction'),
	('2a7ca12e-7b91-498e-bb5b-1d0840288b7e', 'Savina', 'Tombs', '7749313385', 'stombs5@123-reg.co.uk', '14 Sundown Terrace'),
	('219e47f7-3262-47eb-ac87-d30c1fb3e4fe', 'Burton', 'Wiggall', '7071014299', 'bwiggall6@google.cn', '21 Dakota Hill'),
	('e4178942-2136-4846-b827-7b8833712702', 'Catina', 'Lelievre', '2176737623', 'clelievre7@dmoz.org', '25024 Bluestem Park'),
	('d5033e7b-3329-4440-b498-2438d7a519b6', 'Rae', 'Birts', '4116861177', 'rbirts8@sitemeter.com', '4715 Dexter Junction'),
	('e32e24b8-81c8-46d1-9f02-06d51b60aa97', 'Darnell', 'Roistone', '3399468067', 'droistone9@macromedia.com', '0210 Green Ridge Parkway'),
	('1579a11f-4f4a-4976-853a-aca69911f0d1', 'Dasha', 'McAleese', '8007801563', 'dmcaleesea@wsj.com', '482 Lighthouse Bay Point'),
	('0cca335f-3186-41ba-9e4e-54ac626fdf0c', 'Robbi', 'Arnet', '7243230978', 'rarnetb@cbslocal.com', '27 Golf View Alley'),
	('1a98d441-587c-42cb-926e-3cb3c24a533f', 'Trstram', 'Ord', '3256889530', 'tordc@uiuc.edu', '2 Russell Terrace'),
	('c75a1f90-8536-483b-9b4c-5156289c12d7', 'Min', 'Felder', '5323700239', 'mfelderd@list-manage.com', '84 Eliot Park'),
	('6f91de94-553e-436f-aef0-9643f4204b18', 'Gennifer', 'Crummay', '4776657874', 'gcrummaye@techcrunch.com', '76 Northland Park'),
	('64f336ab-db6e-4e73-ae09-67c557873eca', 'Manfred', 'Parnham', '8739603837', 'mparnhamf@nyu.edu', '78 Kedzie Trail'),
	('214429c6-192f-4299-91e5-8d9b8e44a3b9', 'Aldous', 'Bart', '1191211051', 'abartg@yellowbook.com', '04 Blaine Place'),
	('f830e066-93fe-4a78-a54d-f36d0cef868e', 'Pierre', 'MacKintosh', '3476224333', 'pmackintoshh@umn.edu', '81 Pierstorff Road'),
	('a8466804-cb18-49be-890b-388f14df61a1', 'Vi', 'Witherdon', '5396235070', 'vwitherdoni@dot.gov', '5 Ramsey Parkway'),
	('b420d88a-b70c-4d89-8521-fe171aa30d6b', 'Tully', 'Eyer', '7064890749', 'teyerj@yolasite.com', '5 Warbler Court'),
	('7c1840a7-9f46-40a1-8bfc-1150eeaf67f6', 'Brooks', 'Bleyman', '2568948773', 'bbleymank@nih.gov', '0 Thierer Road'),
	('d1fcda36-b726-43fb-a093-d4b2b93543a5', 'Chlo', 'Ruberti', '3672401766', 'crubertil@un.org', '34 Heath Trail'),
	('1831425e-8ad8-4084-b89f-d5ab7b0f1f14', 'Wren', 'Jeannenet', '4522081804', 'wjeannenetm@scribd.com', '28 Montana Pass'),
	('8c771216-25d9-4dcb-9b39-2f1d3e0eb577', 'Lou', 'Whistlecraft', '6189202848', 'lwhistlecraftn@nps.gov', '4803 Marcy Park'),
	('3872f72b-98c4-4dba-9b2a-ef9b9ddab6e8', 'Sanford', 'Faley', '8987179668', 'sfaleyo@purevolume.com', '6663 Heffernan Parkway'),
	('db0a0705-e2b0-4218-a9e9-351264c6bbb6', 'Sidonnie', 'Lawrie', '7797845516', 'slawriep@newsvine.com', '2 Merry Park'),
	('0979f75c-a0ec-49bc-9e0e-d0b63e261fab', 'Dennie', 'Biss', '8772345600', 'dbissq@miitbeian.gov.cn', '41934 Southridge Place'),
	('c428efa9-8cd2-4193-bac0-42a49e4ffc5d', 'Buddie', 'Mabey', '2258401315', 'bmabeyr@hao123.com', '51 Harper Alley'),
	('9ec6da76-a849-4437-b239-bc2e02937cbc', 'Vale', 'Demoge', '7309172002', 'vdemoges@etsy.com', '9166 Debra Terrace'),
	('3adcea11-c30c-4fe7-b247-c945a0b978b7', 'Bruis', 'Caville', '8445383912', 'bcavillet@nih.gov', '83 Gateway Plaza'),
	('f7aaead9-e2d1-46e2-aff2-bfaa81189fe2', 'Laurianne', 'Mears', '7285127220', 'lmearsu@delicious.com', '8743 Morning Center'),
	('4aca9615-0711-4a4f-bb39-8a5d18da9606', 'Kiley', 'Halworth', '9255814015', 'khalworthv@businesswire.com', '6 Crownhardt Center'),
	('d485db62-dd05-4a87-b500-49b4b97a44d9', 'Dael', 'Brandsma', '4268589022', 'dbrandsmaw@ehow.com', '4 Toban Trail'),
	('63b1e101-6fb5-4d5b-b7ae-3c9c9dcb4aff', 'Willy', 'Hickenbottom', '5192041991', 'whickenbottomx@spotify.com', '4313 Dwight Alley'),
	('3de61e7e-e2dd-4106-891d-7dc978097d2a', 'Shana', 'Ackerley', '9352565576', 'sackerleyy@examiner.com', '0 Reinke Junction'),
	('103ec535-54e4-4032-8a4f-094c6025e813', 'Raynard', 'Reagan', '3239993667', 'rreaganz@webmd.com', '201 Hazelcrest Trail'),
	('0e4b7304-ab74-4898-81c0-50533b13726f', 'Nap', 'Oldershaw', '9419122057', 'noldershaw10@shutterfly.com', '36 Oneill Center'),
	('d5c79af8-72d4-45b6-9179-2539ad979cd0', 'Raffarty', 'Schiementz', '9999380770', 'rschiementz11@apache.org', '4 Jenifer Hill'),
	('f8374a40-2f03-45b2-8882-f587f3a1aad6', 'Beverly', 'Beardwood', '6932026282', 'bbeardwood12@bbb.org', '0 Alpine Plaza'),
	('7de0dc28-5357-494c-8da2-aac32f22f9e5', 'Torre', 'Faircley', '4778220096', 'tfaircley13@seesaa.net', '53 Southridge Point'),
	('0cca486c-e0fd-41f2-a402-43c7fe944317', 'Shelden', 'Purle', '4154395952', 'spurle14@netvibes.com', '89398 Pond Parkway'),
	('bf11816b-825e-4d6d-a560-49cbd6459150', 'Henka', 'Weagener', '2357390957', 'hweagener15@cargocollective.com', '489 Russell Parkway'),
	('7ce9f80a-dab0-402f-aade-7a7ea1a5cfa2', 'Hy', 'Farebrother', '8342799521', 'hfarebrother16@usa.gov', '8104 Sloan Drive'),
	('23f00f00-1d05-4953-a04b-c638954cc49a', 'Monika', 'Haley', '7079184878', 'mhaley17@zdnet.com', '5618 Trailsway Junction'),
	('caf87d17-b4f7-4073-bafa-60db28400aa1', 'Mabelle', 'Aggett', '9709941532', 'maggett18@yahoo.com', '4 Spaight Alley'),
	('5449ea13-e439-4dd7-aae9-f0d635022841', 'Marjory', 'Murrison', '9385920387', 'mmurrison19@gnu.org', '92050 Village Green Parkway'),
	('413d78f7-344a-41fc-96f1-417336d36980', 'Haily', 'Ovesen', '8241623661', 'hovesen1a@jiathis.com', '18 Randy Alley'),
	('1d6b4c84-a0ee-484d-a700-f42b3526d0c2', 'Gordon', 'Barwood', '1155760348', 'gbarwood1b@zimbio.com', '2661 Raven Road'),
	('a961b497-cf6d-43da-8717-ff71c2297491', 'Georgianne', 'Livsey', '8568950676', 'glivsey1c@nasa.gov', '00492 Vidon Center'),
	('00abfafd-a840-4dc0-9f36-e9c0be74fb5f', 'Rebecca', 'Boone', '1591796790', 'rboone1d@dion.ne.jp', '40 Hooker Park'),
	('6ed537bf-43ec-484c-98a8-e345d80cf963', 'Kali', 'Shackel', '6684097992', 'kshackel1e@tmall.com', '053 Jenna Parkway'),
	('5fca97e6-0d5b-4b8f-aed5-dcb343b3cb22', 'Marjory', 'Couchman', '3845408828', 'mcouchman1f@1und1.de', '6471 Schurz Way'),
	('50ba324d-4064-4a52-8410-e657caaae38d', 'Michele', 'Hymus', '5686446307', 'mhymus1g@cbsnews.com', '3296 Kingsford Plaza'),
	('69447347-0155-45ab-aef5-c83685dcaad4', 'Alexi', 'Dallman', '4072895714', 'adallman1h@tinypic.com', '3386 Lukken Court'),
	('c0962756-709d-42ce-b4cf-f69dae1f3c8b', 'Cassandry', 'Shailer', '1892061328', 'cshailer1i@businesswire.com', '9 Ruskin Street'),
	('319b2f45-43ed-4914-b0ef-d7ac36f04034', 'Filberto', 'Loveguard', '1913053457', 'floveguard1j@homestead.com', '8 Hanover Place'),
	('a5e520c1-5b5d-48cd-befa-13833b19f1b7', 'Franz', 'Anthoin', '5386165007', 'fanthoin1k@deliciousdays.com', '3 Pine View Street'),
	('4a81f33e-5198-41e0-a06b-7826d5a3ef36', 'Frederich', 'Kesterton', '3377942300', 'fkesterton1l@issuu.com', '9208 Gale Place'),
	('feae7bbf-f7eb-46bc-b362-4aab15162b85', 'Percival', 'Whitty', '4108555175', 'pwhitty1m@telegraph.co.uk', '09 Oakridge Place'),
	('0657eb88-0ccd-4fc2-9ccb-71e7c2081f9b', 'Gawain', 'Jenking', '7136498442', 'gjenking1n@oaic.gov.au', '42 Schlimgen Road'),
	('be6a72a8-1f99-4c4a-9cd6-90823a85cde9', 'Rollins', 'Taillard', '8311081175', 'rtaillard1o@cargocollective.com', '8939 Washington Place'),
	('7ad89b7e-814d-42f6-8c01-35068265b9e9', 'Erma', 'McKeller', '3105029708', 'emckeller1p@nbcnews.com', '20 Dixon Center'),
	('14304471-2d62-4b65-b2ff-846db50465bf', 'Cosimo', 'Dods', '9826445522', 'cdods1q@netlog.com', '2 Grayhawk Way'),
	('b44eb92f-5ce1-459d-b558-e83f62ee6361', 'Daniela', 'Claw', '3575866840', 'dclaw1r@biglobe.ne.jp', '0964 Oriole Place'),
	('f551f0da-c6df-4257-b3a0-e7ba6117fe50', 'Derwin', 'Earry', '9698787277', 'dearry1s@i2i.jp', '12 Maple Wood Alley'),
	('ce63703a-ef46-4f9c-8584-ee82e8cf042c', 'Tania', 'Harold', '8551664507', 'tharold1t@ning.com', '8193 Badeau Crossing'),
	('5a8e613b-02df-4357-bcb0-31c0df8175d4', 'Kayley', 'Vase', '9538449305', 'kvase1u@phpbb.com', '9 Mccormick Drive'),
	('52819c26-90f1-484f-97c6-39d2b69c65a8', 'Doris', 'Graveney', '4194045271', 'dgraveney1v@oaic.gov.au', '99156 Banding Point'),
	('ee29b3d5-eceb-47ae-98a1-b46e99dd243c', 'Yoko', 'Rapp', '8463804795', 'yrapp1w@deliciousdays.com', '71 Hanover Alley'),
	('38e0d184-1996-4aaa-9038-e562d0f50475', 'Ruth', 'Bracchi', '8994767154', 'rbracchi1x@imageshack.us', '67900 Badeau Pass'),
	('c563195e-218a-43d0-90ba-85bd1c4d8c61', 'Josefa', 'Corbridge', '8568634384', 'jcorbridge1y@stumbleupon.com', '23106 Jackson Circle'),
	('b20d0ac5-b46c-4908-8842-6d72ac507e73', 'Ripley', 'Withey', '4367301986', 'rwithey1z@skyrock.com', '5869 Birchwood Trail'),
	('7b7a9f4f-ce2c-4186-b0f1-d2cfad87f8d7', 'Desmund', 'Dorot', '9344645954', 'ddorot20@comsenz.com', '62 Anhalt Avenue'),
	('fa9e0b93-d8fa-480f-8acc-44bfe125f956', 'Rogerio', 'Kleisel', '8765012844', 'rkleisel21@woothemes.com', '644 Meadow Valley Junction'),
	('8c73ccca-f767-436f-9c6e-8e1b85cf1472', 'Gav', 'Livezley', '7188399201', 'glivezley22@ameblo.jp', '40893 Cambridge Alley'),
	('db279aac-fdc7-40ed-8b78-e9d1747e7a47', 'Gifford', 'Joppich', '3036719768', 'gjoppich23@sbwire.com', '9539 Ryan Lane'),
	('8e8d97ad-17e6-4579-a765-5b0035f3c017', 'Val', 'Lindup', '5675195596', 'vlindup24@nationalgeographic.com', '2778 Tomscot Pass'),
	('6d8f23a0-6d9b-4640-a2a4-775314c170c7', 'Heather', 'Ochterlony', '5669739040', 'hochterlony25@forbes.com', '6969 Dahle Alley'),
	('01cab9af-27dc-45b5-836d-9760ee8027b8', 'Jeanine', 'MacCollom', '8016478463', 'jmaccollom26@hc360.com', '98 Mendota Court'),
	('f610ecbc-84b2-49b5-ae80-80b673aed424', 'Aharon', 'Montes', '2026994988', 'amontes27@tinypic.com', '3 Mcguire Terrace'),
	('4d781076-a52d-4dc0-afe8-4850aab9c2bc', 'Hastie', 'Beig', '2136696351', 'hbeig28@youtube.com', '4 Tomscot Terrace'),
	('a71ef1c3-f747-411e-8a4d-dc30a26569fc', 'Guido', 'Fogarty', '3549883350', 'gfogarty29@instagram.com', '6281 Evergreen Court'),
	('b926ba58-72ab-44bd-b07a-17a8679b8b78', 'Theresa', 'Valek', '6176607281', 'tvalek2a@list-manage.com', '41228 Hanson Point'),
	('cb6e5640-84ab-4682-b6a4-81b9159356f2', 'Celestyn', 'Halloran', '5333525400', 'challoran2b@baidu.com', '949 Huxley Lane'),
	('4c636909-4b96-48d1-a145-d53bc89ebf88', 'Mace', 'Wilcockes', '1988302843', 'mwilcockes2c@imageshack.us', '490 Lake View Court'),
	('8a76a79d-a361-4b35-9b79-7ee93c3e5f1d', 'Dayna', 'Yesinov', '2263707909', 'dyesinov2d@rakuten.co.jp', '50 Manufacturers Point'),
	('1ea0844d-aa6c-42eb-b34a-aad2f022f427', 'Natala', 'Clatworthy', '7617807228', 'nclatworthy2e@chronoengine.com', '47 Lotheville Hill'),
	('920a7188-ecb8-4fef-b0a4-0ed6e7d54cd7', 'Tiffy', 'Albany', '8204221639', 'talbany2f@blogger.com', '02008 Nelson Terrace'),
	('eff526a2-4a14-4be8-bb36-f5964923186b', 'Sallee', 'Kalinsky', '9635105182', 'skalinsky2g@ucoz.com', '084 Sommers Street'),
	('d18c141d-111a-4ed9-a089-0738aeeb7f8c', 'Isidoro', 'Edy', '8285913177', 'iedy2h@ucoz.ru', '4409 Forest Dale Hill'),
	('e34c228f-da27-4175-965a-d29975dbe6af', 'Laney', 'Cranton', '6882362721', 'lcranton2i@jiathis.com', '22 Beilfuss Terrace'),
	('a9fbe4ee-23b5-4b00-9f7a-0c53208a3e8b', 'Jeniece', 'Ludl', '3642493729', 'jludl2j@bravesites.com', '68 Novick Center'),
	('33bfef37-3906-4c9a-8e78-087730fe9551', 'Mathe', 'Bissett', '8569503220', 'mbissett2k@zimbio.com', '41 Forest Drive'),
	('f88c8c70-583e-4015-aacb-64e1d941dea0', 'Gerhardt', 'Pilkington', '7186343058', 'gpilkington2l@altervista.org', '4148 Bay Hill'),
	('9b89830d-ee1f-4d40-b467-4b068b07488d', 'Chuck', 'Gude', '9911313493', 'cgude2m@technorati.com', '015 Morning Crossing'),
	('41896e8e-9816-42fb-a4cb-b72e0d777c8b', 'Dorrie', 'Curryer', '8568200474', 'dcurryer2n@gov.uk', '5 Kim Place'),
	('685e5926-cfc3-4388-828e-6962ae5f038a', 'Gary', 'Anfusso', '3418500859', 'ganfusso2o@over-blog.com', '41 Schiller Alley'),
	('0c86a948-12a5-47c9-a269-0077c45133d7', 'Calv', 'Kluss', '3277586306', 'ckluss2p@ca.gov', '57822 Vermont Place'),
	('6285e765-e11d-4a00-88b6-dcc4da793768', 'Winfield', 'Adam', '1704245328', 'wadam2q@fc2.com', '8 Waubesa Lane'),
	('d9b8c202-80b1-4db1-8d35-716caac9a667', 'Helenka', 'Ainscow', '3744161050', 'hainscow2r@nps.gov', '25 Lyons Place'),
	('9dfad8f6-7dd0-43e7-867b-2b8369201b30', 'Onfre', 'Dumbrill', '7978235075', 'odumbrill2s@opensource.org', '87850 Iowa Court'),
	('700b7cf3-9173-4bdd-ae92-08c414f2f2b3', 'Alain', 'Southcoat', '5563239460', 'asouthcoat2t@over-blog.com', '5922 Northport Drive'),
	('4a871c44-6a8a-4d54-afcf-4a15f3dd9db6', 'Rita', 'Klisch', '6104613590', 'rklisch2u@addtoany.com', '71328 Karstens Road'),
	('2fc45dea-f03e-4f20-a02c-e3456060b3ed', 'Sigismondo', 'Dundin', '1995121634', 'sdundin2v@phoca.cz', '39 John Wall Junction'),
	('9c271b63-d579-4ef7-b1ce-6d0ae2377083', 'Angy', 'Allsepp', '9556276673', 'aallsepp2w@dailymotion.com', '262 Johnson Pass'),
	('9e7fddad-ad01-4311-8a0d-0a053ffb5be3', 'Percy', 'Jatczak', '7197578629', 'pjatczak2x@un.org', '923 Hanover Avenue'),
	('51534840-23a2-4fbe-a9de-57289f8bdcbd', 'Kaspar', 'Sabie', '8332277716', 'ksabie2y@vkontakte.ru', '5 Dunning Crossing'),
	('1277b019-fe2e-45e4-958a-167b292353e4', 'Emerson', 'Reinisch', '5115177561', 'ereinisch2z@taobao.com', '221 Lakeland Lane'),
	('7016fbb2-50b9-4de7-92cc-1cf6cf457d5c', 'Hobart', 'Cestard', '1297781436', 'hcestard30@latimes.com', '9372 Rusk Terrace'),
	('dee4a6ca-6d22-44e5-bb04-2ce7b85f89cc', 'Loralie', 'Lamartine', '5638723897', 'llamartine31@berkeley.edu', '6 North Hill'),
	('b4da13c5-ba30-4d1d-8386-06963afedf15', 'Andra', 'Goldring', '7144686955', 'agoldring32@people.com.cn', '21 Holmberg Way'),
	('613fc86f-e599-462f-8a90-b15ec7444f84', 'Mirelle', 'Pollitt', '3086679338', 'mpollitt33@paginegialle.it', '13 Delaware Parkway'),
	('a2496b0e-cefb-4322-a3f7-05001ff8857f', 'Florri', 'Bryers', '9376955074', 'fbryers34@harvard.edu', '0693 Manley Circle'),
	('6b3e429a-562e-4cc6-9959-9241a6944e2f', 'Odetta', 'Boyen', '2506358293', 'oboyen35@google.com.au', '7218 Lukken Center'),
	('75cb385e-62e9-4f5a-a301-d3be7d994353', 'Daria', 'Klemensiewicz', '7039579854', 'dklemensiewicz36@thetimes.co.uk', '6262 Village Parkway'),
	('30b7ddd5-4ddb-412d-afba-1f65a4e7c4da', 'Rog', 'Eliesco', '3241934176', 'reliesco37@google.nl', '5606 Fremont Park'),
	('36eae6c7-dd4c-4d50-a218-abd5d6e95efe', 'Boyd', 'Jaslem', '9937460293', 'bjaslem38@opensource.org', '13 Riverside Hill'),
	('e68c9453-4b73-4e21-8aaf-44c296ab7f96', 'Morlee', 'Carn', '5171414624', 'mcarn39@fema.gov', '78817 Green Drive'),
	('992613e8-4a25-41ed-9ca6-f4b4aecba79d', 'Lisabeth', 'Reven', '2432906735', 'lreven3a@moonfruit.com', '4215 Browning Place'),
	('15e9c364-134e-4df2-9e1e-5bed57ad61f5', 'Mina', 'Jesteco', '7991961293', 'mjesteco3b@t-online.de', '75399 Atwood Pass'),
	('d0e3466a-c9de-436c-8cb0-d8b7c82cf42b', 'Barrie', 'Opy', '2914427362', 'bopy3c@com.com', '48729 Melby Park'),
	('0b0dd982-7d5c-4abb-90f1-4396338470c7', 'Hester', 'Coverly', '3462497625', 'hcoverly3d@typepad.com', '085 Westridge Pass'),
	('6bbf9c48-8ef0-4af6-8379-e27ff629293d', 'Almeria', 'Blaber', '2143657178', 'ablaber3e@vkontakte.ru', '48410 Brentwood Place'),
	('7b658a91-5b74-4550-82a4-c2569cbe56a8', 'Ruddy', 'Porcas', '9933993337', 'rporcas3f@webnode.com', '01 Express Point'),
	('7ab101ed-f7d2-428c-b922-aa838de78a2f', 'Winny', 'McPolin', '9463047067', 'wmcpolin3g@istockphoto.com', '43 Nancy Court'),
	('48218b33-ae7b-437b-b57a-0ad364f0b637', 'Derrek', 'Wreight', '8035331765', 'dwreight3h@vistaprint.com', '73 Jackson Junction'),
	('97b5fc44-a980-4b6b-8a0e-8b4059db2ab5', 'Quintus', 'Ferroni', '5026852227', 'qferroni3i@archive.org', '5 Karstens Place'),
	('d0b60d51-f8ed-4715-8b78-6e6f16863504', 'Ewen', 'Imlach', '6222957140', 'eimlach3j@icio.us', '93557 Hagan Drive'),
	('3075d27e-1f63-42eb-ab15-d4426d829bfa', 'Raddy', 'Cruce', '9165305764', 'rcruce3k@qq.com', '165 Dunning Parkway'),
	('4f65c212-d79c-46ca-b693-acf74395a275', 'Candie', 'Coster', '8545893218', 'ccoster3l@xinhuanet.com', '474 Grover Avenue'),
	('10058437-e692-44c2-aaca-1d867b09cad1', 'Robena', 'Massingberd', '7777700820', 'rmassingberd3m@domainmarket.com', '21 Lawn Way'),
	('ae6e49b2-7163-4654-bf81-3a41aa43aee6', 'Sadye', 'Buxsy', '1033572824', 'sbuxsy3n@ebay.com', '9551 Derek Pass'),
	('9cde35a9-36bd-42f9-a0e0-a1a1862c6858', 'Dyna', 'Sciusscietto', '2649290210', 'dsciusscietto3o@marketwatch.com', '5592 Carberry Crossing'),
	('f4bfaca6-8f5c-409b-a6c5-e97d84c5cd87', 'Robby', 'Bleakley', '1317774159', 'rbleakley3p@va.gov', '8 Maryland Lane');

INSERT INTO wasit (id_wasit, lisensi) VALUES
	('baca91c4-8fc2-4775-ac71-f3b2afeeb9e6', 'J7890'),
	('4813b3d9-ba73-4b9f-bc25-863a1ac72ac5', 'H9012'),
	('f16595d9-7c7c-4abf-9ec6-2ea692338f3b', 'N3456'),
	('226e8462-8318-4b88-9593-e1ce23eb6f54', 'P1234'),
	('0e95aa6a-f266-432d-9055-ab6c9ed7f002', 'M9012'),
	('2a7ca12e-7b91-498e-bb5b-1d0840288b7e', 'B5678'),
	('219e47f7-3262-47eb-ac87-d30c1fb3e4fe', 'D3456'),
	('e4178942-2136-4846-b827-7b8833712702', 'K1234'),
	('d5033e7b-3329-4440-b498-2438d7a519b6', 'G5678'),
	('e32e24b8-81c8-46d1-9f02-06d51b60aa97', 'I3456'),
	('1579a11f-4f4a-4976-853a-aca69911f0d1', 'C9012'),
	('0cca335f-3186-41ba-9e4e-54ac626fdf0c', 'H9012'),
	('1a98d441-587c-42cb-926e-3cb3c24a533f', 'D3456'),
	('c75a1f90-8536-483b-9b4c-5156289c12d7', 'O7890'),
	('6f91de94-553e-436f-aef0-9643f4204b18', 'P1234'),
	('64f336ab-db6e-4e73-ae09-67c557873eca', 'B5678'),
	('214429c6-192f-4299-91e5-8d9b8e44a3b9', 'J7890'),
	('f830e066-93fe-4a78-a54d-f36d0cef868e', 'F1234'),
	('a8466804-cb18-49be-890b-388f14df61a1', 'M9012'),
	('b420d88a-b70c-4d89-8521-fe171aa30d6b', 'A1234');

INSERT INTO status_non_pemain (id_non_pemain, status) VALUES
	('baca91c4-8fc2-4775-ac71-f3b2afeeb9e6', 'mahasiswa'),
	('4813b3d9-ba73-4b9f-bc25-863a1ac72ac5', 'dosen'),
	('f16595d9-7c7c-4abf-9ec6-2ea692338f3b', 'tendik'),
	('226e8462-8318-4b88-9593-e1ce23eb6f54', 'alumni'),
	('0e95aa6a-f266-432d-9055-ab6c9ed7f002', 'umum'),
	('2a7ca12e-7b91-498e-bb5b-1d0840288b7e', 'mahasiswa'),
	('219e47f7-3262-47eb-ac87-d30c1fb3e4fe', 'dosen'),
	('e4178942-2136-4846-b827-7b8833712702', 'tendik'),
	('d5033e7b-3329-4440-b498-2438d7a519b6', 'alumni'),
	('e32e24b8-81c8-46d1-9f02-06d51b60aa97', 'umum'),
	('1579a11f-4f4a-4976-853a-aca69911f0d1', 'mahasiswa'),
	('0cca335f-3186-41ba-9e4e-54ac626fdf0c', 'dosen'),
	('1a98d441-587c-42cb-926e-3cb3c24a533f', 'tendik'),
	('c75a1f90-8536-483b-9b4c-5156289c12d7', 'alumni'),
	('6f91de94-553e-436f-aef0-9643f4204b18', 'umum'),
	('64f336ab-db6e-4e73-ae09-67c557873eca', 'mahasiswa'),
	('214429c6-192f-4299-91e5-8d9b8e44a3b9', 'dosen'),
	('f830e066-93fe-4a78-a54d-f36d0cef868e', 'tendik'),
	('a8466804-cb18-49be-890b-388f14df61a1', 'alumni'),
	('b420d88a-b70c-4d89-8521-fe171aa30d6b', 'umum'),
	('7c1840a7-9f46-40a1-8bfc-1150eeaf67f6', 'mahasiswa'),
	('d1fcda36-b726-43fb-a093-d4b2b93543a5', 'dosen'),
	('1831425e-8ad8-4084-b89f-d5ab7b0f1f14', 'tendik'),
	('8c771216-25d9-4dcb-9b39-2f1d3e0eb577', 'alumni'),
	('3872f72b-98c4-4dba-9b2a-ef9b9ddab6e8', 'umum'),
	('db0a0705-e2b0-4218-a9e9-351264c6bbb6', 'mahasiswa'),
	('0979f75c-a0ec-49bc-9e0e-d0b63e261fab', 'dosen'),
	('c428efa9-8cd2-4193-bac0-42a49e4ffc5d', 'tendik'),
	('9ec6da76-a849-4437-b239-bc2e02937cbc', 'alumni'),
	('3adcea11-c30c-4fe7-b247-c945a0b978b7', 'umum'),
	('f7aaead9-e2d1-46e2-aff2-bfaa81189fe2', 'mahasiswa'),
	('4aca9615-0711-4a4f-bb39-8a5d18da9606', 'dosen'),
	('d485db62-dd05-4a87-b500-49b4b97a44d9', 'tendik'),
	('63b1e101-6fb5-4d5b-b7ae-3c9c9dcb4aff', 'alumni'),
	('3de61e7e-e2dd-4106-891d-7dc978097d2a', 'umum'),
	('103ec535-54e4-4032-8a4f-094c6025e813', 'mahasiswa'),
	('0e4b7304-ab74-4898-81c0-50533b13726f', 'dosen'),
	('d5c79af8-72d4-45b6-9179-2539ad979cd0', 'tendik'),
	('f8374a40-2f03-45b2-8882-f587f3a1aad6', 'alumni'),
	('7de0dc28-5357-494c-8da2-aac32f22f9e5', 'umum'),
	('0cca486c-e0fd-41f2-a402-43c7fe944317', 'mahasiswa'),
	('bf11816b-825e-4d6d-a560-49cbd6459150', 'dosen'),
	('7ce9f80a-dab0-402f-aade-7a7ea1a5cfa2', 'tendik'),
	('23f00f00-1d05-4953-a04b-c638954cc49a', 'alumni'),
	('caf87d17-b4f7-4073-bafa-60db28400aa1', 'umum'),
	('5449ea13-e439-4dd7-aae9-f0d635022841', 'mahasiswa'),
	('413d78f7-344a-41fc-96f1-417336d36980', 'dosen'),
	('1d6b4c84-a0ee-484d-a700-f42b3526d0c2', 'tendik'),
	('a961b497-cf6d-43da-8717-ff71c2297491', 'alumni'),
	('00abfafd-a840-4dc0-9f36-e9c0be74fb5f', 'umum'),
	('6ed537bf-43ec-484c-98a8-e345d80cf963', 'mahasiswa'),
	('5fca97e6-0d5b-4b8f-aed5-dcb343b3cb22', 'dosen'),
	('50ba324d-4064-4a52-8410-e657caaae38d', 'tendik'),
	('69447347-0155-45ab-aef5-c83685dcaad4', 'alumni'),
	('c0962756-709d-42ce-b4cf-f69dae1f3c8b', 'umum'),
	('319b2f45-43ed-4914-b0ef-d7ac36f04034', 'mahasiswa'),
	('a5e520c1-5b5d-48cd-befa-13833b19f1b7', 'dosen'),
	('4a81f33e-5198-41e0-a06b-7826d5a3ef36', 'tendik'),
	('feae7bbf-f7eb-46bc-b362-4aab15162b85', 'alumni'),
	('0657eb88-0ccd-4fc2-9ccb-71e7c2081f9b', 'umum'),
	('be6a72a8-1f99-4c4a-9cd6-90823a85cde9', 'mahasiswa'),
	('7ad89b7e-814d-42f6-8c01-35068265b9e9', 'dosen'),
	('14304471-2d62-4b65-b2ff-846db50465bf', 'tendik'),
	('b44eb92f-5ce1-459d-b558-e83f62ee6361', 'alumni'),
	('f551f0da-c6df-4257-b3a0-e7ba6117fe50', 'umum'),
	('ce63703a-ef46-4f9c-8584-ee82e8cf042c', 'mahasiswa'),
	('5a8e613b-02df-4357-bcb0-31c0df8175d4', 'dosen'),
	('52819c26-90f1-484f-97c6-39d2b69c65a8', 'tendik'),
	('ee29b3d5-eceb-47ae-98a1-b46e99dd243c', 'alumni'),
	('38e0d184-1996-4aaa-9038-e562d0f50475', 'umum'),
	('c563195e-218a-43d0-90ba-85bd1c4d8c61', 'mahasiswa'),
	('b20d0ac5-b46c-4908-8842-6d72ac507e73', 'dosen'),
	('7b7a9f4f-ce2c-4186-b0f1-d2cfad87f8d7', 'tendik'),
	('fa9e0b93-d8fa-480f-8acc-44bfe125f956', 'alumni'),
	('8c73ccca-f767-436f-9c6e-8e1b85cf1472', 'umum'),
	('db279aac-fdc7-40ed-8b78-e9d1747e7a47', 'mahasiswa'),
	('8e8d97ad-17e6-4579-a765-5b0035f3c017', 'dosen'),
	('6d8f23a0-6d9b-4640-a2a4-775314c170c7', 'tendik'),
	('01cab9af-27dc-45b5-836d-9760ee8027b8', 'alumni'),
	('f610ecbc-84b2-49b5-ae80-80b673aed424', 'umum'),
	('4d781076-a52d-4dc0-afe8-4850aab9c2bc', 'mahasiswa'),
	('a71ef1c3-f747-411e-8a4d-dc30a26569fc', 'dosen'),
	('b926ba58-72ab-44bd-b07a-17a8679b8b78', 'tendik'),
	('cb6e5640-84ab-4682-b6a4-81b9159356f2', 'alumni'),
	('4c636909-4b96-48d1-a145-d53bc89ebf88', 'umum'),
	('8a76a79d-a361-4b35-9b79-7ee93c3e5f1d', 'mahasiswa'),
	('1ea0844d-aa6c-42eb-b34a-aad2f022f427', 'dosen'),
	('920a7188-ecb8-4fef-b0a4-0ed6e7d54cd7', 'tendik'),
	('eff526a2-4a14-4be8-bb36-f5964923186b', 'alumni'),
	('d18c141d-111a-4ed9-a089-0738aeeb7f8c', 'umum'),
	('e34c228f-da27-4175-965a-d29975dbe6af', 'mahasiswa'),
	('a9fbe4ee-23b5-4b00-9f7a-0c53208a3e8b', 'dosen'),
	('33bfef37-3906-4c9a-8e78-087730fe9551', 'tendik'),
	('f88c8c70-583e-4015-aacb-64e1d941dea0', 'alumni'),
	('9b89830d-ee1f-4d40-b467-4b068b07488d', 'umum'),
	('41896e8e-9816-42fb-a4cb-b72e0d777c8b', 'mahasiswa'),
	('685e5926-cfc3-4388-828e-6962ae5f038a', 'dosen'),
	('0c86a948-12a5-47c9-a269-0077c45133d7', 'tendik'),
	('6285e765-e11d-4a00-88b6-dcc4da793768', 'alumni'),
	('d9b8c202-80b1-4db1-8d35-716caac9a667', 'umum'),
	('9dfad8f6-7dd0-43e7-867b-2b8369201b30', 'mahasiswa'),
	('700b7cf3-9173-4bdd-ae92-08c414f2f2b3', 'dosen'),
	('4a871c44-6a8a-4d54-afcf-4a15f3dd9db6', 'tendik'),
	('2fc45dea-f03e-4f20-a02c-e3456060b3ed', 'alumni'),
	('9c271b63-d579-4ef7-b1ce-6d0ae2377083', 'umum'),
	('9e7fddad-ad01-4311-8a0d-0a053ffb5be3', 'mahasiswa'),
	('51534840-23a2-4fbe-a9de-57289f8bdcbd', 'dosen'),
	('1277b019-fe2e-45e4-958a-167b292353e4', 'tendik'),
	('7016fbb2-50b9-4de7-92cc-1cf6cf457d5c', 'alumni'),
	('dee4a6ca-6d22-44e5-bb04-2ce7b85f89cc', 'umum'),
	('b4da13c5-ba30-4d1d-8386-06963afedf15', 'mahasiswa'),
	('613fc86f-e599-462f-8a90-b15ec7444f84', 'dosen'),
	('a2496b0e-cefb-4322-a3f7-05001ff8857f', 'tendik'),
	('6b3e429a-562e-4cc6-9959-9241a6944e2f', 'alumni'),
	('75cb385e-62e9-4f5a-a301-d3be7d994353', 'umum'),
	('30b7ddd5-4ddb-412d-afba-1f65a4e7c4da', 'mahasiswa'),
	('36eae6c7-dd4c-4d50-a218-abd5d6e95efe', 'dosen'),
	('e68c9453-4b73-4e21-8aaf-44c296ab7f96', 'tendik'),
	('992613e8-4a25-41ed-9ca6-f4b4aecba79d', 'alumni'),
	('15e9c364-134e-4df2-9e1e-5bed57ad61f5', 'umum'),
	('d0e3466a-c9de-436c-8cb0-d8b7c82cf42b', 'mahasiswa'),
	('0b0dd982-7d5c-4abb-90f1-4396338470c7', 'dosen'),
	('6bbf9c48-8ef0-4af6-8379-e27ff629293d', 'tendik'),
	('7b658a91-5b74-4550-82a4-c2569cbe56a8', 'alumni'),
	('7ab101ed-f7d2-428c-b922-aa838de78a2f', 'umum'),
	('48218b33-ae7b-437b-b57a-0ad364f0b637', 'mahasiswa'),
	('97b5fc44-a980-4b6b-8a0e-8b4059db2ab5', 'dosen'),
	('d0b60d51-f8ed-4715-8b78-6e6f16863504', 'tendik'),
	('3075d27e-1f63-42eb-ab15-d4426d829bfa', 'alumni'),
	('4f65c212-d79c-46ca-b693-acf74395a275', 'umum'),
	('10058437-e692-44c2-aaca-1d867b09cad1', 'mahasiswa'),
	('ae6e49b2-7163-4654-bf81-3a41aa43aee6', 'dosen'),
	('9cde35a9-36bd-42f9-a0e0-a1a1862c6858', 'tendik'),
	('f4bfaca6-8f5c-409b-a6c5-e97d84c5cd87', 'alumni');

INSERT INTO stadium (id_stadium, nama, alamat, kapasitas) VALUES
	('1f1424c6-a2ea-4d24-a419-a8b91b92b528', 'Wenshan', '309 Fair Oaks Junction', '48354'),
	('a8c51959-2706-4f76-966a-a2443ec1f9fc', 'Prince Rupert', '29553 Ronald Regan Plaza', '83177'),
	('1cb441d8-1548-4fde-b7ec-ec7280beb38f', 'Borneo', '41 Brentwood Parkway', '49010'),
	('a645266b-5d9a-445e-aa9c-28eaafa42a15', 'Chatham', '77957 Rowland Junction', '65907'),
	('a9dc0057-0419-40ba-8607-6224445dcc74', 'Pinkman', '182 Sheridan Way', '84148'),
	('fb8b5e52-7512-4916-9ea1-61d21c060764', 'Grangeville', '399 Pennsylvania Alley', '47970'),
	('e1aaddcf-e865-4f3d-bbeb-519859acb137', 'Manston', '164 Northwestern Road', '94877'),
	('73ca9eca-02e7-46af-a91a-5c6949b26116', 'Salamanca', '8147 Kropf Way', '95278'),
	('42158f19-fd13-431e-9347-619d0e195be0', 'Lindi', '23412 Blue Bill Park Park', '40459'),
	('96db1679-e8f8-4c2a-9937-e0c5781b74af', 'Plovdiv', '4864 Boyd Trail', '69672');

INSERT INTO perlengkapan_stadium (id_stadium, item, kapasitas) VALUES
	('1f1424c6-a2ea-4d24-a419-a8b91b92b528', 'goal posts', '62'),
	('a8c51959-2706-4f76-966a-a2443ec1f9fc', 'scoreboard', '73'),
	('1cb441d8-1548-4fde-b7ec-ec7280beb38f', 'bleachers', '78'),
	('a645266b-5d9a-445e-aa9c-28eaafa42a15', 'concession stands', '94'),
	('a9dc0057-0419-40ba-8607-6224445dcc74', 'ticket booths', '68'),
	('fb8b5e52-7512-4916-9ea1-61d21c060764', 'field turf', '63'),
	('e1aaddcf-e865-4f3d-bbeb-519859acb137', 'locker rooms', '71'),
	('73ca9eca-02e7-46af-a91a-5c6949b26116', 'referee whistle', '8'),
	('42158f19-fd13-431e-9347-619d0e195be0', 'corner flags', '81'),
	('96db1679-e8f8-4c2a-9937-e0c5781b74af', 'stadium lights', '13'),
	('1f1424c6-a2ea-4d24-a419-a8b91b92b528', 'team benches', '42'),
	('a8c51959-2706-4f76-966a-a2443ec1f9fc', 'ball boys/girls kits', '55'),
	('1cb441d8-1548-4fde-b7ec-ec7280beb38f', 'first aid kits', '1'),
	('a645266b-5d9a-445e-aa9c-28eaafa42a15', 'megaphones', '51'),
	('a9dc0057-0419-40ba-8607-6224445dcc74', 'loudspeakers', '21'),
	('fb8b5e52-7512-4916-9ea1-61d21c060764', 'VIP boxes', '63'),
	('e1aaddcf-e865-4f3d-bbeb-519859acb137', 'press box', '44'),
	('73ca9eca-02e7-46af-a91a-5c6949b26116', 'tunnel entrance', '87'),
	('42158f19-fd13-431e-9347-619d0e195be0', 'stadium clock', '27'),
	('96db1679-e8f8-4c2a-9937-e0c5781b74af', 'flag poles', '66');

INSERT INTO pertandingan (id_pertandingan, start_datetime, end_datetime, stadium) VALUES
	('93c44227-2ac2-420a-8577-76293771a894', '2023-02-10 0:31:18', '2023-03-28 0:48:38', '1f1424c6-a2ea-4d24-a419-a8b91b92b528'),
	('4ac56e5e-f2d9-491f-9edc-e5120f84c4a7', '2023-02-13 6:46:55', '2023-02-23 21:05:43', 'a8c51959-2706-4f76-966a-a2443ec1f9fc'),
	('4c632c34-0025-42af-94a5-a3eb35070a9f', '2023-03-25 7:06:04', '2023-04-04 18:34:03', '1cb441d8-1548-4fde-b7ec-ec7280beb38f'),
	('e2ec60d1-516a-4a3f-8b32-e8a6dd42f75c', '2023-02-09 3:30:27', '2023-02-12 6:43:24', 'a645266b-5d9a-445e-aa9c-28eaafa42a15'),
	('8f81ff6c-e8ed-4799-87ef-3bf86d37fa44', '2023-04-06 14:35:27', '2023-04-28 5:56:30', 'a9dc0057-0419-40ba-8607-6224445dcc74');

INSERT INTO peristiwa (id_pertandingan, datetime, jenis, id_pemain) VALUES ('4ac56e5e-f2d9-491f-9edc-e5120f84c4a7', '2023-02-25 19:46:28', 'gol', '959b8584-ed9c-4c47-9f4a-783f907a81ce'),
	('e2ec60d1-516a-4a3f-8b32-e8a6dd42f75c', '2023-02-12 13:32:01', 'kartu kuning', '8589a238-793c-42e3-b01c-d9e08673539d'),
	('e2ec60d1-516a-4a3f-8b32-e8a6dd42f75c', '2023-04-21 0:12:06', 'assist', '715a47dd-043a-42e6-91ad-2e3db59e0707'),
	('4ac56e5e-f2d9-491f-9edc-e5120f84c4a7', '2023-04-22 5:22:13', 'kartu kuning', '0e0545c2-f6e4-4be6-93fe-a87b86e65744'),
	('4ac56e5e-f2d9-491f-9edc-e5120f84c4a7', '2023-02-09 18:51:24', 'assist', 'ca2fa3ed-fdb8-4455-b6df-2fbe4a0e82dd'),
	('93c44227-2ac2-420a-8577-76293771a894', '2023-02-13 9:22:25', 'gol', 'ecc2d5a4-c2b2-4d44-bc44-d008f484c97b'),
	('4c632c34-0025-42af-94a5-a3eb35070a9f', '2023-03-30 18:31:42', 'assist', '5a3817be-ad52-4223-a17b-37b115cc6fac'),
	('93c44227-2ac2-420a-8577-76293771a894', '2023-04-13 4:38:56', 'gol', '43c7861e-e355-4da7-b897-cdcd27c5f075'),
	('4ac56e5e-f2d9-491f-9edc-e5120f84c4a7', '2023-02-07 16:03:10', 'assist', '750a2420-22e4-41cc-8d2f-79fa4cc65636'),
	('4c632c34-0025-42af-94a5-a3eb35070a9f', '2023-04-17 0:48:47', 'kartu merah', '9e9f5381-a242-437a-8f28-f8ac0e74b1ee'),
	('4c632c34-0025-42af-94a5-a3eb35070a9f', '2023-02-05 0:22:21', 'kartu merah', '621b69ed-836f-44d9-aeca-36f30481d57b');

INSERT INTO wasit_bertugas (id_wasit, id_pertandingan, posisi_wasit) VALUES ('1579a11f-4f4a-4976-853a-aca69911f0d1', '93c44227-2ac2-420a-8577-76293771a894', 'hakim garis'),
	('b420d88a-b70c-4d89-8521-fe171aa30d6b', '4ac56e5e-f2d9-491f-9edc-e5120f84c4a7', 'wasit utama'),
	('6f91de94-553e-436f-aef0-9643f4204b18', '4c632c34-0025-42af-94a5-a3eb35070a9f', 'wasit cadangan'),
	('0e95aa6a-f266-432d-9055-ab6c9ed7f002', 'e2ec60d1-516a-4a3f-8b32-e8a6dd42f75c', 'wasit utama'),
	('e4178942-2136-4846-b827-7b8833712702', '8f81ff6c-e8ed-4799-87ef-3bf86d37fa44', 'hakim garis'),
	('baca91c4-8fc2-4775-ac71-f3b2afeeb9e6', '93c44227-2ac2-420a-8577-76293771a894', 'wasit cadangan'),
	('f16595d9-7c7c-4abf-9ec6-2ea692338f3b', '4ac56e5e-f2d9-491f-9edc-e5120f84c4a7', 'wasit utama'),
	('f16595d9-7c7c-4abf-9ec6-2ea692338f3b', '4c632c34-0025-42af-94a5-a3eb35070a9f', 'wasit utama'),
	('1a98d441-587c-42cb-926e-3cb3c24a533f', 'e2ec60d1-516a-4a3f-8b32-e8a6dd42f75c', 'wasit utama'),
	('f16595d9-7c7c-4abf-9ec6-2ea692338f3b', '8f81ff6c-e8ed-4799-87ef-3bf86d37fa44', 'hakim garis');

INSERT INTO penonton (id_penonton, username) VALUES ('7c1840a7-9f46-40a1-8bfc-1150eeaf67f6', 'mdeleek0'),
	('d1fcda36-b726-43fb-a093-d4b2b93543a5', 'nmcgerraghty1'),
	('1831425e-8ad8-4084-b89f-d5ab7b0f1f14', 'drepper2'),
	('8c771216-25d9-4dcb-9b39-2f1d3e0eb577', 'aager3'),
	('3872f72b-98c4-4dba-9b2a-ef9b9ddab6e8', 'twormald4'),
	('db0a0705-e2b0-4218-a9e9-351264c6bbb6', 'jheaffey5'),
	('0979f75c-a0ec-49bc-9e0e-d0b63e261fab', 'kosheilds6'),
	('c428efa9-8cd2-4193-bac0-42a49e4ffc5d', 'parr7'),
	('9ec6da76-a849-4437-b239-bc2e02937cbc', 'qpriestner8'),
	('3adcea11-c30c-4fe7-b247-c945a0b978b7', 'sboltwood9'),
	('f7aaead9-e2d1-46e2-aff2-bfaa81189fe2', 'loatesa'),
	('4aca9615-0711-4a4f-bb39-8a5d18da9606', 'cgaufordb'),
	('d485db62-dd05-4a87-b500-49b4b97a44d9', 'gslobomc'),
	('63b1e101-6fb5-4d5b-b7ae-3c9c9dcb4aff', 'labreyd'),
	('3de61e7e-e2dd-4106-891d-7dc978097d2a', 'sfeyere'),
	('103ec535-54e4-4032-8a4f-094c6025e813', 'cparncuttf'),
	('0e4b7304-ab74-4898-81c0-50533b13726f', 'omattheeuwg'),
	('d5c79af8-72d4-45b6-9179-2539ad979cd0', 'rratledgeh'),
	('f8374a40-2f03-45b2-8882-f587f3a1aad6', 'rchalcoti'),
	('7de0dc28-5357-494c-8da2-aac32f22f9e5', 'xwhitmorej');

INSERT INTO pembelian_tiket (nomor_receipt, id_penonton, jenis_tiket, jenis_pembayaran, id_pertandingan) VALUES ('64944', '9ec6da76-a849-4437-b239-bc2e02937cbc', 'Main East', 'Dana', '8f81ff6c-e8ed-4799-87ef-3bf86d37fa44'),
	('65854', '9ec6da76-a849-4437-b239-bc2e02937cbc', 'VIP', 'Dana', '4ac56e5e-f2d9-491f-9edc-e5120f84c4a7'),
	('46912', '3adcea11-c30c-4fe7-b247-c945a0b978b7', 'Kategori 1', 'Dana', '93c44227-2ac2-420a-8577-76293771a894'),
	('26941', 'd485db62-dd05-4a87-b500-49b4b97a44d9', 'Kategori 1', 'Gopay', 'e2ec60d1-516a-4a3f-8b32-e8a6dd42f75c'),
	('78475', 'f7aaead9-e2d1-46e2-aff2-bfaa81189fe2', 'VIP', 'Gopay', '4c632c34-0025-42af-94a5-a3eb35070a9f');

INSERT INTO panitia (id_panitia, jabatan, username) VALUES ('0cca486c-e0fd-41f2-a402-43c7fe944317', 'Ketua Pelaksana', 'pkerfootk'),
	('bf11816b-825e-4d6d-a560-49cbd6459150', 'Wakil Ketua Pelaksana', 'hskydalll'),
	('7ce9f80a-dab0-402f-aade-7a7ea1a5cfa2', 'Koordinator Bidang Acara', 'nmoodycliffem'),
	('23f00f00-1d05-4953-a04b-c638954cc49a', 'Koordinator Bidang Keamanan', 'binskippn'),
	('caf87d17-b4f7-4073-bafa-60db28400aa1', 'Koordinator Bidang Konsumsi', 'rjacobseno'),
	('5449ea13-e439-4dd7-aae9-f0d635022841', 'Koordinator Bidang Perlengkapan', 'sbriggep'),
	('413d78f7-344a-41fc-96f1-417336d36980', 'Koordinator Bidang Promosi', 'gparsonsq'),
	('1d6b4c84-a0ee-484d-a700-f42b3526d0c2', 'Staf Acara', 'amusprattr'),
	('a961b497-cf6d-43da-8717-ff71c2297491', 'Staf Keamanan', 'mgoomess'),
	('00abfafd-a840-4dc0-9f36-e9c0be74fb5f', 'Staf Konsumsi', 'mbenkint'),
	('6ed537bf-43ec-484c-98a8-e345d80cf963', 'Bendahara', 'clamswoodu'),
	('5fca97e6-0d5b-4b8f-aed5-dcb343b3cb22', 'Sekretaris', 'cpesikv'),
	('50ba324d-4064-4a52-8410-e657caaae38d', 'Staf Acara', 'scarwithanw'),
	('69447347-0155-45ab-aef5-c83685dcaad4', 'Staf Keamanan', 'ewhifenx'),
	('c0962756-709d-42ce-b4cf-f69dae1f3c8b', 'Staf Konsumsi', 'sstuddy'),
	('319b2f45-43ed-4914-b0ef-d7ac36f04034', 'Sekretaris', 'ihemphillz'),
	('a5e520c1-5b5d-48cd-befa-13833b19f1b7', 'Bendahara', 'fashling10'),
	('4a81f33e-5198-41e0-a06b-7826d5a3ef36', 'Staf Acara', 'ddulieu11'),
	('feae7bbf-f7eb-46bc-b362-4aab15162b85', 'Staf Keamanan', 'mkauscher12'),
	('0657eb88-0ccd-4fc2-9ccb-71e7c2081f9b', 'Staf Konsumsi', 'zmccaughey13');

INSERT INTO pelatih (id_pelatih, nama_tim) VALUES ('be6a72a8-1f99-4c4a-9cd6-90823a85cde9', 'Coppertone Kids'),
	('7ad89b7e-814d-42f6-8c01-35068265b9e9', 'Trelstar'),
	('14304471-2d62-4b65-b2ff-846db50465bf', 'WhiskCare 357'),
	('b44eb92f-5ce1-459d-b558-e83f62ee6361', 'Xanax'),
	('f551f0da-c6df-4257-b3a0-e7ba6117fe50', 'COREG'),
	('ce63703a-ef46-4f9c-8584-ee82e8cf042c', 'Gowoonsesang'),
	('5a8e613b-02df-4357-bcb0-31c0df8175d4', 'Aderall'),
	('52819c26-90f1-484f-97c6-39d2b69c65a8', 'CLINIMIX'),
	('ee29b3d5-eceb-47ae-98a1-b46e99dd243c', 'Pravastatin'),
	('38e0d184-1996-4aaa-9038-e562d0f50475', 'Tylenol'),
	('c563195e-218a-43d0-90ba-85bd1c4d8c61', 'Coppertone Kids'),
	('b20d0ac5-b46c-4908-8842-6d72ac507e73', 'Trelstar'),
	('7b7a9f4f-ce2c-4186-b0f1-d2cfad87f8d7', 'WhiskCare 357'),
	('fa9e0b93-d8fa-480f-8acc-44bfe125f956', 'Xanax'),
	('8c73ccca-f767-436f-9c6e-8e1b85cf1472', 'COREG'),
	('db279aac-fdc7-40ed-8b78-e9d1747e7a47', 'Gowoonsesang'),
	('8e8d97ad-17e6-4579-a765-5b0035f3c017', 'Aderall'),
	('6d8f23a0-6d9b-4640-a2a4-775314c170c7', 'CLINIMIX'),
	('01cab9af-27dc-45b5-836d-9760ee8027b8', 'Pravastatin'),
	('f610ecbc-84b2-49b5-ae80-80b673aed424', 'Tylenol');

INSERT INTO pelatih (id_pelatih) VALUES ('4d781076-a52d-4dc0-afe8-4850aab9c2bc'),
	('a71ef1c3-f747-411e-8a4d-dc30a26569fc'),
	('b926ba58-72ab-44bd-b07a-17a8679b8b78'),
	('cb6e5640-84ab-4682-b6a4-81b9159356f2'),
	('4c636909-4b96-48d1-a145-d53bc89ebf88'),
	('8a76a79d-a361-4b35-9b79-7ee93c3e5f1d'),
	('1ea0844d-aa6c-42eb-b34a-aad2f022f427'),
	('920a7188-ecb8-4fef-b0a4-0ed6e7d54cd7'),
	('eff526a2-4a14-4be8-bb36-f5964923186b'),
	('d18c141d-111a-4ed9-a089-0738aeeb7f8c'),
	('e34c228f-da27-4175-965a-d29975dbe6af'),
	('a9fbe4ee-23b5-4b00-9f7a-0c53208a3e8b'),
	('33bfef37-3906-4c9a-8e78-087730fe9551'),
	('f88c8c70-583e-4015-aacb-64e1d941dea0'),
	('9b89830d-ee1f-4d40-b467-4b068b07488d'),
	('41896e8e-9816-42fb-a4cb-b72e0d777c8b'),
	('685e5926-cfc3-4388-828e-6962ae5f038a'),
	('0c86a948-12a5-47c9-a269-0077c45133d7'),
	('6285e765-e11d-4a00-88b6-dcc4da793768'),
	('d9b8c202-80b1-4db1-8d35-716caac9a667'),
	('9dfad8f6-7dd0-43e7-867b-2b8369201b30'),
	('700b7cf3-9173-4bdd-ae92-08c414f2f2b3'),
	('4a871c44-6a8a-4d54-afcf-4a15f3dd9db6'),
	('2fc45dea-f03e-4f20-a02c-e3456060b3ed'),
	('9c271b63-d579-4ef7-b1ce-6d0ae2377083'),
	('9e7fddad-ad01-4311-8a0d-0a053ffb5be3'),
	('51534840-23a2-4fbe-a9de-57289f8bdcbd'),
	('1277b019-fe2e-45e4-958a-167b292353e4'),
	('7016fbb2-50b9-4de7-92cc-1cf6cf457d5c'),
	('dee4a6ca-6d22-44e5-bb04-2ce7b85f89cc'),
	('b4da13c5-ba30-4d1d-8386-06963afedf15'),
	('613fc86f-e599-462f-8a90-b15ec7444f84'),
	('a2496b0e-cefb-4322-a3f7-05001ff8857f'),
	('6b3e429a-562e-4cc6-9959-9241a6944e2f'),
	('75cb385e-62e9-4f5a-a301-d3be7d994353'),
	('30b7ddd5-4ddb-412d-afba-1f65a4e7c4da'),
	('36eae6c7-dd4c-4d50-a218-abd5d6e95efe'),
	('e68c9453-4b73-4e21-8aaf-44c296ab7f96'),
	('992613e8-4a25-41ed-9ca6-f4b4aecba79d'),
	('15e9c364-134e-4df2-9e1e-5bed57ad61f5'),
	('d0e3466a-c9de-436c-8cb0-d8b7c82cf42b'),
	('0b0dd982-7d5c-4abb-90f1-4396338470c7'),
	('6bbf9c48-8ef0-4af6-8379-e27ff629293d'),
	('7b658a91-5b74-4550-82a4-c2569cbe56a8');

INSERT INTO spesialisasi_pelatih (id_pelatih, spesialisasi) VALUES ('be6a72a8-1f99-4c4a-9cd6-90823a85cde9', 'teknik'),
	('7ad89b7e-814d-42f6-8c01-35068265b9e9', 'taktik'),
	('14304471-2d62-4b65-b2ff-846db50465bf', 'teknik'),
	('b44eb92f-5ce1-459d-b558-e83f62ee6361', 'taktik'),
	('f551f0da-c6df-4257-b3a0-e7ba6117fe50', 'teknik'),
	('ce63703a-ef46-4f9c-8584-ee82e8cf042c', 'taktik'),
	('5a8e613b-02df-4357-bcb0-31c0df8175d4', 'teknik'),
	('52819c26-90f1-484f-97c6-39d2b69c65a8', 'taktik'),
	('ee29b3d5-eceb-47ae-98a1-b46e99dd243c', 'teknik'),
	('38e0d184-1996-4aaa-9038-e562d0f50475', 'taktik'),
	('c563195e-218a-43d0-90ba-85bd1c4d8c61', 'teknik'),
	('b20d0ac5-b46c-4908-8842-6d72ac507e73', 'taktik'),
	('7b7a9f4f-ce2c-4186-b0f1-d2cfad87f8d7', 'teknik'),
	('fa9e0b93-d8fa-480f-8acc-44bfe125f956', 'taktik'),
	('8c73ccca-f767-436f-9c6e-8e1b85cf1472', 'teknik'),
	('db279aac-fdc7-40ed-8b78-e9d1747e7a47', 'taktik'),
	('8e8d97ad-17e6-4579-a765-5b0035f3c017', 'teknik'),
	('6d8f23a0-6d9b-4640-a2a4-775314c170c7', 'taktik'),
	('01cab9af-27dc-45b5-836d-9760ee8027b8', 'teknik'),
	('f610ecbc-84b2-49b5-ae80-80b673aed424', 'taktik'),
	('4d781076-a52d-4dc0-afe8-4850aab9c2bc', 'teknik'),
	('a71ef1c3-f747-411e-8a4d-dc30a26569fc', 'taktik'),
	('b926ba58-72ab-44bd-b07a-17a8679b8b78', 'teknik'),
	('cb6e5640-84ab-4682-b6a4-81b9159356f2', 'taktik'),
	('4c636909-4b96-48d1-a145-d53bc89ebf88', 'teknik'),
	('8a76a79d-a361-4b35-9b79-7ee93c3e5f1d', 'taktik'),
	('1ea0844d-aa6c-42eb-b34a-aad2f022f427', 'teknik'),
	('920a7188-ecb8-4fef-b0a4-0ed6e7d54cd7', 'taktik'),
	('eff526a2-4a14-4be8-bb36-f5964923186b', 'teknik'),
	('d18c141d-111a-4ed9-a089-0738aeeb7f8c', 'taktik'),
	('e34c228f-da27-4175-965a-d29975dbe6af', 'teknik'),
	('a9fbe4ee-23b5-4b00-9f7a-0c53208a3e8b', 'taktik'),
	('33bfef37-3906-4c9a-8e78-087730fe9551', 'teknik'),
	('f88c8c70-583e-4015-aacb-64e1d941dea0', 'taktik'),
	('9b89830d-ee1f-4d40-b467-4b068b07488d', 'teknik'),
	('41896e8e-9816-42fb-a4cb-b72e0d777c8b', 'taktik'),
	('685e5926-cfc3-4388-828e-6962ae5f038a', 'teknik'),
	('0c86a948-12a5-47c9-a269-0077c45133d7', 'taktik'),
	('6285e765-e11d-4a00-88b6-dcc4da793768', 'teknik'),
	('d9b8c202-80b1-4db1-8d35-716caac9a667', 'taktik'),
	('9dfad8f6-7dd0-43e7-867b-2b8369201b30', 'teknik'),
	('700b7cf3-9173-4bdd-ae92-08c414f2f2b3', 'taktik'),
	('4a871c44-6a8a-4d54-afcf-4a15f3dd9db6', 'teknik'),
	('2fc45dea-f03e-4f20-a02c-e3456060b3ed', 'taktik'),
	('9c271b63-d579-4ef7-b1ce-6d0ae2377083', 'teknik'),
	('9e7fddad-ad01-4311-8a0d-0a053ffb5be3', 'taktik'),
	('51534840-23a2-4fbe-a9de-57289f8bdcbd', 'teknik'),
	('1277b019-fe2e-45e4-958a-167b292353e4', 'taktik'),
	('7016fbb2-50b9-4de7-92cc-1cf6cf457d5c', 'teknik'),
	('dee4a6ca-6d22-44e5-bb04-2ce7b85f89cc', 'taktik'),
	('b4da13c5-ba30-4d1d-8386-06963afedf15', 'teknik'),
	('613fc86f-e599-462f-8a90-b15ec7444f84', 'taktik'),
	('a2496b0e-cefb-4322-a3f7-05001ff8857f', 'teknik'),
	('6b3e429a-562e-4cc6-9959-9241a6944e2f', 'taktik'),
	('75cb385e-62e9-4f5a-a301-d3be7d994353', 'teknik'),
	('30b7ddd5-4ddb-412d-afba-1f65a4e7c4da', 'taktik'),
	('36eae6c7-dd4c-4d50-a218-abd5d6e95efe', 'teknik'),
	('e68c9453-4b73-4e21-8aaf-44c296ab7f96', 'taktik'),
	('992613e8-4a25-41ed-9ca6-f4b4aecba79d', 'teknik'),
	('15e9c364-134e-4df2-9e1e-5bed57ad61f5', 'taktik'),
	('d0e3466a-c9de-436c-8cb0-d8b7c82cf42b', 'teknik'),
	('0b0dd982-7d5c-4abb-90f1-4396338470c7', 'taktik'),
	('6bbf9c48-8ef0-4af6-8379-e27ff629293d', 'teknik'),
	('7b658a91-5b74-4550-82a4-c2569cbe56a8', 'taktik');

INSERT INTO tim_pertandingan (nama_tim, id_pertandingan, skor) VALUES ('Coppertone Kids', '93c44227-2ac2-420a-8577-76293771a894', '5'),
	('Trelstar', '4ac56e5e-f2d9-491f-9edc-e5120f84c4a7', '5'),
	('WhiskCare 357', '4c632c34-0025-42af-94a5-a3eb35070a9f', '4'),
	('Xanax', 'e2ec60d1-516a-4a3f-8b32-e8a6dd42f75c', '4'),
	('COREG', '8f81ff6c-e8ed-4799-87ef-3bf86d37fa44', '5'),
	('Gowoonsesang', '93c44227-2ac2-420a-8577-76293771a894', '1'),
	('Aderall', '4ac56e5e-f2d9-491f-9edc-e5120f84c4a7', '2'),
	('CLINIMIX', '4c632c34-0025-42af-94a5-a3eb35070a9f', '3'),
	('Pravastatin', 'e2ec60d1-516a-4a3f-8b32-e8a6dd42f75c', '2'),
	('Tylenol', '8f81ff6c-e8ed-4799-87ef-3bf86d37fa44', '0');

INSERT INTO manajer (id_manajer, username) VALUES ('7ab101ed-f7d2-428c-b922-aa838de78a2f', 'abenoey14'),
	('48218b33-ae7b-437b-b57a-0ad364f0b637', 'kfairbrace15'),
	('97b5fc44-a980-4b6b-8a0e-8b4059db2ab5', 'ddepka16'),
	('d0b60d51-f8ed-4715-8b78-6e6f16863504', 'fscargle17'),
	('3075d27e-1f63-42eb-ab15-d4426d829bfa', 'bvanderkruis18'),
	('4f65c212-d79c-46ca-b693-acf74395a275', 'rhartly19'),
	('10058437-e692-44c2-aaca-1d867b09cad1', 'adeniso1a'),
	('ae6e49b2-7163-4654-bf81-3a41aa43aee6', 'ajikovsky1b'),
	('9cde35a9-36bd-42f9-a0e0-a1a1862c6858', 'bsawbridge1c'),
	('f4bfaca6-8f5c-409b-a6c5-e97d84c5cd87', 'ymassinger1d');

INSERT INTO tim_manajer (id_manajer, nama_tim) VALUES ('7ab101ed-f7d2-428c-b922-aa838de78a2f', 'Coppertone Kids'),
	('48218b33-ae7b-437b-b57a-0ad364f0b637', 'Trelstar'),
	('97b5fc44-a980-4b6b-8a0e-8b4059db2ab5', 'WhiskCare 357'),
	('d0b60d51-f8ed-4715-8b78-6e6f16863504', 'Xanax'),
	('3075d27e-1f63-42eb-ab15-d4426d829bfa', 'COREG'),
	('4f65c212-d79c-46ca-b693-acf74395a275', 'Gowoonsesang'),
	('10058437-e692-44c2-aaca-1d867b09cad1', 'Aderall'),
	('ae6e49b2-7163-4654-bf81-3a41aa43aee6', 'CLINIMIX'),
	('9cde35a9-36bd-42f9-a0e0-a1a1862c6858', 'Pravastatin'),
	('f4bfaca6-8f5c-409b-a6c5-e97d84c5cd87', 'Tylenol');

INSERT INTO peminjaman (id_manajer, start_datetime, end_datetime, id_stadium) VALUES ('7ab101ed-f7d2-428c-b922-aa838de78a2f', '2023-04-14 14:01:58', '2023-04-24 10:31:29', '1f1424c6-a2ea-4d24-a419-a8b91b92b528'),
	('48218b33-ae7b-437b-b57a-0ad364f0b637', '2023-04-06 13:56:17', '2023-04-12 17:34:21', 'a8c51959-2706-4f76-966a-a2443ec1f9fc'),
	('97b5fc44-a980-4b6b-8a0e-8b4059db2ab5', '2023-04-05 21:34:33', '2023-04-30 21:28:50', '1cb441d8-1548-4fde-b7ec-ec7280beb38f'),
	('d0b60d51-f8ed-4715-8b78-6e6f16863504', '2023-04-13 14:37:05', '2023-04-18 14:19:34', 'a645266b-5d9a-445e-aa9c-28eaafa42a15'),
	('3075d27e-1f63-42eb-ab15-d4426d829bfa', '2023-04-20 18:09:52', '2023-04-26 22:02:57', 'a9dc0057-0419-40ba-8607-6224445dcc74');

INSERT INTO rapat (id_pertandingan, datetime, perwakilan_panitia, manajer_tim_a, manajer_tim_b, isi_rapat) VALUES ('93c44227-2ac2-420a-8577-76293771a894', '2023-04-29 14:23:26', '6ed537bf-43ec-484c-98a8-e345d80cf963', '7ab101ed-f7d2-428c-b922-aa838de78a2f', '4f65c212-d79c-46ca-b693-acf74395a275', 'Babak Semifinal'),
	('4ac56e5e-f2d9-491f-9edc-e5120f84c4a7', '2023-04-27 9:21:56', 'feae7bbf-f7eb-46bc-b362-4aab15162b85', '48218b33-ae7b-437b-b57a-0ad364f0b637', '10058437-e692-44c2-aaca-1d867b09cad1', 'Pertandingan Pembukaan'),
	('4c632c34-0025-42af-94a5-a3eb35070a9f', '2023-04-04 16:49:02', '1d6b4c84-a0ee-484d-a700-f42b3526d0c2', '97b5fc44-a980-4b6b-8a0e-8b4059db2ab5', 'ae6e49b2-7163-4654-bf81-3a41aa43aee6', 'Babak Semifinal'),
	('e2ec60d1-516a-4a3f-8b32-e8a6dd42f75c', '2023-04-20 6:01:06', '23f00f00-1d05-4953-a04b-c638954cc49a', 'd0b60d51-f8ed-4715-8b78-6e6f16863504', '9cde35a9-36bd-42f9-a0e0-a1a1862c6858', 'Babak Semifinal'),
	('8f81ff6c-e8ed-4799-87ef-3bf86d37fa44', '2023-04-20 23:45:18', 'caf87d17-b4f7-4073-bafa-60db28400aa1', '3075d27e-1f63-42eb-ab15-d4426d829bfa', 'f4bfaca6-8f5c-409b-a6c5-e97d84c5cd87', 'Pertandingan Pembukaan');

-- Create a function to perform the username check
CREATE OR REPLACE FUNCTION check_username_exists()
  RETURNS TRIGGER AS
$BODY$
BEGIN
  IF EXISTS (SELECT 1 FROM user_system WHERE username = NEW.username) THEN
    RAISE EXCEPTION 'Username already exists';
  END IF;

  RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

-- Create a trigger to call the function before inserting a new row
CREATE TRIGGER username_check_trigger
BEFORE INSERT ON user_system
FOR EACH ROW
EXECUTE FUNCTION check_username_exists();

CREATE OR REPLACE FUNCTION remove_captain()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.is_captain THEN
        UPDATE PEMAIN
        SET is_captain = FALSE
        WHERE nama_tim = NEW.nama_tim AND is_captain = TRUE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER change_captain_trigger
BEFORE INSERT OR UPDATE ON PEMAIN
FOR EACH ROW
EXECUTE FUNCTION remove_captain();

SELECT * FROM user_system WHERE username = 'bvanderkruis18';


SELECT * from pelatih;

SELECT * FROM Pelatih where nama_tim = 'Coppertone Kids';


SELECT nama_depan, nama_belakang, nomor_hp, email, alamat, spesialisasi
FROM NON_PEMAIN NP INNER JOIN SPESIALISASI_PELATIH SP on NP.id = SP.id_pelatih
WHERE NP.id in (
SELECT id_pelatih from pelatih
where nama_tim = 'Xanax'
);

SELECT * from pemain where nama_tim = 'Coppertone Kids';


UPDATE PEMAIN
SET is_captain = FALSE
WHERE nama_tim is NULL;

SELECT * from spesialisasi_pelatih;


-- Trigger function to check the number of coaches and their specializations
CREATE OR REPLACE FUNCTION cek_pelatih()
  RETURNS TRIGGER AS
$BODY$
DECLARE
  pelatih_count INTEGER;
BEGIN
  -- Count the number of coaches for the specified team
  SELECT COUNT(*) INTO pelatih_count
  FROM pelatih
  WHERE nama_tim = NEW.nama_tim;

  IF pelatih_count = 0 THEN
    -- No coaches yet, allow the new coach to be registered
    RETURN NEW;
  ELSIF pelatih_count = 1 THEN
    -- Check if the new coach has a different specialization
    IF EXISTS (
      SELECT 1
      FROM spesialisasi_pelatih
      WHERE id_pelatih = NEW.id_pelatih
        AND spesialisasi IN (
          SELECT spesialisasi
          FROM spesialisasi_pelatih
          WHERE id_pelatih IN (
            SELECT id_pelatih
            FROM pelatih
            WHERE nama_tim = NEW.nama_tim
          )
        )
    ) THEN
      -- New coach has the same specialization as the existing coach, raise an exception
      RAISE EXCEPTION 'Pelatih baru memiliki spesialisasi yang sama dengan pelatih lain di tim';
    END IF;
  ELSIF pelatih_count = 2 THEN
    -- Already 2 coaches, raise an exception
    RAISE EXCEPTION 'Tim sudah memiliki dua pelatih';
  END IF;

  RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER cek_spesialisasi_pelatih_trigger
BEFORE INSERT OR UPDATE ON pelatih
FOR EACH ROW
EXECUTE FUNCTION cek_pelatih();

SELECT * from non_pemain limit 2;

truncate spesialisasi_pelatih;

select * from spesialisasi_pelatih;


SELECT p.id_pelatih, nama_depan, nama_belakang, string_agg(spesialisasi, ', ') as sp
FROM non_pemain np
JOIN pelatih p ON np.id = p.id_pelatih
JOIN spesialisasi_pelatih sp ON p.id_pelatih = sp.id_pelatih
WHERE p.nama_tim IS NULL
GROUP BY p.id_pelatih, nama_depan, nama_belakang;


INSERT INTO spesialisasi_pelatih (id_pelatih, spesialisasi) VALUES
	('be6a72a8-1f99-4c4a-9cd6-90823a85cde9', 'tendangan'),
	('7ad89b7e-814d-42f6-8c01-35068265b9e9', 'sundulan'),
	('14304471-2d62-4b65-b2ff-846db50465bf', 'tangkapan'),
	('b44eb92f-5ce1-459d-b558-e83f62ee6361', 'serangan'),
	('f551f0da-c6df-4257-b3a0-e7ba6117fe50', 'pertahanan'),
	('ce63703a-ef46-4f9c-8584-ee82e8cf042c', 'tendangan'),
	('5a8e613b-02df-4357-bcb0-31c0df8175d4', 'sundulan'),
	('52819c26-90f1-484f-97c6-39d2b69c65a8', 'tangkapan'),
	('ee29b3d5-eceb-47ae-98a1-b46e99dd243c', 'serangan'),
	('38e0d184-1996-4aaa-9038-e562d0f50475', 'pertahanan'),
	('c563195e-218a-43d0-90ba-85bd1c4d8c61', 'tendangan'),
	('b20d0ac5-b46c-4908-8842-6d72ac507e73', 'sundulan'),
	('7b7a9f4f-ce2c-4186-b0f1-d2cfad87f8d7', 'tangkapan'),
	('fa9e0b93-d8fa-480f-8acc-44bfe125f956', 'serangan'),
	('8c73ccca-f767-436f-9c6e-8e1b85cf1472', 'pertahanan'),
	('db279aac-fdc7-40ed-8b78-e9d1747e7a47', 'tendangan'),
	('8e8d97ad-17e6-4579-a765-5b0035f3c017', 'sundulan'),
	('6d8f23a0-6d9b-4640-a2a4-775314c170c7', 'tangkapan'),
	('01cab9af-27dc-45b5-836d-9760ee8027b8', 'serangan'),
	('f610ecbc-84b2-49b5-ae80-80b673aed424', 'pertahanan'),
	('4d781076-a52d-4dc0-afe8-4850aab9c2bc', 'tendangan'),
	('a71ef1c3-f747-411e-8a4d-dc30a26569fc', 'sundulan'),
	('b926ba58-72ab-44bd-b07a-17a8679b8b78', 'tangkapan'),
	('cb6e5640-84ab-4682-b6a4-81b9159356f2', 'serangan'),
	('4c636909-4b96-48d1-a145-d53bc89ebf88', 'pertahanan'),
	('8a76a79d-a361-4b35-9b79-7ee93c3e5f1d', 'tendangan'),
	('1ea0844d-aa6c-42eb-b34a-aad2f022f427', 'sundulan'),
	('920a7188-ecb8-4fef-b0a4-0ed6e7d54cd7', 'tangkapan'),
	('eff526a2-4a14-4be8-bb36-f5964923186b', 'serangan'),
	('d18c141d-111a-4ed9-a089-0738aeeb7f8c', 'pertahanan'),
	('e34c228f-da27-4175-965a-d29975dbe6af', 'tendangan'),
	('a9fbe4ee-23b5-4b00-9f7a-0c53208a3e8b', 'sundulan'),
	('33bfef37-3906-4c9a-8e78-087730fe9551', 'tangkapan'),
	('f88c8c70-583e-4015-aacb-64e1d941dea0', 'serangan'),
	('9b89830d-ee1f-4d40-b467-4b068b07488d', 'pertahanan'),
	('41896e8e-9816-42fb-a4cb-b72e0d777c8b', 'tendangan'),
	('685e5926-cfc3-4388-828e-6962ae5f038a', 'sundulan'),
	('0c86a948-12a5-47c9-a269-0077c45133d7', 'tangkapan'),
	('6285e765-e11d-4a00-88b6-dcc4da793768', 'serangan'),
	('d9b8c202-80b1-4db1-8d35-716caac9a667', 'pertahanan'),
	('9dfad8f6-7dd0-43e7-867b-2b8369201b30', 'tendangan'),
	('700b7cf3-9173-4bdd-ae92-08c414f2f2b3', 'sundulan'),
	('4a871c44-6a8a-4d54-afcf-4a15f3dd9db6', 'tangkapan'),
	('2fc45dea-f03e-4f20-a02c-e3456060b3ed', 'serangan'),
	('9c271b63-d579-4ef7-b1ce-6d0ae2377083', 'pertahanan'),
	('9e7fddad-ad01-4311-8a0d-0a053ffb5be3', 'tendangan'),
	('51534840-23a2-4fbe-a9de-57289f8bdcbd', 'sundulan'),
	('1277b019-fe2e-45e4-958a-167b292353e4', 'tangkapan'),
	('7016fbb2-50b9-4de7-92cc-1cf6cf457d5c', 'serangan'),
	('dee4a6ca-6d22-44e5-bb04-2ce7b85f89cc', 'pertahanan'),
	('b4da13c5-ba30-4d1d-8386-06963afedf15', 'tendangan'),
	('613fc86f-e599-462f-8a90-b15ec7444f84', 'sundulan'),
	('a2496b0e-cefb-4322-a3f7-05001ff8857f', 'tangkapan'),
	('6b3e429a-562e-4cc6-9959-9241a6944e2f', 'serangan'),
	('75cb385e-62e9-4f5a-a301-d3be7d994353', 'pertahanan'),
	('30b7ddd5-4ddb-412d-afba-1f65a4e7c4da', 'tendangan'),
	('36eae6c7-dd4c-4d50-a218-abd5d6e95efe', 'sundulan'),
	('e68c9453-4b73-4e21-8aaf-44c296ab7f96', 'tangkapan'),
	('992613e8-4a25-41ed-9ca6-f4b4aecba79d', 'serangan'),
	('15e9c364-134e-4df2-9e1e-5bed57ad61f5', 'pertahanan'),
	('d0e3466a-c9de-436c-8cb0-d8b7c82cf42b', 'tendangan'),
	('0b0dd982-7d5c-4abb-90f1-4396338470c7', 'sundulan'),
	('6bbf9c48-8ef0-4af6-8379-e27ff629293d', 'tangkapan'),
	('7b658a91-5b74-4550-82a4-c2569cbe56a8', 'serangan'),
	('be6a72a8-1f99-4c4a-9cd6-90823a85cde9', 'pertahanan'),
	('7ad89b7e-814d-42f6-8c01-35068265b9e9', 'tendangan'),
	('14304471-2d62-4b65-b2ff-846db50465bf', 'sundulan'),
	('b44eb92f-5ce1-459d-b558-e83f62ee6361', 'tangkapan'),
	('f551f0da-c6df-4257-b3a0-e7ba6117fe50', 'serangan'),
	('ce63703a-ef46-4f9c-8584-ee82e8cf042c', 'pertahanan');



SELECT * FROM panitia;