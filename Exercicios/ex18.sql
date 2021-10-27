SELECT	-- LISTA DE CAMPOS
INTO	-- LISTA DE VARI�VEIS
FROM	-- NOME DA TABELA
WHERE	-- CONDICIONAL PARA FILTRAR LINHAS NA TABELA

18.	Criar um bloco PL-SQL para ler o empregado numero 7369, cuja caracter�stica das colunas
dever� ser a mesma definida na tabela EMP.
�	Calcular o novo sal�rio que dever� ter um aumento de 8% sobre o sal�rio atual.
�	Posteriormente, dever� ser mostrado o nome, cargo e o novo sal�rio calculado.

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
	DBMS_OUTPUT.PUT_LINE('SAL�RIO COM REAJUSTE DE 8%: ' || V_NOVOSAL)	;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('EMPREGADO N�O ENCONTRADO!')	;
END;

