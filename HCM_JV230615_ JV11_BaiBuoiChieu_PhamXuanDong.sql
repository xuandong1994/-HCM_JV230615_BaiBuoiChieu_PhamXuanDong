create database if not exists test1;
use test1;
create table teacher(
 id int primary key auto_increment,
 name varchar(100) not null unique,
 email varchar(50) not null unique,
 phone varchar(11) not null unique,
 birthday date not null
);

create table class_room(
 id Int PRIMARY KEY AUTO_INCREMENT,
 name Varchar (200) not null,
 total_student Int default 0,
 start_date date,
 end_date date ,
 CONSTRAINT check_dates CHECK (end_date > start_date)
);

create table teacher_class(
 teacher_id int,
 class_room_id Int,
 start_date Date,
 end_date Date,
 time_slot_start Int,
 time_slot_end Int,
 foreign key (teacher_id) references teacher(id),
 foreign key (class_room_id) references class_room(id)
);

create table student(
 id Int PRIMARY KEY AUTO_INCREMENT,
 name Varchar(150) not null,
 email Varchar(100) not null unique,
 phone Varchar (50),
 Address varchar(100),
 gender Tinyint not null check( gender in (1,2)),
 class_room_id Int,
 birthday Date not null,
 foreign key (class_room_id) references class_room(id)
);

create table subjectt(
 id Int PRIMARY KEY AUTO_INCREMENT,
 name Varchar(200) not null unique
);

create table mark(
 student_id Int not null,
 subject_id Int not null,
 score int not null check (score >=0  and score <= 10),
  foreign key (student_id) references student(id),
  foreign key (subject_id) references subjectt(id)
);

-- YC2: Sử dụng câu lệnh thêm dữ liệu vào các bảng như sau: (10đ).
insert into  teacher(name,email, phone, birthday) values
	('Nguyễn Văn A', 'nguyenvana@email.com','0987654321', '1994-01-01'),
    ('Trần Thị B', 'tranthib@email.com','0987555431', '1985-05-10'),
    ('Lê Văn C', 'levanc@email.com','0987444321', '1992-09-15'),
    ('Phạm Thị D', 'phamthid@email.com','0984004321', '1988-11-20'),
    ('Hoàng Văn E', 'hoangvane@email.com','0984888321', '1990-03-25');
    
insert into class_room (name, total_student, start_date, end_date)
values
    ('Toán học', 30, '2023-09-01', '2023-12-15'),
    ('Tiếng Anh', 25, '2023-09-01', '2023-12-15'),
    ('Khoa học', 20, '2023-09-01', '2023-12-15'),
    ('Lịch sử', 15, '2023-09-01', '2023-12-15'),
    ('Địa lý', 18, '2023-09-01', '2023-12-15');

insert into student (name, email, phone,Address, gender, class_room_id, birthday)
values
    ('Nguyễn Thị X', 'nguyenthix@email.com', '0987654321','hà nội', 2, 1, '2005-02-12'),
    ('Trần Văn Y', 'tranvany@email.com', '0912345678','Hưng yên', 1, 3, '2004-07-23'),
    ('Lê Thị Z', 'lethiz@email.com', '0976543210','Ninh Bình', 2, 2, '2006-11-05'),
    ('Phạm Văn K', 'phamvank@email.com', '0901234567','Hà nam', 1, 4, '2003-09-15'),
    ('Vũ Thị M', 'vuthim@email.com', '0945678901','HCM', 2, 5, '2005-04-30'),
    ('Hoàng Văn N', 'hoangvann@email.com', '0965432109','Nghệ an', 1, 1, '2004-03-08'),
    ('Mai Thị P', 'maithip@email.com', '0932109876','Thanh hóa', 2, 3, '2006-08-17'),
    ('Đinh Văn Q', 'dinhvanq@email.com', '0918765432','Bình dương', 1, 2, '2003-12-22'),
    ('Nguyễn Văn S', 'nguyenvans@email.com', '0987654321','HCM', 1, 4, '2005-10-11'),
    ('Trần Thị T', 'tranthit@email.com', '0912345678','hà nội', 2, 5, '2006-06-26'),
    ('Lê Văn U', 'levanu@email.com', '0976543210','Bình phước', 1, 1, '2004-01-03'),
    ('Phạm Thị V', 'phamthiv@email.com', '0901234567','HCM', 2, 2, '2003-07-20'),
    ('Vũ Văn W', 'vuvanw@email.com', '0945678901','hà nội', 1, 3, '2005-05-14'),
    ('Hoàng Thị X', 'hoangthix@email.com', '0965432109','Nam Định', 2, 4, '2006-02-28'),
    ('Mai Văn Y', 'maivany@email.com', '0932109876','HCM', 1, 5, '2003-09-09');
    
insert into subjectt (name)
values
    ('Toán học'),
    ('Ngữ văn'),
    ('Hóa học');
    
insert into mark (student_id, subject_id, score)
VALUES
    (1, 1, 8),
    (1, 2, 7),
    (2, 1, 9),
    (2, 3, 6),
    (3, 2, 8),
    (3, 3, 7),
    (4, 1, 9),
    (4, 2, 7),
    (5, 3, 8),
    (5, 1, 6),
    (6, 2, 8),
    (6, 3, 7),
    (7, 1, 9),
    (7, 2, 7),
    (8, 3, 8),
    (8, 1, 6),
    (9, 2, 8),
    (9, 3, 7),
    (10, 1, 5),
    (10, 2, 8);
    
