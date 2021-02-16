use apiRouting;
drop table id;
drop table serviceStatus;
drop table serviceConfig;
drop table serviceContent;
drop table serverConfig;
CREATE TABLE IF NOT EXISTS `serviceContent` (
  `id` bigint NOT NULL,
  `serviceName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`serviceName`, `id`))
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS `serverConfig` (
  `id` bigint NOT NULL,
  `hostName` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `serviceConfig` (
  `id` BIGINT NOT NULL,
  `hostId` bigint NOT NULL,
  `port` VARCHAR(45) NULL,
  INDEX `fk_serviceContent_serverConfig1_idx` (`hostId` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_serviceContent_serverConfig1`
    FOREIGN KEY (`hostId`)
    REFERENCES `serverConfig` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `serviceStatus` (
  `id` BIGINT NOT NULL,
  `status` INT NULL,
  `updateTime` timestamp NULL,
  CONSTRAINT `fk_serviceStatus_serverConfig1`
    FOREIGN KEY (`id`)
    REFERENCES `serviceConfig` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  INDEX `fk_serviceStatus_serviceConfig1_idx` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`))
ENGINE = MEMORY;


CREATE TABLE IF NOT EXISTS `id` (
  `name` VARCHAR(45) NOT NULL,
  `id` BIGINT default 1,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;



insert into serverConfig value(1,"generalBackend","192.168.50.20");
insert into id(name) value('id');
insert into id(name) value('serviceConfig');


drop procedure updateServiceContent;
drop procedure genID;
drop procedure enableService;
drop procedure disableService;


DELIMITER //
Create procedure updateServiceContent(IN paraId int,IN paraServiceName varchar(255))
begin
declare serviceContentExist int;
select count(0) into serviceContentExist from serviceContent where id=paraId and serviceName=paraServiceName;
if serviceContentExist=0 then
insert into serviceContent value(paraID,paraServiceName);
end if;
END//

DELIMITER //
Create procedure genID(IN paraName varchar(45),out paraId bigint)
begin
declare serviceContentExist int;
select id into paraId from id where name=paraName;
update id set id=id+1 where name=paraName;

END//

DELIMITER //
Create procedure enableService(IN paraHostId bigint,IN paraPort int)
begin

declare serviceId bigint;

select id into serviceId from serviceConfig where hostId=paraHostId and port=paraPort limit 1;
if serviceId is null then
call genID("serviceConfig",serviceId);
insert into serviceConfig(id,hostId,port) value(serviceId,paraHostId,paraPort);
insert into serviceStatus(id,status,updateTime) value(serviceId,1,now());
end if;
select serviceId;
END//



DELIMITER //
Create procedure disableService(IN paraId bigint)
begin

declare serviceId bigint;
delete from serviceStatus where id=paraId;
delete from serviceConfig where id=paraId;
delete from serviceContent where id=paraId;

END//




call enableService(1,3000);
call disableService(1);
