grammar Mx;

program : commDef* mainDef commDef* EOF;

mainDef : 'int main()' suite ;

suite : '{' statement* '}';

commDef 
    : classDef
    | functionDef
    ;

classDef
    : Class Identifier '{' (statement | functionDef)* 
        (Identifier '(' (basictype Identifier)* ')' suite)?
        '}' ';'
    ;
        
functionDef :  (basictype | Void) Identifier '(' (basictype Identifier)* ')' suite;

basictype
    : Bool
    | Int
    | String
    ;

ifstmt
    : If '(' expression ')' 
        '{' statement '}'
        ( '{' statement '}' )?
    ;

whilestmt
    : While '(' expression ')'
        '{' statement '}'
    ;

forstmt
    : For '(' expression? ';' expression? ';' expression? ')' 
        '{' statement '}'
    ;

varDef
    : (basictype | Identifier) Identifier
    | (basictype | Identifier) Identifier ('[' ']')+ expression
    | (basictype | Identifier) expression
    ;

statement
    : suite                                                 
    | varDef                                              
    | ifstmt                                                
    | forstmt                                               
    | whilestmt                                             
    | jumpstmt                                              
    | expression ';'                                        
    | ';'                                                   
    ;

jumpstmt
    : Return expression? ';'                                
    | Break ';'                                             
    | Continue ';'
    ;

expression
    : primary                                               
    | expression '.' Identifier                             
    | <assoc=right> New define_array                           
    | expression '[' expression ']'                         
    | expression '(' (expression (',' expression)*)? ')'                    
    | expression op=('++' | '--')                           
    | <assoc=right> op=('+' | '-' | '++' | '--') expression 
    | <assoc=right> op=('~' | '!' ) expression              
    | expression op=('*' | '/' | '%') expression            
    | expression op=('+' | '-') expression                  
    | expression op=('<<' | '>>') expression                
    | expression op=('<' | '>' | '>=' | '<=') expression    
    | expression op=('==' | '!=' ) expression               
    | expression op='&' expression                          
    | expression op='^' expression                          
    | expression op='|' expression                          
    | expression '&&' expression                            
    | expression '||' expression                            
    | <assoc=right> expression '=' expression              
    ;

define_array
    : basictype ( '[' expression ']' )+ ('[' ']')*;


primary
    : '(' expression ')' 
    | This 
    | Identifier 
    | literal 
    ;

literal
    : Digit
    | Stringliteral
    | True | False
    | Null 
    ;

Identifier
    : [a-zA-Z] [a-zA-Z_0-9]*
    ;

Digit
    : [1-9] [0-9]*
    | '0'
    ;

Add : '+';
Dec : '-';
Mul : '*';
Div : '/';
Mod : '%';

Gre : '>';
Les :'<';
Gre_equal : '>=';
Les_equal : '<=';
Not_equal : '!=';
Equal : '==';

loc_and : '&&';
loc_or : '||';
loc_not : '!';

Right_shift : '>>';
Left_shift : '<<';
And : '&';
Or : '|';
Xor : '^';
Not : '~';

Assign : '=';

AddAdd : '++';
DecDec : '--';

Dot : '.';

LeftParen : '(';
RightParen : ')';
LeftBracket : '[';
RightBracket : ']';
LeftBrace : '{';
RightBrace : '}';

Semi : ';';
Comma : ',';


Space
    : (' ')+
        -> skip
    ;

Enter
    :   '\n'
        -> skip
    ;

Notes
    : '//' ~[\r\n]*
        -> skip
    ;

Stringliteral
    : '"' Stringvalue* '"'
    ;

fragment
Stringvalue
    : ~["\\\n\r]
    | '\\n'
    | '\\\\'
    | '\\"'
    ;

Int : 'int';
Bool : 'bool';
String : 'string';
Null: 'null';
Void : 'void';
True : 'true';
False : 'false';
If : 'if';
Else : 'else';
For : 'for';
While : 'while';
Break : 'break';
Continue : 'continue';
Return : 'return';
New : 'new';
Class : 'class';
This : 'this';