-- 1. Lấy ra danh sách Student có sắp xếp tăng dần theo Name gồm các cột sau: Id, Name, Email, Phone, Gender, BirthDay, Age (5đ)

select s.id,s.name, s.email, s.phone, s.gender, s.BirthDay, year(current_date())- year(s.BirthDay) age 
from Student s 
group by s.id,s.name, s.email, s.phone, s.gender, s.BirthDay
order by s.name;

-- 2. Lấy ra danh sách Teacher gồm: Id, Name, Phone, Email, BirthDay, Age,TotalCLass (5đ)

 select tc.id,tc.name, tc.email, tc.phone, tc.email, tc.BirthDay, year(current_date())- year(tc.BirthDay) age 
 from teacher tc ;
 
-- 3. Truy vấn danh sách class_room gồm: Id, Name, TotalStudent, StartDate, EndDate khai giảng năm 2023 (5đ)

select * from class_room where year(start_date) = 2023;

-- 4. Cập nhật cột ToalStudent trong bảng class_room = Tổng số Student của mỗi class_room theo Id của class_room(5đ)

update class_room c set total_student = (select count(*) from student s where s.class_room_id = c.id);

-- 5. Tạo View v_getStudentInfo thực hiện lấy ra danh sách Student gồm: Id, Name, Email, Phone, Address, Gender, BirthDay, ClassName, MarksAvg, 
-- Trong đó cột MarksAvg hiển thị như sau:
-- 0 < MarksAvg <=5 Loại Yếu
-- 5 < MarksAvg < 7.5 Loại Trung bình
-- 7.5 <= MarksAvg <= 8 Loại GIỏi
-- 8 < MarksAvg Loại xuất sắc (5đ)

create view v_getStudentInfo as  

select s.id, s.name, s.email, s.phone, s.address, s.gender, s.BirthDay, c.name classname,
case when avg(m.score) > 0 and avg(m.score) < 5 then 'yếu'
	 when avg(m.score) >= 5 and avg(m.score) < 7.5 then 'trung bình'	
	 when avg(m.score) >= 7.5 and avg(m.score) <= 8 then 'giỏi'
	 when avg(m.score) > 8 then 'xuất sắc ' end MarksAvg
 from student s join mark m on m.student_id = s.id
 join class_room c on c.id = s.class_room_id
 group by s.id, s.name, s.email, s.phone, s.address, s.gender, s.BirthDay, c.name ;

-- 6. View v_getStudentMax hiển thị danh sách Sinh viên có điểm trung bình >= 7.5 (5đ)

create view v_getStudentMax as  
select s.id, s.name, s.email, s.phone, s.address, s.gender, s.BirthDay, c.name ClassName, avg(m.score) MarksAvg
 from student s join mark m on m.student_id = s.id
 join class_room c on c.id = s.class_room_id 
 group by s.id, s.name, s.email, s.phone, s.address, s.gender, s.BirthDay, c.name
 having avg(m.score) >=7.5;

-- 7. Tạo thủ tục thêm mới dữ liệu vào bảng class_room (5đ)

DELIMITER //
create procedure add_class_room(
 in p_name varchar(255),
 in p_total_student int ,
 in p_start_date date,
 in p_end_date date 
)
begin
	insert into class_room (name,total_student,start_date,end_date) value
    (p_name,p_total_student,p_start_date,p_end_date);
end//
call add_class_room ('lớp x',0,'2023-11-01','2023-12-31')
-- select * from class_room;

-- 8. Tạo thủ tục cập nhật dữ liệu trên bảng student (5đ)

DELIMITER //
create procedure update_student(
 in p_id int,
 in p_name varchar(255),
 in p_email varchar(255) ,
 in p_phone varchar(11),
 in p_gender tinyint ,
 in p_class_room_id int,
 in p_birthday date
)
begin
	update student set
    name = p_name,
    email = p_email,
    phone = p_phone ,
    gender = p_gender,
    class_room_id = p_class_room_id ,
    birthday = p_birthday
    where id = p_id;
end//
call update_student(1,'Phạm Xuân Đông', 'dong@gmail.com', '0987654331', 1, 1, '1994-10-09');
-- select * from student;

-- 9. Tạo thủ tục xóa dữ liệu theo id trên bảng subject (5đ)

DELIMITER //
create procedure delete_subjectt(
	in p_id int
)
begin
	delete from subjectt where id = p_id;

end//

-- 10.Tạo thủ tục getStudentPaginate lấy ra danh sách sinh viên có phân trang gồm:
-- Id, Name, Email, Phone, Address, Gender, BirthDay, ClassName, Khi gọi thủ tuc truyền vào limit và page (15đ)

DELIMITER //
create procedure getStudentPaginate (
	in p_limit int,
    in p_page int
)
begin
	declare startt int;
	set startt = (p_page - 1) * p_limit;
    select s.id, s.email, s.phone, s.address, s.gender, s.BirthDay, c.name classname
    from student s join class_room c on s.class_room_id = c.id
    order by s.id
    limit startt, p_limit ;
end // 
call getStudentPaginate (8,1)