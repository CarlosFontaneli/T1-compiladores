lexer grammar LALexer;


PROGRAMA: DECLARACOES 'algoritmo' CORPO 'fim_algoritmo';
fragment DECLARACOES: (DECL_LOCAL_GLOBAL)*;
fragment DECL_LOCAL_GLOBAL: DECLARACAO_LOCAL | DECLARACAO_GLOBAL;

NUM_INT: ('0'..'9')+;
NUM_REAL: ('0'..'9')+ PONTO ('0'..'9')+;

CADEIA: ASPAS ('a'..'z' | 'A'..'Z' | ' ' | '.' | '/' | DELIM | '?' | '<' | '-' | '>' | '+' | ',' | '(' | ')' | '!' | '$' | '=' | ';')* ASPAS;
ASPAS: '"';

ALGORITMO: 'algoritmo';
FIM_ALGORITMO: 'fim_algoritmo';
FACA: 'faca';
DECLARE: 'declare';
CONSTANTE: 'constante';
TIPOO: 'tipo';
COCHESQ: '[';
COCHDIR: ']';
LITERAL: 'literal';
INTEIRO: 'inteiro';
REAL: 'real';
LOGICO: 'logico';
REGISTROO: 'registro';
FIMREGISTRO: 'fim_registro';
PROCEDIMENTO: 'procedimento';
FIMPROCED: 'fim_procedimento';
FUNCAO: 'funcao';
FIM_FUNCAO: 'fim_funcao';
VAR: 'var';
LEIA: 'leia';
ESCREVA: 'escreva';
SE: 'se';
ENTAO: 'entao';
FIM_SE: 'fim_se';
SENAO: 'senao';
CASO: 'caso';
FIM_CASO: 'fim_caso';
PARA: 'para';
FIM_PARA: 'fim_para';
ENQUANTO: 'enquanto';
FIM_ENQUANTO: 'fim_enquanto';
ATE: 'ate';
RETORNE: 'retorne';
VERDADEIRO: 'verdadeiro';
FALSO: 'falso';
SEJA: 'seja';
NAO: 'nao';

fragment CORPO: (DECLARACAO_LOCAL)* (CMD)*;

fragment DECLARACAO_LOCAL: 'declare' VARIAVEL
                | 'constante' IDENT DELIM TIPO_BASICO '=' VALOR_CONSTANTE
                | 'tipo' IDENT DELIM TIPO;
fragment DECLARACAO_GLOBAL: 'procedimento' IDENT ABREPAR (PARAMETROS)? FECHAPAR (DECLARACAO_LOCAL)* (CMD)* 'fim_procedimento'
                 | 'funcao' IDENT ABREPAR (PARAMETROS)? FECHAPAR DELIM TIPO_ESTENDIDO (DECLARACAO_LOCAL)* (CMD)* 'fim_funcao';

OP_UNARIO: '-';

fragment VARIAVEL: IDENTIFICADOR (SEPAR IDENTIFICADOR)* DELIM TIPO;
fragment IDENTIFICADOR: IDENT (PONTO IDENT)* DIMENSAO;
fragment DIMENSAO: ('[' EXP_ARITMETICA ']')*;
fragment TIPO: REGISTRO | TIPO_ESTENDIDO;
fragment TIPO_BASICO: 'literal' | 'inteiro' | 'real' | 'logico';
fragment TIPO_BASICO_IDENT: TIPO_BASICO | IDENT;
fragment TIPO_ESTENDIDO: (CIRCUNF)? TIPO_BASICO_IDENT;
fragment VALOR_CONSTANTE: CADEIA | NUM_INT | NUM_REAL | 'verdadeiro' | 'falso';
fragment REGISTRO: 'registro' (VARIAVEL)* 'fim_registro';

fragment PARAMETRO: ('var')? IDENTIFICADOR (SEPAR IDENTIFICADOR)* DELIM TIPO_ESTENDIDO;
fragment PARAMETROS: PARAMETRO (SEPAR PARAMETRO)*;

