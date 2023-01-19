USE `vehicle_management_database`;
-- -----------------------------------------------------
-- Available vehicles view
-- -----------------------------------------------------
DROP VIEW IF EXISTS `available_vehicles`;
CREATE VIEW `vehicle_management_database`.`available_vehicles` AS
    SELECT 
        `vehicles`.`vehicle_registration` AS "Registration", 
        `vehicles`.`vehicle_make` AS "Make", 
        `vehicles`.`vehicle_model` AS "Model", 
        `vehicles`.`vehicle_year` AS "Year", 
        `vehicles`.`vehicle_colour` AS "Colour"
    FROM `vehicles`
    WHERE `vehicles`.`vehicle_availability` = 1;

-- -----------------------------------------------------
-- Vehicle amount used by department
-- -----------------------------------------------------
DROP VIEW IF EXISTS `department_vehicle_usage`;
CREATE VIEW `vehicle_management_database`.`department_vehicle_usage` AS
    SELECT
        `departments`.`department_id` AS "ID",
        `departments`.`department_name` AS "Name",
        COUNT(*) AS "Vehicles Used"
    FROM `sign_out_forms`
    -- Join `faculty_members` and `sign_out_forms` where `faculty_member_id` is the same
    JOIN `faculty_members`
    ON `sign_out_forms`.`sign_out_form_faculty_member_id` = `faculty_members`.`faculty_member_id`
    -- Join `departments` and `faculty_members` where `department_id` is the same
    JOIN `departments`
    ON `faculty_members`.`faculty_member_department_id` = `departments`.`department_id`
    -- Group by department and order by amount of vehicles used
    GROUP BY `departments`.`department_id`
    ORDER BY "Vehicles Used" DESC;

-- -----------------------------------------------------
-- Mileage by vehicle view for last month
-- -----------------------------------------------------
DROP VIEW IF EXISTS `last_month_mileage_by_vehicle`;
CREATE VIEW `vehicle_management_database`.`last_month_mileage_by_vehicle` AS
    SELECT
        `vehicles`.`vehicle_registration` AS "Registration",
        `vehicles`.`vehicle_make` AS "Make", 
        `vehicles`.`vehicle_model` AS "Model", 
        SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) AS "Mileage"
    FROM `trip_completion_forms`
    -- Join `trip_completion_forms` and `vehicles` where `vehicle_registration` is the same
    JOIN `vehicles`
    ON `trip_completion_forms`.`trip_completion_form_vehicle_registration` = `vehicles`.`vehicle_registration`
    -- Only if occured last month
    WHERE `trip_completion_forms`.`trip_completion_form_completion_date` 
        >= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01')
    AND `trip_completion_forms`.`trip_completion_form_completion_date`
        < DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
    -- Group by vehicle registration and order by mileage
    GROUP BY `vehicle_registration`
    ORDER BY SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) DESC;

-- -----------------------------------------------------
-- Mileage by faculty member view for last month
-- -----------------------------------------------------
DROP VIEW IF EXISTS `last_month_mileage_by_faculty_member`;
CREATE VIEW `vehicle_management_database`.`last_month_mileage_by_faculty_member` AS
    SELECT
        `faculty_members`.`faculty_member_id` AS "Faculty ID",
        CONCAT(`faculty_members`.`faculty_member_forename`, ' ', `faculty_members`.`faculty_member_surname`) AS "Name",
        `departments`.`department_name` AS "Department",
        SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) AS "Mileage"
    FROM `trip_completion_forms`
    -- Join `trip_completion_forms` and `faculty_members` where `faculty_member_id` is the same
    JOIN `faculty_members`
    ON `trip_completion_forms`.`trip_completion_form_faculty_member_id` = `faculty_members`.`faculty_member_id`
    -- Join `departments` where `department_id` is the same
    JOIN `departments`
    ON `faculty_members`.`faculty_member_department_id` = `departments`.`department_id`
    -- Only if occured last month
    WHERE `trip_completion_forms`.`trip_completion_form_completion_date` 
        >= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01')
    AND `trip_completion_forms`.`trip_completion_form_completion_date`
        < DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
    -- Group by faculty name and order by mileage
    GROUP BY `faculty_members`.`faculty_member_id`
    ORDER BY SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) DESC;

-- -----------------------------------------------------
-- Mileage by department view for last month
-- -----------------------------------------------------
DROP VIEW IF EXISTS `last_month_mileage_by_department`;
CREATE VIEW `vehicle_management_database`.`last_month_mileage_by_department` AS
    SELECT
        `departments`.`department_id` AS "ID",
        `departments`.`department_name` AS "Department",
        SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) AS "Mileage"
    FROM `trip_completion_forms`
    -- Join `trip_completion_forms` and `faculty_members` where `faculty_member_id` is the same
    JOIN `faculty_members`
    ON `trip_completion_forms`.`trip_completion_form_faculty_member_id` = `faculty_members`.`faculty_member_id`
    -- Join `departments` where `department_id` is the same
    JOIN `departments`
    ON `faculty_members`.`faculty_member_department_id` = `departments`.`department_id`
    -- Only if occured last month
    WHERE `trip_completion_forms`.`trip_completion_form_completion_date` 
        >= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01')
    AND `trip_completion_forms`.`trip_completion_form_completion_date`
        < DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
    -- Group by department name and order by mileage
    GROUP BY `departments`.`department_name`
    ORDER BY SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) DESC;

