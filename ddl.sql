-- -----------------------------------------------------
-- Schema cook_competition
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cook_competition` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;

USE `cook_competition` ;

-- -----------------------------------------------------
-- Table grade
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `grade` (
                                       `id` INT NOT NULL AUTO_INCREMENT,
                                       `name` VARCHAR(100) NOT NULL,
                                       PRIMARY KEY (`id`),
                                       CONSTRAINT `grade_uc_1` UNIQUE (`name` ASC)
);

-- -----------------------------------------------------
-- Table cook
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cook` (
                                      `id` INT NOT NULL AUTO_INCREMENT,
                                      `first_name` VARCHAR(100) NOT NULL,
                                      `last_name` VARCHAR(100) NOT NULL,
                                      `phone_number` VARCHAR(15) NULL,
                                      `birth_date` DATE NOT NULL,
                                      `grade_id` INT NOT NULL,
                                      PRIMARY KEY (`id`),
                                      INDEX `cook_idx_1` (`grade_id` ASC),
                                      INDEX `cook_idx_2` (`last_name` ASC, `first_name` ASC),
                                      INDEX `cook_idx_3` (`birth_date` ASC),
                                      CONSTRAINT `fk_cook_grade` FOREIGN KEY (`grade_id`) REFERENCES `grade` (`id`)
);


-- -----------------------------------------------------
-- Table `cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cuisine` (
                                         `id` INT NOT NULL AUTO_INCREMENT,
                                         `name` VARCHAR(100) NOT NULL,
                                         PRIMARY KEY (`id`),
                                         CONSTRAINT `cuisine_uc_1` UNIQUE (`name` ASC)
);


-- -----------------------------------------------------
-- Table cook_specialisation
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cook_specialisation` (
                                                     `id` INT NOT NULL AUTO_INCREMENT,
                                                     `yrs_of_exp` INT NULL,
                                                     `cuisine_id` INT NOT NULL,
                                                     `cook_id` INT NOT NULL,
                                                     PRIMARY KEY (`id`),
                                                     CONSTRAINT `cook_specialisation_uc_1` UNIQUE (`cuisine_id` ASC, `cook_id` ASC),
                                                     INDEX `cook_specialisation_idx_1` (`cook_id` ASC),
                                                     CONSTRAINT `fk_cook_specialisation_cook` FOREIGN KEY (`cook_id`) REFERENCES `cook` (`id`),
                                                     CONSTRAINT `fk_cook_specialisation_cuisine` FOREIGN KEY (`cuisine_id`) REFERENCES `cuisine` (`id`)
);


-- -----------------------------------------------------
-- Table episode
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `episode` (
                                         `id` INT NOT NULL AUTO_INCREMENT,
                                         `number` INT NOT NULL,
                                         `calendar_year` SMALLINT NOT NULL,
                                         PRIMARY KEY (`id`),
                                         CONSTRAINT `episode_idx_1` UNIQUE (`calendar_year` ASC, `number` ASC)
);


-- -----------------------------------------------------
-- Table `recipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe` (
                                        `id` INT NOT NULL AUTO_INCREMENT,
                                        `name` VARCHAR(100) NOT NULL,
                                        `difficulty` TINYINT NOT NULL,
                                        `description` TEXT NULL,
                                        `portions` INT NOT NULL,
                                        `cuisine_id` INT NOT NULL,
                                        PRIMARY KEY (`id`),
                                        INDEX `recipe_idx_1` (`name` ASC),
                                        INDEX `recipe_idx_2` (`cuisine_id` ASC),
                                        INDEX `recipe_idx_3` (`difficulty` ASC),
                                        CONSTRAINT `fk_recipe_cuisine1` FOREIGN KEY (`cuisine_id`) REFERENCES `cuisine` (`id`)
);


-- -----------------------------------------------------
-- Table `episode_cook`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `episode_cook` (
                                              `id` INT NOT NULL AUTO_INCREMENT,
                                              `cook_id` INT NOT NULL,
                                              `episode_id` INT NOT NULL,
                                              `recipe_id` INT NOT NULL,
                                              `is_winner` BOOL NOT NULL DEFAULT(0),
                                              PRIMARY KEY (`id`),
                                              CONSTRAINT `episode_cook_uc_1` UNIQUE (`cook_id` ASC, `episode_id` ASC),
                                              INDEX `fk_episode_cook_episode1_idx` (`episode_id` ASC, `cook_id` ASC),
                                              INDEX `fk_episode_cook_recipe1_idx` (`recipe_id` ASC, `episode_id` ASC, `cook_id` ASC),
                                              CONSTRAINT `fk_episode_cook_cook` FOREIGN KEY (`cook_id`) REFERENCES `cook` (`id`),
                                              CONSTRAINT `fk_episode_cook_episode` FOREIGN KEY (`episode_id`) REFERENCES `episode` (`id`),
                                              CONSTRAINT `fk_episode_cook_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
);


