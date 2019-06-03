-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema work
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema work
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `work` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `work` ;

-- -----------------------------------------------------
-- Table `work`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `work`.`employee` ;

CREATE TABLE IF NOT EXISTS `work`.`employee` (
  `Id` INT(11) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Active` BIT(1) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `work`.`salary`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `work`.`salary` ;

CREATE TABLE IF NOT EXISTS `work`.`salary` (
  `idsalary` INT(11) NOT NULL,
  `employee_Id` INT(11) NOT NULL,
  `Salary` VARCHAR(45) NOT NULL,
  `Datetime` DATETIME NOT NULL,
  PRIMARY KEY (`idsalary`),
  INDEX `fk_salary_employee_idx` (`employee_Id` ASC),
  CONSTRAINT `fk_salary_employee`
    FOREIGN KEY (`employee_Id`)
    REFERENCES `work`.`employee` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `work`.`employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `work`;
INSERT INTO `work`.`employee` (`Id`, `Name`, `Active`) VALUES (1, 'Великанов Сергей', 1);
INSERT INTO `work`.`employee` (`Id`, `Name`, `Active`) VALUES (2, 'Ахметов Ахмет', 0);
INSERT INTO `work`.`employee` (`Id`, `Name`, `Active`) VALUES (3, 'Иванов Иван', 1);
INSERT INTO `work`.`employee` (`Id`, `Name`, `Active`) VALUES (4, 'Гуськова Мария', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `work`.`salary`
-- -----------------------------------------------------
START TRANSACTION;
USE `work`;
INSERT INTO `work`.`salary` (`idsalary`, `employee_Id`, `Salary`, `Datetime`) VALUES (1, 1, '55000', '2011-04-12T00:00:00.000');
INSERT INTO `work`.`salary` (`idsalary`, `employee_Id`, `Salary`, `Datetime`) VALUES (2, 1, '50000', '2011-04-13T00:00:00.000');
INSERT INTO `work`.`salary` (`idsalary`, `employee_Id`, `Salary`, `Datetime`) VALUES (3, 2, '4444', '2011-04-12T00:00:00.000');
INSERT INTO `work`.`salary` (`idsalary`, `employee_Id`, `Salary`, `Datetime`) VALUES (7, 1, '4200', '2011-04-14T00:00:00.000');

COMMIT;

