-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------
--              THIS CODE DOES NOT WORK
-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------

USE `vehicle_management_database`;
-- -----------------------------------------------------
-- Add vehicle procedure
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `add_vehicle`;
DELIMITER $$
CREATE PROCEDURE `vehicle_management_database`.`add_vehicle` (
    IN `vehicle_registration` VARCHAR(7),
    IN `vehicle_type` VARCHAR(45),
    IN `vehicle_make` VARCHAR(45),
    IN `vehicle_model` VARCHAR(45),
    IN `vehicle_year` YEAR,
    IN `vehicle_colour` VARCHAR(45),
    IN `vehicle_fuel_type` VARCHAR(20),
    IN `vehicle_odometer_reading` INT,
    IN `vehicle_last_maintenance_date` DATE,
    IN `vehicle_registration_date` DATE
)
BEGIN
    INSERT INTO `vehicle_management_database`.`vehicles` (
        `vehicle_registration`, `vehicle_type`, `vehicle_make`,
        `vehicle_model`, `vehicle_year`, `vehicle_colour`,
        `vehicle_fuel_type`, `vehicle_odometer_reading`,
        `vehicle_last_maintenance_date`, `vehicle_registration_date`,
        `vehicle_acquisition_date`, `vehicle_availability`
    ) 
    VALUES (@vehicle_registration, @vehicle_type, @vehicle_make, 
    @vehicle_model, @vehicle_year, @vehicle_colour, @vehicle_fuel_type, 
    @vehicle_odometer_reading, @vehicle_last_maintenance_date, 
    @vehicle_registration_date, NOW(), 1);
END $$
DELIMITER ;

-- -----------------------------------------------------
-- Flip vehicle availability procedure
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `flip_vehicle_availability`;
DELIMITER $$
CREATE PROCEDURE `vehicle_management_database`.`flip_vehicle_availability` (
    `vehicle_registration_lookup` VARCHAR(7))
BEGIN    
	UPDATE `vehicles`
	SET `vehicles`.`vehicle_availability` = NOT `vehicles`.`vehicle_availability`
	WHERE `vehicles`.`vehicle_registration` = `vehicle_registration_lookup`;
END $$
DELIMITER ; 

-- -----------------------------------------------------
-- Sign out vehicle procedure
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `sign_out_vehicle`;
DELIMITER $$
CREATE PROCEDURE `vehicle_management_database`.`sign_out_vehicle` (
    `r_id` INT,
    `forename` VARCHAR(45),
    `surname` VARCHAR(45),
    `email` VARCHAR(45),
    `notes` VARCHAR(500))
BEGIN
START TRANSACTION;

    SELECT `reservations`.`reservation_vehicle_type_required` AS `v_type`
    FROM `reservations` 
    WHERE `reservations`.`reservation_id` = `r_id`;
    
    SELECT `vehicles`.`vehicle_registration` AS `v_reg`
    FROM `vehicles`
    WHERE `vehicles`.`vehicle_availability` = 1 AND `vehicles`.`vehicle_type` = `v_type`
    LIMIT 1;

    SELECT `vehicles`.`vehicle_odometer_reading` AS `v_odo`
    FROM `vehicles`
    WHERE `vehicles`.`vehicle_registration` = `v_reg`;

    SELECT `reservations`.`reservation_faculty_member_id` AS `f_id`
    FROM `reservations` 
    WHERE `reservations`.`reservation_id` = `r_id`;
    -- Find the staff member's id based on their name and email
    SELECT `staff_members`.`staff_member_id` AS `s_id`
    FROM `staff_members`
    WHERE `staff_members`.`staff_member_forename` = `forename`
        AND `staff_members`.`staff_member_surname` = `surname`
        AND `staff_members`.`staff_member_email` = `email`;
    -- Add a row to `sign_out_forms` for the vehicle to be signed out if one exists
    INSERT INTO `sign_out_forms`
        (`sign_out_form_vehicle_registration`, `sign_out_form_reservation_id`, `sign_out_form_faculty_member_id`,
        `sign_out_form_staff_member_id`, `sign_out_form_date`, `sign_out_form_odometer_reading`, `sign_out_form_notes`)
    VALUES (`v_reg`, `r_id`, `f_id`, `s_id`, NOW(), `v_odo`, `notes`);
    -- Change availability to false
    CALL `flip_vehicle_availability`(`v_reg`);
END $$
DELIMITER ;

