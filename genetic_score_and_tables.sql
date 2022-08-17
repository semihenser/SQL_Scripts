use uniqgene_data;

DROP table if exists endurance_score;
CREATE TABLE endurance_score (
    id int NOT NULL AUTO_INCREMENT,
	total_endurance_score varchar(99),
    rs1815739 varchar(3),
    rs4253778 varchar(3),
	rs8192678 varchar(3),
    rs1042713 varchar(3),
    rs2070744 varchar(3),
    rs11549465 varchar(3),
	rs4644994 varchar(3),									                                               												
    PRIMARY KEY (id)
);
DROP table if exists injury_score;
CREATE TABLE injury_score (
    id int NOT NULL AUTO_INCREMENT,
	total_injury_score varchar(99),
    rs1800795 varchar(3),
    rs1049434 varchar(3),
	rs12722 varchar(3),
	rs1800012 varchar(3),
    PRIMARY KEY (id)
);
DROP table if exists motor_score;
CREATE TABLE motor_score (
    id int NOT NULL AUTO_INCREMENT,
	total_motor_score varchar(99),
	rs4680 varchar(3) ,
	rs6265 varchar(3),
    PRIMARY KEY (id)
);
DROP table if exists oxygen_score;
CREATE TABLE oxygen_score (
    id int NOT NULL AUTO_INCREMENT,
	total_oxygen_score varchar(99),
    rs11549465 varchar(3),
    rs2070744 varchar(3),
    PRIMARY KEY (id)
);
DROP table if exists power_score;
CREATE TABLE power_score(
    id int NOT NULL AUTO_INCREMENT,
	total_power_score varchar(99),
    rs1815739 varchar(3),
    rs4253778 varchar(3),
	rs8192678 varchar(3),
    rs1042713 varchar(3),
    rs2070744 varchar(3),
    rs11549465 varchar(3),
    PRIMARY KEY (id)
);
DROP table if exists general_scores;
CREATE TABLE general_scores(
    id int NOT NULL AUTO_INCREMENT,
    power varchar(3),
    endurance varchar(3),
	motor varchar(3),
    oxygen varchar(3),
	injury varchar(3),
    PRIMARY KEY (id)
);
SELECT @rows_count := COUNT(*) FROM genes_data;
DROP PROCEDURE IF EXISTS general_loop;
DELIMITER $$ 
CREATE PROCEDURE general_loop()
 BEGIN
