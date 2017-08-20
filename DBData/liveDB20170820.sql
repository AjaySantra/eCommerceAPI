-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 20, 2017 at 11:47 AM
-- Server version: 5.7.19-0ubuntu0.16.04.1
-- PHP Version: 7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `EcommerceDB`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAddressDetails` (IN `_name` VARCHAR(100), IN `_userId` VARCHAR(150), IN `_userType` VARCHAR(20), IN `_line1` VARCHAR(100), IN `_line2` VARCHAR(100), IN `_line3` VARCHAR(100), IN `_landmark` VARCHAR(100), IN `_state` VARCHAR(50), IN `_city` VARCHAR(50), IN `_pincode` VARCHAR(20), IN `_country` VARCHAR(50), IN `_phone1` VARCHAR(20), IN `_phone2` VARCHAR(20), IN `_isDefault` TINYINT)  BEGIN
			DECLARE Message VARCHAR(200);
			DECLARE _ID int ;
            
            IF EXISTS (SELECT  1 FROM  `EcommerceDB`.`AddressMaster` WHERE UserId = _userId  AND _isDefault = 1)
            THEN
            
				UPDATE  `EcommerceDB`.`AddressMaster` SET IsDefault = 0 WHERE UserId = _userId;
            
            END IF;
            

			INSERT INTO `EcommerceDB`.`AddressMaster`
					(`Name`, `UserId`, `UserType`, `Line1`, `Line2`, `Line3`, `Landmark`, `State`, `City`, `PinCode`, `Country`, `PhoneNo1`,
					`PhoneNo2`, `IsDefault`, `IsActive`, `CreatedBy`, `CreatedDate`)
			VALUES
					(_name, _userId, _userType, _line1, _line2, _line3, _landmark, _state, _city, _pincode, _country, _phone1, _phone2, 
					_isDefault, 1, _userId, CURRENT_TIMESTAMP());

			SET _ID = (SELECT LAST_INSERT_ID());

			IF( IFNULL( _ID , 0 ) > 0)
			THEN

				CALL  AddAddressLog(_ID);
				
				SET Message ='Data has been saved successfully.';
				SELECT Message;
            
            
            ELSE 
            
				SET Message ='Error : Details not saved..';
				SELECT Message;

			END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAddressLog` (IN `_ID` INT)  BEGIN

		
       INSERT INTO `EcommerceDB`.`AddressMasterLog`
			(`Name`, `UserId`, `UserType`, `Line1`, `Line2`, `Line3`, `Landmark`, `State`, `City`, `PinCode`, `Country`, `PhoneNo1`,
			`PhoneNo2`, `IsDefault`, `IsActive`, `CreatedBy`, `CreatedDate`)
            SELECT
				`Name`, `UserId`, `UserType`, `Line1`, `Line2`, `Line3`, `Landmark`, `State`, `City`, `PinCode`, `Country`, `PhoneNo1`,
			`PhoneNo2`, `IsDefault`, `IsActive`, `CreatedBy`, `CreatedDate`
            FROM     `EcommerceDB`.`AddressMaster`
            WHERE `ID` = _ID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCustomersLog` (IN `_ID` INT)  BEGIN
	
	INSERT INTO `EcommerceDB`.`CustomersLog`
		(`CustomerId`, `UserId`, `FirstName`, `LastName`, `ContactNo`, `Gender`, `DOB`, `ReferralCode`, `MyReferral`
			, `MaritalStatus`, `ReferedBy`, `IsActive`, `CreatedBy`, `CreatedDate`, `ModifyBy`,`ModifyDate`)
	SELECT `CustomerId`, `UserId`, `FirstName`, `LastName`, `ContactNo`, `Gender`, `DOB`, `ReferralCode`, `MyReferral`
			, `MaritalStatus`, `ReferedBy`, `IsActive`, `CreatedBy`, `CreatedDate`, `ModifyBy`,`ModifyDate`
	FROM `EcommerceDB`.`Customers`
    WHERE `ID` = _ID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUserAuthenticationLog` (IN `_ID` INT)  BEGIN

		INSERT INTO `EcommerceDB`.`UserAuthenticationLog`
			(`UserId`, `Password`, `AccessToken`, `LoginType`, `IsSocial`, `SocialType`, `SocialToken`, `IsActive`, `CreatedBy`, `CreatedDate`)
		SELECT 
			`UserId`, `Password`, `AccessToken`, `LoginType`, `IsSocial`, `SocialType`, `SocialToken`, `IsActive`, `CreatedBy`, `CreatedDate`
		FROM `EcommerceDB`.`UserAuthentication`
		WHERE `ID` = _ID;
        
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckUserAuthentication` (IN `_userId` VARCHAR(250))  BEGIN
	DECLARE Message VARCHAR(200);
    
    IF EXISTS (SELECT  1 FROM UserAuthentication U WHERE U.UserId  = _userId )
    THEN
    
		SELECT CU.ContactNo, CU.Gender , CU.UserId, CONCAT(IFNULL(CU.FirstName,'') ,' ', IFNULL(CU.LastName,'') )AS FullName
						, CU.CustomerId, UA.Password , '' AS Message 
		FROM Customers CU 
		INNER JOIN UserAuthentication UA ON CU.UserId = UA.UserId
		WHERE UA.UserId = _userId
        LIMIT 1;
        
        SELECT COUNT(1) AS CartCount FROM CartDetails LIMIT 1; 
            
    ELSE
    
		SET Message = 'Invalid User ID.';
		SELECT Message;
		END IF;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAddressDetails` (IN `_userId` VARCHAR(100))  BEGIN
		
            SELECT am.ID, am.`Name`, am.UserId, am.UserType, am.Line1, am.Line2, am.Line3, am.Landmark, am.State, am.City, am.PinCode, am.Country, am.PhoneNo1,
					am.PhoneNo2, am.IsDefault
            FROM AddressMaster am 
            WHERE am.UserId = _userId;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `StoreDetails` (IN `_storeId` VARCHAR(250))  BEGIN
		IF( IFNULL(_storeId,'') = '')
        THEN
        
			SELECT s.StoreId, s.UserId as EmailId, s.StoreName, CONCAT(IFNULL(s.FirstName,'') ,' ', IFNULL(s.LastName,'') ) AS FullName, s.MobileNo
            ,s.ContactNo, s.CustomerCareNumber, s.Latitude, s.Longitude, sl.CompanyName as SellerName, sl.SellerId
            FROM StoreMaster s 
            INNER JOIN Sellers sl ON s.SellerId = sl.UserId;
            
        ELSE
        
			SELECT s.StoreId, s.UserId as EmailId, s.StoreName, CONCAT(IFNULL(s.FirstName,'') ,' ', IFNULL(s.LastName,'') ) AS FullName, s.MobileNo
            ,s.ContactNo, s.CustomerCareNumber, s.Latitude, s.Longitude, sl.CompanyName as SellerName, sl.SellerId
            FROM StoreMaster s 
            INNER JOIN Sellers sl ON s.SellerId = sl.UserId
            WHERE s.UserId = _storeId;
            
        END IF;
		
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCustomerDetails` (IN `_userId` VARCHAR(100), IN `_dob` VARCHAR(100), IN `_contactNo` VARCHAR(20), IN `_gender` VARCHAR(20))  BEGIN

	DECLARE Message VARCHAR(200);
	DECLARE _ID int ;

	UPDATE `EcommerceDB`.`Customers`
	SET	 `ContactNo` =_contactNo,
	`Gender` =  _gender,`ModifyBy` = _userId, `ModifyDate` = CURRENT_TIMESTAMP()
	WHERE `UserId` = _userId;

	SET _ID = (SELECT ID FROM Customers WHERE UserId = _userId LIMIT 1);

	IF(_ID > 0)
	THEN
    
		CALL AddCustomersLog(_ID);
        
		CALL CheckUserAuthentication(_userId);

	ELSE

		SET Message =' Invalid Details.';
		SELECT Message;

	END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UserRegistration` (IN `_firstname` VARCHAR(100), IN `_lastname` VARCHAR(100), IN `_userId` VARCHAR(100), IN `_password` VARCHAR(100), IN `_contactNo` VARCHAR(20), IN `_gender` VARCHAR(20), IN `_referralCode` VARCHAR(100), IN `_isSocial` TINYINT, IN `_socialToken` VARCHAR(2000), IN `_socialType` VARCHAR(5), IN `_createdBy` VARCHAR(100), IN `_loginType` VARCHAR(100), IN `_accessToken` VARCHAR(250))  BEGIN

    DECLARE Message VARCHAR(200);
	DECLARE _ID int ;
       DECLARE  _tempSocialType VARCHAR(10);
    DECLARE _CustomerId VARCHAR(200);
    SET _CustomerId = 'C0001';
	
    IF NOT EXISTS( SELECT  ID FROM UserAuthentication  WHERE UserId = _userId LIMIT 1)
	THEN
			

			INSERT INTO `EcommerceDB`.`UserAuthentication`
				(`UserId`, `Password`, `AccessToken`, `LoginType`, `IsSocial`,`SocialType` ,`SocialToken`, `IsActive`, `CreatedBy`, `CreatedDate`)
			VALUES(_userId, _password, _accessToken, _loginType, _isSocial, _socialType, _socialToken,1,_createdBy, CURRENT_TIMESTAMP());

						SET _ID = (SELECT LAST_INSERT_ID());

			IF( IFNULL( _ID , 0 ) > 0) 			THEN

				CALL  AddUserAuthenticationLog(_ID);

				INSERT INTO `EcommerceDB`.`Customers`
					(`CustomerId`, `UserId`, `FirstName`, `LastName`, `ContactNo`, `Gender`, `ReferralCode`
					, `IsActive`, `CreatedBy`, `CreatedDate`, `ModifyBy`, `ModifyDate`)
				VALUES	(_CustomerId, _userId, _firstName, _lastName, _contactNo, _gender, _referralCode
					 , 1, _createdBy,CURRENT_TIMESTAMP() , _createdBy, CURRENT_TIMESTAMP());

				SET _ID = (SELECT LAST_INSERT_ID());

						IF( IFNULL( _ID , 0 ) > 0)
						THEN

							CALL  AddCustomersLog(_ID);

						END IF;

			END IF;              
            CALL CheckUserAuthentication(_userId);
            

	ELSE

		IF (IFNULL(_socialToken,'') <> '')
		THEN

				SET _tempSocialType = (SELECT SocialType FROM UserAuthentication WHERE UserId = _userId LIMIT 1);

				IF(IFNULL(_socialType,'') <> IFNULL(_tempSocialType,''))
				THEN

						UPDATE UserAuthentication SET IsSocial = _isSocial , SocialType = _socialType , SocialToken = _socialToken
						WHERE UserId = _userId;

						SET _ID = (SELECT ID FROM UserAuthentication WHERE UserId = _userId LIMIT 1);

						IF(_ID > 0)
						THEN
                        	CALL AddUserAuthenticationLog(_ID);
						END IF;
                        
                        CALL CheckUserAuthentication(_userId);

				ELSE

						IF NOT EXISTS(SELECT * FROM UserAuthentication WHERE UserId = _userId AND SocialType = _socialType 
						AND SocialToken = _socialToken)
						THEN

							SET Message ='Unable to login with social network.';
							SELECT Message;
                            
						ELSE
                        
                        	CALL CheckUserAuthentication(_userId);
						
						END IF;

				END IF;
                
		ELSE       
			
            SET Message ='User Id  Is Already Exists.';
			SELECT Message;

		END IF;

	END IF;
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `AddressMaster`
--