-- -----------------------------------------------------
-- Table `episode_judge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `episode_judge` (
                                               `id` INT NOT NULL AUTO_INCREMENT,
                                               `cook_id` INT NOT NULL,
                                               `episode_id` INT NOT NULL,
                                               PRIMARY KEY (`id`),
                                               CONSTRAINT `episode_judge_uc_1` UNIQUE (`cook_id` ASC, `episode_id` ASC),
                                               INDEX `episode_judge_idx_1` (`episode_id` ASC, `cook_id` ASC),
                                               CONSTRAINT `fk_episode_judge_cook` FOREIGN KEY (`cook_id`) REFERENCES `cook` (`id`),
                                               CONSTRAINT `fk_episode_judge_episode` FOREIGN KEY (`episode_id`) REFERENCES `episode` (`id`)
);


-- -----------------------------------------------------
-- Table `equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `equipment` (
                                           `id` INT NOT NULL AUTO_INCREMENT,
                                           `name` VARCHAR(100) NOT NULL,
                                           `manual` TEXT NULL,
                                           PRIMARY KEY (`id`),
                                           CONSTRAINT `equipment_uc_1` UNIQUE (`name` ASC)
);

-- -----------------------------------------------------
-- Table `food_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `food_group` (
                                            `id` INT NOT NULL AUTO_INCREMENT,
                                            `name` VARCHAR(100) NOT NULL,
                                            `description` VARCHAR(100) NULL,
                                            PRIMARY KEY (`id`),
                                            CONSTRAINT `food_group_uc_1` UNIQUE (`name` ASC)
);


-- -----------------------------------------------------
-- Table `ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ingredient` (
                                            `id`            INT          NOT NULL AUTO_INCREMENT,
                                            `name`          VARCHAR(100) NOT NULL,
                                            `food_group_id` INT          NOT NULL,
                                            PRIMARY KEY (`id`),
                                            INDEX `ingredient_idx_1` (`food_group_id` ASC),
                                            INDEX `ingredient_idx_2` (`name` ASC),
                                            CONSTRAINT `fk_ingredient_food_group` FOREIGN KEY (`food_group_id`) REFERENCES `food_group` (`id`)
);


-- -----------------------------------------------------
-- Table `label`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `label` (
                                       `id` INT NOT NULL AUTO_INCREMENT,
                                       `name` VARCHAR(100) NOT NULL,
                                       PRIMARY KEY (`id`),
                                       CONSTRAINT `label_uc_1` UNIQUE (`name` ASC)
);


-- -----------------------------------------------------
-- Table `meal_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meal_type` (
                                           `id` INT NOT NULL AUTO_INCREMENT,
                                           `name` VARCHAR(100) NOT NULL,
                                           PRIMARY KEY (`id`),
                                           CONSTRAINT `meal_type_uc_1` UNIQUE (`name` ASC)
);


-- -----------------------------------------------------
-- Table `recipe_equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe_equipment` (
                                                  `id` INT NOT NULL AUTO_INCREMENT,
                                                  `recipe_id` INT NOT NULL,
                                                  `equipment_id` INT NOT NULL,
                                                  PRIMARY KEY (`id`),
                                                  CONSTRAINT `recipe_equipment_uc_1` UNIQUE (`recipe_id` ASC, `equipment_id` ASC),
                                                  INDEX `fk_recipe_equipment_equipment1_idx` (`equipment_id` ASC),
                                                  CONSTRAINT `fk_recipe_equipment_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
                                                  CONSTRAINT `fk_recipe_equipment_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
);


-- -----------------------------------------------------
-- Table `unit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `unit` (
                                      `id` INT NOT NULL AUTO_INCREMENT,
                                      `name` VARCHAR(100) NOT NULL,
                                      PRIMARY KEY (`id`),
                                      CONSTRAINT `unit_uc_1` UNIQUE (`name` ASC)
);


