    THUMB
    AREA    fibanoci,CODE,READONLY
    EXPORT __main
	ENTRY
__main    FUNCTION
    MOV R0,#0;
    MOV R1,#1;
	MOV R7,#0;temporary register for checking wirh r7 for every time 
    MOV R3,#10;  series upto f(10)   in fibancoi sequence 
    MOV R4,#0;f(n) for every time for iteraing loop ;also can  be assumed as tempoary register for storing every time
    MOV R5,#0x20000000;The entire series is written from this memory location
    ADD R4,R0,R1;f(0)=1;f(1)=1;
DECLOOP CMP R7,R3;if(val > req) loop for iterating 10 times 
    BLE FIB;if r7 is less than r3 then go to 
    B stop;after finally R3 is 0 then loop will end got to stop  
FIB STR R4,[R5],#1;Storing the series into memory
	ADD R4,R1,R0;f(n)=f(n-1)+f(n-2)
    MOV R0,R1;update r0 as r1 for next iteration f(n+1-2)=f(n-1) which is r1   in this case
    MOV R1,R4;update r1 as r4 for next iteration f(n+1-1)=f(n) which is r4    in this case
	SUB R3,R3,#1;
    B DECLOOP;Loop untill val >= req
stop    B stop
        ENDFUNC
        END
