	THUMB
    AREA    maximum,CODE,READONLY
    EXPORT __main
	ENTRY
__main    FUNCTION
	MOV R1,#10;//a
	MOV R2,#15;//b
	MOV R3,#20;//c
	MOV R4,#0;//maximum of a and b for future use 
	MOV R5,#0;//maximum of (max(a,b) and c )//final maximum value 
	CMP R1,R2//compare a and b
	BLT LOOP1//a<b go to loop1 
	BEQ  LOOP2 //a=b go to loop2
	MOV R4,R1;//a>b r4 =a 
LOOP1 	
	MOV R4,R2;//a<b r4=b=r1
	CMP R4,R3;//compare r4 and c 
	BLT LOOP3;//r4<c go to loop3 
	BEQ LOOP4;//r4=c 
	MOV R5,R4;//r4>c r5=r4 maximum of and a and b and c 
	B stop;//exit 
LOOP2
	MOV R4,R2;//a=b 
	CMP R4,R3;//compare a with c 
	BLT LOOP3;//a<c go to loop3 
	BEQ LOOP4;//a=c got loop loop4
	MOV R5,R4;//a>c a is maximum 
	B stop
LOOP3 
	MOV R5,R3;// c is maximum 
	B stop
LOOP4
	MOV R5,R1;
	B stop
	
stop   B stop
       ENDFUNC
       END