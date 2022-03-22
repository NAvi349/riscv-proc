main: 	addi x1, x0, 15	
		addi x2, x0, 22 	
		add x3, x1, x2		
		or x4, x3, x2 		
		xor x5, x3, x4 		
		add x6, x5, x4 		
		beq x5, x6, end 	
		slt x4, x3, x4 		
		beq x4, x0, around 
		addi x6, x0, 0 	
		
around: slt x4, x5, x3 		
		add x6, x4, x5 		
		sub x2, x3, x1		
		sw x1, 84(x3) 		
		lw x1, 84(x3) 	
		addi x1, x1, 0	
		add x7, x2, x3 		
		jal x3, end 		
		
		
end: 	add x2, x2, x9 		
		addi x4, x0, 1
				
done: 	beq x1, x1, done 	