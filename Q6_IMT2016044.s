    THUMB
    AREA    gcd,CODE,READONLY
    EXPORT __main
	ENTRY
__main    FUNCTION
	MOV R0,#15;a 
    MOV R1,#6;b
LOOP CMP R0,R1;//while (a!=b)
	BNE LOOP1;//if a is not equal to b go to if then else loop
	B stop;//if a =b stop
LOOP1	ITE GT;//if(a>b)
	SUBGT R0,R0,R1;//a=a-b then 
	SUBLE R1,R1,R0;// else b=b-a; 
	B LOOP;
	
	
	
	
	
stop    B stop
        ENDFUNC
        END

	