-- -----------------------------------------------------
-- Mileage by department view for last year
-- -----------------------------------------------------
DROP VIEW IF EXISTS `annual_mileage_by_department`;
CREATE VIEW `vehicle_management_database`.`annual_mileage_by_department` AS
    SELECT
        `departments`.`department_id` AS "ID",
        `departments`.`department_name` AS "Department",
        SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) AS "Mileage" 
    FROM `trip_completion_forms`
    -- Join `trip_completion_forms` and `faculty_members` where `faculty_member_id` is the same
    JOIN `faculty_members`
    ON `trip_completion_forms`.`trip_completion_form_faculty_member_id` = `faculty_members`.`faculty_member_id`
    -- Join `departments` where `department_id` is the same
    JOIN `departments`
    ON `faculty_members`.`faculty_member_department_id` = `departments`.`department_id`
    -- Only if occured last year
    WHERE `trip_completion_forms`.`trip_completion_form_completion_date`
        >= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 YEAR, '%Y-01-01')
    AND `trip_completion_forms`.`trip_completion_form_completion_date`
        < DATE_FORMAT(CURRENT_DATE, '%Y-01-01')
    -- Group by department name and order by mileage
    GROUP BY `departments`.`department_name`
    ORDER BY SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) DESC;

-- -----------------------------------------------------
-- Mileage by vehicle view total
-- -----------------------------------------------------
DROP VIEW IF EXISTS `mileage_by_vehicle`;
CREATE VIEW `vehicle_management_database`.`mileage_by_vehicle` AS
    SELECT
        `vehicles`.`vehicle_registration` AS "Registration",
        `vehicles`.`vehicle_make` AS "Make", 
        `vehicles`.`vehicle_model` AS "Model", 
        SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) AS "Mileage"
    FROM `trip_completion_forms`
    -- Join `trip_completion_forms` and `vehicles` where `vehicle_registration` is the same
    JOIN `vehicles`
    ON `trip_completion_forms`.`trip_completion_form_vehicle_registration` = `vehicles`.`vehicle_registration`
    -- Group by vehicle registration and order by mileage
    GROUP BY `vehicle_registration`
    ORDER BY SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) DESC;

-- -----------------------------------------------------
-- Mileage by department view total
-- -----------------------------------------------------
DROP VIEW IF EXISTS `mileage_by_department`;
CREATE VIEW `vehicle_management_database`.`mileage_by_department` AS
    SELECT
        `departments`.`department_id` AS "ID",
        `departments`.`department_name` AS "Department",
        SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) AS "Mileage"
    FROM `trip_completion_forms`
    -- Join `trip_completion_forms` and `faculty_members` where `faculty_member_id` is the same
    JOIN `faculty_members`
    ON `trip_completion_forms`.`trip_completion_form_faculty_member_id` = `faculty_members`.`faculty_member_id`
    -- Join `departments` where `department_id` is the same
    JOIN `departments`
    ON `faculty_members`.`faculty_member_department_id` = `departments`.`department_id`
    GROUP BY `departments`.`department_name`
    ORDER BY SUM(`trip_completion_forms`.`trip_completion_form_odometer_end` - `trip_completion_forms`.`trip_completion_form_odometer_start`) DESC;

-- -----------------------------------------------------
-- Bills view
-- -----------------------------------------------------
DROP VIEW IF EXISTS `fuel_bills`;
CREATE VIEW `vehicle_management_database`.`fuel_bills` AS
    SELECT
        `trip_completion_forms`.`trip_completion_form_id` AS "ID",
        `reservations`.`reservation_departure_date` AS "Departure Date",
        `trip_completion_forms`.`trip_completion_form_completion_date` AS "Return Date",
        IFNULL(`trip_completion_forms`.`trip_completion_form_fuel_purchased`, 0) AS "Fuel Purchased",
        IFNULL(`trip_completion_forms`.`trip_completion_form_credit_card_number_used`, '') AS "Credit Card Used",
        CONCAT('£', ROUND(IFNULL(`trip_completion_forms`.`trip_completion_form_fuel_purchased`, 0) * 1.91, 2)) AS "Total"
    FROM `trip_completion_forms`
    -- Join `trip_completion_forms` and `reservations` where `reservation_id` is the same
    JOIN `reservations`
    ON `trip_completion_forms`.`trip_completion_form_reservation_id` = `reservations`.`reservation_id`
    -- Order by trip completion form id
    ORDER BY `trip_completion_forms`.`trip_completion_form_id` DESC;