-- -----------------------------------------------------
-- Table `recipe_ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe_ingredient` (
                                                   `id`              INT           NOT NULL AUTO_INCREMENT,
                                                   `quantity`        DECIMAL(6, 2) NOT NULL,
                                                   `is_basic`        TINYINT(1)    NOT NULL DEFAULT '0',
                                                   `calories`        DECIMAL(6, 2) NOT NULL,
                                                   `carbon_hydrates` DECIMAL(6, 2) NOT NULL,
                                                   `protein`         DECIMAL(6, 2) NOT NULL,
                                                   `fat`             DECIMAL(6, 2) NOT NULL,
                                                   `recipe_id`       INT           NOT NULL,
                                                   `ingredient_id`   INT           NOT NULL,
                                                   `unit_id`         INT           NOT NULL,
                                                   PRIMARY KEY (`id`),
                                                   CONSTRAINT `recipe_ingredient_uc_1` UNIQUE (`recipe_id` ASC, `ingredient_id` ASC),
                                                   INDEX `recipe_ingredient_idx_1` (`ingredient_id` ASC),
                                                   INDEX `recipe_ingredient_idx_2` (`unit_id` ASC),
                                                   CONSTRAINT `fk_recipe_ingredient_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`id`),
                                                   CONSTRAINT `fk_recipe_ingredient_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`),
                                                   CONSTRAINT `fk_recipe_ingredient_unit` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`id`)
);


-- -----------------------------------------------------
-- Table `recipe_label`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe_label` (
                                              `id` INT NOT NULL AUTO_INCREMENT,
                                              `label_id` INT NOT NULL,
                                              `recipe_id` INT NOT NULL,
                                              PRIMARY KEY (`id`),
                                              CONSTRAINT `recipe_label_uc_1` UNIQUE (`recipe_id` ASC, `label_id` ASC),
                                              INDEX `recipe_label_idx_1` (`label_id` ASC),
                                              CONSTRAINT `fk_recipe_label_label` FOREIGN KEY (`label_id`) REFERENCES `label` (`id`),
                                              CONSTRAINT `fk_recipe_label_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
);


-- -----------------------------------------------------
-- Table `recipe_meal_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe_meal_type` (
                                                  `id` INT NOT NULL AUTO_INCREMENT,
                                                  `recipe_id` INT NOT NULL,
                                                  `meal_type_id` INT NOT NULL,
                                                  PRIMARY KEY (`id`),
                                                  INDEX `recipe_meal_type_uc_1` (`recipe_id` ASC, `meal_type_id` ASC),
                                                  INDEX `recipe_meal_type_idx_1` (`meal_type_id` ASC),
                                                  CONSTRAINT `fk_recipe_meal_type_meal_type` FOREIGN KEY (`meal_type_id`) REFERENCES `meal_type` (`id`),
                                                  CONSTRAINT `fk_recipe_meal_type_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
);


-- -----------------------------------------------------
-- Table `recipe_step`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe_step` (
                                             `id` INT NOT NULL AUTO_INCREMENT,
                                             `recipe_id` INT NOT NULL,
                                             `time` TIME NOT NULL,
                                             `is_prep` TINYINT(1) NULL DEFAULT '0',
                                             `description` VARCHAR(500) NULL,
                                             `order` TINYINT NOT NULL,
                                             PRIMARY KEY (`id`),
                                             INDEX `recipe_step_idx_1` (`recipe_id` ASC, `order` ASC),
                                             CONSTRAINT `fk_recipe_step_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
);


-- -----------------------------------------------------
-- Table `score`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `score` (
                                       `id` INT NOT NULL AUTO_INCREMENT,
                                       `points` INT NULL,
                                       `episode_cook_id` INT NOT NULL,
                                       `episode_judge_id` INT NOT NULL,
                                       PRIMARY KEY (`id`),
                                       CONSTRAINT `score_uc_1` UNIQUE (`episode_cook_id` ASC, `episode_judge_id` ASC),
                                       INDEX `score_idx_1` (`episode_judge_id` ASC),
                                       CONSTRAINT `fk_score_episode_cook` FOREIGN KEY (`episode_cook_id`) REFERENCES `episode_cook` (`id`),
                                       CONSTRAINT `fk_score_episode_judge` FOREIGN KEY (`episode_judge_id`) REFERENCES `episode_judge` (`id`)
);


