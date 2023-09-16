create database social_media;

use social_media;

create table account_type (
ID int,
account_type varchar(15)
);

alter table account_type
add constraint at_pk primary key(ID);

create table app_user(
ID varchar(100),
account_type_id int,
firstname varchar(50),
lastname varchar(50),
profile_name varchar(50),
signup_date date,
constraint au_pk primary key(ID),
constraint au_fk foreign key(account_type_id) references account_type(ID)
);


create table post(
ID varchar(100) primary key,
app_user_id varchar(100) not null,
post_type_id varchar(100) not null,
creation_date date not null,
caption text,
constraint p_fk foreign key(app_user_id) references app_user(ID)
);


create table post_type(
ID varchar(100) primary key,
post_type varchar(20)
);

alter table post
drop foreign key p_fk1;

alter table post
add constraint p_fk1 foreign key(post_type_id) references post_type(ID);


create table post_media(
ID varchar(100) primary key,
post_id varchar(100) not null,
filter_id varchar(50) not null,
media_type varchar(25) not null,
media_file blob,
post_position int not null,
latitude double,
longitude double,
post_validity int,
constraint pm_fk1 foreign key(post_id) references post(ID)
);


create table filter(
ID varchar(50) primary key,
filter_name varchar(20),
filter_details json
);

alter table post_media 
add constraint pm_fk2 foreign key(filter_id) references filter(ID);


create table effect(
ID varchar(50) primary key,
effect_name varchar(50)
);


create table post_media_effect(
post_media_id varchar(100),
effect_id varchar(50),
scale double,
constraint pme_pk primary key (post_media_id, effect_id),
constraint pme_fk1 foreign key(post_media_id) references post_media(ID),
constraint pme_fk2 foreign key(effect_id) references effect(ID)
);

describe post_media_effect;


create table comment(
ID varchar(100) primary key,
created_by_user_id varchar(100) not null,
post_id varchar(100) not null,
creation_date date not null,
comment text not null,
comment_replied_to_id varchar(100),
constraint c_fk1 foreign key(created_by_user_id) references app_user(ID),
constraint c_fk2 foreign key(post_id) references post(ID),
constraint c_fk3 foreign key(comment_replied_to_id) references comment(ID)
);


create table follower(
following_user_id varchar(100) not null,
followed_user_id varchar(100)not null,
constraint f_fk1 foreign key(following_user_id) references app_user(ID),
constraint f_fk2 foreign key(followed_user_id) references app_user(ID)
);

alter table follower 
add constraint f_pk primary key(following_user_id, followed_user_id);

describe follower;


create table reaction(
user_id varchar(100) not null,
post_id varchar(100) not null,
reaction_type varchar(20),
constraint r_pk primary key(user_id, post_id),
constraint r_fk1 foreign key(user_id) references app_user(ID),
constraint r_fk2 foreign key(post_id) references post(ID)
);


create table user_post_media_tag(
post_media_id varchar(100) not null,
app_user_id varchar(100) not null,
x_coordinate double not null,
y_coordinate double not null,
constraint upmt_pk primary key(post_media_id, app_user_id),
constraint upmt_fk1 foreign key(post_media_id) references post_media(ID),
constraint upmt_fk2 foreign key(app_user_id) references app_user(ID)
);


create table message_type(
ID varchar(20) primary key,
message_type varchar(20)
);


create table message(
sender_id varchar(100),
reciever_id varchar(100),
message_type_id varchar(20),
message_text text,
constraint m_pk primary key(sender_id, reciever_id),
constraint m_fk1 foreign key(sender_id) references app_user(ID),
constraint m_fk2 foreign key(reciever_id) references app_user(ID),
constraint m_fk3 foreign key(message_type_id) references message_type(ID)
);



create table post_mention(
post_id varchar(100),
mentioned_user_id varchar(100),
constraint pmen_pk primary key(post_id, mentioned_user_id),
constraint pmen_fk1 foreign key(post_id) references post(ID),
constraint pmen_fk2 foreign key(mentioned_user_id) references app_user(ID)
);


create table shared_to_whatsapp(
post_id varchar(100),
shared_by_user_id varchar(100),
constraint stw_pk primary key(post_id, shared_by_user_id),
constraint stw_fk1 foreign key(post_id) references post(ID),
constraint stw_fk2 foreign key(shared_by_user_id) references app_user(ID)
);

describe shared_to_whatsapp;


create table saved_post(
post_id varchar(100),
saved_post_user_id varchar(100),
constraint sp_pk primary key(post_id, saved_post_user_id),
constraint sp_fk1 foreign key(post_id) references post(ID),
constraint sp_fk2 foreign key(saved_post_user_id) references app_user(ID)
);






