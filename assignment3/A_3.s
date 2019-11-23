	THUMB
    AREA    maximum,CODE,READONLY
	IMPORT printMsg
	IMPORT printNewLine
	IMPORT printGate	
		
    EXPORT __sigmoid
	ENTRY
__sigmoid     FUNCTION
;__main    FUNCTION
	VLDR.F32 s0, =1.0 ;
	VLDR.F32 s1, =1.0 ; 
	;VLDR.F32 s2, =2.0 ;   x input is here 
	VLDR.F32 s3, =1.0 ; mul_factor
	VLDR.F32 s7, =1.0 ; mul_factor
	
loop VMOV.F32 s6,s8
	 VDIV.F32 s5,s2,s3 ; C = x/n
	 VADD.F32 s3,s3,s7; n = n+1
	 VFMA.F32 s0,s1,s5 ; A = A + BC
	 VMUL.F32 s1,s1,s5; B = B*C
	 VADD.F32 s4,s0,s7;
	 VDIV.F32 s8,s0,s4;
	 VCMP.F32 s6,s8
	 VMRS APSR_nzcv, FPSCR
	 BNE loop
	 BX lr
	 LTORG

	   ENDFUNC
	   EXPORT __not 
__not       FUNCTION
		MOV r5,r14;for calling l
		VLDR.F32 s12, = -1.0 ; w0
		VLDR.F32 s15, =1.0;bias
		VCVTR.S32.F32 s21,s9;
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s15,s15,s20;
		 VADD.F32 s16,s12,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid; y= ~a   
		 VCVTR.S32.F32 s24,s8;
		 VMOV.F32 r0,s21
		 BL printMsg
		 VMOV.F32 r0,s24
		 BL printMsg
		 BL printNewLine
		 MOV r14,r5
		 
	   
	   BX lr
	   LTORG

	   ENDFUNC
	   EXPORT __and
__and      FUNCTION	
		MOV r5,r14
		; weights of and gate s12 s13 s15 s15(biased wieight ); 
		VLDR.F32 s12, = 1.0 ; w0
		VLDR.F32 s13, =1.0; w1
		VLDR.F32 s14, =1.0 ; w2
		VLDR.F32 s15, =-2.0;weight of bias
		
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10; 
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is  intial bias b 1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15; sum of weigthed inputs 
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s24,s8; in every function output s8 is converted and stored in s24 which is final output 
		 VMOV.F32 r0,s21;input1
		 BL printMsg
		 VMOV.F32 r0,s22;input2
		 BL printMsg
		 VMOV.F32 r0,s23;input3
		 BL printMsg
		 VMOV.F32 r0,s24;output3 
		 BL printMsg
		 BL printNewLine
		 MOV r14,r5
	   BX lr
	   LTORG

	   ENDFUNC
	    EXPORT __or
__or      FUNCTION	
		MOV r5,r14
		; weights of and gate s12 s13 s15 s15(biased wieight ); 
		VLDR.F32 s12, = 2.0 ; w0
		VLDR.F32 s13, =2.0 ; w1
		VLDR.F32 s14, =2.0 ; w2
		VLDR.F32 s15, =-1.0;bias
		
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10;
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is  intial bias b which is  1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15;sum of weigthed inputs  along with biased weigths
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s24,s8;
		 VMOV.F32 r0,s21
		 BL printMsg
		 VMOV.F32 r0,s22
		 BL printMsg
		 VMOV.F32 r0,s23
		 BL printMsg
		 VMOV.F32 r0,s24
		 BL printMsg
		 BL printNewLine
		 MOV r14,r5
		BX lr
		LTORG

	   ENDFUNC
		EXPORT __nor
__nor      FUNCTION	
		MOV r5,r14
		; weights of and gate s12 s13 s15 s15(biased wieight ); 
		VLDR.F32 s12, = -1.0 ; w0
		VLDR.F32 s13, =-1.0 ; w1
		VLDR.F32 s14, =-1.0 ; w2
		VLDR.F32 s15, =1.0;bias
		
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10;
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is bias 1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s24,s8;
		 VMOV.F32 r0,s21
		 BL printMsg
		 VMOV.F32 r0,s22
		 BL printMsg
		 VMOV.F32 r0,s23
		 BL printMsg
		 VMOV.F32 r0,s24
		 BL printMsg
		 BL printNewLine
		 MOV r14,r5
	   BX lr
	   LTORG

	   ENDFUNC	
		EXPORT __nand
