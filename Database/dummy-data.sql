-- -----------------------------------------------------
-- Vehicles table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`vehicles` (`vehicle_registration`, `vehicle_type`, `vehicle_make`, `vehicle_model`, `vehicle_year`, `vehicle_colour`, `vehicle_fuel_type`, `vehicle_odometer_reading`, `vehicle_last_maintenance_date`, `vehicle_registration_date`, `vehicle_acquisition_date`, `vehicle_availability`)
VALUES
    ('AB123CD', 'Sedan', 'Toyota', 'Camry', '2010', 'Black', 'Gasoline', 100000, '2022-01-01', '2011-02-01', '2021-03-01', 1),
    ('CD456EF', 'SUV', 'Ford', 'Explorer', '2012', 'White', 'Gasoline', 10000, '2022-01-01', '2013-02-01', '2019-03-01', 1),
    ('EF789GH', 'Truck', 'Chevrolet', 'Silverado', '2015', 'Red', 'Diesel', 200000, '2022-01-01', '2015-02-01', '2020-03-01', 1),
    ('GH123IJ', 'Hatchback', 'Honda', 'Fit', '2008', 'Blue', 'Gasoline', 50000, '2022-01-01', '2008-02-01', '2021-03-01', 1),
    ('IJ456KL', 'Convertible', 'BMW', '3 series', '2011', 'Silver', 'Gasoline', 80000, '2022-01-01', '2011-02-01', '2020-03-01', 1),
    ('KL789MN', 'Sedan', 'Nissan', 'Altima', '2013', 'Gray', 'Gasoline', 60000, '2022-01-01', '2013-02-01', '2019-03-01', 1),
    ('MN123OP', 'SUV', 'Jeep', 'Grand Cherokee', '2018', 'Black', 'Gasoline', 40000, '2022-01-01', '2018-02-01', '2018-03-01', 1),
    ('OP456QR', 'Truck', 'Ram', '1500', '2020', 'White', 'Gasoline', 20000, '2022-01-01', '2020-02-01', '2020-03-01', 1),
    ('QR789ST', 'Crossover', 'Mazda', 'CX-5', '2017', 'Red', 'Gasoline', 30000, '2022-01-01', '2017-02-01', '2017-03-01', 0),
    ('ST123UV', 'Sedan', 'Tesla', 'Model S', '2019', 'Black', 'Electric', 15000, '2022-01-01', '2019-02-01', '2019-03-01', 0);

-- -----------------------------------------------------
-- Department table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`departments` (`department_name`, `department_head_id`, `department_phone`, `department_email`, `department_location`)
VALUES
    ('Computer Science', 1, '+44 1234 567890', 'cs@ncu.edu', 'Building A'),
    ('Engineering', 2, '+44 1234 567891', 'engineering@ncu.edu', 'Building B'),
    ('Business', 3, '+44 1234 567892', 'business@ncu.edu', 'Building C');

-- -----------------------------------------------------
-- Faculty Members table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`faculty_members` (`faculty_member_department_id`, `faculty_member_forename`, `faculty_member_surname`, `faculty_member_email`, `faculty_member_phone`, `faculty_member_travel_auth`)
VALUES
    (1, 'Jeremy', 'Clarkson', 'jclarkson@ncu.edu', '+44 1234 567894', 1),
    (2, 'Hayley', 'Smith', 'hayley.smith@ncu.edu', '+44 1234 567895', 1),
    (3, 'Bob', 'Davids', 'bob.davids@ncu.edu', '+44 1234 567896', 0);    

-- -----------------------------------------------------
-- Mechanics table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`mechanics` (`mechanic_forename`, `mechanic_surname`, `mechanic_email`, `mechanic_phone`)
VALUES
    ('John', 'Smith', 'john.smith@hotmail.com', '+44 1234 563990'),
    ('Jane', 'Doe', 'jane.doe@hotmail.com', '+44 2345 678901'),
    ('Bob', 'Johnson', 'bob.johnson@icloud.com', '+44 3456 789012');

-- -----------------------------------------------------
-- Staff Members table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`staff_members` (`staff_member_forename`, `staff_member_surname`, `staff_member_email`, `staff_member_phone`)
VALUES
    ('John', 'Doe', 'johndoe@gmail.com', '+44 1234 567890'),
    ('Jane', 'Smith', 'janesmith@hotmail.com', '+44 2345 628901'),
    ('John', 'Johnson', 'jjohnson@gmail.com', '+44 3456 782912');


-- -----------------------------------------------------
-- Reservations table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`reservations` (`reservation_department_id`, `reservation_faculty_member_id`, `reservation_departure_date`, `reservation_vehicle_type_required`, `reservation_destination`, `reservation_reason`, `reservation_status`, `reservation_notes`)
VALUES
    (1, 1, '2022-01-01', 'Sedan', 'New York City', 'Research Paper Presentation', 'Accepted', null),
    (2, 2, '2022-01-15', 'SUV', 'Los Angeles', 'Off-Campus Learning Centre Visit', 'Accepted', null),
    (3, 3, '2022-02-01', 'Truck', 'Houston', 'Student Field Trip', 'Accepted', null),
    (1, 1, '2022-02-01', 'Truck', 'Chicago', 'Student Field Trip', 'Accepted', null),
    (2, 2, '2022-12-01', 'Hatchback', 'Miami', 'Conference', 'Accepted', null),
    (1, 1, '2022-12-15', 'Convertible', 'Seattle', 'Off-Campus Learning Centre Visit', 'Accepted', null),
    (3, 3, '2023-01-01', 'Sedan', 'Boston', 'Student Field Trip', 'Accepted', null);

