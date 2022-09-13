#1.asama: Tabloların olusturulması
#2.asama: FV string degerlerinden int degerlerin elde edilmesi ve guc hesabı
#3.asama: Hesaplanan guclerin seviyelere ayrılması
# STAGE 1
use admin_database;
DROP table if exists endurance_score;
CREATE TABLE endurance_score (
    id int NOT NULL AUTO_INCREMENT,
    rs1815739 int(3),
    rs4253778 int(3),
	rs8192678 int(3),
    rs1042713 int(3),
    rs2070744 int(3),
    rs11549465 int(3),
	rs4644994 int(3),	
	total_endurance_score int(99),
    PRIMARY KEY (id)
);
DROP table if exists injury_score;
CREATE TABLE injury_score (
    id int NOT NULL AUTO_INCREMENT,
    rs1800795 int(3),
    rs1049434 int(3),
	rs12722 int(3),
	rs1800012 int(3),
    total_injury_score int(99),
    PRIMARY KEY (id)
);
DROP table if exists motor_score;
CREATE TABLE motor_score (
    id int NOT NULL AUTO_INCREMENT,
	rs4680 int(3) ,
	rs6265 int(3),	
    total_motor_score int(99),
    PRIMARY KEY (id)
);
DROP table if exists oxygen_score;
CREATE TABLE oxygen_score (
    id int NOT NULL AUTO_INCREMENT,
    rs11549465 int(3),
    rs2070744 int(3),
	total_oxygen_score int(99),
    PRIMARY KEY (id)
);
DROP table if exists power_score;
CREATE TABLE power_score(
    id int NOT NULL AUTO_INCREMENT,
    rs1815739 int(3),
    rs4253778 int(3),
	rs8192678 int(3),
    rs1042713 int(3),
    rs2070744 int(3),
    rs11549465 int(3),
    total_power_score int(99),
    PRIMARY KEY (id)
);
DROP table if exists general_scores;
CREATE TABLE general_scores(
    id int NOT NULL AUTO_INCREMENT,
    power int(3),
    power_level varchar (20),
    endurance int(3),
    endurance_level varchar (20),
	motor int(3),
    motor_level varchar (20),
    oxygen int(3),
    oxygen_level  varchar (20),
	injury int(3),
    injury_level varchar (20),
    PRIMARY KEY (id)
);

# STAGE 2
SELECT @rows_count := COUNT(*) FROM genome_lab;
DROP PROCEDURE IF EXISTS general_loop;
DELIMITER $$ 
CREATE PROCEDURE general_loop()
 BEGIN
