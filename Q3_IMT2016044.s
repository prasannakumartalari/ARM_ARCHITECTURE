    THUMB
    AREA    evenandodd,CODE,READONLY
    EXPORT __main
	ENTRY
__main    FUNCTION
	MOV R4,#10;
	MOV R3,#2;
	UDIV R5,R4,R3;//division by 2 
	MLS R5,R5,R3,R4;
	;//if r5 =1 then it is odd else it is even 
stop    B stop
        ENDFUNC
        END
			