-- -----------------------------------------------------
-- Unused reservations view
-- -----------------------------------------------------
DROP VIEW IF EXISTS `unused_reservations`;
CREATE VIEW `vehicle_management_database`.`unused_reservations` AS
    SELECT
        `reservations`.`reservation_faculty_member_id` AS "Faculty ID",
        CONCAT(`faculty_members`.`faculty_member_forename`, ' ', `faculty_members`.`faculty_member_surname`) AS "Name",
        `departments`.`department_name` AS "Department",
        `reservations`.`reservation_departure_date` AS "Expected departure",
        `reservations`.`reservation_vehicle_type_required` AS "Vehicle Type",
        `reservations`.`reservation_destination` AS "Destination",
        `reservations`.`reservation_reason` AS "Reason",
        IFNULL(`reservations`.`reservation_notes`, '') AS "Notes"
    FROM `reservations`
    -- Join `reservations` and `faculty_members` where `faculty_member_id` is the same
    JOIN `faculty_members`
    ON `reservations`.`reservation_faculty_member_id` = `faculty_members`.`faculty_member_id`
    -- Join `departments` where `department_id` is the same
    JOIN `departments`
    ON `faculty_members`.`faculty_member_department_id` = `departments`.`department_id`
    -- Return the reservation if the departure date is less than the current date and the `reservation_id` is not in `sign_out_forms`
    WHERE `reservations`.`reservation_departure_date` < NOW()
    AND `reservations`.`reservation_id` NOT IN (SELECT `sign_out_form_reservation_id` FROM `sign_out_forms`);

-- -----------------------------------------------------
-- Parts usage form summary for last month
-- -----------------------------------------------------
DROP VIEW IF EXISTS `last_month_parts_usage_summary`;
CREATE VIEW `vehicle_management_database`.`last_month_parts_usage_summary` AS
    SELECT
        `parts_usage_forms`.`parts_usage_form_date` AS "Date",
        CONCAT(`mechanics`.`mechanic_forename`, ' ', `mechanics`.`mechanic_surname`) AS "Mechanic Name",
        `parts`.`part_type` AS "Part Type",
        `parts`.`part_name` AS "Part Name",
        `parts_usage_forms`.`parts_usage_form_part_quantity` AS "Quantity",
        CONCAT('£', ROUND(`parts_usage_forms`.`parts_usage_form_part_quantity` * `parts`.`part_cost`, 2)) AS "Cost"
    FROM `parts_usage_forms`
    -- Join `parts_usage_forms` and `parts` where `part_id` is the same
    JOIN `parts`
    ON `parts_usage_forms`.`parts_usage_form_part_id` = `parts`.`part_id`
    -- Join `parts_usage_forms` and `mechanics` where `mechanic_id` is the same
    JOIN `mechanics`
    ON `parts_usage_forms`.`parts_usage_form_mechanic_id` = `mechanics`.`mechanic_id`
    -- Only if used last month
    WHERE `parts_usage_forms`.`parts_usage_form_date` 
        >= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01')
    AND `parts_usage_forms`.`parts_usage_form_date`
        < DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
    -- Order by the date
    ORDER BY `parts_usage_forms`.`parts_usage_form_date` DESC;

-- -----------------------------------------------------
-- Vehicle maintenance summary for last month
-- -----------------------------------------------------
DROP VIEW IF EXISTS `last_month_vehicle_maintenance_summary`;
CREATE VIEW `vehicle_management_database`.`last_month_vehicle_maintenance_summary` AS
    SELECT
        `maintenance_logs`.`maintenance_log_date` AS "Log Date",
        `vehicles`.`vehicle_registration` AS "Registration",
        `maintenance_logs`.`maintenance_log_expected_return_date` AS "Exp. Return Date",
        MAX(`maintenance_detail_forms`.`maintenance_detail_form_completion_date`) AS "Actual Return",
        `maintenance_logs`.`maintenance_log_notes` AS "Maintenance Notes"
    FROM `maintenance_logs`
    -- Join `maintenance_logs` and `vehicles` where `vehicle_registration` is the same
    JOIN `vehicles`
    ON `maintenance_logs`.`maintenance_log_vehicle_registration` = `vehicles`.`vehicle_registration`
    -- Join `maintenance_logs` and `maintenance_detail_forms` where `maintenance_log_id` is the same
    JOIN `maintenance_detail_forms`
    ON `maintenance_logs`.`maintenance_log_id` = `maintenance_detail_forms`.`maintenance_detail_form_maintenance_log_id`
    -- Only if maintenance is finished and it was completed last month
    WHERE `maintenance_logs`.`maintenance_log_is_finished`
    AND `maintenance_detail_forms`.`maintenance_detail_form_completion_date`
        >= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01')
    AND `maintenance_detail_forms`.`maintenance_detail_form_completion_date`
        < DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
    -- Group by the log id and order by the date completed
    GROUP BY `maintenance_logs`.`maintenance_log_id`
    ORDER BY MAX(`maintenance_detail_forms`.`maintenance_detail_form_completion_date`) DESC;
