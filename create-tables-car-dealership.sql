-- Create script for Car Dealership 

create table salesperson (
	staff_id SERIAL primary key, 
	first_name VARCHAR(100), 
	last_name VARCHAR(100)
);

create table service_record (
	service_record_id SERIAL primary key, 
	date DATE, 
	balance_history NUMERIC(6,2)
);

create table car (
	car_id SERIAL primary key, 
	make VARCHAR(100), 
	model VARCHAR(100), 
	color VARCHAR(50), 
	year numeric(4,0),
	service_record_id SERIAL, 
	foreign key (service_record_id) references service_record(service_record_id)
);

create table mechanic (
	mechanic_id SERIAL primary key, 
	first_name VARCHAR(100), 
	last_name VARCHAR(100)
);

create table maintenance (
	maintenance_id SERIAL primary key, 
	maint_descrip text, 
	maint_subtotal NUMERIC(6,2)
);

create table parts (
	part_id SERIAL primary key, 
	part_name VARCHAR(200), 
	part_inventory INTEGER, 
	part_price NUMERIC(6,2)
);

create table invoice (
	invoice_id SERIAL primary key, 
	date DATE, 
	staff_id SERIAL, 
	car_id SERIAL, 
	foreign key (staff_id) references salesperson(staff_id),
	foreign key (car_id) references car(car_id)
);

create table service_ticket (
	service_ticket_id SERIAL primary key, 
	service_total NUMERIC(6,2),
	car_id SERIAL, 
	mechanic_id SERIAL, 
	maintenance_id SERIAL, 
	part_id SERIAL,
	foreign key (car_id) references car(car_id),
	foreign key (mechanic_id) references mechanic(mechanic_id),
	foreign key (maintenance_id) references maintenance(maintenance_id), 
	foreign key (part_id) references parts(part_id)
);

create table customer (
	customer_id SERIAL primary key, 
	invoice_id SERIAL, 
	service_ticket_id SERIAL, 
	foreign key (invoice_id) references invoice(invoice_id), 
	foreign key (service_ticket_id) references service_ticket(service_ticket_id)
);


alter table service_record
rename date to service_record_date

alter table invoice 
rename date to invoice_date

alter table car 
rename year to car_year

alter table service_ticket 
alter column service_total set data type numeric(8,2)

alter table customer 
add column first_name VARCHAR(50),
add column last_name VARCHAR(50);



