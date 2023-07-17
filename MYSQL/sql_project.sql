CREATE DATABASE bank;
use bank;

CREATE TABLE customer
   (custid VARCHAR(6),
       fname VARCHAR(30),
       mname VARCHAR(30),
       ltname VARCHAR(30),
       city VARCHAR(15),
       mobileno VARCHAR(10),
       occupation VARCHAR(10),
       dob DATE,
      CONSTRAINT customer1_custid_pk PRIMARY KEY(custid));
	
CREATE TABLE branch
   (
    bid VARCHAR(6),
    bname VARCHAR(30),
    bcity VARCHAR(30),
    CONSTRAINT branch_bid_pk PRIMARY KEY(bid) 
   );
   
CREATE TABLE account
   (
      acnumber VARCHAR(6),
      custid  VARCHAR(6),
      bid VARCHAR(6),
      opening_balance INT(7),
      aod DATE,
      atype VARCHAR(10),
      astatus VARCHAR(10),
      CONSTRAINT account_acnumber_pk PRIMARY KEY(acnumber),
      CONSTRAINT account_custid_fk FOREIGN KEY(custid) REFERENCES customer(custid),
      CONSTRAINT account_bid_fk FOREIGN KEY(bid) REFERENCES branch(bid) 
    );
    
CREATE TABLE trandetails
    (   
     tnumber VARCHAR(6),
     acnumber VARCHAR(6),
     dot DATE,
     medium_of_transaction VARCHAR(20),
     transaction_type VARCHAR(20),
     transaction_amount INT(7),    
     CONSTRAINT trandetails_tnumber_pk PRIMARY KEY(tnumber),
     CONSTRAINT trandetails_acnumber_fk FOREIGN KEY(acnumber) REFERENCES account(acnumber)  
    );
    
CREATE TABLE loan
   (
   
    custid VARCHAR(6),
    bid VARCHAR(6),
    loan_amount INT(7),
    CONSTRAINT loan_customer_custid_bid_pk PRIMARY KEY(custid,bid),
    CONSTRAINT loan_custid_fk FOREIGN KEY(custid) REFERENCES  customer(custid),
    CONSTRAINT loan_bid_fk FOREIGN KEY(bid) REFERENCES  branch(bid)
   );
   
INSERT INTO customer VALUES('C00001','Ramesh','Chandra','Sharma','Delhi','9543198345','Service','1976-12-06'),
('C00002','Avinash','Sunder','Minha','Delhi','9876532109','Service','1974-10-16'),
('C00003','Rahul',null,'Rastogi','Delhi','9765178901','Student','1981-09-26'),
('C00004','Parul',null,'Gandhi','Delhi','9876532109','Housewife','1976-11-03'),
('C00005','Naveen','Chandra','Aedekar','Mumbai','8976523190','Service','1976-09-19'),
('C00006','Chitresh',null,'Barwe','Mumbai','7651298321','Student','1992-11-06'),
('C00007','Amit','Kumar','Borkar','Mumbai','9875189761','Student','1981-09-06'),
('C00008','Nisha',null,'Damle','Mumbai','7954198761','Service','1975-12-03'),
('C00009','Abhishek',null,'Dutta','Kolkata','9856198761','Service','1973-05-22'),
('C00010','Shankar',null,'Nair','Chennai','8765489076','Service','1976-07-12');

INSERT INTO branch VALUES('B00001','Asaf ali road','Delhi'),('B00002','New delhi main branch','Delhi'),
('B00003','Delhi cantt','Delhi'),('B00004','Jasola','Delhi'),('B00005','Mahim','Mumbai')
,('B00006','Vile parle','Mumbai'),('B00007','Mandvi','Mumbai'),
('B00008','Jadavpur','Kolkata'),('B00009','Kodambakkam','Chennai');

INSERT INTO account VALUES('A00001','C00001','B00001',1000,'2012-12-15','Saving','Active'),
('A00002','C00002','B00001',1000,'2012-06-12','Saving','Active'),
('A00003','C00003','B00002',1000,'2012-05-17','Saving','Active'),
('A00004','C00002','B00005',1000,'2013-01-27','Saving','Active'),
('A00005','C00006','B00006',1000,'2012-12-17','Saving','Active'),
('A00006','C00007','B00007',1000,'2010-08-12','Saving','Suspended'),
('A00007','C00007','B00001',1000,'2012-10-02','Saving','Active'),
('A00008','C00001','B00003',1000,'2009-11-09','Saving','Terminated'),
('A00009','C00003','B00007',1000,'2008-11-30','Saving','Terminated'),
('A00010','C00004','B00002',1000,'2013-03-01','Saving','Active');

INSERT INTO trandetails VALUES('T00001','A00001','2013-01-01','Cheque','Deposit',2000),
('T00002','A00001','2013-02-01','Cash','Withdrawal',1000),
('T00003','A00002','2013-01-01','Cash','Deposit',2000),
('T00004','A00002','2013-02-01','Cash','Deposit',3000),
('T00005','A00007','2013-01-11','Cash','Deposit',7000),
('T00006','A00007','2013-01-13','Cash','Deposit',9000),
('T00007','A00001','2013-03-13','Cash','Deposit',4000),
('T00008','A00001','2013-03-14','Cheque','Deposit',3000),
('T00009','A00001','2013-03-21','Cash','Withdrawal',9000),
('T00010','A00001','2013-03-22','Cash','Withdrawal',2000),
('T00011','A00002','2013-03-25','Cash','Withdrawal',7000),
('T00012','A00007','2013-03-26','Cash','Withdrawal',2000);

INSERT INTO loan VALUES('C00001','B00001',100000),
('C00002','B00002',200000),('C00009','B00008',400000),
('C00010','B00009',500000),('C00001','B00003',600000),
('C00002','B00001',600000);

Select custid, fname, mname, dob 
     From customer 
     Order By Extract(year From dob), fname ASC;

Select custid, fname, if(mname is not null, mname, ltname)
As Cust_Name
From customer;

select * from customer;
select * from branch;
select * from account;
select * from trandetails;
select * from loan;

Select account.acnumber, customer.custid, customer.fname, customer.ltname, account.aod
From account
Inner join customer 
On account.custid = customer.custid;

Select 
		(Select count(city)
		From customer
		Where city="Delhi")
As Cust_Count;
Select account.custid, customer.fname, account.acnumber
From account, customer
Where account.custid = customer.custid
And day(aod) > 15;
 
 Select distinct customer.fname, customer.city, account.acnumber
from account, customer
where account.custid = customer.custid
And not(occupation="business" or occupation="service" or occupation="student");

Select bcity, count(*)
as Count_Branch 
from branch
Group By bcity;
Select account.acnumber, customer.fname, customer.ltname
from account, customer
where account.custid = customer.custid
and astatus = "Active";

Select customer.custid, customer.fname, account.acnumber
from account, customer
where account.custid = customer.custid
and astatus = "Terminated";