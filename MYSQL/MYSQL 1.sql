use rana_university;
select * from students;
select concat(F_name," ",L_name) from students;
select concat("full name ", f_name, " ",L_name) from students;
select concat("name = ", f_name, " ",L_name) from students;
select concat(f_name," ",L_name," ", Age," ", Gender) from students;
select concat_ws(" ",f_name,L_name,Age,Gender) as "Details" from students;
select char_length("Rama");
select char_length(F_name) from students;
select F_name,char_length(F_name) from students;
select F_name,char_length(L_name) from students;
select concat_ws(" ",F_name,L_name) as "Details" from students;
select right ("rama", 1);
select left ("rama", 2);
select right(F_name,1) from students;
select left(L_name, 1) from students;
select left(L_name, 1) from students;
select left(right(L_name,2),1) from students;
select substring("Rama", 2, 2);
select substring(F_name, -4,4) from students;
select substring(F_name, -2,2) from students;
select substring(F_name, char_length(F_name)/2,1) from students;
select F_name, reverse (F_name) from students;
insert into students ( F_name,L_name,Age,Gender,Course) values ("Madam", "rita", 45, "Female", "Btech"),("Nitin", "Kumar", 45, "Male", "Btech");
select * from students where F_name = reverse (F_name);
select * from students where char_length(F_name)>5;
select concat(F_name," ",L_name)as FullName,char_length(concat(F_name, " ", L_name)) from students;
select* from students where (char_length(concat(F_name," ",L_name)as FullName)) % 2 <> 0;
select* from students where char_length(L_name)%2 =0;