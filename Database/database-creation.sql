DROP DATABASE IF EXISTS `vehicle_management_database`;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema vehicle_management_database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vehicle_management_database` DEFAULT CHARACTER SET utf8 ;
USE `vehicle_management_database` ;

-- -----------------------------------------------------
-- Table `vehicle_management_database`.`vehicles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`vehicles` (
    `vehicle_registration` VARCHAR(7) NOT NULL,
    `vehicle_type` VARCHAR(45) NOT NULL,
    `vehicle_make` VARCHAR(45) NOT NULL,
    `vehicle_model` VARCHAR(45) NOT NULL,
    `vehicle_year` YEAR NOT NULL,
    `vehicle_colour` VARCHAR(45) NOT NULL,
    `vehicle_fuel_type` VARCHAR(20) NOT NULL,
    `vehicle_odometer_reading` INT NOT NULL,
    `vehicle_last_maintenance_date` DATE NOT NULL,
    `vehicle_registration_date` DATE NOT NULL,
    `vehicle_acquisition_date` DATE NOT NULL,
    `vehicle_availability` TINYINT NOT NULL,
    PRIMARY KEY (`vehicle_registration`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_management_database`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`departments` (
    `department_id` INT NOT NULL AUTO_INCREMENT,
    `department_name` VARCHAR(45) NOT NULL,
    `department_head_id` INT NOT NULL,
    `department_phone` VARCHAR(45) NOT NULL,
    `department_email` VARCHAR(45) NOT NULL,
    `department_location` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_management_database`.`faculty_members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`faculty_members` (
    `faculty_member_id` INT NOT NULL AUTO_INCREMENT,
    `faculty_member_department_id` INT NOT NULL,
    `faculty_member_forename` VARCHAR(45) NOT NULL,
    `faculty_member_surname` VARCHAR(45) NOT NULL,
    `faculty_member_email` VARCHAR(45) NOT NULL,
    `faculty_member_phone` VARCHAR(15) NOT NULL,
    `faculty_member_travel_auth` TINYINT NOT NULL,
    PRIMARY KEY (`faculty_member_id`),
    INDEX `fk_faculty_members_departments_idx` (`faculty_member_department_id` ASC) VISIBLE,
    CONSTRAINT `fk_faculty_members_departments`
        FOREIGN KEY (`faculty_member_department_id`)
        REFERENCES `vehicle_management_database`.`departments` (`department_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_management_database`.`reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`reservations` (
    `reservation_id` INT NOT NULL AUTO_INCREMENT,
    `reservation_department_id` INT NOT NULL,
    `reservation_faculty_member_id` INT NOT NULL,
    `reservation_departure_date` DATE NOT NULL,
    `reservation_vehicle_type_required` VARCHAR(45) NULL,
    `reservation_destination` VARCHAR(45) NOT NULL,
    `reservation_reason` VARCHAR(150) NOT NULL,
    `reservation_status` VARCHAR(10) NOT NULL,
    `reservation_notes` VARCHAR(500) NULL,
    INDEX `fk_reservations_faculty_members1_idx` (`reservation_faculty_member_id` ASC) VISIBLE,
    PRIMARY KEY (`reservation_id`),
    INDEX `fk_reservations_departments1_idx` (`reservation_department_id` ASC) VISIBLE,
    CONSTRAINT `fk_reservations_faculty_members1`
        FOREIGN KEY (`reservation_faculty_member_id`)
        REFERENCES `vehicle_management_database`.`faculty_members` (`faculty_member_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_reservations_departments1`
        FOREIGN KEY (`reservation_department_id`)
        REFERENCES `vehicle_management_database`.`departments` (`department_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_management_database`.`trip_completion_forms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`trip_completion_forms` (
    `trip_completion_form_id` INT NOT NULL AUTO_INCREMENT,
    `trip_completion_form_reservation_id` INT NOT NULL,
    `trip_completion_form_vehicle_registration` VARCHAR(7) NOT NULL,
    `trip_completion_form_faculty_member_id` INT NOT NULL,
    `trip_completion_form_odometer_start` INT NOT NULL,
    `trip_completion_form_odometer_end` INT NOT NULL,
    `trip_completion_form_fuel_purchased` INT NULL,
    `trip_completion_form_credit_card_number_used` VARCHAR(16) NULL,
    `trip_completion_form_fuel_reciept` VARCHAR(200) NULL,
    `trip_completion_form_maintenance_complaints` VARCHAR(500) NULL,
    `trip_completion_form_completion_date` DATE NOT NULL,
    `trip_completion_form_notes` VARCHAR(500) NULL,
    INDEX `fk_trip_completion_forms_reservations1_idx` (`trip_completion_form_reservation_id` ASC) VISIBLE,
    INDEX `fk_trip_completion_forms_vehicles1_idx` (`trip_completion_form_vehicle_registration` ASC) VISIBLE,
    INDEX `fk_trip_completion_forms_faculty_members1_idx` (`trip_completion_form_faculty_member_id` ASC) VISIBLE,
    PRIMARY KEY (`trip_completion_form_id`),
    CONSTRAINT `fk_trip_completion_forms_reservations1`
        FOREIGN KEY (`trip_completion_form_reservation_id`)
        REFERENCES `vehicle_management_database`.`reservations` (`reservation_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_trip_completion_forms_vehicles1`
        FOREIGN KEY (`trip_completion_form_vehicle_registration`)
        REFERENCES `vehicle_management_database`.`vehicles` (`vehicle_registration`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_trip_completion_forms_faculty_members1`
        FOREIGN KEY (`trip_completion_form_faculty_member_id`)
        REFERENCES `vehicle_management_database`.`faculty_members` (`faculty_member_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_management_database`.`maintenance_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`maintenance_logs` (
    `maintenance_log_id` INT NOT NULL AUTO_INCREMENT,
    `maintenance_log_vehicle_registration` VARCHAR(7) NOT NULL,
    `maintenance_log_date` DATE NOT NULL,
    `maintenance_log_expected_return_date` DATE NOT NULL,
    `maintenance_log_is_finished` TINYINT(1) NULL,
    `maintenance_log_notes` VARCHAR(500) NULL,
    PRIMARY KEY (`maintenance_log_id`),
    INDEX `fk_maintenance_logs_vehicles1_idx` (`maintenance_log_vehicle_registration` ASC) VISIBLE,
    CONSTRAINT `fk_maintenance_logs_vehicles1`
        FOREIGN KEY (`maintenance_log_vehicle_registration`)
        REFERENCES `vehicle_management_database`.`vehicles` (`vehicle_registration`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_management_database`.`mechanics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`mechanics` (
    `mechanic_id` INT NOT NULL AUTO_INCREMENT,
    `mechanic_forename` VARCHAR(45) NOT NULL,
    `mechanic_surname` VARCHAR(45) NOT NULL,
    `mechanic_email` VARCHAR(45) NOT NULL,
    `mechanic_phone` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`mechanic_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_management_database`.`maintenance_detail_forms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`maintenance_detail_forms` (
    `maintenance_detail_form_id` INT NOT NULL AUTO_INCREMENT,
    `maintenance_detail_form_maintenance_log_id` INT NOT NULL,
    `maintenance_detail_form_mechanic_id` INT NOT NULL,
    `maintenance_detail_form_description` VARCHAR(500) NOT NULL,
    `maintenance_detail_form_parts_used` VARCHAR(500) NOT NULL,
    `maintenance_detail_form_completion_date` DATE NOT NULL,
    PRIMARY KEY (`maintenance_detail_form_id`),
    INDEX `fk_maintenance_detail_forms_maintenance_logs1_idx` (`maintenance_detail_form_maintenance_log_id` ASC) VISIBLE,
    INDEX `fk_maintenance_detail_forms_mechanics1_idx` (`maintenance_detail_form_mechanic_id` ASC) VISIBLE,
    CONSTRAINT `fk_maintenance_detail_forms_maintenance_logs1`
        FOREIGN KEY (`maintenance_detail_form_maintenance_log_id`)
        REFERENCES `vehicle_management_database`.`maintenance_logs` (`maintenance_log_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_maintenance_detail_forms_mechanics1`
        FOREIGN KEY (`maintenance_detail_form_mechanic_id`)
        REFERENCES `vehicle_management_database`.`mechanics` (`mechanic_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_management_database`.`parts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`parts` (
    `part_id` INT NOT NULL AUTO_INCREMENT,
    `part_name` VARCHAR(45) NOT NULL,
    `part_type` VARCHAR(45) NOT NULL,
    `part_quantity` INT NOT NULL,
    `part_minimum_quantity` INT NOT NULL,
    `part_cost` DECIMAL NOT NULL,
    PRIMARY KEY (`part_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_management_database`.`parts_usage_forms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`parts_usage_forms` (
    `parts_usage_form_id` INT NOT NULL AUTO_INCREMENT,
    `parts_usage_form_part_id` INT NOT NULL,
    `parts_usage_form_mechanic_id` INT NOT NULL,
    `parts_usage_form_maintenance_detail_form_id` INT NOT NULL,
    `parts_usage_form_part_quantity` INT NOT NULL,
    `parts_usage_form_date` DATE NOT NULL,
    PRIMARY KEY (`parts_usage_form_id`),
    INDEX `fk_parts_usage_forms_parts1_idx` (`parts_usage_form_part_id` ASC) VISIBLE,
    INDEX `fk_parts_usage_forms_maintenance_detail_forms1_idx` (`parts_usage_form_maintenance_detail_form_id` ASC) VISIBLE,
    INDEX `fk_parts_usage_forms_mechanics1_idx` (`parts_usage_form_mechanic_id` ASC) VISIBLE,
    CONSTRAINT `fk_parts_usage_forms_parts1`
        FOREIGN KEY (`parts_usage_form_part_id`)
        REFERENCES `vehicle_management_database`.`parts` (`part_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_parts_usage_forms_maintenance_detail_forms1`
        FOREIGN KEY (`parts_usage_form_maintenance_detail_form_id`)
        REFERENCES `vehicle_management_database`.`maintenance_detail_forms` (`maintenance_detail_form_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_parts_usage_forms_mechanics1`
        FOREIGN KEY (`parts_usage_form_mechanic_id`)
        REFERENCES `vehicle_management_database`.`mechanics` (`mechanic_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_management_database`.`staff_members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`staff_members` (
    `staff_member_id` INT NOT NULL AUTO_INCREMENT,
    `staff_member_forename` VARCHAR(45) NOT NULL,
    `staff_member_surname` VARCHAR(45) NOT NULL,
    `staff_member_email` VARCHAR(45) NOT NULL,
    `staff_member_phone` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`staff_member_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vehicle_management_database`.`sign_out_forms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vehicle_management_database`.`sign_out_forms` (
    `sign_out_form_id` INT NOT NULL AUTO_INCREMENT,
    `sign_out_form_vehicle_registration` VARCHAR(7) NOT NULL,
    `sign_out_form_reservation_id` INT NOT NULL,
    `sign_out_form_faculty_member_id` INT NOT NULL,
    `sign_out_form_staff_member_id` INT NOT NULL,
    `sign_out_form_date` DATE NOT NULL,
    `sign_out_form_odometer_reading` INT NOT NULL,
    `sign_out_form_notes` VARCHAR(500) NULL,
    PRIMARY KEY (`sign_out_form_id`),
    INDEX `fk_sign_out_form_vehicles1_idx` (`sign_out_form_vehicle_registration` ASC) VISIBLE,
    INDEX `fk_sign_out_form_reservations1_idx` (`sign_out_form_reservation_id` ASC) VISIBLE,
    INDEX `fk_sign_out_form_faculty_members1_idx` (`sign_out_form_faculty_member_id` ASC) VISIBLE,
    INDEX `fk_sign_out_form_staff_members1_idx` (`sign_out_form_staff_member_id` ASC) VISIBLE,
    CONSTRAINT `fk_sign_out_form_vehicles1`
        FOREIGN KEY (`sign_out_form_vehicle_registration`)
        REFERENCES `vehicle_management_database`.`vehicles` (`vehicle_registration`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_sign_out_form_reservations1`
        FOREIGN KEY (`sign_out_form_reservation_id`)
        REFERENCES `vehicle_management_database`.`reservations` (`reservation_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_sign_out_form_faculty_members1`
        FOREIGN KEY (`sign_out_form_faculty_member_id`)
        REFERENCES `vehicle_management_database`.`faculty_members` (`faculty_member_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_sign_out_form_staff_members1`
        FOREIGN KEY (`sign_out_form_staff_member_id`)
        REFERENCES `vehicle_management_database`.`staff_members` (`staff_member_id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
