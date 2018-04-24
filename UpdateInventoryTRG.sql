
/**C##CARDENAS276_P	

@ULICES CARDENAS LAB 7
TRIGGER
*/


CREATE OR REPLACE TRIGGER UpdateInventoryTRG 
BEFORE UPDATE ON INVENTORY 
FOR EACH ROW

DECLARE
        QTY_TOO_LOW EXCEPTION; 
        PRAGMA EXCEPTION_INIT(QTY_TOO_LOW, -20111);
       

BEGIN
        
        IF :NEW.StockQTY < 0 THEN
        RAISE QTY_TOO_LOW;
        END IF;
        
       
        DBMS_OUTPUT.PUT_LINE('QUANTITY IN STOCK '|| :NEW.StockQTY);


EXCEPTION 
        WHEN QTY_TOO_LOW THEN 
        RAISE;
        WHEN OTHERS THEN
        RAISE;
        
    
END;
/