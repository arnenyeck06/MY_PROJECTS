--4 Create several procedures to accept product number and produce the following result
# a. Procedure Get_Product_Num_Cust
# i. Receives product number as input and produces number of customers purchased that product as output*/

CREATE OR REPLACE PROCEDURE GET_PRODUCT_NUM_CUST
      (PROD_NO IN NUMBER) IS
      NUM_CUST NUMBER;
BEGIN
   SELECT COUNT(DISTINCT O.CUSTOMER_NO) AS NUM_CUST
   INTO NUM_CUST
   FROM PRODUCT P
   INNER JOIN ORDERLINE OL ON P.PRODUCT_NO = OL.PRODUCT_NO
   INNER JOIN ORDERS O ON OL.ORDER_NO = O.ORDER_NO
   INNER JOIN CUSTOMER C ON C.CUSTOMER_NO = O.CUSTOMER_NO
   WHERE P.PRODUCT_NO = PROD_NO;
   
   DBMS_OUTPUT.PUT_LINE('NUMBER OF PURCHASE FOR : ' || PROD_NO || ' IS, ' || NUM_CUST);
END ;


/*


# b. Procedure Get_ Product_Cust_Purchases
# i. Receives Product number as input and produces total purchases by all customer of that product as output*/

CREATE OR REPLACE PROCEDURE GET_PRODUCT_CUST_PURCHASE
   (PROD_NO IN NUMBER) IS
   TOT_PURCH NUMBER;
BEGIN
   SELECT ROUND(SUM(O.TOTAL_AMT), 3) AS TOTAL_PURCHASE
   INTO TOT_PURCH
   FROM PRODUCT P
   INNER JOIN ORDERLINE OL ON P.PRODUCT_NO = OL.PRODUCT_NO
   INNER JOIN ORDERS O ON OL.ORDER_NO = O.ORDER_NO
   INNER JOIN CUSTOMER C ON C.CUSTOMER_NO = O.CUSTOMER_NO
   WHERE P.PRODUCT_NO = PROD_NO;
   
   DBMS_OUTPUT.PUT_LINE('THE TOTAL PURCHASE FOR THE PRODUCT: ' || PROD_NO || ' IS $' || TOT_PURCH);
END;


# /*c. Procedure Get_product_Num_orders
# i. Receives product number as input and produces number of orders by all customers for that product as output
# */
DROP PROCEDURE GET_PRODUCT_NUM_ORDERS;


CREATE OR REPLACE PROCEDURE GET_PRODUCT_NUM_ORDERS
   (PROD_NO IN NUMBER) IS
   TOT_ORDS NUMBER;
BEGIN
   SELECT COUNT(O.ORDER_NO) AS TOTAL_ORDERS
   INTO TOT_ORDS
   FROM PRODUCT P
   INNER JOIN ORDERLINE OL ON P.PRODUCT_NO = OL.PRODUCT_NO
   INNER JOIN ORDERS O ON OL.ORDER_NO = O.ORDER_NO
   INNER JOIN CUSTOMER C ON C.CUSTOMER_NO = O.CUSTOMER_NO
   WHERE P.PRODUCT_NO = PROD_NO;
   
   DBMS_OUTPUT.PUT_LINE('THE TOTAL ORDERS FOR THE PRODUCT: ' || PROD_NO || ' IS ' || TOT_ORDS);
END;


# /*Part3: Using OES4, answer the following queries with user defined functions

# 6. Create several user defined functions to accept product number and produce the following result
# a. Function Get_Product_Num_Cust
# */

CREATE OR REPLACE FUNCTION GET_PRODUCT_NUM_CUST
     (CUSTOMER1 IN VARCHAR2)
      RETURN NUMBER IS
    CURSOR A IS
SELECT  COUNT(PRODUCT_NO) TOT
FROM OES4.PRODUCT
WHERE CUSTOMER_NO=CUSTOMER1;
   A_VAR       A%ROWTYPE;
   BEGIN
     OPEN A;
     FETCH A INTO A_VAR;
     IF A%NOTFOUND THEN
         RETURN 'NO PRODUCT';
     ELSE
         RETURN A_VAR.TOT;
     END IF;
   END;
/


# b. Function Get_ Product_Cust_Purchases
# i. Receives Product number as input and produces total purchases by all customer of that product as output
# */
CREATE OR REPLACE FUNCTION GET_ PRODUCT_CUST_PURCHASES
     (CUSTOMER1 IN VARCHAR2)
      RETURN NUMBER IS
    CURSOR A IS
SELECT  COUNT(PRODUCT_NO) TOT
FROM OES4.PRODUCT
WHERE CUSTOMER_NO=CUSTOMER1;
   A_VAR       A%ROWTYPE;
   BEGIN
     OPEN A;
     FETCH A INTO A_VAR;
     IF A%NOTFOUND THEN
         RETURN 'NO PRODUCT';
     ELSE
         RETURN A_VAR.TOT;
     END IF;
   END;
/



# /*i. Receives product number as input and produces number of orders by all customers for that product as output
# */

CREATE OR REPLACE FUNCTION GET_PRODUCT_NUM_ORDERS
     (CUSTOMER1 IN VARCHAR2)
      RETURN NUMBER IS
    CURSOR A IS
SELECT  COUNT(PRODUCT_NO) TOT
FROM OES4.ORDERS
WHERE CUSTOMER_NO=CUSTOMER1;
   A_VAR       A%ROWTYPE;
   BEGIN
     OPEN A;
     FETCH A INTO A_VAR;
     IF A%NOTFOUND THEN
         RETURN 'NO ORDER';
     ELSE
         RETURN A_VAR.TOT;
     END IF;
   END;
/

/*


# 7 Develop SQL program to call these udfs
# PRODUCT#, TOTAL_SALES, TOTAL_NUMBER_ORDERS
# */

DECLARE
FUNCTION GET_PRODUCT_NUM_ORDERS(PRODNO1 IN NUMBER) IS
    BEGIN
            DBMS_OUTPUT.PUT_LINE('PRODUCT_NO          NUMBER_OF_ORDERS');
    FOR A IN (SELECT PRODUCT_NO, COUNT(PRODUCT_NO) AS NO_OF_ORDERS FROM ( SELECT * FROM ORDERLINE L, ORDERS O WHERE L.ORDER_NO=O.ORDER_NO) WHERE PRODUCT_NO=PRODNO1 GROUP BY PRODUCT_NO)
              LOOP
            DBMS_OUTPUT.PUT_LINE(A.PRODUCT_NO ||LPAD(A.NO_OF_ORDERS,25));
              END LOOP;
    END;
BEGIN
     GET_PRODUCT_NUM_ORDERS(120);
END;
