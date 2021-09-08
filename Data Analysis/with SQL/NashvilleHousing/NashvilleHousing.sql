select * from NashvilleHousing;

---------------------------------------
--STANDARDISE DATE FORMAT

select Saledate,convert(Date,saledate)
from NashvilleHousing;


alter table NashvilleHousing
add SaleDateConverted Date;

update NashvilleHousing
set SaleDateConverted=convert(date,saledate);


---------------------------------------------------------

--Populate Property Address data
select ParcelID--propertyaddress
from NashvilleHousing 
where PropertyAddress=NULL
order by ParcelID

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress--,isnull(a.propertyaddress,b.prppertyaddress)
from nashvillehousing a
join nashvillehousing b
on a.ParcelID=b.ParcelID
where a .PropertyAddress=NULL

update a
set propertyaddress=isnull(a.propertyaddress,b.propertyaddress)
from NashvilleHousing a join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID]<>b.[UniqueID]
where a.PropertyAddress is null

----------------------------------------------------
--BReaking our Address into INdividual Columns (Address,City,State)

select Propertyaddress
FROM NashvilleHousing

SELECT 
substring(Propertyaddress,1,CHARINDEX(',',PropertyAddress)-1) as Address
,substring(Propertyaddress,CHARINDEX(',',PropertyAddress)+1,len(Propertyaddress)) as State
from NashvilleHousing

alter table NashvilleHousing
add PropertySplitAddress nvarchar(100);

update NashvilleHousing
set PropertySplitAddress=substring(Propertyaddress,1,CHARINDEX(',',PropertyAddress)-1)



alter table NashvilleHousing
add PropertySplitCity nvarchar(100);

update NashvilleHousing
set PropertySplitCity=substring(Propertyaddress,CHARINDEX(',',PropertyAddress)+1,len(Propertyaddress))


select * from NashvilleHousing;
------------------------------------------------------------------------------------------------------------
select Owneraddress from NashvilleHousing


select
PARSENAME(REPLACE(Owneraddress,',','.'),3),
PARSENAME(REPLACE(Owneraddress,',','.'),2),
PARSENAME(REPLACE(Owneraddress,',','.'),1)
from NashvilleHousing

/*
alter table NashvilleHousing
add OwnerSplitAddress nvarchar(100),
add OwnerSplitCity nvarchar(100),
add OwnerSplitState nvarchar(100);
--AND

update NashvilleHousing
set OwnerSplitAddress=PARSENAME(REPLACE(Owneraddress,',','.'),3) and
set OwnerSplitCity=PARSENAME(REPLACE(Owneraddress,',','.'),2) and
set OwnerSplitState=PARSENAME(REPLACE(Owneraddress,',','.'),1);*/


alter table NashvilleHousing
add OwnerSplitAddress nvarchar(100);

update NashvilleHousing
set OwnerSplitAddress=PARSENAME(REPLACE(Owneraddress,',','.'),3)
---

alter table NashvilleHousing
add OwnerSplitCity nvarchar(100);

update NashvilleHousing
set OwnerSplitCity=PARSENAME(REPLACE(Owneraddress,',','.'),2)

alter table NashvilleHousing
add OwnerSplitState nvarchar(100);

update NashvilleHousing
set OwnerSplitState=PARSENAME(REPLACE(Owneraddress,',','.'),1)

select * from NashvilleHousing;
------------------------------------------------------------------------------------------------------------


select distinct soldasvacant
from NashvilleHousing;

update NashvilleHousing
set SoldAsVacant=case 
					when SoldAsVacant='Y' then 'Yes'
					when SoldAsVacant='N' then 'No'
					when SoldAsVacant='Yeah' then 'Yes'
				end
where SoldAsVacant in ('Y','N','Yeah')

select distinct soldasvacant
from NashvilleHousing;

/* select case when SoldAsVacant='Y' then 'Yes'
					when SoldAsVacant='N' then 'No'
					when SoldAsVacant='Yeah' then 'Yes'
					else SoldAsVacant
				end
				*/

-----------------------------------------------
-- Remove Duplicates

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

From PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress



Select *
From PortfolioProject.dbo.NashvilleHousing




---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns



Select *
From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate















-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--- Importing Data using OPENROWSET and BULK INSERT	

--  More advanced and looks cooler, but have to configure server appropriately to do correctly
--  Wanted to provide this in case you wanted to try it


--sp_configure 'show advanced options', 1;
--RECONFIGURE;
--GO
--sp_configure 'Ad Hoc Distributed Queries', 1;
--RECONFIGURE;
--GO


--USE PortfolioProject 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1 

--GO 


---- Using BULK INSERT

--USE PortfolioProject;
--GO
--BULK INSERT nashvilleHousing FROM 'C:\Temp\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv'
--   WITH (
--      FIELDTERMINATOR = ',',
--      ROWTERMINATOR = '\n'
--);
--GO


---- Using OPENROWSET
--USE PortfolioProject;
--GO
--SELECT * INTO nashvilleHousing
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
--    'Excel 12.0; Database=C:\Users\alexf\OneDrive\Documents\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv', [Sheet1$]);
--GO
 
---------------------------------------------


