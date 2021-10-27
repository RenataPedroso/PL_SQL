SELECT	-- LISTA DE CAMPOS
INTO	-- LISTA DE VARIÁVEIS
FROM	-- NOME DA TABELA
WHERE	-- CONDICIONAL PARA FILTRAR LINHAS NA TABELA

18.	Criar um bloco PL-SQL para ler o empregado numero 7369, cuja característica das colunas
deverá ser a mesma definida na tabela EMP.
•	Calcular o novo salário que deverá ter um aumento de 8% sobre o salário atual.
•	Posteriormente, deverá ser mostrado o nome, cargo e o novo salário calculado.

DECLARE
	V_REG		EMP%ROWTYPE												;
	V_NOVOSAL	EMP.SAL%TYPE											;
BEGIN
	SELECT	*
	INTO	V_REG
	FROM	EMP
	WHERE	EMPNO = &CODIGO												;
	V_NOVOSAL := V_REG.SAL * 1.08										;
	DBMS_OUTPUT.PUT_LINE('NOME: ' || V_REG.ENAME)						;
	DBMS_OUTPUT.PUT_LINE('CARGO: ' || V_REG.JOB)						;
	DBMS_OUTPUT.PUT_LINE('SALÁRIO COM REAJUSTE DE 8%: ' || V_NOVOSAL)	;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('EMPREGADO NÃO ENCONTRADO!')	;
END;

