USE mm_cpsc502101team01;
/* ============== 
SUPERVET MILESTONE 2
TEAM MEMBERS:
	DUC VO
	JOU HO
	KHANH LE
	SAM FARMER
================ */

/* 1. Display all prescriptions and medicine for all pets of a customer, looked up by customer's email */
-- Help retrieve medication history for all customer's pets
SELECT prescriptionID, 
Pet.name AS `pet_name`, 
Product.productID,
Product.name AS `drug_name`,
PrescriptionProduct.quantity,
PrescriptionProduct.unit, 
PrescriptionProduct.description,
Prescription.createdAt AS `prescribed_ date`
FROM Prescription
JOIN PrescriptionProduct USING (prescriptionID)
JOIN Product USING (productID)
JOIN Pet USING (petID)
JOIN Customer USING (customerID)
WHERE Customer.email = 'dbevanslp@feedburner.com' 
ORDER BY Pet.name;

/* 2. Calculate Total Prescription Cost for each pet of a customer, provided customerID */
-- Help retrive useful data for customer when asked
SELECT petID,
Pet.name as `pet_name`, 
ROUND(SUM(PrescriptionProduct.quantity * Product.price),2) AS `Total Prescription Cost`
FROM Prescription
JOIN PrescriptionProduct USING (prescriptionID)
JOIN Product USING (productID)
JOIN Pet USING (petID)
JOIN Customer USING (customerID)
WHERE customerID = 1781 
GROUP BY petID
ORDER BY Pet.name;

/* 3. Find out average prescription cost for a pet of customers who live in Washington state */
-- This statistic helps with target prescription cost range for specific area
SELECT ROUND(AVG(prescription_cost), 2) AS `Average Washington Prescription Cost` FROM (
	SELECT SUM(Product.price * PrescriptionProduct.quantity) AS prescription_cost 
	FROM Customer 
	JOIN Pet USING (customerID)
	JOIN Prescription USING (petID)
	JOIN PrescriptionProduct USING (prescriptionID)
	JOIN Product USING (productID)
	WHERE state = "Washington"
	GROUP BY prescriptionID
) AS PrescriptionCost;


/* 4. Find out customers who paid for the above average price product in store and when they bought it */
-- This will help with marketing strategy such as send out ads or promotion.
SELECT customerID, first_name, last_name, email,
Product.name AS `product_name`, Product.price, 
SaleProduct.quantity,
SaleProduct.createdAt AS `purchased_date`
FROM Customer
JOIN Payment USING (customerID)
JOIN SaleProduct USING (saleID)
JOIN Product USING (productID)
WHERE productID IN (
	SELECT productID FROM Product
	WHERE price > (SELECT AVG(price) FROM Product)
)
ORDER BY Product.price DESC;


/* 5. This query will return a list of vets 
whose login password is less than 8 characters 
and does not contain special characters (alphanumerics) */
SELECT vetID, first_name, last_name, email
FROM Vet
WHERE LENGTH(password) < 8 AND password NOT LIKE '%[^a-zA-Z0-9]%';


/* 6. This query will return a list of proucts 
and their total sale price in descending order */
SELECT productID, name, price, SP.quantity, category, (price * SP.quantity) AS totalsale
FROM SaleProduct SP
JOIN Product P USING (productID)
ORDER BY totalsale DESC;

/* 7. This query will return a list of states where the customers reside, 
and the total number of customers in each state in descending order */
SELECT state, COUNT(state) AS totalcustomer
FROM Customer
GROUP BY state
ORDER BY totalcustomer DESC;

/* Call the stored procedure for petID 1996 to retrieve prescibed medication history */
CALL pet_medication_history(1996);