__nand      FUNCTION	
		MOV r5,r14
		; weights of and gate s12 s13 s15 s15(biased wieight ); 
		VLDR.F32 s12, = -1.0 ; w0
		VLDR.F32 s13, =-1.0; w1
		VLDR.F32 s14, =-1.0 ; w2
		VLDR.F32 s15, =4.0;bias
		
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10;
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is bias 1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s24,s8;
		 VMOV.F32 r0,s21
		 BL printMsg
		 VMOV.F32 r0,s22
		 BL printMsg
		 VMOV.F32 r0,s23
		 BL printMsg
		 VMOV.F32 r0,s24
		 BL printMsg
		 BL printNewLine
		 MOV r14,r5
	   BX lr
	   LTORG

	   ENDFUNC
		 EXPORT __xor
__xor      FUNCTION	
		MOV r5,r14
		; we implemnted xor gate as abc+a*~b*~c+b*~a~c+c*~a*~c;
		; above  four terms  are intermediate layer terms and final output is caluclated by  doing or of four terms 
		; for this we use multi layer  perceptrons 
		;reference for multi layer  perceptrons 
		;https://towardsdatascience.com/implementing-the-xor-gate-using-backpropagation-in-neural-networks-c1f255b4f20d
		;x1 of intermediate  layer 
		VLDR.F32 s12, = 2.0 ; w0
		VLDR.F32 s13, =-2.0; w1
		VLDR.F32 s14, =-2.0 ; w2
		VLDR.F32 s15, =-1.0;bias
			
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10;
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is bias 1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s25,s8
		 VCVT.F32.S32 s25,s25
		 
		
		;x2 of intermediate  layer 
		VLDR.F32 s12, = -2.0 ; w0
		VLDR.F32 s13, =2.0; w1
		VLDR.F32 s14, =-2.0 ; w2
		VLDR.F32 s15, =-1.0;bias
			
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10;
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is bias 1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s26,s8
		 VCVT.F32.S32 s26,s26
		 
		 
		 ; weights of and gate s12 s13 s15 s15(biased wieight ); 
		;x3 of intermediate  layer 
		VLDR.F32 s12, = -2.0 ; w0
		VLDR.F32 s13, =-2.0; w1
		VLDR.F32 s14, =2.0 ; w2
		VLDR.F32 s15, =-1.0;bias
			
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10;
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is bias 1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s27,s8
		 VCVT.F32.S32 s27,s27
		 
		 		 ; weights of and gate s11 s12 s13 s14(bias); 
		;x4 of intermediate  layer 
		VLDR.F32 s12, = 2.0 ; w0
		VLDR.F32 s13, =2.0; w1
		VLDR.F32 s14, =2.0 ; w2
		VLDR.F32 s15, =-5.0;bias
			
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10;
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is bias 1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s28,s8
		 VCVT.F32.S32 s28,s28
		 		 ; weights of and gate s11 s12 s13 s14(bias); 
		;output  
		VLDR.F32 s12, = 2.0 ; 
		VLDR.F32 s13, = 2.0; 
		VLDR.F32 s14, = 2.0 ; 
		VLDR.F32 s17, = 2.0 ; 
		VLDR.F32 s15, = -1.0;
		
		 VMUL.F32 s12,s12,s25;
		 VMUL.F32 s13,s13,s26;
		 VMUL.F32 s14,s14,s27;
		 VMUL.F32 s17,s17,s28; note  s20 is bias 1.0
		 VMUL.F32 s15,s15,s20;w5*bias
		 
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s17;
		 VADD.F32 s16,s16,s15;
		 
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s24,s8;
		 VMOV.F32 r0,s21
		 BL printMsg
		 VMOV.F32 r0,s22
		 BL printMsg
		 VMOV.F32 r0,s23
		 BL printMsg
		 VMOV.F32 r0,s24
		 BL printMsg
		 BL printNewLine
		 MOV r14,r5
	   BX lr
	   LTORG

	   ENDFUNC
	    EXPORT __xor
			; xnor function
 EXPORT __xnor