-- -----------------------------------------------------
-- Sign Out Forms table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`sign_out_forms` (`sign_out_form_vehicle_registration`, `sign_out_form_reservation_id`, `sign_out_form_faculty_member_id`, `sign_out_form_staff_member_id`, `sign_out_form_date`, `sign_out_form_odometer_reading`, `sign_out_form_notes`)
VALUES
    ('AB123CD', 1, 1, 1, '2022-01-01', 100000, 'Research Paper Presentation'),
    ('CD456EF', 2, 2, 2, '2022-01-15', 10000, 'Off-Campus Learning Centre Visit'),
    ('EF789GH', 3, 3, 3, '2022-02-01', 200000, 'Student Field Trip'),
    ('GH123IJ', 5, 2, 3, '2022-12-01', 50000, 'Conference'),
    ('IJ456KL', 6, 1, 3, '2022-12-15', 80000, 'Off-Campus Learning Centre Visit'),
    ('KL789MN', 7, 3, 2, '2023-01-01', 60000, 'Student Field Trip');

-- -----------------------------------------------------
-- Trip Completion Forms table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`trip_completion_forms` (`trip_completion_form_reservation_id`, `trip_completion_form_vehicle_registration`, `trip_completion_form_faculty_member_id`, `trip_completion_form_odometer_start`, `trip_completion_form_odometer_end`, `trip_completion_form_fuel_purchased`, `trip_completion_form_credit_card_number_used`, `trip_completion_form_fuel_reciept`, `trip_completion_form_maintenance_complaints`, `trip_completion_form_completion_date`, `trip_completion_form_notes`)
VALUES
    (1, 'AB123CD', 1, 100000, 100025, null, null, null, 'No complaints', '2022-01-01', 'Everything went smoothly'),
    (2, 'CD456EF', 2, 10000, 10050, 25, '1234123412341234', 'receipts\fuel-receipt.jpeg', 'Tire pressure warning light came on', '2022-01-15', 'Had to stop at gas station to fill tires'),
    (3, 'EF789GH', 3, 200000, 200022, null, null, null, 'No complaints', '2022-02-01', 'Trip was uneventful'),
    (5, 'GH123IJ', 2, 50000, 50123, null, null, null, 'No complaints', '2022-12-01', 'Everything went smoothly'),
    (6, 'IJ456KL', 1, 80000, 80040, 25, '1234123412341234', 'receipts\fuel-receipt2.jpeg', 'Tire pressure warning light came on', '2022-12-15', 'Had to stop at gas station to fill tires'),
    (7, 'KL789MN', 3, 60000, 60072, null, null, null, 'No complaints', '2023-01-01', 'Trip was uneventful');

-- -----------------------------------------------------
-- Maintenance Logs table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`maintenance_logs` (`maintenance_log_vehicle_registration`, `maintenance_log_date`, `maintenance_log_expected_return_date`,  `maintenance_log_is_finished`, `maintenance_log_notes`)
VALUES
    ('AB123CD', '2022-05-01', '2022-11-03', 1, 'Regular maintenance check'),
    ('CD456EF', '2022-05-02', '2022-12-05', 1, 'Check engine light on'),
    ('EF789GH', '2022-05-03', '2022-12-05', 1, 'Tire rotation and oil change');

-- -----------------------------------------------------
-- Maintenance Detail Forms table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`maintenance_detail_forms` (`maintenance_detail_form_id`, `maintenance_detail_form_maintenance_log_id`, `maintenance_detail_form_mechanic_id`, `maintenance_detail_form_description`, `maintenance_detail_form_parts_used`, `maintenance_detail_form_completion_date`)
VALUES
    (1, 1, 1, 'Changed oil and oil filter', 'Oil filter: Purolator L14459, Oil: 5W-30', '2022-11-01'),
    (2, 2, 2, 'Replaced spark plugs', 'Spark plugs: NGK BKR5E-11', '2022-12-02'),
    (3, 3, 3, 'Replaced brake pads and rotors', 'Brake pads: Bosch QuietCast BP926, Rotors: Bosch QuietCast PRT5127', '2022-12-03');

-- -----------------------------------------------------
-- Parts table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`parts` (`part_id`, `part_name`, `part_type`, `part_quantity`, `part_minimum_quantity`, `part_cost`)
VALUES
    (1, 'Oil filter', 'filter', 10, 5, 2.5),
    (2, 'Air filter', 'filter', 15, 8, 5),
    (3, 'Fuel filter', 'filter', 12, 6, 7.5),
    (4, 'Timing belt', 'belt', 8, 4, 20),
    (5, 'Drive belt', 'belt', 10, 5, 15);

-- -----------------------------------------------------
-- Parts Usage Forms table dummy data
-- -----------------------------------------------------
INSERT INTO `vehicle_management_database`.`parts_usage_forms` (`parts_usage_form_part_id`, `parts_usage_form_mechanic_id`, `parts_usage_form_maintenance_detail_form_id`, `parts_usage_form_part_quantity`, `parts_usage_form_date`)
VALUES
    (1, 1, 1, 2, '2022-11-01'),
    (2, 2, 2, 1, '2022-12-02'),
    (3, 3, 3, 4, '2022-12-03');
