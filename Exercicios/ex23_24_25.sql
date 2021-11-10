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

CREATE TABLE PRODUTO
(codigo NUMBER(4) primary key,nome VARCHAR2(20),valor NUMBER(7,2),
 categoria NUMBER(4));
 
CREATE OR REPLACE PROCEDURE CONSULTAR_PRODUTO
(
	V_COD	IN	PRODUTO.CODIGO%TYPE		,
	V_NOME	OUT	PRODUTO.NOME%TYPE		,
	V_VALOR	OUT	PRODUTO.VALOR%TYPE		,
	V_CATEG	OUT	PRODUTO.CATEGORIA%TYPE
)
IS
BEGIN
	SELECT
	(NOME, VALOR, CATEGORIA)  -- OPCIONAL
	FROM
	PRODUTO WHERE CODIGO = V_COD; 
    
    DBMS_OUTPUT.PUT_LINE('PRODUTO' || V_NOVOSAL)	;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('CÓDIGO DO PRODUTO NÃO FOI ENCONTRADO!');
END CONSULTAR_PRODUTO; 

-------------------------

--EXECUTANDO A PROCEDURE

EXEC CONSULTAR_PRODUTO(&V_COD)

-- PROCEDURE PARA CRIAR NOVOS FUNCIONARIOS NA TABELA
CREATE OR REPLACE PROCEDURE novos_empregados
	(
		v_emp_no 		IN 	emp.empno%TYPE		,
		v_emp_name 		IN 	emp.ename%TYPE		,
		v_emp_job 		IN 	emp.job%TYPE		,
		v_emp_hiredate	IN 	emp.hiredate%TYPE	,
		v_emp_sal 		IN 	emp.sal%TYPE		,
		v_dept_no 		IN 	emp.deptno%TYPE
	)
IS
BEGIN
	INSERT INTO emp (empno, ename, job,  hiredate, sal, deptno )
	VALUES
	(v_emp_no, v_emp_name, v_emp_job, v_emp_hiredate, v_emp_sal,     v_dept_no);
	COMMIT;
END novos_empregados;

-------------------------------------------

-- PARA EXECUTAR A PROCEDURE:

EXEC NOVOS_EMPREGADOS (1,'JOÃO', 'GERENTE', '10/05/2011', 5600, 30)

-- PROCEDURE PARA FORMATAR TELEFONE
CREATE OR REPLACE PROCEDURE formata_telefone
	(v_phone_no 	IN OUT 	varchar)
IS
BEGIN
  v_phone_no := SUBSTR (v_phone_no,1,5) || '-' || SUBSTR (v_phone_no,6,4);
  Dbms_output.put_line('Telefone:  ' || v_phone_no);
END formata_telefone;


912345678   -- IN

91234-5678  -- OUT


-- EXECUTANDO A PROCEDURE

DECLARE
    v_phone_no  varchar(15) := '&v_phone_no';
BEGIN
    formata_telefone (v_phone_no);
END;

-- 23 Criar uma procedure para inclusão de dados na tabela produto.
-- Execute antes o comando para criação da tabela PRODUTO, conforme abaixo:

CREATE TABLE produto
(codigo NUMBER(4) primary key,nome VARCHAR2(20),valor NUMBER(7,2),
 categoria NUMBER(4));
 
---------------------

CREATE OR REPLACE PROCEDURE INSERE_PRODUTO
(
	V_COD	IN	PRODUTO.CODIGO%TYPE		,
	V_NOME	IN	PRODUTO.NOME%TYPE		,
	V_VALOR	IN	PRODUTO.VALOR%TYPE		,
	V_CATEG	IN	PRODUTO.CATEGORIA%TYPE
)
IS
BEGIN
	INSERT INTO PRODUTO
	(CODIGO, NOME, VALOR, CATEGORIA)  -- OPCIONAL
	VALUES
	(V_COD, V_NOME, V_VALOR, V_CATEG)	;
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE('CÓDIGO DO PRODUTO JÁ CADASTRADO!');
END INSERE_PRODUTO; 

-------------------------