__xnor      FUNCTION	
		MOV r5,r14
		; we use demorgans law here ~(a+b)=~a.~b;
		; same way as xor gate but in  choosing terms we do negation of each term and inplace of or we use and gate 
		;x1 of intermediate  layer 
		VLDR.F32 s12, = -2.0 ; w0
		VLDR.F32 s13, =2.0; w1
		VLDR.F32 s14, =2.0 ; w2
		VLDR.F32 s15, =1.0;bias
			
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10;
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is bias 1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s25,s8
		 VCVT.F32.S32 s25,s25
		 
		 ; weights of and gate s11 s12 s13 s14(bias); 
		;x2 of intermediate  layer 
		VLDR.F32 s12, = 2.0 ; w0
		VLDR.F32 s13, =-2.0; w1
		VLDR.F32 s14, =2.0 ; w2
		VLDR.F32 s15, =1.0;bias
			
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10;
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is bias 1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s26,s8
		 VCVT.F32.S32 s26,s26
		 
		 
		 ; weights of and gate s11 s12 s13 s14(bias); 
		;x3 of intermediate  layer 
		VLDR.F32 s12, = 2.0 ; w0
		VLDR.F32 s13, =2.0; w1
		VLDR.F32 s14, =-2.0 ; w2
		VLDR.F32 s15, =1.0;bias
			
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10;
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is bias 1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s27,s8
		 VCVT.F32.S32 s27,s27
		 
		 		 ; weights of and gate s11 s12 s13 s14(bias); 
		;x4 of intermediate  layer 
		VLDR.F32 s12, = -2.0 ; w0
		VLDR.F32 s13, =-2.0; w1
		VLDR.F32 s14, =-2.0 ; w2
		VLDR.F32 s15, =5.0;bias
			
		
		VCVTR.S32.F32 s21,s9;
		VCVTR.S32.F32 s22,s10;
		VCVTR.S32.F32 s23,s11;
		
		
		 VMUL.F32 s12,s12,s9;
		 VMUL.F32 s13,s13,s10;
		 VMUL.F32 s14,s14,s11;
		 VMUL.F32 s15,s15,s20; note  s20 is bias 1.0
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s28,s8
		 VCVT.F32.S32 s28,s28
		 		 ; weights of and gate s11 s12 s13 s14(bias); 
		;output  
		VLDR.F32 s12, = 2.0 ; w0
		VLDR.F32 s13, = 2.0; w1
		VLDR.F32 s14, = 2.0 ; w2
		VLDR.F32 s17, = 2.0 ; w2
		VLDR.F32 s15, = -7.0;weight bias
		
		 VMUL.F32 s12,s12,s25;
		 VMUL.F32 s13,s13,s26;
		 VMUL.F32 s14,s14,s27;
		 VMUL.F32 s17,s17,s28; note  s20 is bias 1.0
		 VMUL.F32 s15,s15,s20;
		 
		 
		 VADD.F32 s16,s12,s13;
		 VADD.F32 s16,s16,s14;
		 VADD.F32 s16,s16,s17;
		 VADD.F32 s16,s16,s15;
		 VMOV.F32 s2,s16;
		 BL __sigmoid;
		 VCVTR.S32.F32 s24,s8;
		 VMOV.F32 r0,s21
		 BL printMsg
		 VMOV.F32 r0,s22
		 BL printMsg
		 VMOV.F32 r0,s23
		 BL printMsg
		 VMOV.F32 r0,s24
		 BL printMsg
		 BL printNewLine
		 MOV r14,r5
	   BX lr
	   LTORG

	   ENDFUNC
	    EXPORT __xnor			
				
	  EXPORT __main
		  
__main    FUNCTION	
		
	   
	   MOV r0,#0
	   BL printGate
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =0.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __and
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =1.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __and
	    VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __and
	   
	   MOV r0,#3
	   BL printGate
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =0.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __nor
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =1.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __nor
	    VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __nor
	   
	   MOV r0,#2
	   BL printGate
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =0.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __nand
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =1.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __nand
	    VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __nand
	   
	   MOV r0,#1
	   BL printGate
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =0.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __or
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =1.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __or
	    VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __or
	   MOV r0,#4
	   BL printGate
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =0.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __xor
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =1.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __xor
	    VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __xor
	   MOV r0,#6
	   BL printGate
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s20, =1.0 ; bias
	   BL __not
	   VLDR.F32 s9, =0.0 ; in1
	   VLDR.F32 s20, =1.0 ; bias
	   BL __not
	   MOV r0,#5
	   BL printGate
	   VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =0.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	    BL __xnor 
		 VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =1.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __xnor
	    VLDR.F32 s9, =1.0 ; in1
	   VLDR.F32 s10, =1.0 ; in2
	   VLDR.F32 s11, =0.0 ; in3
	   VLDR.F32 s20, =1.0 ; bias
	   BL __xnor
		
stop    B  stop ; stop program	   
     endfunc
     end 
