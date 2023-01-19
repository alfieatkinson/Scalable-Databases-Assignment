USE `vehicle_management_database`;
-- -----------------------------------------------------
-- Show a particular bill
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `show_bill`;
DELIMITER $$
CREATE PROCEDURE `vehicle_management_database`.`show_bill` (IN `bill_id` INT)
BEGIN
    SELECT * FROM `fuel_bills`
    WHERE `fuel_bills`.`ID` = `bill_id`;
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
-- Select the mileage by department view based on input
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `show_mileage_by_department`;
DELIMITER $$
CREATE PROCEDURE `vehicle_management_database`.`show_mileage_by_department` (
    `timeframe` VARCHAR(10))
BEGIN
    IF UPPER(`timeframe`) = 'ALLTIME' THEN
        SELECT * FROM `mileage_by_department`;
    ELSEIF UPPER(`timeframe`) = 'YEARLY' THEN
        SELECT * FROM `annual_mileage_by_department`;
    ELSEIF UPPER(`timeframe`) = 'MONTHLY' THEN
        SELECT * FROM `last_month_mileage_by_department`;
    END IF;
END $$
DELIMITER ;

-- -----------------------------------------------------
-- Select the mileage by vehicle view based on input
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `show_mileage_by_vehicle`;
DELIMITER $$
CREATE PROCEDURE `vehicle_management_database`.`show_mileage_by_vehicle` (
    `timeframe` VARCHAR(10))
BEGIN
    IF UPPER(`timeframe`) = 'ALLTIME' THEN
        SELECT * FROM `mileage_by_vehicle`;
    ELSEIF UPPER(`timeframe`) = 'MONTHLY' THEN
        SELECT * FROM `last_month_mileage_by_vehicle`;
    END IF;
END $$
DELIMITER ;