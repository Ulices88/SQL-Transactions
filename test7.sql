/**C##CARDENAS276_P	

@ULICES CARDENAS LAB 7
TESTS
*/


SELECT * 
FROM ORDERITEMS OI JOIN INVENTORY I ON OI.PARTID = I.PARTID
WHERE ORDERID = 6099;
/*
* GOOD  NUMBERS
*/
@Lab7 1 6099 1001 15


SELECT * 
FROM ORDERITEMS OI JOIN INVENTORY I ON OI.PARTID = I.PARTID
WHERE ORDERID = 6099;
/*
GOOD CUSTID, BAD ORDER ID
*/
@Lab7 1 9999 1001 15
/*
GOOD CUSTID, GOOD ORDER ID NO MATCH IN ORDER
*/
@Lab7 1 6109 1001 15
/*
GOOD CUSTID, GOOD ORDERID, MATCH, BAD PART ID
*/

@Lab7 1 6099 1999 15

/*
GOOD CUSTID, GOOD ORDERID, GOOD PART ID, QTY INPUT < 0
*/

@Lab7 1 6099 1001 -1

/*
GOOD CUSTID, GOOD ORDERID, GOOD PART ID, QTY IN STOCKQTY FALLS <= 0
*/
@Lab7 1 6099 1001 200
