/**C##CARDENAS276_P	

@ULICES CARDENAS LAB 7
*/


DECLARE

    inCustid  NUMBER := &1;
    inOrderid NUMBER := &2;
    inPartid  NUMBER := &3;
    inQty     NUMBER := &4; 
    v_Flag    CHAR(1) :='N';
   
    vCustid   NUMBER;
    vOrderid  NUMBER;
    vPartid   NUMBER;
    vQty      NUMBER;
    vDetail   NUMBER;
    
    Invalid_CustomerID  EXCEPTION;
    Invalid_OrderID  EXCEPTION;
    No_Match         EXCEPTION;
    Part_Not_Exists  EXCEPTION;
    Inadequate_Qty   EXCEPTION;
    Part_Not_Exist   EXCEPTION;
    vERROR           VARCHAR(200);
    QTY_TOO_LOW      EXCEPTION;
    PRAGMA EXCEPTION_INIT(QTY_TOO_LOW, -20111);
   
BEGIN
    DBMS_OUTPUT.PUT_LINE('LAB 6 BY YUNII' );
    DBMS_OUTPUT.PUT_LINE('---------------------------------');

     BEGIN 
        SELECT C.CUSTID
        INTO vCustid
        FROM CUSTOMERS C
        WHERE C.CUSTID = inCustid;
        DBMS_OUTPUT.PUT_LINE('CUSTOMER ID ' || vCustid|| ' FOUND' );
     EXCEPTION 
        WHEN NO_DATA_FOUND THEN
        RAISE Invalid_CustomerID;
     END;
     
     
     BEGIN
        SELECT O.ORDERID
        INTO  vOrderid
        FROM  ORDERS O
        WHERE O.ORDERID = inOrderid;
        DBMS_OUTPUT.PUT_LINE('Order ID '|| vOrderid||' FOUND');
     EXCEPTION 
        WHEN NO_DATA_FOUND THEN
        RAISE Invalid_OrderID;
     END;
     
     
     BEGIN
        SELECT 'Y'
        INTO v_Flag
        FROM ORDERS O
        WHERE CUSTID = inCustid
        AND O.ORDERID = inOrderid;
        DBMS_OUTPUT.PUT_LINE(v_Flag||'ES MATCHED CUSTOMER ID '||vCUSTID||
        ' ON ORDER NUMBER '||vOrderid);
     EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RAISE No_Match;
     END;
      

    BEGIN
        SELECT I.PARTID
        INTO  vPartid
        FROM  INVENTORY I
        WHERE I.PARTID = inPartid;
        DBMS_OUTPUT.PUT_LINE( 'PART NUMBER ' || vPartid||' FOUND');
        EXCEPTION 
        WHEN NO_DATA_FOUND THEN
        RAISE Part_Not_Exist;
    END;
    
      BEGIN
        IF inQTY > 0 THEN 
        DBMS_OUTPUT.PUT_LINE('Qty '||inQty||' ENTERED');

        ELSE
        RAISE Inadequate_Qty;
        END IF;
     END;
      
BEGIN
     addLineItemSP(vOrderid,vPartid,inQTY);
     COMMIT;
END;
     

EXCEPTION 
      WHEN Invalid_CustomerID THEN
      vERROR :=' NOT A VALID CUSTOMER ID ';
      DBMS_OUTPUT.PUT_LINE('---------------------------------');
      DBMS_OUTPUT.PUT_LINE(vERROR);
      
      WHEN Invalid_OrderID THEN
      vERROR :='NOT A VALID ORDER ID';
      DBMS_OUTPUT.PUT_LINE('---------------------------------');
      DBMS_OUTPUT.PUT_LINE(vERROR);
      
      WHEN No_Match THEN
      vERROR := ' NO MATCH FOR CUSTOMER ID WITH THAT ORDER ID';
      DBMS_OUTPUT.PUT_LINE('---------------------------------');
      DBMS_OUTPUT.PUT_LINE(vERROR);
      
      WHEN Part_Not_Exist THEN 
      vERROR := ' INVALID PART ID';
      DBMS_OUTPUT.PUT_LINE('---------------------------------');
      DBMS_OUTPUT.PUT_LINE(vERROR);
      
      WHEN Inadequate_Qty THEN
      vERROR :='INADEQUATE QUANTITY MUST BE A VALUE GREATER THAN 0';
      DBMS_OUTPUT.PUT_LINE('---------------------------------');
      DBMS_OUTPUT.PUT_LINE(vERROR);
      
      WHEN QTY_TOO_LOW THEN
      vERROR :='RESULTING STOCKQTY LESS THAN 0';
      DBMS_OUTPUT.PUT_LINE('---------------------------------');
      DBMS_OUTPUT.PUT_LINE(vERROR);
      DBMS_OUTPUT.PUT_LINE('TRANSACTION ROLLED BACK');
      ROLLBACK;
      
      WHEN NO_DATA_FOUND THEN 
      vError := 'NO DATA FOUND';
      DBMS_OUTPUT.PUT_LINE('---------------------------------');
      DBMS_OUTPUT.PUT_LINE(vERROR);
      
      WHEN OTHERS THEN
      vError := SQLERRM;
      DBMS_OUTPUT.PUT_LINE('---------------------------------');
      DBMS_OUTPUT.PUT_LINE(vError);
       
END;
/