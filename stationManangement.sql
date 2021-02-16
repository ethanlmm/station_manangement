
-- -----------------------------------------------------
-- Table `stationManangement`.`Station`
-- ------------------------------	-----------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Station` (
  `id_station` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `fk_location` INT NOT NULL,
  `id_admin` INT NOT NULL,
  PRIMARY KEY (`id_station`),
  INDEX `fk_Station_location1_idx` (`fk_location` ASC) ,
  INDEX `fk_Station_Admin1_idx` (`id_admin` ASC) ,
  CONSTRAINT `fk_Station_location1`
    FOREIGN KEY (`fk_location`)
    REFERENCES `stationManangement`.`Location` (`id_location`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Station_Admin1`
    FOREIGN KEY (`id_admin`)
    REFERENCES `stationManangement`.`Admin` (`id_admin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `stationManangement`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Location` (
  `id_location` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `street1` VARCHAR(45) NULL,
  `street2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `zipcode` INT NULL,
  PRIMARY KEY (`id_location`));


-- -----------------------------------------------------
-- Table `stationManangement`.`Sensor_inckude`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Sensor_inckude` (
  `idStation_include` INT NOT NULL,
  PRIMARY KEY (`idStation_include`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stationManangement`.`Sensor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Sensor` (
  `idSensor` INT NOT NULL,
  `Sensor_Data_fk` INT NULL,
  PRIMARY KEY (`idSensor`));


-- -----------------------------------------------------
-- Table `stationManangement`.`Sensor_Data`
-- -----------------------------------------------------



-- -----------------------------------------------------
-- Table `stationManangement`.`timestamps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);


-- -----------------------------------------------------
-- Table `stationManangement`.`Mananger`
-- -----------------------------------------------------



-- -----------------------------------------------------
-- Table `stationManangement`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Location` (
  `id_location` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `street1` VARCHAR(45) NULL,
  `street2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `zipcode` INT NULL,
  PRIMARY KEY (`id_location`));


-- -----------------------------------------------------
-- Table `stationManangement`.`Admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Admin` (
  `id_admin` INT NOT NULL,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  PRIMARY KEY (`id_admin`));


-- -----------------------------------------------------
-- Table `stationManangement`.`Station`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Station` (
  `id_station` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `fk_location` INT NOT NULL,
  `id_admin` INT NOT NULL,
  PRIMARY KEY (`id_station`),
  INDEX `fk_Station_location1_idx` (`fk_location` ASC) ,
  INDEX `fk_Station_Admin1_idx` (`id_admin` ASC) ,
  CONSTRAINT `fk_Station_location1`
    FOREIGN KEY (`fk_location`)
    REFERENCES `stationManangement`.`Location` (`id_location`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Station_Admin1`
    FOREIGN KEY (`id_admin`)
    REFERENCES `stationManangement`.`Admin` (`id_admin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `stationManangement`.`Vendor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Vendor` (
  `id_vendor` INT NOT NULL,
  `contact` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_vendor`));


-- -----------------------------------------------------
-- Table `stationManangement`.`Catagory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Catagory` (
  `id_catagory` INT NOT NULL,
  `category` VARCHAR(45) NULL,
  PRIMARY KEY (`id_catagory`));


-- -----------------------------------------------------
-- Table `stationManangement`.`Device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Device` (
  `id_device` INT NOT NULL,
  `id_vendor` INT NOT NULL,
  `id_catagory` INT NOT NULL,
  `model` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id_device`, `id_vendor`, `id_catagory`),
  INDEX `fk_Device_Vendor1_idx` (`id_vendor` ASC) ,
  INDEX `fk_Device_Catagory1_idx` (`id_catagory` ASC) ,
  CONSTRAINT `fk_Device_Vendor1`
    FOREIGN KEY (`id_vendor`)
    REFERENCES `stationManangement`.`Vendor` (`id_vendor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Device_Catagory1`
    FOREIGN KEY (`id_catagory`)
    REFERENCES `stationManangement`.`Catagory` (`id_catagory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `stationManangement`.`DeviceIndex`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`DeviceIndex` (
  `id_index` INT NOT NULL,
  `id_device` INT NOT NULL,
  `sensor_location` VARCHAR(45) NULL,
  `configuration` JSON NULL,
  PRIMARY KEY (`id_index`, `id_device`),
  INDEX `fk_DeviceIndex_Device1_idx` (`id_device` ASC) VISIBLE,
  CONSTRAINT `fk_DeviceIndex_Device1`
    FOREIGN KEY (`id_device`)
    REFERENCES `stationManangement`.`Device` (`id_device`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stationManangement`.`StationData`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`StationData` (
  `id_station` INT NOT NULL,
  `id_device` INT NOT NULL,
  `id_time_tag` TIMESTAMP NOT NULL,
  `data` JSON NULL,
  PRIMARY KEY (`id_station`, `id_device`),
  INDEX `fk_StationData_Station1_idx` (`id_station` ASC) ,
  INDEX `fk_StationData_SensorIndex1_idx` (`id_device` ASC) ,
  CONSTRAINT `fk_StationData_Station1`
    FOREIGN KEY (`id_station`)
    REFERENCES `stationManangement`.`Station` (`id_station`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StationData_SensorIndex1`
    FOREIGN KEY (`id_device`)
    REFERENCES `stationManangement`.`DeviceIndex` (`id_index`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `stationManangement`.`StationGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`StationGroup` (
  `id_group` INT NOT NULL,
  `id_station` INT NOT NULL,
  PRIMARY KEY (`id_group`, `id_station`),
  INDEX `fk_include_Station1_idx` (`id_station` ASC) ,
  CONSTRAINT `fk_include_Station1`
    FOREIGN KEY (`id_station`)
    REFERENCES `stationManangement`.`Station` (`id_station`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `stationManangement`.`StationManangement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`StationManangement` (
  `id_group` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id_group`),
  CONSTRAINT `fk_stationGroup_include1`
    FOREIGN KEY (`id_group`)
    REFERENCES `stationManangement`.`StationGroup` (`id_group`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `stationManangement`.`EventCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`EventCategory` (
  `id_event_category` INT NOT NULL,
  `event_category` VARCHAR(45) NULL,
  PRIMARY KEY (`id_event_category`));


-- -----------------------------------------------------
-- Table `stationManangement`.`Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Event` (
  `id_event` VARCHAR(45) NOT NULL,
  `time` TIMESTAMP NOT NULL,
  `category` INT NOT NULL,
  `priority` SMALLINT NOT NULL,
  `text` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_event`, `time`),
  INDEX `fk_Event_EventCategory1_idx` (`category` ASC),
  CONSTRAINT `fk_Event_EventCategory1`
    FOREIGN KEY (`category`)
    REFERENCES `stationManangement`.`EventCategory` (`id_event_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `stationManangement`.`StationLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`StationLog` (
  `id_event` VARCHAR(45) NOT NULL,
  `time` TIMESTAMP NOT NULL,
  `id_station` INT NOT NULL,
  INDEX `fk_StationLog_Event1_idx` (`id_event` ASC, `time` ASC),
  INDEX `fk_StationLog_Station1_idx` (`id_station` ASC),
  CONSTRAINT `fk_StationLog_Event1`
    FOREIGN KEY (`id_event` , `time`)
    REFERENCES `stationManangement`.`Event` (`id_event` , `time`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StationLog_Station1`
    FOREIGN KEY (`id_station`)
    REFERENCES `stationManangement`.`Station` (`id_station`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `stationManangement`.`AdminGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`AdminGroup` (
  `id_group` INT NOT NULL,
  `id_admin` INT NOT NULL,
  PRIMARY KEY (`id_group`, `id_admin`),
  INDEX `fk_StationGroupInclude_copy1_ManangerGroup1_idx` (`id_admin` ASC),
  CONSTRAINT `fk_StationGroupInclude_copy1_ManangerGroup1`
    FOREIGN KEY (`id_admin`)
    REFERENCES `stationManangement`.`Admin` (`id_admin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `stationManangement`.`AdminManangement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`AdminManangement` (
  `id_group` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id_group`),
  CONSTRAINT `fk_stationGroup_include10`
    FOREIGN KEY (`id_group`)
    REFERENCES `stationManangement`.`AdminGroup` (`id_group`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `stationManangement`.`Driver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Driver` (
  `id_driver` INT NOT NULL,
  `id_device` VARCHAR(45) NOT NULL,
  `link` VARCHAR(45) NULL,
  `version` VARCHAR(45) NULL,
  PRIMARY KEY (`id_driver`),
  INDEX `fk_Driver_Sensor1_idx` (`id_device` ASC),
  CONSTRAINT `fk_Driver_Sensor1`
    FOREIGN KEY (`id_device`)
    REFERENCES `stationManangement`.`Device` (`id_device`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `stationManangement`.`DeviceGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`DeviceGroup` (
  `id_station` INT NOT NULL,
  `id_device_group` INT NOT NULL,
  `id_device_index` INT NULL,
  `configuration` JSON NULL,
  PRIMARY KEY (`id_station`, `id_device_group`),
  INDEX `fk_DeviceGroupAggregation_DeviceIndex1_idx` (`id_device_index` ASC),
  INDEX `fk_DeviceGroupAggregation_Station1_idx` (`id_station` ASC) ,
  UNIQUE INDEX `id_device_index_UNIQUE` (`id_device_index` ASC) ,
  CONSTRAINT `fk_DeviceGroupAggregation_DeviceIndex1`
    FOREIGN KEY (`id_device_index`)
    REFERENCES `stationManangement`.`DeviceIndex` (`id_index`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DeviceGroupAggregation_Station1`
    FOREIGN KEY (`id_station`)
    REFERENCES `stationManangement`.`Station` (`id_station`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `stationManangement`.`Warehouse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Warehouse` (
  `id_warehouse` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `id_location` INT NOT NULL,
  INDEX `fk_Warehouse_Location1_idx` (`id_location` ASC),
  PRIMARY KEY (`id_warehouse`),
  CONSTRAINT `fk_Warehouse_Location1`
    FOREIGN KEY (`id_location`)
    REFERENCES `stationManangement`.`Location` (`id_location`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
 

-- -----------------------------------------------------
-- Table `stationManangement`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`Inventory` (
  `id_device` INT NOT NULL,
  `id_warehouse` VARCHAR(45) NOT NULL,
  `quantity` VARCHAR(45) NOT NULL,
  INDEX `fk_Inventory_Warehouse1_idx` (`id_warehouse` ASC) ,
  INDEX `fk_Inventory_Device1_idx` (`id_device` ASC) ,
  CONSTRAINT `fk_Inventory_Warehouse1`
    FOREIGN KEY (`id_warehouse`)
    REFERENCES `stationManangement`.`Warehouse` (`id_warehouse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventory_Device1`
    FOREIGN KEY (`id_device`)
    REFERENCES `stationManangement`.`Device` (`id_device`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `stationManangement`.`StationGroupLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`StationGroupLog` (
  `id_group` INT NOT NULL,
  `id_station` INT NOT NULL,
  `id_event` VARCHAR(45) NOT NULL,
  `time` TIMESTAMP NOT NULL,
  INDEX `fk_GroupLog_StationGroup1_idx` (`id_group` ASC, `id_station` ASC),
  INDEX `fk_GroupLog_Event1_idx` (`id_event` ASC, `time` ASC),
  CONSTRAINT `fk_GroupLog_StationGroup1`
    FOREIGN KEY (`id_group` , `id_station`)
    REFERENCES `stationManangement`.`StationGroup` (`id_group` , `id_station`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GroupLog_Event1`
    FOREIGN KEY (`id_event` , `time`)
    REFERENCES `stationManangement`.`Event` (`id_event` , `time`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `stationManangement`.`AdminGroupLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stationManangement`.`AdminGroupLog` (
  `id_group` INT NOT NULL,
  `id_admin` INT NOT NULL,
  `id_event` VARCHAR(45) NOT NULL,
  `time` TIMESTAMP NOT NULL,
  INDEX `fk_AdminGroupLog_AdminGroup1_idx` (`id_group` ASC, `id_admin` ASC) ,
  INDEX `fk_AdminGroupLog_Event1_idx` (`id_event` ASC, `time` ASC),
  CONSTRAINT `fk_AdminGroupLog_AdminGroup1`
    FOREIGN KEY (`id_group` , `id_admin`)
    REFERENCES `stationManangement`.`AdminGroup` (`id_group` , `id_admin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AdminGroupLog_Event1`
    FOREIGN KEY (`id_event` , `time`)
    REFERENCES `stationManangement`.`Event` (`id_event` , `time`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

