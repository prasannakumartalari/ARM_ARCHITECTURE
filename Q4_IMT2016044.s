	THUMB
    AREA    nestedlooptried ,CODE,READONLY
    EXPORT __main
	ENTRY
__main    FUNCTION
	
	MOV R4,#11;
	MOV R5,#3;
	MOV R2,#0;
	MOV R1,#0;FOR STORING  NUMBER IF IT IS ODD 
	MOV R0,#0;FOR STORING  NUMBER IF IT IS EVEN 
	MOV R5,#0;
	UDIV R5, R4,R5;//division by 2 
	CMP  R5,#1;
	ITE  NE  ; // tried to store based on remainder when number is divided  by 3 
	MOVNE R1,R4;// 
	CMPNE R5,#2;;//  
	ITE  NE  ;// tried ite inside ite but showed error  
	MOVNE R6,R4;
	MOVEQ R2,R4;
	MOVEQ R0,R4;
	
	
	
	
stop    B stop
        ENDFUNC
        END	