-- -----------------------------------------------------
-- Table `subject_matter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `subject_matter` (
                                                `id` INT NOT NULL AUTO_INCREMENT,
                                                `name` VARCHAR(100) NOT NULL,
                                                `description` VARCHAR(100) NULL,
                                                PRIMARY KEY (`id`),
                                                CONSTRAINT `subject_matter_uc_1` UNIQUE (`name` ASC)
);


-- -----------------------------------------------------
-- Table `recipe_subject_matter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe_subject_matter` (
                                                       `id` INT NOT NULL AUTO_INCREMENT,
                                                       `recipe_id` INT NOT NULL,
                                                       `subject_matter_id` INT NOT NULL,
                                                       PRIMARY KEY (`id`),
                                                       INDEX `recipe_subject_matter_uc_1` (`recipe_id` ASC, `subject_matter_id` ASC),
                                                       INDEX `recipe_subject_matter_idx_1` (`subject_matter_id` ASC),
                                                       CONSTRAINT `fk_recipe_subject_matter_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`),
                                                       CONSTRAINT `fk_recipe_subject_matter_subject_matter` FOREIGN KEY (`subject_matter_id`) REFERENCES `subject_matter` (`id`)
);


-- ------------------------------------------------------
--
-- Stored Procedures for adding scores and participations
--
-- ------------------------------------------------------

-- ------------------------------------------------------
-- Procedure for picking 10 random cooks for each episode
-- ------------------------------------------------------

DELIMITER //

CREATE PROCEDURE Pick_Cooks_for_Episode(episode_number int, cal_year int)
BEGIN
    if (not exists(Select * from episode where calendar_year=cal_year and number = episode_number)) then
        signal SQLSTATE '45000'
            set message_text = 'There is no such episode - year combination';
    end if;

    if (exists(select * from episode_cook ec inner join episode e on ec.episode_id = e.id
               where number = episode_number and calendar_year=cal_year)) then
        signal SQLSTATE '45000'
            set message_text = 'There are already cooks selected for this episode';
    end if;

    insert into episode_cook (recipe_id, cook_id, episode_id)
    select  max(recipe_id) as random_recipe_id,
            cook_id as random_cook_id,
            (Select episode.id from episode where calendar_year=cal_year and number = episode_number) as episode_id
    from (select r.id as recipe_id,
                 -- Select a random cooks with specialization in each recipe cuisine
                 (select k.id from cook k inner join cook_specialisation cs on k.id = cs.cook_id
                  where r.cuisine_id = cs.cuisine_id
                    -- Each cook should not participate in more than 3 consecutive episodes of the same year
                    and (episode_number < 4  or k.id not in (select cook_id from episode_cook
                                                                                     inner join episode on episode_cook.episode_id = episode.id
                                                             where number = episode_number-1 and calendar_year = cal_year)
                      or k.id not in (select cook_id from episode_cook
                                                              inner join episode on episode_cook.episode_id = episode.id
                                      where number = episode_number-2 and calendar_year = cal_year)
                      or k.id not in (select cook_id from episode_cook
                                                              inner join episode on episode_cook.episode_id = episode.id
                                      where number = episode_number-3 and calendar_year = cal_year)
                      )
                  order by rand() limit 1
                 ) as cook_id
          -- select 10 random recipes from 10 random cuisines
          from  (select
                     -- Select a random recipe for each selected cuisine
                     (select id from recipe where cuisine_id = c1.id order by rand() limit 1) as recipe_id
                 from cuisine c1
                 -- Each cuisine should not be selected in e consecutive years
                 where episode_number < 4
                    or id not in (select cuisine_id from recipe
                                                             inner join episode_cook on recipe.id = episode_cook.recipe_id
                                                             inner join episode on episode_cook.episode_id = episode.id
                                  where number = episode_number-1 and calendar_year = cal_year)
                    or id not in (select cuisine_id from recipe
                                                             inner join episode_cook on recipe.id = episode_cook.recipe_id
                                                             inner join episode on episode_cook.episode_id = episode.id
                                  where number = episode_number-2 and calendar_year = cal_year)
                    or id not in (select cuisine_id from recipe
                                                             inner join episode_cook on recipe.id = episode_cook.recipe_id
                                                             inner join episode on episode_cook.episode_id = episode.id
                                  where number = episode_number-3 and calendar_year = cal_year)
                 order by rand() -- randomize the selection by ordering by a random number
                ) rcp inner join recipe r on r.id = rcp.recipe_id
         ) cr
    group by cr.cook_id
    limit 10;
END //

DELIMITER ;

-- ------------------------------------------------------
-- Procedure for picking 3 random judges for each episode
-- ------------------------------------------------------


DELIMITER //

CREATE PROCEDURE Pick_Judges_for_Episode(episode_number int, cal_year int)
BEGIN
    if (not exists(Select * from episode where calendar_year=cal_year and number = episode_number)) then
        signal SQLSTATE '45000'
            set message_text = 'There is no such episode - year combination';
    end if;

    if (exists(select * from episode_judge ec inner join episode e on ec.episode_id = e.id
               where number = episode_number and calendar_year=cal_year)) then
        signal SQLSTATE '45000'
            set message_text = 'There are already judges selected for this episode';
    end if;

    insert into episode_judge ( cook_id, episode_id)
    select k.id,
           (Select episode.id from episode where calendar_year=cal_year and number = episode_number) as episode_id
    from cook k
    -- Each judge should not participate in more than 3 consecutive episodes of the same year
    where (episode_number < 4  or k.id not in (select cook_id from episode_judge
                                                                       inner join episode on episode_judge.episode_id = episode.id
                                               where number = episode_number-1 and calendar_year = cal_year)
        or k.id not in (select cook_id from episode_judge
                                                inner join episode on episode_judge.episode_id = episode.id
                        where number = episode_number-2 and calendar_year = cal_year)
        or k.id not in (select cook_id from episode_judge
                                                inner join episode on episode_judge.episode_id = episode.id
                        where number = episode_number-3 and calendar_year = cal_year)
        )
      and (k.id not in (select cook_id from episode_cook
                                                inner join episode on episode_cook.episode_id = episode.id
                        where number = episode_number and calendar_year = cal_year)
        )
    order by rand() limit 3;

END //


-- ------------------------------------------------------
-- Procedures scoring
-- ------------------------------------------------------

DELIMITER //

CREATE PROCEDURE Create_Cook_Score(ck_id int, ju_id int, ep_id int, score int)
BEGIN
    if (not exists(Select * from episode e where e.id = ep_id)) then
        signal SQLSTATE '45000'
            set message_text = 'There is no such episode';
    end if;

    if (not exists(Select * from episode_cook ec where ec.cook_id= ck_id and ec.episode_id = ep_id)) then
        signal SQLSTATE '45000'
            set message_text = 'There is no such cook in this episode';
    end if;

    if (not exists(Select * from episode_judge ej where ej.cook_id=ju_id and ej.episode_id = ep_id)) then
        signal SQLSTATE '45000'
            set message_text = 'There is no such judge in this episode';
    end if;

    if (exists(Select * from score sc
                                 inner join episode_cook ec on sc.episode_cook_id = ec.id
                                 inner join episode_judge ej on sc.episode_judge_id = ej.id
               where ec.episode_id = ep_id and ej.episode_id = ep_id
                 and ec.cook_id = ck_id and ej.cook_id = ju_id)) then
        signal SQLSTATE '45000'
            set message_text = 'There is already a score for this cook by this judge for this episode';
    end if;

    insert into score (points, episode_cook_id, episode_judge_id)
    select score, ec.id, ej.id
    from episode_cook ec, episode_judge ej
    where ec.episode_id = ep_id and ej.episode_id = ep_id
      and ec.cook_id = ck_id and ej.cook_id = ju_id;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE Update_Cook_Score(ck_id int, ju_id int, ep_id int, score int)
BEGIN
    if (not exists(Select * from episode e where e.id = ep_id)) then
        signal SQLSTATE '45000'
            set message_text = 'There is no such episode';
    end if;

    if (not exists(Select * from episode_cook ec where ec.cook_id= ck_id and ec.episode_id = ep_id)) then
        signal SQLSTATE '45000'
            set message_text = 'There is no such cook in this episode';
    end if;

    if (not exists(Select * from episode_judge ej where ej.cook_id=ju_id and ej.episode_id = ep_id)) then
        signal SQLSTATE '45000'
            set message_text = 'There is no such judge in this episode';
    end if;

    Update score
    set points = score
    where id = (
        select id from (
                           select sc.id
                           from score sc
                                    inner join episode_cook ec on sc.episode_cook_id = ec.id
                                    inner join episode_judge ej on sc.episode_judge_id = ej.id
                           where ec.episode_id = ep_id and ej.episode_id = ep_id
                             and ec.cook_id = ck_id and ej.cook_id = ju_id
                       ) sc1);

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE 	Create_Cook_Random_Specializations(cook_id int)
BEGIN

    insert into cook_specialisation (cook_id, cuisine_id, yrs_of_exp)
    select cook_id,
           c.id as cuisine_id,
           floor(rand()*10)+1 as yrs_of_exp

    from cuisine c
    order by rand()
    limit 10;

END //

DELIMITER ;


DELIMITER ;

DELIMITER //

CREATE PROCEDURE Create_Cook_Random_Scores()
BEGIN

    insert into score (points, episode_cook_id, episode_judge_id)
    select floor(rand()*5)+1, ec.id as episode_cook_id, ej.id as episode_judge_id
    from episode e
             inner join episode_cook ec on e.id= ec.episode_id
             inner join episode_judge ej on e.id = ej.episode_id;

END //

DELIMITER ;

DELIMITER ;

DELIMITER //

CREATE PROCEDURE Set_Episode_Winners()
BEGIN

    update episode_cook as ec1
    set ec1.is_winner=true
    where id in (select id from (
                                    select id from episode_cook ecc inner join
                                                   (select episode_id,
                                                           cook_id,
                                                           ROW_NUMBER() OVER(PARTITION BY episode_id) row_id
                                                    from
                                                        (select e.id as episode_id,
                                                                avg(s.points) av_score,
                                                                c.id as cook_id

                                                         from score s inner join episode_cook ec on s.episode_cook_id = ec.id
                                                                      inner join recipe r on ec.recipe_id = r.id
                                                                      inner join cook c on ec.cook_id = c.id
                                                                      inner join episode e on ec.episode_id = e.id
                                                                      inner join cook_specialisation cs on c.id = cs.cook_id and cs.cuisine_id = r.cuisine_id
                                                         group by  e.id,
                                                                   c.id,
                                                                   cs.yrs_of_exp

                                                         order by e.id, av_score DESC, cs.yrs_of_exp DESC, rand()) cc) cc1
                                                   on cc1.cook_id = ecc.cook_id and cc1.episode_id = ecc.episode_id
                                    where row_id =1) cc2);

END //

DELIMITER ;


-- ---------------------------------------
--
-- VIEWS and SPs for exercise questions
--
-- ---------------------------------------


-- ---------------------------------------
-- 3.1
-- ---------------------------------------

CREATE VIEW Cook_Average_Score_by_Cuisine AS
select
    CONCAT(first_name, ' ', last_name) AS Cook_Name,
    cu.name Cuisine_Name,
    avg(s.points) Average_Score

from score s inner join episode_cook ec on s.episode_cook_id = ec.id
             inner join cook c on ec.cook_id = c.id
             inner join recipe r on ec.recipe_id = r.id
             inner join cuisine cu on r.cuisine_id = cu.id

group by Cook_Name, Cuisine_Name
order by Cuisine_Name, Average_Score DESC, Cook_Name;

-- ---------------------------------------
-- 3.2
-- ---------------------------------------

DELIMITER ;

DELIMITER //

CREATE PROCEDURE Find_Cooks_By_Cuisine_Season(cuisine_name varchar(100), season_year int)
BEGIN

    select
        CONCAT(first_name, ' ', last_name) AS Cook_Name,
        cu.name Cuisine_Name,
        if(c_episode.cook_id is not null, 'True', 'False') AS Participated
-- Select all cooks specialized in specific cuisine
    from cook c inner join cook_specialisation cs on c.id = cs.cook_id
                inner join cuisine cu on cs.cuisine_id = cu.id
-- Select cooks that executed recipes of specific cuisine in specific year
                left join (select ec.cook_id,
                                  r.cuisine_id
                           from episode_cook ec inner join recipe r on ec.recipe_id = r.id
                                                inner join episode e on ec.episode_id = e.id
                           where e.calendar_year = season_year
    ) c_episode
                          on c_episode.cook_id = c.id and c_episode.cuisine_id = cu.id
    where cu.name = cuisine_name;


END //

DELIMITER ;

-- ---------------------------------------
-- 3.3
-- ---------------------------------------

CREATE VIEW Young_Cook_Recipies AS
select
    CONCAT(first_name, ' ', last_name) AS Cook_Name,
    TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age,
    recipes
-- We select all the distinct recipes for each cook.
-- i.e If a cook has executed the same recipe more than once during the years
-- this recipe is counted one time
from cook c join (select count(distinct ec.recipe_id) recipes,
                         cook_id
                  from episode_cook ec
                  group by cook_id) ep_count on ep_count.cook_id = c.id

where TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) < 30
order by recipes DESC;

-- ---------------------------------------
-- 3.4
-- ---------------------------------------

CREATE VIEW Cooks_Never_Been_Judges AS

select
    CONCAT(first_name, ' ', last_name) AS Cook_Name
from cook c where c.id not in (select ec.cook_id from episode_judge ec);

-- ---------------------------------------
-- 3.5
-- ---------------------------------------

CREATE VIEW Cooks_With_Same_Judge_Appear_over3 AS

select
    CONCAT(first_name, ' ', last_name) AS Cook_Name,
    ec1.appearances, ec1.calendar_year
from cook c inner join
     (
         select count(*) as appearances,
                ej.cook_id,
                e.calendar_year

         from episode_judge ej inner join episode e on ej.episode_id = e.id
         group by ej.cook_id, e.calendar_year
         having count(*) >= 3
         order by appearances, cook_id) ec1 on ec1.cook_id = c.id;

-- ---------------------------------------
-- 3.6
-- ---------------------------------------

CREATE VIEW Top_3_label_pairs as

select l1.name as label1,
       l2.name as label2,
       count
from
    (select distinct greatest(l1, l2) id1, least(l1,l2) id2, count
     from
         (Select count(rl1.recipe_id) as count, rl1.label_id as l1, rl2.label_id as l2 from
             (select rl.label_id, rl.recipe_id from recipe_label rl) rl1 inner join
             (select rl.label_id, rl.recipe_id from recipe_label rl) rl2 on rl1.recipe_id = rl2.recipe_id
                 and rl1.label_id <> rl2.label_id

          group by rl1.label_id, rl2.label_id
          order by count(rl1.recipe_id) DESC) ec) ll
        inner join label l1 on ll.id1 = l1.id
        inner join label l2 on ll.id2 = l2.id
limit 3;


-- ---------------------------------------
-- 3.7
-- ---------------------------------------

CREATE VIEW Cooks_With_5_less_Appearances as
select
    CONCAT(first_name, ' ', last_name) AS Cook_Name,
    count(*) as appearances
from cook c inner join episode_cook ec on c.id = ec.cook_id
group by CONCAT(first_name, ' ', last_name)
having count(*) <= (select
                        count(*) appearances
                    from episode_cook ec
                    group by ec.cook_id
                    order by appearances DESC
                    limit 1) - 5
order by appearances DESC;

-- ---------------------------------------
-- 3.8
-- ---------------------------------------

CREATE VIEW Top_Equipment_number_by_recipe as

select
    e.number,
    e.calendar_year,
    count(distinct re.equipment_id)
from episode e inner join episode_cook ec on e.id = ec.episode_id
               inner join recipe r on ec.recipe_id = r.id
               inner join recipe_equipment re on r.id = re.recipe_id

group by e.number, e.calendar_year
order by count(distinct re.equipment_id) desc
limit 1;

-- ---------------------------------------
-- 3.9
-- ---------------------------------------

CREATE VIEW Avg_CarbonH_per_Year as

select
    e.calendar_year,
    avg(rch.carbons) as avg_ch
from episode e inner join episode_cook ec on e.id = ec.episode_id
               inner join
     (Select sum(re.carbon_hydrates)/r.portions carbons, r.id from
         recipe r
             inner join recipe_ingredient re on r.id = re.recipe_id
      group by r.id) rch on ec.recipe_id = rch.id

group by e.calendar_year
order by calendar_year;

-- ---------------------------------------
-- 3.10
-- ---------------------------------------

CREATE VIEW find_cuisines_with_more_parts as
select c1.name,
       fy.participations,
       fy.calendar_year as f_year,
       ny.calendar_year as n_year

from
    cuisine c1 inner join

    (select count(*) as participations,
            c.id as cuisine_id,
            e.calendar_year
     from episode_cook ac inner join recipe r on ac.recipe_id = r.id
                          inner join cuisine c on r.cuisine_id = c.id
                          inner join episode e on ac.episode_id = e.id
     group by c.name, e.calendar_year) fy
    on fy.cuisine_id = c1.id
               inner join
    (select count(*) as participations,
            c.id as cuisine_id,
            e.calendar_year
     from episode_cook ac inner join recipe r on ac.recipe_id = r.id
                          inner join cuisine c on r.cuisine_id = c.id
                          inner join episode e on ac.episode_id = e.id
     group by c.name, e.calendar_year) ny
    on fy.cuisine_id = ny.cuisine_id
        and fy.participations = ny.participations
        and ny.calendar_year = fy.calendar_year + 1
where fy.participations >= 3
order by fy.participations DESC;

-- ---------------------------------------
-- 3.11
-- ---------------------------------------

CREATE VIEW Top5_jusge_scores_overall as

select
    CONCAT(jdg.first_name, ' ', jdg.last_name) AS Judge_Name,
    CONCAT(ck.first_name, ' ', ck.last_name) AS Cook_Name,
    sum(score.points) as total_score
from episode_cook ec inner join score on ec.id = score.episode_cook_id
                     inner join episode_judge ej on score.episode_judge_id = ej.id
                     inner join cook ck on ec.cook_id = ck.id
                     inner  join cook jdg on ej.cook_id = jdg.id
group by Judge_Name, Cook_Name
order by total_score DESC
limit 5;

-- ---------------------------------------
-- 3.12
-- ---------------------------------------

CREATE VIEW Most_difficult_episode_per_year as

select
    calendar_year,
    number as episode_number,
    episode_difficulty
from
    (select
         ROW_NUMBER() over (PARTITION BY calendar_year ORDER by avg(r.difficulty) DESC) as aa,
         e.calendar_year,
         e.number,
         avg(r.difficulty) as episode_difficulty
     from episode e inner join episode_cook ec on e.id = ec.episode_id
                    inner join recipe r on ec.recipe_id = r.id
     group by e.calendar_year, e.number) ed
where ed.aa = 1;

-- ---------------------------------------
-- 3.13
-- ---------------------------------------

CREATE VIEW episode_with_least_total_Grade as

select
    cook_grade.calendar_year,
    cook_grade.number as episode_number,
    cook_grade.total_grade + judge_grade.total_grade as overall_grade
from

    (select e.calendar_year,
            e.number,
            sum(ck.grade_id) as total_grade

     from episode_cook ec inner join episode e on ec.episode_id = e.id
                          inner join cook ck on ec.cook_id = ck.id
     group by e.calendar_year, e.number
     order by total_grade DESC) cook_grade inner join
    (select e.calendar_year,
            e.number,
            sum(ck.grade_id) as total_grade

     from episode_judge ec inner join episode e on ec.episode_id = e.id
                           inner join cook ck on ec.cook_id = ck.id
     group by e.calendar_year, e.number
     order by total_grade DESC) judge_grade
    on cook_grade.calendar_year = judge_grade.calendar_year
        and cook_grade.number = judge_grade.number

order by overall_grade
limit 1;

-- ---------------------------------------
-- 3.14
-- ---------------------------------------

CREATE VIEW Most_frequent_subject_matter as

select
    sm.name,
    count(*) as appearances

from recipe r inner join recipe_subject_matter rcm on r.id = rcm.recipe_id
              inner join subject_matter sm on rcm.subject_matter_id = sm.id
              inner join episode_cook ec on r.id = ec.recipe_id
group by sm.name
order by appearances desc
limit 1;

-- ---------------------------------------
-- 3.15
-- ---------------------------------------

CREATE VIEW Food_group_never_appeared As

select *
from food_group
where id not in
      (select distinct i.food_group_id

       from episode_cook ec inner join recipe r on ec.recipe_id = r.id
                            inner join recipe_ingredient ri on r.id = ri.recipe_id
                            inner join ingredient i on ri.ingredient_id = i.id);

