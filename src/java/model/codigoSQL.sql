-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Odontologo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Odontologo` (
  `idOdontologo` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Cedula` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idOdontologo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Servicio` (
  `idServicio` INT NOT NULL,
  `Nombre_Servicio` VARCHAR(45) NULL,
  `Duracion` VARCHAR(45) NULL,
  `Costo` DOUBLE NULL,
  PRIMARY KEY (`idServicio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Paciente` (
  `idPaciente` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(90) NOT NULL,
  `Sexo` VARCHAR(45) NOT NULL,
  `Edad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPaciente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `correo` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `idUsuario` INT NOT NULL,
  `idPaciente` INT NOT NULL,
  `idOdontologo` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_Usuario_Paciente1_idx` (`idPaciente` ASC),
  INDEX `fk_Usuario_Odontologo1_idx` (`idOdontologo` ASC),
  CONSTRAINT `fk_Usuario_Paciente1`
    FOREIGN KEY (`idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_Odontologo1`
    FOREIGN KEY (`idOdontologo`)
    REFERENCES `mydb`.`Odontologo` (`idOdontologo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Recibo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Recibo` (
  `idRecibo` INT NOT NULL,
  `Costo` DOUBLE NULL,
  PRIMARY KEY (`idRecibo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consulta` (
  `idConsulta` INT NOT NULL,
  `Fecha` VARCHAR(45) NULL,
  `Paciente_idPaciente` INT NOT NULL,
  `Recibo_idRecibo` VARCHAR(30) NOT NULL,
  `Estado` VARCHAR(10) NOT NULL,
  `Odontologo_idOdontologo` INT NOT NULL,
  PRIMARY KEY (`idConsulta`),
  INDEX `fk_Consulta_Paciente_idx` (`Paciente_idPaciente` ASC),
  INDEX `fk_Consulta_Recibo1_idx` (`Recibo_idRecibo` ASC),
  INDEX `fk_Consulta_Odontologo1_idx` (`Odontologo_idOdontologo` ASC),
  CONSTRAINT `fk_Consulta_Paciente`
    FOREIGN KEY (`Paciente_idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Recibo1`
    FOREIGN KEY (`Recibo_idRecibo`)
    REFERENCES `mydb`.`Recibo` (`idRecibo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Odontologo1`
    FOREIGN KEY (`Odontologo_idOdontologo`)
    REFERENCES `mydb`.`Odontologo` (`idOdontologo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consulta_has_Servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consulta_has_Servicio` (
  `Consulta_idConsulta` CHAR NOT NULL,
  `Servicio_idServicio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Consulta_idConsulta`, `Servicio_idServicio`),
  INDEX `fk_Consulta_has_Servicio_Servicio1_idx` (`Servicio_idServicio` ASC),
  INDEX `fk_Consulta_has_Servicio_Consulta1_idx` (`Consulta_idConsulta` ASC),
  CONSTRAINT `fk_Consulta_has_Servicio_Consulta1`
    FOREIGN KEY (`Consulta_idConsulta`)
    REFERENCES `mydb`.`Consulta` (`idConsulta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_has_Servicio_Servicio1`
    FOREIGN KEY (`Servicio_idServicio`)
    REFERENCES `mydb`.`Servicio` (`idServicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tratamiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tratamiento` (
  `idTratamiento` INT NOT NULL,
  `Nombre_Tratamiento` VARCHAR(45) NULL,
  `Costo` DOUBLE NULL,
  `Consulta_idConsulta` INT NOT NULL,
  PRIMARY KEY (`idTratamiento`),
  INDEX `fk_Tratamiento_Consulta1_idx` (`Consulta_idConsulta` ASC),
  CONSTRAINT `fk_Tratamiento_Consulta1`
    FOREIGN KEY (`Consulta_idConsulta`)
    REFERENCES `mydb`.`Consulta` (`idConsulta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Usuario (correo, password, idUsuario, idPaciente) VALUES("brandon@mailinator.com", "password", 1, 1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
