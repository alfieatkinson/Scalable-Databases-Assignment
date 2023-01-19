USE `vehicle_management_database`;
-- -----------------------------------------------------
-- Update parts inventory when part is used
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `update_parts_inventory`;
DELIMITER $$
CREATE TRIGGER `vehicle_management_database`.`update_parts_inventory`
AFTER INSERT ON `parts_usage_forms`
FOR EACH ROW
BEGIN
    UPDATE `parts`
    SET `parts`.`part_quantity` = `parts`.`part_quantity` - NEW.`parts_usage_form_part_quantity`
    WHERE `parts`.`part_id` = NEW.`parts_usage_form_part_id`;
END $$
DELIMITER ;

-- -----------------------------------------------------
-- Restock part when it falls below minimum required
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `restock_part`;
DELIMITER $$
CREATE TRIGGER `vehicle_management_database`.`restock_part`
AFTER INSERT ON `parts_usage_forms`
FOR EACH ROW
BEGIN
    UPDATE `parts`
    SET `parts`.`part_quantity` = `parts`.`part_quantity` + `parts`.`part_minimum_quantity`
    WHERE `parts`.`part_id` = NEW.`parts_usage_form_part_id`
    AND `parts`.`part_quantity` - NEW.`parts_usage_form_part_quantity` < `parts`.`part_minimum_quantity`;
END $$
DELIMITER ;

-- -----------------------------------------------------
-- Update vehicle odometer when a trip is completed
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `update_vehicle_odometer`;
DELIMITER $$
CREATE TRIGGER `vehicle_management_database`.`update_vehicle_odometer`
AFTER INSERT ON `trip_completion_forms`
FOR EACH ROW
BEGIN
    UPDATE `vehicles`
    SET `vehicles`.`vehicle_odometer_reading` = NEW.`trip_completion_form_odometer_end`
    WHERE `vehicles`.`vehicle_registration` = NEW.`trip_completion_form_vehicle_registration`;
END $$
DELIMITER ;

-- -----------------------------------------------------
-- Update vehicle availability when it is signed out
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `update_vehicle_availability_after_sign_out`;
DELIMITER $$
CREATE TRIGGER `vehicle_management_database`.`update_vehicle_availability_after_sign_out`
AFTER INSERT ON `sign_out_forms`
FOR EACH ROW
BEGIN
    UPDATE `vehicles`
    SET `vehicles`.`vehicle_availability` = 0
    WHERE `vehicles`.`vehicle_registration` = NEW.`sign_out_form_vehicle_registration`;
END $$
DELIMITER ;

-- -----------------------------------------------------
-- Update vehicle availability when it goes into maintenance
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `update_vehicle_availability_for_maintenance`;
DELIMITER $$
CREATE TRIGGER `vehicle_management_database`.`update_vehicle_availability_for_maintenance`
AFTER INSERT ON `maintenance_logs`
FOR EACH ROW
BEGIN
    UPDATE `vehicles`
    SET `vehicles`.`vehicle_availability` = 0
    WHERE `vehicles`.`vehicle_registration` = NEW.`maintenance_log_vehicle_registration`;
END $$
DELIMITER ;

-- -----------------------------------------------------
-- Update vehicle availability when a trip is completed
-- -----------------------------------------------------
DROP TRIGGER IF EXISTS `update_vehicle_availability_after_trip_completion`;
DELIMITER $$
CREATE TRIGGER `vehicle_management_database`.`update_vehicle_availability_after_trip_completion`
AFTER INSERT ON `trip_completion_forms`
FOR EACH ROW
BEGIN
    UPDATE `vehicles`
    SET `vehicles`.`vehicle_availability` = 1
    WHERE `vehicles`.`vehicle_registration` = NEW.`trip_completion_form_vehicle_registration`;
END $$
DELIMITER ;