	THUMB
    AREA    maximum,CODE,READONLY
	IMPORT printMsg	
    EXPORT __SIN
__SIN    FUNCTION

	
	
	VMOV.F32 s12,s20 ; C = x
	VLDR.F32 s13, =2.0 ;  i 
	VMOV.F32 s14,s12; temp
	VLDR.F32 s19, =2.0 ; add i=i+2 2 factor 
	VLDR.F32 s18, =1.0
	VMOV.F32 s23,s12;temp1 =x 
	VMUL.F32 s11,s12,s12 ; B = x*x
	
sineloop VMOV.F32 s21,s23
	
	
	;//sinx
	
	VMUL.F32 s14,s14,s11;//temp =temp*x*x 
	VADD.F32 s16,s13,s18;// i-1
	VMUL.F32 s10,s16,s13;//i*i+1
	VDIV.F32 s14,s14,s10;//temp/i*i+1;
	VNMUL.F32 s14,s14,s18;//temp=-temp
	VADD.F32 s23,s23,s14;//t1=t1+
	VADD.F32 s13,s13,s19;  
	VCMP.F32 s21,s23
	VMRS APSR_nzcv, FPSCR
	BNE sineloop
	 B __cos

	ENDFUNC
	
	EXPORT __cos
	ENTRY
__cos  FUNCTION

	
	
	VMOV.F32 s2,s20 ; C = x;1.04719756 rad =60 
	VLDR.F32 s3, =2.0 ;  i 
	VLDR.F32 s4, =1.0; temp
	VLDR.F32 s7, =1.0;
	
	VLDR.F32 s9, =2.0 ; add i=i+2 2 factor 
	VLDR.F32 s8, =1.0;temp1 =x 
	VMUL.F32 s1,s2,s2 ; B = x*x
	
cosloop VMOV.F32 s15,s8
	
	
	;//COS
	
	
	
	VMUL.F32 s4,s4,s1;//temp =temp*x
	VSUB.F32 s6,s3,s7;// i-1
	VMUL.F32 s0,s3,s6;
	VDIV.F32 s4,s4,s0;//temp/i-1;
	VNMUL.F32 s4,s4,s7;//temp=-temp
	VADD.F32 s8,s8,s4;//t1=t1+
	VADD.F32 s3,s3,s9;  
	VCMP.F32 s15,s8;
	VMRS APSR_nzcv, FPSCR
	BNE cosloop
	B  loop5

	ENDFUNC

	EXPORT __main
     
__main  FUNCTION
	
	VLDR.F32 S25,=100
	VLDR.F32 S26,=0
	MOV R7,#360;
	MOV R6,#10;
	MOV R4,#0;
	VLDR.F32 S27,=3.14592 ;Storing Pi value
	VLDR.F32 S28,=180 ; Storing 180 degress
	;MOV R4,#1;Angle in degrees
loop3	
	VMOV.F32 S20,R4; 
    VCVT.F32.U32 S20, S20;
	VMUL.F32 S20,S20, S27
	VDIV.F32 S20,S20, S28 ;Converted angle into radians
	
	B __SIN
loop5
	VMUL.F32 s21,S25;
	VMUL.F32 S15,S25;
	VLDR.F32 S29,=319;
	VADD.F32 S15,S29
	VLDR.F32 S29,=239;
	VADD.F32 S21,S29;
	VMOV.F32 R0,S15
	VMOV.F32 R1,S21
	BL printMsg
	ADD R4,R6
	CMP R4,R7;
	BLE loop3;
	BGT stop
				
stop B stop
	ENDFUNC
	END