--EXECUTANDO A PROCEDURE

EXEC INSERE_PRODUTO(&CODIGO, '&NOME', &VALOR, &CATEGORIA)

-- 24 Criar uma procedure para consultar um produto na tabela PRODUTO, 
-- informando o código através de parâmetro. Apresentar seu nome, valor e 
-- categoria.

Nota: Tratar erro caso o produto não seja encontrado.

Nota: Para executar a procedure, faça um bloco PL/SQL que chame a procedure 
passando parâmetro.

CREATE OR REPLACE PROCEDURE CONSULTA_PRODUTO
(
	V_COD	IN	PRODUTO.CODIGO%TYPE
)
IS -- EQUIVALENTE AO DECLARE
	V_NOME	PRODUTO.NOME%TYPE			;
	V_VALOR	PRODUTO.VALOR%TYPE			;
	V_CATEG PRODUTO.CATEGORIA%TYPE		;
BEGIN
	SELECT 	NOME, 	VALOR,	 CATEGORIA
	INTO	V_NOME, V_VALOR, V_CATEG
	FROM	PRODUTO
	WHERE	CODIGO = V_COD				;
	DBMS_OUTPUT.PUT_LINE('CÓDIGO: ' || V_COD)		;
	DBMS_OUTPUT.PUT_LINE('NOME: ' || V_NOME)		;
	DBMS_OUTPUT.PUT_LINE('CATEGORIA: ' || V_CATEG)	;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('CÓDIGO NÃO ENCONTRADO!')	;
END CONSULTA_PRODUTO;

--------------

-- EXECUTANDO A PROCEDURE

DECLARE
	V_COD	PRODUTO.CODIGO%TYPE	:= &CODIGO	;
BEGIN
	CONSULTA_PRODUTO(V_COD)	;
END;

-- 25.	Criar a procedure NOTAS para atualizar valores em alguns campos da tabela
-- ALUNO, conforme as seguintes regras:

-- ?	MEDIA: (NOTA1+NOTA2)/2

-- ?	RESULTADO: MEDIA >= 7 ? 'APROVADO '

-- ?	RESULTADO: MEDIA <   7 ?  'EXAME '

-- Nota: Antes da procedure, criar a tabela e inserir linhas, conforme comandos 
-- abaixo:

CREATE TABLE ALUNO (RA NUMBER(5) PRIMARY KEY, NOME VARCHAR2(20),
NOTA1 NUMBER(3,1), NOTA2 NUMBER(3,1), MEDIA NUMBER(3,1), 
RESULTADO VARCHAR2(10));

INSERT INTO ALUNO (RA,NOME,NOTA1,NOTA2) VALUES (1,'ANTONIO',9,7);
INSERT INTO ALUNO (RA,NOME,NOTA1,NOTA2) VALUES (2,'BEATRIZ',4,6);
INSERT INTO ALUNO (RA,NOME,NOTA1,NOTA2) VALUES (3,'CLAUDIO',8,6);

---------------------

CREATE OR REPLACE PROCEDURE NOTAS
IS
	CURSOR C_ALUNO IS SELECT * FROM ALUNO	;
	V_MEDIA		ALUNO.MEDIA%TYPE			;
	V_RESULT 	ALUNO.RESULTADO%TYPE		;
BEGIN
	FOR V_REGALUNO IN C_ALUNO LOOP
		V_MEDIA := (V_REGALUNO.NOTA1 + V_REGALUNO.NOTA2) / 2 ;
		IF V_MEDIA >= 7 THEN
			V_RESULT := 'APROVADO'	;
		ELSE
			V_RESULT := 'REPROVADO'	;
		END IF;	
		UPDATE ALUNO
		SET
		MEDIA = V_MEDIA, RESULTADO = V_RESULT
		WHERE RA = V_REGALUNO.RA			;
	END LOOP;	
	DBMS_OUTPUT.PUT_LINE('REGISTROS ATUALIZADOS COM SUCESSO!');
END NOTAS;

---------------

-- EXECUTANDO A PROCEDURE

EXEC NOTAS