DECLARE no INT;
  SET no = 0;
  simpleloop: LOOP
    SET no = no +1;
	#power_score
	SELECT @rs1815739_fv_value  :=  (SELECT rs1815739 FROM admin_database.genome_lab WHERE id = no); #kullanıcının fv degerinin cekilmesi (string)
	SELECT @rs1815739_score_value := (SELECT rs1815739 FROM admin_database.power_FV WHERE genotype = @rs1815739_fv_value); #fv stringine karsilik gelen int degerin alınması
    #her gen icin bu islem tekrarlanır.
	SELECT @rs4253778_fv_value  :=  (SELECT rs4253778 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs4253778_score_value := (SELECT rs4253778 FROM admin_database.power_FV WHERE genotype = @rs4253778_fv_value);
	SELECT @rs1042713_fv_value  :=  (SELECT rs1042713 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs1042713_score_value := (SELECT rs1042713 FROM admin_database.power_FV WHERE genotype = @rs1042713_fv_value);
	SELECT @rs8192678_fv_value  :=  (SELECT rs8192678 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs8192678_score_value := (SELECT rs8192678 FROM admin_database.power_FV WHERE genotype = @rs8192678_fv_value);
	SELECT @rs2070744_fv_value  :=  (SELECT rs2070744 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs2070744_score_value := (SELECT rs2070744 FROM admin_database.power_FV WHERE genotype = @rs2070744_fv_value);
	SELECT @rs11549465_fv_value  :=  (SELECT rs11549465 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs11549465_score_value := (SELECT rs11549465 FROM admin_database.power_FV WHERE genotype = @rs11549465_fv_value);
    #bulunan int degerler ile formule gore guc skoru hesaplanır
	SELECT @power_score_value := ROUND((100/(2*6))*(@rs1815739_score_value+@rs4253778_score_value+@rs8192678_score_value+
	@rs1042713_score_value+@rs2070744_score_value+@rs11549465_score_value)); 
	#hesaplanan guc skoru ve bulunan degerler guc taplosuna insert edilir.
	INSERT INTO power_score(`total_power_score`,`rs1815739`,`rs4253778`,`rs8192678`,`rs1042713`,`rs2070744`,`rs11549465`)
	VALUES (@power_score_value,@rs1815739_score_value,@rs4253778_score_value,@rs8192678_score_value,
	@rs1042713_score_value,@rs2070744_score_value,@rs11549465_score_value);

    #endurance
    SELECT @rs1815739_fv_value  :=  (SELECT rs1815739 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs1815739_score_value := (SELECT rs1815739 FROM admin_database.endurance_FV WHERE genotype = @rs1815739_fv_value);
	SELECT @rs4253778_fv_value  :=  (SELECT rs4253778 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs4253778_score_value := (SELECT rs4253778 FROM admin_database.endurance_FV WHERE genotype = @rs4253778_fv_value); 
	SELECT @rs8192678_fv_value  :=  (SELECT rs8192678 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs8192678_score_value := (SELECT rs8192678 FROM admin_database.endurance_FV WHERE genotype = @rs8192678_fv_value);
	SELECT @rs1042713_fv_value  :=  (SELECT rs1042713 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs1042713_score_value := (SELECT rs1042713 FROM admin_database.endurance_FV WHERE genotype = @rs1042713_fv_value); 
	SELECT @rs11549465_fv_value  :=  (SELECT rs11549465 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs11549465_score_value := (SELECT rs11549465 FROM admin_database.endurance_FV WHERE genotype = @rs11549465_fv_value); 
	SELECT @rs2070744_fv_value  :=  (SELECT rs2070744 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs2070744_score_value := (SELECT rs2070744 FROM admin_database.endurance_FV WHERE genotype = @rs2070744_fv_value); 
    #endurance insert
    SELECT @endurance_score_value := ROUND((100/(2*6))*(@rs1815739_score_value+@rs4253778_score_value+@rs8192678_score_value+
	@rs1042713_score_value+@rs2070744_score_value+@rs11549465_score_value));
	INSERT INTO endurance_score(`total_endurance_score`,`rs1815739`,`rs4253778`,`rs8192678`,`rs1042713`,`rs2070744`,`rs11549465`)
	VALUES (@endurance_score_value,@rs1815739_score_value,@rs4253778_score_value,@rs8192678_score_value,
	@rs1042713_score_value,@rs2070744_score_value,@rs11549465_score_value);

    #motor
	SELECT @rs6265_fv_value  :=  (SELECT rs6265 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs6265_score_value := (SELECT rs6265 FROM admin_database.motor_FV WHERE genotype = @rs6265_fv_value);
	SELECT @rs4680_fv_value  :=  (SELECT rs4680 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs4680_score_value := (SELECT rs4680 FROM admin_database.motor_FV WHERE genotype = @rs4680_fv_value);
    #motor insert
	SELECT @motor_score_value := ROUND((100/(2*2))*(@rs6265_score_value+@rs4680_score_value));
    INSERT INTO motor_score(`total_motor_score`,`rs6265`,`rs4680`)
	VALUES ( @motor_score_value,@rs6265_score_value,@rs4680_score_value);

    #oxygen
    SELECT @rs2070744_fv_value  :=  (SELECT rs2070744 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs2070744_score_value := (SELECT rs2070744 FROM admin_database.oxygen_FV WHERE genotype = @rs2070744_fv_value);
	SELECT @rs11549465_fv_value  :=  (SELECT rs11549465 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs11549465_score_value := (SELECT rs11549465 FROM admin_database.oxygen_FV WHERE genotype = @rs11549465_fv_value);
	#oxygen insert
    SELECT @oxygen_score_value := ROUND((100/(2*2)) *(@rs2070744_score_value+@rs11549465_score_value));
    INSERT INTO oxygen_score(`total_oxygen_score`,`rs2070744`,`rs11549465`)
	VALUES (@oxygen_score_value,@rs2070744_score_value,@rs11549465_score_value);

    #injury
	SELECT @rs1800012_fv_value  :=  (SELECT rs1800012 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs1800012_score_value := (SELECT rs1800012 FROM admin_database.injury_FV WHERE genotype = @rs1800012_fv_value);
	SELECT @rs12722_fv_value  :=  (SELECT rs12722 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs12722_score_value := (SELECT rs12722 FROM admin_database.injury_FV WHERE genotype = @rs12722_fv_value);
	SELECT @rs1049434_fv_value  :=  (SELECT rs1049434 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs1049434_score_value := (SELECT rs1049434 FROM admin_database.injury_FV WHERE genotype = @rs1049434_fv_value);
	SELECT @rs1800795_fv_value  :=  (SELECT rs1800795 FROM admin_database.genome_lab WHERE id = no); 
	SELECT @rs1800795_score_value := (SELECT rs1800795 FROM admin_database.injury_FV WHERE genotype = @rs1800795_fv_value);
	#injury insert
	SELECT @injury_score_value := ROUND((100/(2*4))*(@rs1800012_score_value+@rs1800795_score_value+@rs12722_score_value+@rs1049434_score_value));
	INSERT INTO injury_score(`total_injury_score`,`rs1800012`,`rs1800795`,`rs12722`,`rs1049434`)
	VALUES (@injury_score_value,@rs1800012_score_value,@rs1800795_score_value,@rs12722_score_value,@rs1049434_score_value);
# STAGE 3
	#score tagging
	CASE 
    WHEN @power_score_value <=20 THEN SET @power_level_value = ('very_low');
	WHEN @power_score_value <=40 THEN SET @power_level_value = ('low');
	WHEN @power_score_value <=60 THEN SET @power_level_value = ('moderate');
    WHEN @power_score_value <=80 THEN SET @power_level_value = ('high');
    WHEN @power_score_value <=100 THEN SET @power_level_value = ('very_high');
	END CASE;
    
    CASE 
    WHEN @endurance_score_value <=20 THEN  SET @endurance_level_value = ('very_low');
	WHEN @endurance_score_value <=40 THEN SET @endurance_level_value =('low');
	WHEN @endurance_score_value <=60 THEN SET @endurance_level_value = ('moderate');
    WHEN @endurance_score_value <=80 THEN SET @endurance_level_value = ('high');
    WHEN @endurance_score_value <=100 THEN SET @endurance_level_value = ('very_high');
    END CASE;
    
    CASE
    WHEN @motor_score_value <=20 THEN SET @motor_level_value = ('very_low');
	WHEN @motor_score_value <=40 THEN SET @motor_level_value =  ('low');
	WHEN @motor_score_value <=60 THEN SET @motor_level_value = ('moderate');
    WHEN @motor_score_value <=80 THEN SET @motor_level_value  = ('high');
    WHEN @motor_score_value <=100 THEN SET @motor_level_value = ('very_high');
    END CASE;
    
    CASE
    WHEN @injury_score_value <=20 THEN SET @injury_level_value = ('very_low');
	WHEN @injury_score_value <=40 THEN SET @injury_level_value = ('low');
	WHEN @injury_score_value <=60 THEN SET @injury_level_value = ('moderate');
    WHEN @injury_score_value <=80 THEN SET @injury_level_value = ('high');
    WHEN @injury_score_value <=100 THEN SET @injury_level_value = ('very_high');
	END CASE;
    
    CASE
    WHEN @oxygen_score_value <=20 THEN SET @oxygen_level_value = ('very_low');
	WHEN @oxygen_score_value <=40 THEN SET @oxygen_level_value =  ('low');
	WHEN @oxygen_score_value <=60 THEN SET @oxygen_level_value =  ('moderate');
    WHEN @oxygen_score_value <=80 THEN SET @oxygen_level_value =  ('high');
    WHEN @oxygen_score_value <=100 THEN SET @oxygen_level_value = ('very_high');
    END CASE;
    
	#general_score
	INSERT INTO general_scores(`power`,`endurance`,`motor`,`oxygen`,`injury`,`power_level`,`endurance_level`,`motor_level`,`oxygen_level`,`injury_level`)
	VALUES (@power_score_value,@endurance_score_value,@motor_score_value,@oxygen_score_value,@injury_score_value,
    @power_level_value,@endurance_level_value,@motor_level_value,@oxygen_level_value,@injury_level_value);
    
    IF no =@rows_count THEN
     LEAVE simpleloop;
    END IF;
 END LOOP simpleloop;
SELECT no;
END $$
DELIMITER ;
call general_loop();
