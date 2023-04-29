insert into salesperson (first_name, last_name)
values ('Todd', 'Toddington');
insert into salesperson (first_name, last_name)
values ('Jeff', 'Jeffington');
insert into salesperson (first_name, last_name)
values ('Tommy', 'Tomlinson');

insert into service_record (service_record_date, balance_history)
values ('2023-01-14', 863.24);
insert into service_record (service_record_date, balance_history)
values ('2023-02-23', 421.09);
insert into service_record (service_record_date, balance_history)
values ('2023-03-03', 201.98);

insert into mechanic (first_name, last_name)
values ('Sammy', 'Samson');
insert into mechanic (first_name, last_name)
values ('Jackie', 'Jackson');
insert into mechanic (first_name, last_name)
values ('Peter', 'Peterson');

insert into maintenance (maint_descrip, maint_subtotal)
values(
	'Transmission was totally shot, radiator replaced due to overheat, CAM shafts replaced.', 
	9867.68
);
insert into maintenance (maint_descrip, maint_subtotal)
values(
	'Front bumper buffed and repainted, as well as replaced headlight, grill, front brakes and rotors',
	4593.90
);
insert into maintenance (maint_descrip, maint_subtotal)
values(
	'Full set of new offroad, specialty tires. Oil change and transmission flush',
	5209.43
);

insert into parts (part_name, part_inventory, part_price)
values('Transmission', 23, 5600.90);
insert into parts (part_name, part_inventory, part_price)
values('Radiator', 36, 1500.89);
insert into parts (part_name, part_inventory, part_price)
values('Front Bumper', 41, 3294.32);
insert into parts (part_name, part_inventory, part_price)
values ('Offroad Tire Set', 62, 3050);

insert into car (make, model, color, car_year, service_record_id)
values('Chevy', 'Malibu', 'Black', '2018', 3);
insert into car (make, model, color, car_year, service_record_id)
values('Porsche', '911', 'Red', '2021', 1);
insert into car (make, model, color, car_year, service_record_id)
values('Ford', 'Focus', 'Silver', '2014', 2);

insert into invoice(invoice_date, staff_id, car_id)
values('2023-01-15', 1, 2);
insert into invoice(invoice_date, staff_id, car_id)
values('2023-02-25', 2, 3);
insert into invoice(invoice_date, staff_id, car_id)
values('2023-03-20', 3, 1);

create function calculate_service_total(
	maint_subtotal numeric(6,2), 
	parts_price numeric(6,2), 
	maintenance_id INT, 
	part_id INT, 
	car_id INT,
	mechanic_id INT)
returns int
as $$
declare result numeric(7,2);
begin
	select round(maint_subtotal + parts_price, 2) into result;
	insert into service_ticket (service_total, maintenance_id, part_id, car_id, mechanic_id) 
	values (result, maintenance_id, part_id, car_id, mechanic_id);
	return result;
end;
$$ language plpgsql

select calculate_service_total(9867.68, 3050, 1, 1, 1, 2);
select calculate_service_total(4593.90, 3294.24, 2, 3, 2, 3);
select calculate_service_total(5209.43, 3050.00, 3, 2, 3, 1);

create function customer_full_name(_invoice_id int, _service_ticket_id int, full_name VARCHAR(100))
returns VOID
as $$
begin 
	update customer 
	set first_name = split_part(full_name, ' ', 1), last_name = split_part(full_name, ' ', 2)
	where _invoice_id = invoice_id and _service_ticket_id = service_ticket_id;
end
$$ language plpgsql

drop function customer_full_name

select customer_full_name(1, 1, 'Dwight Schrute');
select customer_full_name(2, 2, 'Kenny Rogers');
select customer_full_name(3, 3, 'Johhny Bravo');

select * from customer

insert into customer(customer_id, service_ticket_id, invoice_id)
values(1, 1, 1);
insert into customer(customer_id, service_ticket_id, invoice_id)
values(2, 2, 2);
insert into customer(customer_id, service_ticket_id, invoice_id)
values(3, 3, 3);













