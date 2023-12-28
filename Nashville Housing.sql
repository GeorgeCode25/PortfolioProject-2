--Cleaning Data in SQL Query

Select * From PortfolioProject.dbo.NashvilleHousing


--Standardize Date Format
Select SaleDateConverted, Convert (Date, SaleDate)
From PortfolioProject.dbo.NashvilleHousing

Update NashvilleHousing 
SET SaleDate = Convert(Date, Saledate)

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = Convert(Date,Saledate)


--Populate Property Address Data
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]


--Breaking Out Address Into Individual Columns ( Address, City, State)

Select 
Substring(PropertyAddress,1, CHARINDEX(',', PropertyAddress) -1 ) as Address,
Substring(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))  as Address
FROM PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

Update NashvilleHousing 
SET PropertySplitAddress = Substring(PropertyAddress,1, CHARINDEX(',', PropertyAddress) -1)



PARSENAME(REPLACE(OwnerAddress, ' , ', '.') , 3)
PARSENAME(REPLACE(OwnerAddress, ' , ', '.') , 2)
PARSENAME(REPLACE(OwnerAddress, ' , ', '.') , 1)




ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing 
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ' , ', '.') , 3)



ALTER TABLE NashvilleHousing
ADD OwnerSplitCity Nvarchar(255);

Update NashvilleHousing 
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ' , ', '.') , 2)


ALTER TABLE NashvilleHousing
ADD OwnerSplitState Nvarchar(255);

Update NashvilleHousing 
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ' , ', '.') , 1)



--Change Y and N to Yes and No in "Sold as Vacant" Field
SELECT Distinct (SoldasVacant), COUNT(SoldAsVacant)
FROM NashvilleHousing
GROUP by SoldAsVacant
Order by 2

SELECT SoldAsVacant, 
CASE
When SoldAsVacant = 'Y'  THEN 'Yes'
 When SoldAsVacant = 'N' THEN 'No'
 ELSE SoldAsVacant 
 END
 FROM NashvilleHousing

Update NashvilleHousing
 SET SoldAsVacant =
CASE
When SoldAsVacant = 'Y'  THEN 'Yes'
 When SoldAsVacant = 'N' THEN 'No'
 ELSE SoldAsVacant 
 END
 FROM NashvilleHousing

--REMOVE Duplicates

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


-- Delete Unused Columns

Select *
From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate



