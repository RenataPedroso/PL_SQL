DECLARE

    v_id FORNECEDOR.N_FORNEC%TYPE := &id;
    v_endereco FORNECEDOR.ENDERECO%TYPE;
    v_venda FORNECEDOR.VENDA%TYPE;
    
BEGIN

    SELECT ENDERECO, VENDA
    INTO v_endereco, v_venda
    FROM FORNECEDOR 
    WHERE N_FORNEC = v_id;
    
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_id);
    DBMS_OUTPUT.PUT_LINE('Endereco: ' || v_endereco);
    DBMS_OUTPUT.PUT_LINE('Vendas: ' || v_venda);
    
EXCEPTION

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ID não encontrado.');
        
END;

SET VERIFY OFF;
SET SERVEROUTPUT ON;