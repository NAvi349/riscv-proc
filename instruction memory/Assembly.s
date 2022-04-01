main: 		addi x3, x0, 10 		# x3 = 10 
		addi x4, x0, 12			# x4 = 12
		or x5, x3, x4 			# x5 = (10 OR 12) = 14 
		and x6, x3, x4 			# x5 = (10 AND 12) = 8		
		bne x5, x6, end 		# should be taken 
		addi x4, x4, x5 		# shouldn't be executed
		
around: slt x7, x5, x6 			# x7 = (8 < 14) = 1		
		sub x8, x6, x5 			# x8 = (8 - 14) = -6 		
		sw x4, 10(x3) 			#[20] = 12 
		lw x9, 10(x3) 			# x9 = [20] = 12	
		xor x10, x2, x2			# x10 = x2 ^ x2
		
done: 	beq x2, x2, done 		#infinite loop
