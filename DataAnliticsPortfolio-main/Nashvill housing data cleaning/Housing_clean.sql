-- importing data
Create database DataCl;

Create tAbLe Nash_housing(
	UniqueID int,
	ParcelID varchar(255),	
	LandUse	varchar(255),
	PropertyAddress	varchar(255),
	SaleDate varchar(255),	
	SalePrice int,
	LegalReference varchar(255),	
	SoldAsVacant varchar(255),	
	OwnerName varchar(255),	
	OwnerAddress varchar(255),	
	Acreage	double,	
	TaxDistrict	varchar(255),	
	LandValue int,	
	BuildingValue int,	
	TotalValue int,	
    YearBuilt int,	
	Bedrooms int,	
	FullBath int,	
	HalfBath int
);

LOAD DATA LOCAL INFILE
'F:/CODEING/Nashville_Housing.csv' INTO TABLE Nash_housing
CHARACTER SET 'utf8'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;



SELECT * FROM datacl.nash_housing;


UPDATE nash_housing
SET SaleDate = DATE_FORMAT(STR_TO_DATE(SaleDate, '%M %d, %Y'), '%Y-%m-%d');



-- joining the address

Select *
From datacl.nash_housing
-- Where PropertyAddress is null
order by ParcelID;

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
FROM datacl.nash_housing a
JOIN datacl.nash_housing b ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID;


UPDATE datacl.nash_housing a
JOIN datacl.nash_housing b ON a.ParcelID = b.ParcelID
AND a.`UniqueID` <> b.`UniqueID`
SET a.PropertyAddress = COALESCE(a.PropertyAddress, b.PropertyAddress)
WHERE a.PropertyAddress IS NULL;


-- apending the adress collum

-- using these to check everything is working in each line
/*
Select PropertyAddress
From datacl.nash_housing;

Select PropertySplitAddress
From datacl.nash_housing;

Select PropertySplitCity
From datacl.nash_housing;
*/
-- Splitting PropertyAddress into separate columns for Address and City

-- Adding PropertySplitAddress column
ALTER TABLE nash_housing
ADD PropertySplitAddress NVARCHAR(255);

-- Updating PropertySplitAddress with the address portion of PropertyAddress
UPDATE nash_housing
SET PropertySplitAddress = SUBSTRING_INDEX(PropertyAddress, ',', 1);

-- Adding PropertySplitCity column
ALTER TABLE nash_housing
ADD PropertySplitCity NVARCHAR(255);

-- Updating PropertySplitCity with the city portion of PropertyAddress
UPDATE nash_housing
SET PropertySplitCity = SUBSTRING_INDEX(PropertyAddress, ',', -1);


-- Splitting OwnerAddress into separate columns for Address, City, and State

-- Adding OwnerSplitAddress column
ALTER TABLE nash_housing
ADD OwnerSplitAddress NVARCHAR(255);

-- Updating OwnerSplitAddress with the address portion of OwnerAddress
UPDATE nash_housing
SET OwnerSplitAddress = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', 1));

-- Adding OwnerSplitCity column
ALTER TABLE nash_housing
ADD OwnerSplitCity NVARCHAR(255);

-- Updating OwnerSplitCity with the city portion of OwnerAddress
UPDATE nash_housing
SET OwnerSplitCity = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1));

-- Adding OwnerSplitState column
ALTER TABLE nash_housing
ADD OwnerSplitState NVARCHAR(255);

-- Updating OwnerSplitState with the state portion of OwnerAddress
UPDATE nash_housing
SET OwnerSplitState = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1));

-- Retrieving all columns from the NashvilleHousing table
SELECT *
FROM nash_housing;

-- changing the y and n to yes and no

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From datacl.nash_housing
Group by SoldAsVacant
order by 2;


Update nash_housing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END;

-- removing repettes in the data


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From datacl.nash_housing
order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress;



Select *
From datacl.nash_housing;

-- droping unused collums

Select *
From datacl.nash_housing;


ALTER TABLE datacl.nash_housing
DROP COLUMN OwnerAddress,
DROP COLUMN TaxDistrict,
DROP COLUMN PropertyAddress,
DROP COLUMN SaleDate;