fragment CMD: CMD_LEIA | CMD_ESCREVA | CMD_SE | CMD_CASO | CMD_PARA | CMD_ENQUANTO | CMD_FACA | CMD_ATRIBUICAO | CMD_CHAMADA | CMD_RETORNE;
fragment CMD_LEIA: 'leia' ABREPAR ((CIRCUNF)? IDENTIFICADOR (SEPAR (CIRCUNF)? IDENTIFICADOR)*) FECHAPAR;
fragment CMD_ESCREVA: 'escreva' ABREPAR EXPRESSAO (SEPAR EXPRESSAO)* FECHAPAR;
fragment CMD_SE: 'se' EXPRESSAO 'entao' (CMD)* ('senao' (CMD)*)? 'fim_se';
fragment CMD_CASO: 'caso' EXP_ARITMETICA 'seja' SELECAO ('senao' (CMD)*)? 'fim_caso';
fragment CMD_PARA: 'para' IDENT '<-' EXP_ARITMETICA 'ate' EXP_ARITMETICA 'faca' (CMD)* 'fim_para';
fragment CMD_ENQUANTO: 'enquanto' EXPRESSAO 'faca' (CMD)* 'fim_enquanto';
fragment CMD_FACA: FACA (CMD)* 'ate' EXPRESSAO;
fragment CMD_ATRIBUICAO: (CIRCUNF)? IDENTIFICADOR '<-' EXPRESSAO;
fragment CMD_CHAMADA: IDENT ABREPAR EXPRESSAO (SEPAR EXPRESSAO)* FECHAPAR;
fragment CMD_RETORNE: 'retorne' EXPRESSAO;
fragment SELECAO: (ITEM_SELECAO)*;
fragment ITEM_SELECAO: CONSTANTES DELIM (CMD)*;
fragment CONSTANTES: NUMERO_INTERVALO (SEPAR NUMERO_INTERVALO)*;
fragment NUMERO_INTERVALO: (OP_UNARIO)? NUM_INT ('..' (OP_UNARIO)? NUM_INT)?;
fragment OP_RELACIONAL: '=' | '<>' | '>=' | '<=' | '>' | '<';

fragment EXP_ARITMETICA: TERMO (OP1 TERMO)*;
fragment TERMO: FATOR (OP2 FATOR)*;
fragment FATOR: PARCELA (OP3 PARCELA)*;
fragment PARCELA: (OP_UNARIO)? PARCELA_UNARIO | PARCELA_NAO_UNARIO;
fragment PARCELA_UNARIO: (CIRCUNF)? IDENTIFICADOR
              | IDENT ABREPAR EXPRESSAO (SEPAR EXPRESSAO)* FECHAPAR
              | NUM_INT
              | NUM_REAL
              | ABREPAR EXPRESSAO FECHAPAR;
fragment PARCELA_NAO_UNARIO: '&' IDENTIFICADOR | CADEIA;
fragment EXP_RELACIONAL: EXP_ARITMETICA (OP_RELACIONAL EXP_ARITMETICA)?;
fragment EXPRESSAO: TERMO_LOGICO (OP_LOGICO_1 TERMO_LOGICO)*;
fragment TERMO_LOGICO: FATOR_LOGICO (OP_LOGICO_2 FATOR_LOGICO)*;


fragment FATOR_LOGICO: NAO? PARCELA_LOGICA;
fragment PARCELA_LOGICA: ('verdadeiro' | 'falso') | EXP_RELACIONAL;
OP_LOGICO_1: 'ou';
OP_LOGICO_2: 'e';

IGNORAR: ('ã' | 'õ' | 'ç' | 'à' | 'á' | 'é' | 'è' | 'ó' | 'ò' | 'ú' | 'ù' | 'â' | ';' | 'í' | '!' | 'ê') -> skip;
ABREEE: '{ ';
ABRECHAVE: '{';
FECHACHAVE: ' }';
ESPACO: (' '|'\t'|'\r'|'\n') -> skip;

IGUAL: '=';
DIFERENTE: '<>';
MAIORIGUAL: '>=';
MENORIGUAL: '<=';
MAIOR: '>';
MENOR: '<';
MAIS: '+';
OP_DIV: '/';
OP_MULT: '*';
OP1: (MAIS | OP_UNARIO);
OP2: (OP_MULT | OP_DIV);
OP3: '%';

IDENT: ('a'..'z' | '_' | 'A'..'Z') ('a'..'z' | '_' | '0'..'9' | 'A'..'Z')*;

FLECHA: '<-';
DELIM: ':';
ABREPAR: '(';
FECHAPAR: ')';
SEPAR: ',';
PONTO: '.';
CIRCUNF: '^';
EZINHO: '&';
SEQUENCIA: '..';

ERR_SIMBOLO_NAO_PERMITIDO: ('$' | '~' | '}');

COMENTARIO:'{' ~[\r\n{}]* '}' [\r]? [\n]? -> skip;

COMENTARIO_NAO_FECHADO: ('{' | '{ ') ~('\n'| '\r' | '}')* ('\n' | '\r');

CAD_LITERAL_NAO_FECHADA: '"' (~('\n'|'\''|'\\' | '"'))* ('\n' | '\r');
