/**C##CARDENAS276_P	

@ULICES CARDENAS LAB 7
STORED PROCEDURE
*/

CREATE OR REPLACE PROCEDURE addLineItemSP
(psORDERID NUMBER ,psPARTID NUMBER, psQTY NUMBER) IS

    QTY_TOO_LOW EXCEPTION; 
    PRAGMA EXCEPTION_INIT(QTY_TOO_LOW, -20111);
    
BEGIN
        INSERT INTO ORDERITEMS
        (ORDERID,PARTID,QTY)
        VALUES
        (psORDERID,psPARTID, psQTY);
        DBMS_OUTPUT.PUT_LINE('NEW LINE ITEM INSERTED ');
        
        
EXCEPTION
        WHEN QTY_TOO_LOW THEN
        DBMS_OUTPUT.PUT_LINE('QUANTITY TOO LOW');
        ROLLBACK;
        WHEN OTHERS THEN
        RAISE;
END;