DECLARE no INT;
  SET no = 0;
  simpleloop: LOOP
    SET no = no +1;
	#power_score
	SELECT @rs1815739_fv_value  :=  (SELECT rs1815739 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs1815739_score_value := (SELECT rs1815739 FROM uniqgene_data.power_fv WHERE genotype = @rs1815739_fv_value);
	SELECT @rs4253778_fv_value  :=  (SELECT rs4253778 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs4253778_score_value := (SELECT rs4253778 FROM uniqgene_data.power_fv WHERE genotype = @rs4253778_fv_value);
	SELECT @rs1042713_fv_value  :=  (SELECT rs1042713 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs1042713_score_value := (SELECT rs1042713 FROM uniqgene_data.power_fv WHERE genotype = @rs1042713_fv_value);
	SELECT @rs8192678_fv_value  :=  (SELECT rs8192678 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs8192678_score_value := (SELECT rs8192678 FROM uniqgene_data.power_fv WHERE genotype = @rs8192678_fv_value);
	SELECT @rs2070744_fv_value  :=  (SELECT rs2070744 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs2070744_score_value := (SELECT rs2070744 FROM uniqgene_data.power_fv WHERE genotype = @rs2070744_fv_value);
	SELECT @rs11549465_fv_value  :=  (SELECT rs11549465 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs11549465_score_value := (SELECT rs11549465 FROM uniqgene_data.power_fv WHERE genotype = @rs11549465_fv_value);
	#power insert
    SELECT @power_score_value := ROUND((100/(2*6))*(@rs1815739_score_value+@rs4253778_score_value+@rs8192678_score_value+
	@rs1042713_score_value+@rs2070744_score_value+@rs11549465_score_value)); 
    
	INSERT INTO power_score(`total_power_score`,`rs1815739`,`rs4253778`,`rs8192678`,`rs1042713`,`rs2070744`,`rs11549465`)
	VALUES (@power_score_value,@rs1815739_score_value,@rs4253778_score_value,@rs8192678_score_value,
	@rs1042713_score_value,@rs2070744_score_value,@rs11549465_score_value);

    #endurance
    SELECT @rs1815739_fv_value  :=  (SELECT rs1815739 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs1815739_score_value := (SELECT rs1815739 FROM uniqgene_data.endurance_fv WHERE genotype = @rs1815739_fv_value);
	SELECT @rs4253778_fv_value  :=  (SELECT rs4253778 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs4253778_score_value := (SELECT rs4253778 FROM uniqgene_data.endurance_fv WHERE genotype = @rs4253778_fv_value); 
	SELECT @rs8192678_fv_value  :=  (SELECT rs8192678 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs8192678_score_value := (SELECT rs8192678 FROM uniqgene_data.endurance_fv WHERE genotype = @rs8192678_fv_value);
	SELECT @rs1042713_fv_value  :=  (SELECT rs1042713 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs1042713_score_value := (SELECT rs1042713 FROM uniqgene_data.endurance_fv WHERE genotype = @rs1042713_fv_value); 
	SELECT @rs11549465_fv_value  :=  (SELECT rs11549465 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs11549465_score_value := (SELECT rs11549465 FROM uniqgene_data.endurance_fv WHERE genotype = @rs11549465_fv_value); 
	SELECT @rs2070744_fv_value  :=  (SELECT rs2070744 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs2070744_score_value := (SELECT rs2070744 FROM uniqgene_data.endurance_fv WHERE genotype = @rs2070744_fv_value); 
    #endurance insert
    SELECT @endurance_score_value := ROUND((100/(2*6))*(@rs1815739_score_value+@rs4253778_score_value+@rs8192678_score_value+
	@rs1042713_score_value+@rs2070744_score_value+@rs11549465_score_value));
    
	INSERT INTO endurance_score(`total_endurance_score`,`rs1815739`,`rs4253778`,`rs8192678`,`rs1042713`,`rs2070744`,`rs11549465`)
	VALUES (@endurance_score_value,@rs1815739_score_value,@rs4253778_score_value,@rs8192678_score_value,
	@rs1042713_score_value,@rs2070744_score_value,@rs11549465_score_value);

    
    #motor
	SELECT @rs6265_fv_value  :=  (SELECT rs6265 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs6265_score_value := (SELECT rs6265 FROM uniqgene_data.motor_fv WHERE genotype = @rs6265_fv_value);
	SELECT @rs4680_fv_value  :=  (SELECT rs4680 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs4680_score_value := (SELECT rs4680 FROM uniqgene_data.motor_fv WHERE genotype = @rs4680_fv_value);
    #motor insert
	SELECT @motor_score_value := ROUND((100/(2*2))*(@rs6265_score_value+@rs4680_score_value));
    INSERT INTO motor_score(`total_motor_score`,`rs6265`,`rs4680`)
	VALUES ( @motor_score_value,@rs6265_score_value,@rs4680_score_value);

    
    #oxygen
    SELECT @rs2070744_fv_value  :=  (SELECT rs2070744 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs2070744_score_value := (SELECT rs2070744 FROM uniqgene_data.oxygen_fv WHERE genotype = @rs2070744_fv_value);
	SELECT @rs11549465_fv_value  :=  (SELECT rs11549465 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs11549465_score_value := (SELECT rs11549465 FROM uniqgene_data.oxygen_fv WHERE genotype = @rs11549465_fv_value);
	#oxygen insert
    SELECT @oxygen_score_value := ROUND((100/(2*2)) *(@rs2070744_score_value+@rs11549465_score_value));
    
    INSERT INTO oxygen_score(`total_oxygen_score`,`rs2070744`,`rs11549465`)
	VALUES (@oxygen_score_value,@rs2070744_score_value,@rs11549465_score_value);

    #injury
	SELECT @rs1800012_fv_value  :=  (SELECT rs1800012 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs1800012_score_value := (SELECT rs1800012 FROM uniqgene_data.injury_fv WHERE genotype = @rs1800012_fv_value);
	SELECT @rs12722_fv_value  :=  (SELECT rs12722 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs12722_score_value := (SELECT rs12722 FROM uniqgene_data.injury_fv WHERE genotype = @rs12722_fv_value);
	SELECT @rs1049434_fv_value  :=  (SELECT rs1049434 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs1049434_score_value := (SELECT rs1049434 FROM uniqgene_data.injury_fv WHERE genotype = @rs1049434_fv_value);
	SELECT @rs1800795_fv_value  :=  (SELECT rs1800795 FROM uniqgene_data.genes_data WHERE id = no); 
	SELECT @rs1800795_score_value := (SELECT rs1800795 FROM uniqgene_data.injury_fv WHERE genotype = @rs1800795_fv_value);
	#injury insert
	SELECT @injury_score_value := ROUND((100/(2*4))*(@rs1800012_score_value+@rs1800795_score_value+@rs12722_score_value+@rs1049434_score_value));
	INSERT INTO injury_score(`total_injury_score`,`rs1800012`,`rs1800795`,`rs12722`,`rs1049434`)
    
	VALUES (@injury_score_value,@rs1800012_score_value,@rs1800795_score_value,@rs12722_score_value,@rs1049434_score_value);
    
    #general_score
	INSERT INTO general_scores(`power`,`endurance`,`motor`,`oxygen`,`injury`)
	VALUES (@power_score_value,@endurance_score_value,@motor_score_value,@oxygen_score_value,@injury_score_value);
    
    IF no =@rows_count THEN
     LEAVE simpleloop;
    END IF;
 END LOOP simpleloop;
SELECT no;
END $$
DELIMITER ;
call general_loop();