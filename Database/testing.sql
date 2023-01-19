INSERT INTO `vehicle_management_database`.`trip_completion_forms` (`trip_completion_form_reservation_id`, `trip_completion_form_vehicle_registration`, `trip_completion_form_faculty_member_id`, `trip_completion_form_odometer_start`, `trip_completion_form_odometer_end`, `trip_completion_form_fuel_purchased`, `trip_completion_form_credit_card_number_used`, `trip_completion_form_fuel_reciept`, `trip_completion_form_maintenance_complaints`, `trip_completion_form_completion_date`, `trip_completion_form_notes`)
VALUES
    (1, 'AB123CD', 1, 100000, 100025, null, null, null, 'No complaints', '2022-01-01', 'Everything went smoothly');

SELECT * FROM `available_vehicles`;