CREATE TABLE `AddressMaster` (
  `ID` int(11) NOT NULL,
  `Name` varchar(200) DEFAULT NULL,
  `UserId` varchar(100) NOT NULL,
  `UserType` varchar(45) DEFAULT NULL,
  `Line1` varchar(100) DEFAULT NULL,
  `Line2` varchar(100) DEFAULT NULL,
  `Line3` varchar(100) DEFAULT NULL,
  `Landmark` varchar(100) DEFAULT NULL,
  `State` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `PinCode` varchar(10) DEFAULT NULL,
  `Country` varchar(45) DEFAULT NULL,
  `PhoneNo1` varchar(20) DEFAULT NULL,
  `PhoneNo2` varchar(20) DEFAULT NULL,
  `IsDefault` tinyint(4) DEFAULT '0',
  `IsActive` tinyint(4) DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `AddressMaster`
--

INSERT INTO `AddressMaster` (`ID`, `Name`, `UserId`, `UserType`, `Line1`, `Line2`, `Line3`, `Landmark`, `State`, `City`, `PinCode`, `Country`, `PhoneNo1`, `PhoneNo2`, `IsDefault`, `IsActive`, `CreatedBy`, `CreatedDate`) VALUES
(2, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', NULL, NULL, 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 0, 1, 'risiraja@gmail.com', '2017-08-17 01:43:12'),
(7, 'Gourav Pal', 'gouravpal@gm.com', 'Customer', 'Baner', NULL, NULL, 'Aker Solutions', 'MH', 'Pune', '657897', 'India', '8965236523', '9856325698', 1, 1, 'gouravpal@gm.com', '2017-08-19 18:25:53'),
(8, 'Gourav Pal', 'gouravpal@gm.com', 'Customer', 'Baner', 'Baner', NULL, 'Aker Solutions', 'MH', 'Pune', '657897', 'India', '8965236523', '9856325698', 1, 1, 'gouravpal@gm.com', '2017-08-19 18:35:58'),
(9, 'Gourav Pal', 'gouravpal@gm.com', 'Customer', 'Baner', 'Baner', NULL, 'Aker Solutions', 'MH', 'Pune', '657897', 'India', '8965236523', '9856325698', 1, 1, 'gouravpal@gm.com', '2017-08-19 18:37:37'),
(10, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', '', '', 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 0, 1, 'risiraja@gmail.com', '2017-08-19 18:37:58'),
(11, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', '', '', 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 0, 1, 'risiraja@gmail.com', '2017-08-19 18:38:47'),
(12, 'Gourav Pal', 'gouravpal@gm.com', 'Customer', 'Baner', 'Baner', NULL, 'Aker Solutions', 'MH', 'Pune', '657897', 'India', '8965236523', '9856325698', 1, 1, 'gouravpal@gm.com', '2017-08-19 18:43:06'),
(20, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', 'Pune 1', '', 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 0, 1, 'risiraja@gmail.com', '2017-08-20 08:15:40'),
(21, 'Anupam Sen', 'shiv@gmail.com', 'Customer', 'Baner Road', 'Baner', NULL, 'Near Aker Solutions', 'Maharashtra', 'Pune', '411045', 'India', '9823652365', '8523697412', 0, 1, 'shiv@gmail.com', '2017-08-20 10:10:23'),
(22, 'Gourav Pal', 'shiv@gmail.com', 'Customer', 'Pune Baner', 'Pune', NULL, 'Near chandrma Hotel', 'MH', 'Pune', '411045', 'India', '9856325698', '', 1, 1, 'shiv@gmail.com', '2017-08-20 10:49:20'),
(23, 'Ajay Santra', 'shiv@gmail.com', 'Customer', 'SB Road', 'Pune', NULL, 'Near Chaturshringi Temple', 'MH', 'Pune', '411016', 'Ind', '9865321254', '', 0, 1, 'shiv@gmail.com', '2017-08-20 10:51:04'),
(24, 'Abhidhek Sharma', 'shiv@gmail.com', 'Customer', 'Firstcry Offc', 'tadiwsla road', NULL, 'near pune station', 'mh', 'pune', '411012', 'ind', '9856236512', '', 0, 1, 'shiv@gmail.com', '2017-08-20 10:52:13');

-- --------------------------------------------------------

--
-- Table structure for table `AddressMasterLog`
--

CREATE TABLE `AddressMasterLog` (
  `ID` int(11) NOT NULL,
  `Name` varchar(200) DEFAULT NULL,
  `UserId` varchar(100) NOT NULL,
  `UserType` varchar(45) DEFAULT NULL,
  `Line1` varchar(100) DEFAULT NULL,
  `Line2` varchar(100) DEFAULT NULL,
  `Line3` varchar(100) DEFAULT NULL,
  `Landmark` varchar(100) DEFAULT NULL,
  `State` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `PinCode` varchar(10) DEFAULT NULL,
  `Country` varchar(45) DEFAULT NULL,
  `PhoneNo1` varchar(20) DEFAULT NULL,
  `PhoneNo2` varchar(20) DEFAULT NULL,
  `IsDefault` tinyint(4) DEFAULT '0',
  `IsActive` tinyint(4) DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `AddressMasterLog`
--

INSERT INTO `AddressMasterLog` (`ID`, `Name`, `UserId`, `UserType`, `Line1`, `Line2`, `Line3`, `Landmark`, `State`, `City`, `PinCode`, `Country`, `PhoneNo1`, `PhoneNo2`, `IsDefault`, `IsActive`, `CreatedBy`, `CreatedDate`) VALUES
(1, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', NULL, NULL, 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 1, 1, 'risiraja@gmail.com', '2017-08-17 01:43:12'),
(2, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', NULL, NULL, 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 1, 1, 'risiraja@gmail.com', '2017-08-19 16:19:39'),
(3, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', NULL, NULL, 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', NULL, 1, 'risiraja@gmail.com', '2017-08-19 16:26:23'),
(4, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', NULL, NULL, 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 1, 1, 'risiraja@gmail.com', '2017-08-19 16:36:25'),
(5, 'Gourav Pal', 'gouravpal@gm.com', NULL, 'Baner', NULL, NULL, 'Aker Solutions', 'Maharashtra', 'Pune', '411045', 'India', '98523652368', '', 1, 1, 'gouravpal@gm.com', '2017-08-19 18:19:04'),
(6, 'Gourav Pal', 'gouravpal@gm.com', 'Customer', 'Baner', NULL, NULL, 'Aker Solutions', 'MH', 'Pune', '657897', 'India', '8965236523', '9856325698', 1, 1, 'gouravpal@gm.com', '2017-08-19 18:25:53'),
(7, 'Gourav Pal', 'gouravpal@gm.com', 'Customer', 'Baner', 'Baner', NULL, 'Aker Solutions', 'MH', 'Pune', '657897', 'India', '8965236523', '9856325698', 1, 1, 'gouravpal@gm.com', '2017-08-19 18:43:06'),
(8, 'Gourav Pal', 'gouravpal@gm.com', 'Customer', 'Baner', 'Baner', NULL, 'Aker Solutions', 'MH', 'Pune', '657897', 'India', '8965236523', '9856325698', 0, 1, 'gouravpal@gm.com', '2017-08-19 18:48:43'),
(9, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', '', '', 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 1, 1, 'risiraja@gmail.com', '2017-08-20 07:21:20'),
(10, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', '', '', 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 1, 1, 'risiraja@gmail.com', '2017-08-20 08:09:49'),
(11, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', 'Pune 1', '', 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 0, 1, 'risiraja@gmail.com', '2017-08-20 08:10:34'),
(12, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', 'Pune 1', '', 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 1, 1, 'risiraja@gmail.com', '2017-08-20 08:11:58'),
(13, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', 'Pune 1', '', 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 0, 1, 'risiraja@gmail.com', '2017-08-20 08:12:21'),
(14, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', 'Pune 1', '', 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 1, 1, 'risiraja@gmail.com', '2017-08-20 08:15:29'),
(15, 'Risi Raja', 'risiraja@gmail.com', 'Customer', 'Baner ,Pune', 'Pune 1', '', 'Aker Solution', 'MH', 'Pune', '411045', 'India', '9876543210', '', 0, 1, 'risiraja@gmail.com', '2017-08-20 08:15:40'),
(16, 'Anupam Sen', 'shiv@gmail.com', 'Customer', 'Baner Road', 'Baner', NULL, 'Near Aker Solutions', 'Maharashtra', 'Pune', '411045', 'India', '9823652365', '8523697412', 1, 1, 'shiv@gmail.com', '2017-08-20 10:10:23'),
(17, 'Gourav Pal', 'shiv@gmail.com', 'Customer', 'Pune Baner', 'Pune', NULL, 'Near chandrma Hotel', 'MH', 'Pune', '411045', 'India', '9856325698', '', 1, 1, 'shiv@gmail.com', '2017-08-20 10:49:20'),
(18, 'Ajay Santra', 'shiv@gmail.com', 'Customer', 'SB Road', 'Pune', NULL, 'Near Chaturshringi Temple', 'MH', 'Pune', '411016', 'Ind', '9865321254', '', 0, 1, 'shiv@gmail.com', '2017-08-20 10:51:04'),
(19, 'Abhidhek Sharma', 'shiv@gmail.com', 'Customer', 'Firstcry Offc', 'tadiwsla road', NULL, 'near pune station', 'mh', 'pune', '411012', 'ind', '9856236512', '', 0, 1, 'shiv@gmail.com', '2017-08-20 10:52:13');

-- --------------------------------------------------------

--
-- Table structure for table `CardMaster`
--

CREATE TABLE `CardMaster` (
  `Id` int(11) NOT NULL,
  `UserId` varchar(100) NOT NULL,
  `BankName` varchar(45) DEFAULT NULL,
  `CardType` varchar(45) DEFAULT NULL,
  `NameOnCard` varchar(45) DEFAULT NULL,
  `CardNumber` varchar(45) DEFAULT NULL,
  `ExpiryDate` datetime DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CardMasterLog`
--

CREATE TABLE `CardMasterLog` (
  `Id` int(11) NOT NULL,
  `UserId` varchar(100) NOT NULL,
  `BankName` varchar(45) DEFAULT NULL,
  `CardType` varchar(45) DEFAULT NULL,
  `NameOnCard` varchar(45) DEFAULT NULL,
  `CardNumber` varchar(45) DEFAULT NULL,
  `ExpiryDate` datetime DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CartDetails`
--

CREATE TABLE `CartDetails` (
  `ID` int(11) NOT NULL,
  `UserId` varchar(150) NOT NULL,
  `ProductId` int(11) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `CreatedBy` varchar(150) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CartDetailsLog`
--

CREATE TABLE `CartDetailsLog` (
  `ID` int(11) NOT NULL,
  `UserId` varchar(150) NOT NULL,
  `ProductId` int(11) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `CreatedBy` varchar(150) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CustomerNotification`
--

CREATE TABLE `CustomerNotification` (
  `ID` int(11) NOT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `Message` varchar(500) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CustomerNotificationLog`
--

CREATE TABLE `CustomerNotificationLog` (
  `ID` int(11) NOT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `Message` varchar(500) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Customers`
--

CREATE TABLE `Customers` (
  `ID` int(11) NOT NULL,
  `CustomerId` varchar(45) DEFAULT NULL,
  `UserId` varchar(100) NOT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `Gender` varchar(20) DEFAULT NULL,
  `DOB` datetime DEFAULT NULL,
  `ReferralCode` varchar(45) DEFAULT NULL,
  `MyReferral` varchar(45) DEFAULT NULL,
  `MaritalStatus` varchar(20) DEFAULT NULL,
  `ReferedBy` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Customers`
--

INSERT INTO `Customers` (`ID`, `CustomerId`, `UserId`, `FirstName`, `LastName`, `ContactNo`, `Gender`, `DOB`, `ReferralCode`, `MyReferral`, `MaritalStatus`, `ReferedBy`, `IsActive`, `CreatedBy`, `CreatedDate`, `ModifyBy`, `ModifyDate`) VALUES
(6, 'gourav20170808', 'gourav@db.com', 'gourav', 'Pal', '9876543210', 'Male', '2017-09-09 00:00:00', NULL, NULL, 'Single', NULL, 1, 'admin@api.com', '2017-08-08 00:00:00', NULL, '2017-08-08 00:00:00'),
(7, 'ajay20170808', 'ajay@firstcry.com', 'ajay', 'santra', '9876543210', 'Male', '2017-09-09 00:00:00', NULL, NULL, 'Single', NULL, 1, 'admin@api.com', '2017-08-08 00:00:00', NULL, '2017-08-08 00:00:00'),
(13, 'C0001', 'risiraja@gmail.com', 'Risi', 'Raja', '9876543210', 'Male', '1990-01-01 00:00:00', NULL, NULL, NULL, NULL, 1, NULL, '2017-08-16 18:19:47', 'risiraja@gmail.com', '2017-08-20 05:41:47'),
(14, 'C0001', 'kwt1988@hotmail.com', 'Wee', 'Ting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, '2017-08-18 02:13:39', NULL, '2017-08-18 02:13:39'),
(15, 'C0001', 'gouravpal@gm.com', 'Gourav', 'Pal', '8956325635', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-19 18:17:09', NULL, '2017-08-19 18:17:09'),
(16, 'C0001', 'gouravpal1991@gmail.com', 'Gourav', 'Pal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, '2017-08-19 19:14:34', NULL, '2017-08-19 19:14:34'),
(17, 'C0001', 'shiv@gmail.com', 'shivnath', 'pal', '9658235623', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-20 03:50:29', 'shiv@gmail.com', '2017-08-20 10:54:59');

-- --------------------------------------------------------

--
-- Table structure for table `CustomersLog`
--

CREATE TABLE `CustomersLog` (
  `ID` int(11) NOT NULL,
  `CustomerId` varchar(45) DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `Gender` varchar(20) DEFAULT NULL,
  `DOB` datetime DEFAULT NULL,
  `ReferralCode` varchar(45) DEFAULT NULL,
  `MyReferral` varchar(45) DEFAULT NULL,
  `MaritalStatus` varchar(20) DEFAULT NULL,
  `ReferedBy` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CustomersLog`
--

INSERT INTO `CustomersLog` (`ID`, `CustomerId`, `UserId`, `FirstName`, `LastName`, `ContactNo`, `Gender`, `DOB`, `ReferralCode`, `MyReferral`, `MaritalStatus`, `ReferedBy`, `IsActive`, `CreatedBy`, `CreatedDate`, `ModifyBy`, `ModifyDate`) VALUES
(1, 'gourav20170808', 'gourav@db.com', 'gourav', 'Pal', '9876543210', 'Male', '2017-09-09 00:00:00', NULL, NULL, 'Single', NULL, 1, 'admin@api.com', '2017-08-08 00:00:00', NULL, '2017-08-08 00:00:00'),
(2, 'C0001', 'rahulm@gmail.com', 'abhi', 'Sharma', '9876543210', 'Male', NULL, '15955412PF63417867', NULL, NULL, NULL, 1, 'abhi@gmail.com', '2017-08-12 09:45:28', 'abhi@gmail.com', '2017-08-12 09:45:28'),
(3, 'C0001', 'test@gmail.com', 'test', 'k', '8568565236', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-13 00:54:32', NULL, '2017-08-13 00:54:32'),
(4, 'C0001', 'gouravpal1991@gmail.com', 'Gourav', 'Pal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, '2017-08-16 17:40:56', NULL, '2017-08-16 17:40:56'),
(5, 'C0001', 'ajay@gmail.com', 'Ajay', 'Kumar', '8569589652', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-16 17:41:43', NULL, '2017-08-16 17:41:43'),
(6, 'C0001', 'gourav.niitstudent@gmail.com', 'Gourav', 'Pal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, '2017-08-16 17:42:31', NULL, '2017-08-16 17:42:31'),
(7, 'C0001', 'risiraja@gmail.com', 'Risi', 'Raja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, '2017-08-16 18:19:47', NULL, '2017-08-16 18:19:47'),
(8, 'C0001', 'risiraja@gmail.com', 'Risi', 'Raja', '9876543210', 'Male', '1990-01-01 00:00:00', NULL, NULL, NULL, NULL, 1, NULL, '2017-08-16 18:19:47', 'risiraja@gmail.com', '2017-08-17 01:03:26'),
(9, 'C0001', 'kwt1988@hotmail.com', 'Wee', 'Ting', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, '2017-08-18 02:13:39', NULL, '2017-08-18 02:13:39'),
(10, 'C0001', 'gouravpal@gm.com', 'Gourav', 'Pal', '8956325635', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-19 18:17:09', NULL, '2017-08-19 18:17:09'),
(11, 'C0001', 'gouravpal1991@gmail.com', 'Gourav', 'Pal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, '2017-08-19 19:14:34', NULL, '2017-08-19 19:14:34'),
(12, 'C0001', 'shiv@gmail.com', 'shivnath', 'pal', '9856235689', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-20 03:50:29', NULL, '2017-08-20 03:50:29'),
(13, 'C0001', 'risiraja@gmail.com', 'Risi', 'Raja', '9876543210', 'Male', '1990-01-01 00:00:00', NULL, NULL, NULL, NULL, 1, NULL, '2017-08-16 18:19:47', 'risiraja@gmail.com', '2017-08-20 05:41:47'),
(14, 'C0001', 'shiv@gmail.com', 'shivnath', 'pal', '2356895236', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-20 03:50:29', 'shiv@gmail.com', '2017-08-20 06:11:08'),
(15, 'C0001', 'shiv@gmail.com', 'shivnath', 'pal', '9658235623', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-20 03:50:29', 'shiv@gmail.com', '2017-08-20 06:13:20'),
(16, 'C0001', 'shiv@gmail.com', 'shivnath', 'pal', '9658235623', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-20 03:50:29', 'shiv@gmail.com', '2017-08-20 06:13:31'),
(17, 'C0001', 'shiv@gmail.com', 'shivnath', 'pal', '9658235623', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-20 03:50:29', 'shiv@gmail.com', '2017-08-20 06:15:32'),
(18, 'C0001', 'shiv@gmail.com', 'shivnath', 'pal', '9658235623', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-20 03:50:29', 'shiv@gmail.com', '2017-08-20 06:36:22'),
(19, 'C0001', 'shiv@gmail.com', 'shivnath', 'pal', '9658235623', 'Male', NULL, '', NULL, NULL, NULL, 1, NULL, '2017-08-20 03:50:29', 'shiv@gmail.com', '2017-08-20 10:54:59');

-- --------------------------------------------------------

--
-- Table structure for table `CustomerWishList`
--

CREATE TABLE `CustomerWishList` (
  `Id` int(11) NOT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `WishlistTitle` varchar(100) DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `IsPublic` tinyint(4) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CustomerWishListLog`
--

CREATE TABLE `CustomerWishListLog` (
  `Id` int(11) NOT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `WishlistTitle` varchar(100) DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `IsPublic` tinyint(4) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ErrorLog`
--

CREATE TABLE `ErrorLog` (
  `LogId` int(11) NOT NULL,
  `ErrorDateTime` datetime DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `ErrorNumber` varchar(45) DEFAULT NULL,
  `ErrorSeverity` int(11) DEFAULT NULL,
  `ErrorState` int(11) DEFAULT NULL,
  `ErrorProcedure` varchar(200) DEFAULT NULL,
  `ErrorLine` int(11) DEFAULT NULL,
  `ErrorMessage` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `PurchaseDetails`
--

CREATE TABLE `PurchaseDetails` (
  `ID` int(11) NOT NULL,
  `OrderNo` varchar(45) NOT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `ProductName` varchar(200) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `MRP` decimal(18,2) DEFAULT NULL,
  `DiscountType` varchar(45) DEFAULT NULL,
  `DiscountPercentage` decimal(18,2) DEFAULT NULL,
  `DiscountAmount` decimal(18,2) DEFAULT NULL,
  `Quanity` int(11) DEFAULT NULL,
  `OfferMRP` decimal(18,2) DEFAULT NULL,
  `ItemStatus` varchar(20) DEFAULT NULL,
  `Comments` varchar(500) DEFAULT NULL,
  `StoreID` varchar(50) DEFAULT NULL,
  `Color` varchar(45) DEFAULT NULL,
  `BaseCost` decimal(18,2) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `PurchaseDetailsLog`
--

CREATE TABLE `PurchaseDetailsLog` (
  `ID` int(11) NOT NULL,
  `OrderNo` varchar(45) NOT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `ProductName` varchar(200) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `MRP` decimal(18,2) DEFAULT NULL,
  `DiscountType` varchar(45) DEFAULT NULL,
  `DiscountPercentage` decimal(18,2) DEFAULT NULL,
  `DiscountAmount` decimal(18,2) DEFAULT NULL,
  `Quanity` int(11) DEFAULT NULL,
  `OfferMRP` decimal(18,2) DEFAULT NULL,
  `ItemStatus` varchar(20) DEFAULT NULL,
  `Comments` varchar(500) DEFAULT NULL,
  `StoreID` varchar(50) DEFAULT NULL,
  `Color` varchar(45) DEFAULT NULL,
  `BaseCost` decimal(18,2) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `PurchaseMaster`
--

CREATE TABLE `PurchaseMaster` (
  `ID` int(11) NOT NULL,
  `OrderNo` varchar(45) NOT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `UserId` varchar(100) NOT NULL,
  `StoreId` varchar(50) DEFAULT NULL,
  `OrderStatus` varchar(20) DEFAULT NULL,
  `TotalQty` int(11) DEFAULT NULL,
  `TotalAmount` decimal(18,2) DEFAULT NULL,
  `Tax` decimal(18,2) DEFAULT NULL,
  `TaxAmount` decimal(18,2) DEFAULT NULL,
  `OtherTax` decimal(18,2) DEFAULT NULL,
  `OtherTaxAmount` decimal(18,2) DEFAULT NULL,
  `Discount` decimal(18,2) DEFAULT NULL,
  `DiscountAmount` decimal(18,2) DEFAULT NULL,
  `RoundOff` decimal(18,2) DEFAULT NULL,
  `OfferCode` varchar(50) DEFAULT NULL,
  `Comments` varchar(500) DEFAULT NULL,
  `PaymentType` varchar(20) DEFAULT NULL,
  `OrderType` varchar(20) DEFAULT NULL,
  `ShippingAndHandling` decimal(18,2) DEFAULT NULL,
  `GrandAmount` decimal(18,2) DEFAULT NULL,
  `ShippingAddress` varchar(500) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `PurchaseMasterLog`
--

CREATE TABLE `PurchaseMasterLog` (
  `ID` int(11) NOT NULL,
  `OrderNo` varchar(45) NOT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `UserId` varchar(100) NOT NULL,
  `StoreId` varchar(50) DEFAULT NULL,
  `OrderStatus` varchar(20) DEFAULT NULL,
  `TotalQty` int(11) DEFAULT NULL,
  `TotalAmount` decimal(18,2) DEFAULT NULL,
  `Tax` decimal(18,2) DEFAULT NULL,
  `TaxAmount` decimal(18,2) DEFAULT NULL,
  `OtherTax` decimal(18,2) DEFAULT NULL,
  `OtherTaxAmount` decimal(18,2) DEFAULT NULL,
  `Discount` decimal(18,2) DEFAULT NULL,
  `DiscountAmount` decimal(18,2) DEFAULT NULL,
  `RoundOff` decimal(18,2) DEFAULT NULL,
  `OfferCode` varchar(50) DEFAULT NULL,
  `Comments` varchar(500) DEFAULT NULL,
  `PaymentType` varchar(20) DEFAULT NULL,
  `ShippingAndHandling` decimal(18,2) DEFAULT NULL,
  `GrandAmount` decimal(18,2) DEFAULT NULL,
  `ShippingAddress` varchar(500) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ReviewAndRatings`
--

CREATE TABLE `ReviewAndRatings` (
  `ID` int(11) NOT NULL,
  `ProductId` varchar(50) DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `Stars` int(11) DEFAULT NULL,
  `Comments` varchar(5000) DEFAULT NULL,
  `IsApproved` tinyint(4) DEFAULT NULL,
  `IsHelpFull` tinyint(4) DEFAULT NULL,
  `ReviewTitle` varchar(200) DEFAULT NULL,
  `VerifiedCustomer` tinyint(4) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ReviewAndRatingsLog`
--

CREATE TABLE `ReviewAndRatingsLog` (
  `ID` int(11) NOT NULL,
  `ProductId` varchar(50) DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `Stars` int(11) DEFAULT NULL,
  `Comments` varchar(5000) DEFAULT NULL,
  `IsApproved` tinyint(4) DEFAULT NULL,
  `IsHelpFull` tinyint(4) DEFAULT NULL,
  `ReviewTitle` varchar(200) DEFAULT NULL,
  `VerifiedCustomer` tinyint(4) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Sellers`
--

CREATE TABLE `Sellers` (
  `ID` int(11) NOT NULL,
  `SellerId` varchar(45) NOT NULL,
  `UserId` varchar(100) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `CompanyName` varchar(200) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `ReferadBy` varchar(100) DEFAULT NULL,
  `CustomerCareNumber` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Sellers`
--

INSERT INTO `Sellers` (`ID`, `SellerId`, `UserId`, `FirstName`, `LastName`, `CompanyName`, `Gender`, `ContactNo`, `MobileNo`, `ReferadBy`, `CustomerCareNumber`, `IsActive`, `CreatedBy`, `CreatedDate`, `ModifyBy`, `ModifyDate`) VALUES
(1, 'S0001', 'sale@eco.com', 'Seller', 'Lname', 'Saller Pvt. Ltd.', 'Male', '22-600299', '9876543210', NULL, '1800234590', 1, NULL, '2017-09-09 00:00:00', NULL, '2015-09-09 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `SellersLog`
--

CREATE TABLE `SellersLog` (
  `ID` int(11) NOT NULL,
  `SellerId` varchar(45) DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `CompanyName` varchar(200) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `ReferadBy` varchar(100) DEFAULT NULL,
  `CustomerCareNumber` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `StoreMaster`
--

CREATE TABLE `StoreMaster` (
  `Id` int(11) NOT NULL,
  `StoreId` varchar(45) NOT NULL,
  `UserId` varchar(100) NOT NULL,
  `SellerId` varchar(100) NOT NULL,
  `StoreName` varchar(500) DEFAULT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `CustomerCareNumber` varchar(20) DEFAULT NULL,
  `SpecialOffersEmails` varchar(50) DEFAULT NULL,
  `ReferralCode` varchar(50) DEFAULT NULL,
  `Latitude` varchar(45) DEFAULT NULL,
  `Longitude` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `StoreMaster`
--

INSERT INTO `StoreMaster` (`Id`, `StoreId`, `UserId`, `SellerId`, `StoreName`, `FirstName`, `LastName`, `MobileNo`, `ContactNo`, `CustomerCareNumber`, `SpecialOffersEmails`, `ReferralCode`, `Latitude`, `Longitude`, `IsActive`, `CreatedBy`, `CreatedDate`, `ModifyBy`, `ModifyDate`) VALUES
(1, 'ST001', 'store@eco.com', 'sale@eco.com', 'store 1', 'store ', 'lname', '987654321', '22-6009876', '1800123456', NULL, NULL, '18.5679387', '73.785364', 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `StoreMasterLog`
--

CREATE TABLE `StoreMasterLog` (
  `Id` int(11) NOT NULL,
  `StoreId` varchar(45) DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `SellerId` varchar(100) DEFAULT NULL,
  `StoreName` varchar(500) DEFAULT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `CustomerCareNumber` varchar(20) DEFAULT NULL,
  `SpecialOffersEmails` varchar(50) DEFAULT NULL,
  `ReferralCode` varchar(50) DEFAULT NULL,
  `Latitude` varchar(45) DEFAULT NULL,
  `Longitude` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `UserAuthentication`
--

CREATE TABLE `UserAuthentication` (
  `ID` int(11) NOT NULL,
  `UserId` varchar(100) NOT NULL,
  `Password` varchar(1000) DEFAULT NULL,
  `AccessToken` varchar(1000) DEFAULT NULL,
  `LoginType` varchar(45) DEFAULT NULL,
  `IsSocial` tinyint(4) DEFAULT '0',
  `SocialType` varchar(45) DEFAULT NULL,
  `SocialToken` varchar(2000) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(45) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `UserAuthentication`
--

INSERT INTO `UserAuthentication` (`ID`, `UserId`, `Password`, `AccessToken`, `LoginType`, `IsSocial`, `SocialType`, `SocialToken`, `IsActive`, `CreatedBy`, `CreatedDate`) VALUES
(1, 'ajay@firstcry.com', 'ajay', NULL, 'Customer', 0, NULL, NULL, 1, 'admin@firstcry.com', NULL),
(2, 'gourav@db.com', 'sha1$ed2f50fd$1$9d300dc13f25579400d8e060458b395282979b21', NULL, 'Customer', 0, NULL, NULL, 1, 'admin@firstcry.com', NULL),
(3, 'sale@eco.com', NULL, NULL, 'Seller', 0, NULL, NULL, 1, 'admin@firstcry.com', NULL),
(4, 'Store@eco.com', NULL, NULL, 'Store', 0, NULL, NULL, 1, NULL, NULL),
(11, 'risiraja@gmail.com', 'sha1$35c4155f$1$6efa9c0a13864c5b5959335f983250c4910770ff', NULL, 'customer', 0, '', '', 1, NULL, '2017-08-16 18:19:47'),
(12, 'kwt1988@hotmail.com', '', NULL, 'customer', 1, 'F', 'EAATtf5lCDhMBAILhG4JvOWFXhS2yoTZC2F4G7KzvaLr9ZBwDXAYIYKLBg6tTvalevNjokQnpkhIfBGB7FeJBCBU0obpE0HJR1TSirqPbHbPSpOgJVujfEXl0DtNADLEyOZAu7IJn7iFpWsCy6UNkLg5ZBMXH1RGBq9JCZCEZCvIMY5vZBjP0L055byE2BrspZCDcx8zF0r8ZCtBxzMrMXeqS5yg7swW7DMlQZD', 1, NULL, '2017-08-18 02:13:39'),
(13, 'gouravpal@gm.com', 'sha1$3f589ea2$1$f670135df609490f082014d45f4b77a7026664d3', NULL, 'customer', 0, NULL, NULL, 1, NULL, '2017-08-19 18:17:09'),
(14, 'gouravpal1991@gmail.com', '', NULL, 'customer', 1, 'G', 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEwOTMxYWFjNWVjMWVjZThmOGY0NmMwNThjY2MzMTZjOTk3ZjY2ZDMifQ.eyJhenAiOiI4NTcyODcxNDUwODMtaWVuMzhzYjQ0NW1sMGlnNTBjYW4xYWNmYmluYzVqcTcuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4NTcyODcxNDUwODMtMnRsNGM5dHEzNDdtMnI3dnQ2cWprNWxtdDRmcTAyMHEuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDg3NTI0MTEwMjc1NzY2NjY4MTUiLCJlbWFpbCI6ImdvdXJhdnBhbDE5OTFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImlzcyI6Imh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbSIsImlhdCI6MTUwMzE3MDA3NCwiZXhwIjoxNTAzMTczNjc0LCJuYW1lIjoiR291cmF2IFBhbCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLTF3WnFsa0Z2ZGRjL0FBQUFBQUFBQUFJL0FBQUFBQUFBR2dBLzhJSFUyS2NLSGZnL3M5Ni1jL3Bob3RvLmpwZyIsImdpdmVuX25hbWUiOiJHb3VyYXYiLCJmYW1pbHlfbmFtZSI6IlBhbCIsImxvY2FsZSI6ImVuIn0.WxlBKU_nVmuC4HycuVN-u6yZgB9C2zyrsm4gu2cCTuuyONG4YxUsthmuvguKGQayO0Bz6XS1GIaausV1iHixQeGsFY5XsRZIXPT7ATm1BXsVDf7EVg7Dx1_DWHnUZiExWr-vUhOIouxCmY7gjYHtoItBy_4PFQZS_oFn8dts5einQZjz_pKC_OIcZYsHXVW_u7NFS0YoOenUaflyAx7SPVMhGYsyFsdBs_JuqQ2d3wE8AcFcni_gG9nHI55XeGoKrIzCZLAWbDXpCmz7uxTL9terJMjSjDVv4rwSyI08l2n9x60xGvJnp3sPXc_aO6AP-aBgBWsgAvkIPN9PLABvJQ', 1, NULL, '2017-08-19 19:14:34'),
(15, 'shiv@gmail.com', 'sha1$4bd7c1b5$1$e680fdedb5ffda68290d18b87ae029544aec6960', NULL, 'customer', 0, NULL, NULL, 1, NULL, '2017-08-20 03:50:29');

-- --------------------------------------------------------

--
-- Table structure for table `UserAuthenticationLog`
--

CREATE TABLE `UserAuthenticationLog` (
  `ID` int(11) NOT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `Password` varchar(1000) DEFAULT NULL,
  `AccessToken` varchar(1000) DEFAULT NULL,
  `LoginType` varchar(45) DEFAULT NULL,
  `IsSocial` tinyint(4) DEFAULT '0',
  `SocialType` varchar(45) DEFAULT NULL,
  `SocialToken` varchar(2000) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(45) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `UserAuthenticationLog`
--

INSERT INTO `UserAuthenticationLog` (`ID`, `UserId`, `Password`, `AccessToken`, `LoginType`, `IsSocial`, `SocialType`, `SocialToken`, `IsActive`, `CreatedBy`, `CreatedDate`) VALUES
(1, 'ajay@firstcry.com', 'ajay', NULL, 'Customer', 0, NULL, NULL, 1, 'admin@firstcry.com', NULL),
(2, 'rahu1231sadfas23l@gmail.com', 'sha1$4c40182f$1$322181fa1fda01987d4c89afb23851bb1becd7eb', '9876Asbc', 'Customer', 0, NULL, NULL, 1, 'abhi@gmail.com', '2017-08-12 09:32:51'),
(3, 'rahulm@gmail.com', 'sha1$095391a6$1$6cd488acb9e29690448fbfd8842e9c4128ff04d6', '9876Asbc', 'Customer', 0, NULL, NULL, 1, 'abhi@gmail.com', '2017-08-12 09:45:28'),
(4, 'rahulm@gmail.com', 'sha1$095391a6$1$6cd488acb9e29690448fbfd8842e9c4128ff04d6', '9876Asbc', 'Customer', 1, 'F', 'adfjasldflasd13nlasdflasdfjkaskdf', 1, 'abhi@gmail.com', '2017-08-12 09:45:28'),
(5, 'rahulm@gmail.com', 'sha1$095391a6$1$6cd488acb9e29690448fbfd8842e9c4128ff04d6', '9876Asbc', 'Customer', 1, 'G', 'adfjasldflasd13nlasdflasdfjksdfsdfsdfsdfsaskdf', 1, 'abhi@gmail.com', '2017-08-12 09:45:28'),
(6, 'rahulm@gmail.com', 'sha1$095391a6$1$6cd488acb9e29690448fbfd8842e9c4128ff04d6', '9876Asbc', 'Customer', 1, 'F', 'adfjasldflasd13nlasdflasdfjkaskdf', 1, 'abhi@gmail.com', '2017-08-12 09:45:28'),
(7, 'test@gmail.com', 'sha1$fb0b201f$1$960b89cfdbe84aa242818cb2426cbb8632d99429', NULL, 'customer', NULL, NULL, NULL, 1, NULL, '2017-08-13 00:54:32'),
(8, 'gouravpal1991@gmail.com', '', NULL, 'customer', 1, 'G', 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjkxNDEyODQwYzEwMTlkZWRmZjE4NTRiODk5MzhhZDBhOTA3OGI4NzEifQ.eyJhenAiOiI4NTcyODcxNDUwODMtaWVuMzhzYjQ0NW1sMGlnNTBjYW4xYWNmYmluYzVqcTcuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4NTcyODcxNDUwODMtMnRsNGM5dHEzNDdtMnI3dnQ2cWprNWxtdDRmcTAyMHEuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDg3NTI0MTEwMjc1NzY2NjY4MTUiLCJlbWFpbCI6ImdvdXJhdnBhbDE5OTFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImlzcyI6Imh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbSIsImlhdCI6MTUwMjkwNTIxMiwiZXhwIjoxNTAyOTA4ODEyLCJuYW1lIjoiR291cmF2IFBhbCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLTF3WnFsa0Z2ZGRjL0FBQUFBQUFBQUFJL0FBQUFBQUFBR2dBLzhJSFUyS2NLSGZnL3M5Ni1jL3Bob3RvLmpwZyIsImdpdmVuX25hbWUiOiJHb3VyYXYiLCJmYW1pbHlfbmFtZSI6IlBhbCIsImxvY2FsZSI6ImVuIn0.d0hU1Im6oME8iwF9G57NG5Xp7SxV-zpupr8G_etLVftphOJ-QnbiijzTNv9wG8yBOttIsrfpNUllOhTWIqyWR_WJh7AA_SUCJfSiYKE_xeN-o5yZI67yQoAs-iwTMkbnBtZjBMnkWB0JjiCvFMRvz_CJr_TRIH4pzYAB7Q1xKkj8IHM2GngstVVP_sdtXXgls3SOMNfNnJhQPI6SR4U2X417hJxaGd7Le3Z8onapj6kYOMkW_zsl5drDzV5cUZgRXvDQO01Ik2LnKnGvm2cc-Tr5CEBP47JtL7J-Z4oGqZ2CRXevjnYQNbvIXGOqKnY1JHzfkg1rInE-hdw94Hvkcg', 1, NULL, '2017-08-16 17:40:56'),
(9, 'ajay@gmail.com', 'sha1$ceff8f6a$1$5c8155f87a962282362f3f23deb6cdcebb23bd55', NULL, 'customer', 0, NULL, NULL, 1, NULL, '2017-08-16 17:41:43'),
(10, 'gourav.niitstudent@gmail.com', '', NULL, 'customer', 1, 'F', 'EAATtf5lCDhMBAA81kEs6mJhH6ZA32aLqLnvZCALg5rprOkCPOeQPkU3KjIqFurPcJ7ZBqNqajQFpAJjSoaIOkN8mT38Wx6Va8hKyLxdUYwPfondMVZBYiaxQaZBHmJ6tIOUATNprdnfeYcQD6TNUeaYb1IYfpOHrfPkiuJx1521oksO8ZBZBxtmvrZCRcjeLIjr5IxPmaQnMRK7OtWFHaqrZBlMQPtLCLhy8ZD', 1, NULL, '2017-08-16 17:42:31'),
(11, 'risiraja@gmail.com', 'sha1$35c4155f$1$6efa9c0a13864c5b5959335f983250c4910770ff', NULL, 'customer', 0, '', '', 1, NULL, '2017-08-16 18:19:47'),
(12, 'kwt1988@hotmail.com', '', NULL, 'customer', 1, 'F', 'EAATtf5lCDhMBAILhG4JvOWFXhS2yoTZC2F4G7KzvaLr9ZBwDXAYIYKLBg6tTvalevNjokQnpkhIfBGB7FeJBCBU0obpE0HJR1TSirqPbHbPSpOgJVujfEXl0DtNADLEyOZAu7IJn7iFpWsCy6UNkLg5ZBMXH1RGBq9JCZCEZCvIMY5vZBjP0L055byE2BrspZCDcx8zF0r8ZCtBxzMrMXeqS5yg7swW7DMlQZD', 1, NULL, '2017-08-18 02:13:39'),
(13, 'gouravpal@gm.com', 'sha1$3f589ea2$1$f670135df609490f082014d45f4b77a7026664d3', NULL, 'customer', 0, NULL, NULL, 1, NULL, '2017-08-19 18:17:09'),
(14, 'gouravpal1991@gmail.com', '', NULL, 'customer', 1, 'G', 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjEwOTMxYWFjNWVjMWVjZThmOGY0NmMwNThjY2MzMTZjOTk3ZjY2ZDMifQ.eyJhenAiOiI4NTcyODcxNDUwODMtaWVuMzhzYjQ0NW1sMGlnNTBjYW4xYWNmYmluYzVqcTcuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4NTcyODcxNDUwODMtMnRsNGM5dHEzNDdtMnI3dnQ2cWprNWxtdDRmcTAyMHEuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDg3NTI0MTEwMjc1NzY2NjY4MTUiLCJlbWFpbCI6ImdvdXJhdnBhbDE5OTFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImlzcyI6Imh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbSIsImlhdCI6MTUwMzE3MDA3NCwiZXhwIjoxNTAzMTczNjc0LCJuYW1lIjoiR291cmF2IFBhbCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vLTF3WnFsa0Z2ZGRjL0FBQUFBQUFBQUFJL0FBQUFBQUFBR2dBLzhJSFUyS2NLSGZnL3M5Ni1jL3Bob3RvLmpwZyIsImdpdmVuX25hbWUiOiJHb3VyYXYiLCJmYW1pbHlfbmFtZSI6IlBhbCIsImxvY2FsZSI6ImVuIn0.WxlBKU_nVmuC4HycuVN-u6yZgB9C2zyrsm4gu2cCTuuyONG4YxUsthmuvguKGQayO0Bz6XS1GIaausV1iHixQeGsFY5XsRZIXPT7ATm1BXsVDf7EVg7Dx1_DWHnUZiExWr-vUhOIouxCmY7gjYHtoItBy_4PFQZS_oFn8dts5einQZjz_pKC_OIcZYsHXVW_u7NFS0YoOenUaflyAx7SPVMhGYsyFsdBs_JuqQ2d3wE8AcFcni_gG9nHI55XeGoKrIzCZLAWbDXpCmz7uxTL9terJMjSjDVv4rwSyI08l2n9x60xGvJnp3sPXc_aO6AP-aBgBWsgAvkIPN9PLABvJQ', 1, NULL, '2017-08-19 19:14:34'),
(15, 'shiv@gmail.com', 'sha1$4bd7c1b5$1$e680fdedb5ffda68290d18b87ae029544aec6960', NULL, 'customer', 0, NULL, NULL, 1, NULL, '2017-08-20 03:50:29');

-- --------------------------------------------------------

--
-- Table structure for table `WalletsMaster`
--

CREATE TABLE `WalletsMaster` (
  `ID` int(11) NOT NULL,
  `UserId` varchar(45) DEFAULT NULL,
  `BalanceAmount` decimal(18,2) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `WalletTransactionsLog`
--

CREATE TABLE `WalletTransactionsLog` (
  `Id` int(11) NOT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `TransactionType` varchar(45) DEFAULT NULL,
  `Amount` decimal(18,2) DEFAULT NULL,
  `OrderID` varchar(20) DEFAULT NULL,
  `PaymentType` varchar(20) DEFAULT NULL,
  `TransactionDate` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `AddressMaster`
--
ALTER TABLE `AddressMaster`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `AddressMasterLog`
--
ALTER TABLE `AddressMasterLog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `CardMaster`
--
ALTER TABLE `CardMaster`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_Card_Customer_idx` (`UserId`);

--
-- Indexes for table `CardMasterLog`
--
ALTER TABLE `CardMasterLog`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `CartDetails`
--
ALTER TABLE `CartDetails`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_Cart_Customer_idx` (`UserId`);

--
-- Indexes for table `CartDetailsLog`
--
ALTER TABLE `CartDetailsLog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `CustomerNotification`
--
ALTER TABLE `CustomerNotification`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_Notification_Customer_idx` (`UserId`);

--
-- Indexes for table `CustomerNotificationLog`
--
ALTER TABLE `CustomerNotificationLog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UserId_UNIQUE` (`UserId`),
  ADD KEY `MainIndex` (`UserId`);

--
-- Indexes for table `CustomersLog`
--
ALTER TABLE `CustomersLog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `CustomerWishList`
--
ALTER TABLE `CustomerWishList`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_WishList_Customer_idx` (`UserId`);

--
-- Indexes for table `CustomerWishListLog`
--
ALTER TABLE `CustomerWishListLog`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `ErrorLog`
--
ALTER TABLE `ErrorLog`
  ADD PRIMARY KEY (`LogId`);

--
-- Indexes for table `PurchaseDetails`
--
ALTER TABLE `PurchaseDetails`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_PurachseDetails_PurchaseMaster_idx` (`OrderNo`);

--
-- Indexes for table `PurchaseDetailsLog`
--
ALTER TABLE `PurchaseDetailsLog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `PurchaseMaster`
--
ALTER TABLE `PurchaseMaster`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `OrderNo_UNIQUE` (`OrderNo`),
  ADD KEY `fk_PurchaseMaster_Customers_idx` (`UserId`),
  ADD KEY `fk_PuchaseMaster_Store_idx` (`StoreId`);

--
-- Indexes for table `PurchaseMasterLog`
--
ALTER TABLE `PurchaseMasterLog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `ReviewAndRatings`
--
ALTER TABLE `ReviewAndRatings`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `fk_Review_Customers_idx` (`UserId`);

--
-- Indexes for table `ReviewAndRatingsLog`
--
ALTER TABLE `ReviewAndRatingsLog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Sellers`
--
ALTER TABLE `Sellers`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `EmailID_UNIQUE` (`UserId`);

--
-- Indexes for table `SellersLog`
--
ALTER TABLE `SellersLog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `StoreMaster`
--
ALTER TABLE `StoreMaster`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `StoreId_UNIQUE` (`StoreId`),
  ADD KEY `fk_Sellers_Store_idx` (`SellerId`),
  ADD KEY `fk_Store_UserAuth_idx` (`UserId`);

--
-- Indexes for table `StoreMasterLog`
--
ALTER TABLE `StoreMasterLog`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `UserAuthentication`
--
ALTER TABLE `UserAuthentication`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UserID_UNIQUE` (`UserId`);

--
-- Indexes for table `UserAuthenticationLog`
--
ALTER TABLE `UserAuthenticationLog`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `WalletsMaster`
--
ALTER TABLE `WalletsMaster`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UserID_UNIQUE` (`UserId`);

--
-- Indexes for table `WalletTransactionsLog`
--
ALTER TABLE `WalletTransactionsLog`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_WalletTrans_WalletMaster_idx` (`UserId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `AddressMaster`
--
ALTER TABLE `AddressMaster`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `AddressMasterLog`
--
ALTER TABLE `AddressMasterLog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `CardMaster`
--
ALTER TABLE `CardMaster`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `CardMasterLog`
--
ALTER TABLE `CardMasterLog`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `CartDetails`
--
ALTER TABLE `CartDetails`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `CartDetailsLog`
--
ALTER TABLE `CartDetailsLog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `CustomerNotification`
--
ALTER TABLE `CustomerNotification`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `CustomerNotificationLog`
--
ALTER TABLE `CustomerNotificationLog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Customers`
--
ALTER TABLE `Customers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `CustomersLog`
--
ALTER TABLE `CustomersLog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `CustomerWishList`
--
ALTER TABLE `CustomerWishList`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `CustomerWishListLog`
--
ALTER TABLE `CustomerWishListLog`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ErrorLog`
--
ALTER TABLE `ErrorLog`
  MODIFY `LogId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `PurchaseDetails`
--
ALTER TABLE `PurchaseDetails`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `PurchaseDetailsLog`
--
ALTER TABLE `PurchaseDetailsLog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `PurchaseMaster`
--
ALTER TABLE `PurchaseMaster`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `PurchaseMasterLog`
--
ALTER TABLE `PurchaseMasterLog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ReviewAndRatings`
--
ALTER TABLE `ReviewAndRatings`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ReviewAndRatingsLog`
--
ALTER TABLE `ReviewAndRatingsLog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Sellers`
--
ALTER TABLE `Sellers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `SellersLog`
--
ALTER TABLE `SellersLog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `StoreMaster`
--
ALTER TABLE `StoreMaster`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `StoreMasterLog`
--
ALTER TABLE `StoreMasterLog`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `UserAuthentication`
--
ALTER TABLE `UserAuthentication`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `UserAuthenticationLog`
--
ALTER TABLE `UserAuthenticationLog`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `WalletsMaster`
--
ALTER TABLE `WalletsMaster`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `WalletTransactionsLog`
--
ALTER TABLE `WalletTransactionsLog`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `CardMaster`
--
ALTER TABLE `CardMaster`
  ADD CONSTRAINT `fk_Card_Customer` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `CartDetails`
--
ALTER TABLE `CartDetails`
  ADD CONSTRAINT `fk_Cart_Customer` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `CustomerNotification`
--
ALTER TABLE `CustomerNotification`
  ADD CONSTRAINT `fk_Notification_Customer` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Customers`
--
ALTER TABLE `Customers`
  ADD CONSTRAINT `fk_Customer_UserAuth` FOREIGN KEY (`UserId`) REFERENCES `UserAuthentication` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `CustomerWishList`
--
ALTER TABLE `CustomerWishList`
  ADD CONSTRAINT `fk_WishList_Customer` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `PurchaseDetails`
--
ALTER TABLE `PurchaseDetails`
  ADD CONSTRAINT `fk_PurachseDetails_PurchaseMaster` FOREIGN KEY (`OrderNo`) REFERENCES `PurchaseMaster` (`OrderNo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `PurchaseMaster`
--
ALTER TABLE `PurchaseMaster`
  ADD CONSTRAINT `fk_PuchaseMaster_Store` FOREIGN KEY (`StoreId`) REFERENCES `StoreMaster` (`StoreId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_PurchaseMaster_Customers` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ReviewAndRatings`
--
ALTER TABLE `ReviewAndRatings`
  ADD CONSTRAINT `fk_Review_Customers` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Sellers`
--
ALTER TABLE `Sellers`
  ADD CONSTRAINT `fk_Seller_UserAuth` FOREIGN KEY (`UserId`) REFERENCES `UserAuthentication` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `StoreMaster`
--
ALTER TABLE `StoreMaster`
  ADD CONSTRAINT `fk_Store_Seller` FOREIGN KEY (`SellerId`) REFERENCES `Sellers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Store_UserAuth` FOREIGN KEY (`UserId`) REFERENCES `UserAuthentication` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `WalletsMaster`
--
ALTER TABLE `WalletsMaster`
  ADD CONSTRAINT `fk_Wallets_Customer` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `WalletTransactionsLog`
--
ALTER TABLE `WalletTransactionsLog`
  ADD CONSTRAINT `fk_WalletTrans_WalletMaster` FOREIGN KEY (`UserId`) REFERENCES `WalletsMaster` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
