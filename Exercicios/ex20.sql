20.	Criar um bloco PL/SQL para incluir registros na tabela TITULO para todos os clientes cadastrados na tabela CLIENTE cujo status seja ATIVO. 

Para cada parcela existente na tabela CLIENTE, 1 registro de t�tulo dever� ser inserido na tabela TITULO, ou seja, se o cliente escolheu pagar em 5 parcelas, fa�a uma rotina que insira 5 novos registros na tabela TITULO, de acordo com as condi��es abaixo:
�	CODIGO = CODIGO DO CLIENTE

�	NUMERO DO TITULO = SEQUENCIAL A PART�R DE 1, PARA CADA CLIENTE SELECIONADO (Para isso, crie uma sequ�ncia)

�	VALOR DO TITULO = VALOR DA VENDA DIVIDIDO PELO N�MERO DE PARCELAS

�	VALOR DOS JUROS = 0

�	VALOR DOS DESCONTOS = 0

�	VALOR PAGO = 0

�	DATA DE EMISS�O = EMISS�O DA NOTA FISCAL DO CLIENTE

�	DATA DE VENCTO = DEVER� SER DE 30 EM 30 DIAS A PARTIR DA EMISS�O PARA CADA T�TULO

�	DATA DE PAGAMENTO = NULO


Observa��es: Dever� ser utilizado CURSOR com registro ou com vari�veis

Criar o cursor fora do c�digo:

DROP SEQUENCE seq_numtit;
CREATE SEQUENCE seq_num_tit INCREMENT BY 1 START WITH 01;

-- RESOLU��O

DECLARE
	CURSOR c_cliente IS SELECT codigo, parcela, valor_nota,  emissao_nota 
	FROM cliente WHERE status = 'A';
	V_REG		C_CLIENTE%ROWTYPE		;
	V_PARC		NUMBER(2)				;
	V_VALTIT	TITULO.VALOR_TITULO%TYPE;
	V_VENC		DATE					;
BEGIN
	OPEN 	C_cliente;
 	FETCH 	C_cliente INTO V_REG;
   	WHILE 	C_cliente%FOUND LOOP
			V_PARC:= 0;
			V_VALTIT:= V_REG.valor_nota / V_REG.parcela	;
			v_venc	:= V_REG.emissao_nota				;
			WHILE V_PARC <  V_REG.parcela  LOOP
				v_venc:= v_venc + 30;
				Insert into titulo
				Values
				(seq_numtit.nextval,v_reg.codigo, v_valtit,0,0,0,v_reg.emissao_nota,v_venc,null);
            	V_parc:= V_parc + 1;
			END LOOP;
         	FETCH C_cliente INTO V_REG;
  	END LOOP;
   	CLOSE C_cliente;
	DBMS_OUTPUT.PUT_LINE('REGISTROS INSERIDOS COM SUCESSO!');
END;


sempre que retornar mais de um elemento, trabalhar com cursor, depois com vari�veis de mem�ria
O cursor abre um espa�o tempor�rio na memoria para que possamos trabalhar com os dados
criar uma sequencia com create sequence seq increment by 1 start with 01, mas primeiro dar um drop sequence seq
criar um cursor dentro do declare
o v_reg precisa ser compat�vel com o cursor e ser rowtype


