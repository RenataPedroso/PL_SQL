19.	Criar um bloco PL/SQL para selecionar na tabela FORNECEDOR o fornecedor informado na 
tela em tempo de execução e controlar no programa as seguintes situações:

•	Caso não encontre registro o bloco deve ir para o EXCEPTION apresentando mensagem de 
registro não encontrado.

•	Caso encontre o registro, verificar a quantidade de estrelas para este fornecedor e:
?	Se for igual a 5, apresentar um EXCEPTION definido no programa como E_ForaEscopo com a 
mensagem ‘Fornecedor fora do escopo – Estrela = 5’. Para isso, utilize a opção RAISE.
?	Para os demais valores de ESTRELA, apresentar a mensagem: 
'Fornecedor dentro parametro pesquisa – Estrela = x’.'

DECLARE
	V_REG 			FORNECEDOR%ROWTYPE			;
	E_ForaEscopo	EXCEPTION					;
BEGIN
	SELECT 	  *
	INTO 	V_REG
	FROM 	FORNECEDOR
	WHERE 	N_FORNEC = &CODIGO			;
	IF V_REG.ESTRELA = 5 THEN
		RAISE E_ForaEscopo					;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Fornecedor dentro parametro pesquisa – Estrela = ' || V_REG.ESTRELA);
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND	THEN
		DBMS_OUTPUT.PUT_LINE('FORNECEDOR NÃO ENCONTRADO!');
	WHEN E_ForaEscopo THEN
		DBMS_OUTPUT.PUT_LINE('Fornecedor fora do escopo – Estrela = 5');
END;



