		ldi r0, 0
init	ldi r1, 20
		ldi r2, 10
		ldi r4, 7
		stm r0, 192
		stm r1, 64
		stm r2, 96
		stm r4, 128
		stm r0, 160
		ldi r6, 31
		ldi r7, 27
		csr print
st_row	adi r1, 1
		adi r2, 1
		stm r1, 64
		stm r2, 96
		stm r0, 160
		nop
		cmp r1, r6
		jpz end_col
		cmp r2, r7
		jpz st_col
		jmp st_row
end_col	adi r1, 255
		adi r2, 1
		stm r1, 64
		stm r2, 96
		stm r0, 160
		nop
		cmp r2, r7
		jpz end_row
		cmp r1, r0
		jpz st_row
		jmp end_col
end_row adi r1, 255
		adi r2, 255
		stm r1, 64
		stm r2, 96
		stm r0, 160
		nop
		cmp r1, r0
		jpz st_col
		cmp r2, r0
		jpz end_col
		jmp end_row
st_col	adi r1, 1
		adi r2, 255
		stm r1, 64
		stm r2, 96
		stm r0, 160
		nop
		cmp r2, r0
		jpz st_row
		cmp r1, r6
		jpz end_row
		jmp st_col

print	ldi r5, 85
		stm r5, 32
		ldi r5, 58
		stm r5, 32
		ldi r5, 32
		stm r5, 32
		ldm r5, 1
		adi r5, 48
		stm r5, 32
		ldi r5, 32
		stm r5, 32
		ldi r5, 77
		stm r5, 32
		ldi r5, 58
		stm r5, 32
		ldi r5, 32
		stm r5, 32
		ldm r5, 2
		adi r5, 48
		stm r5, 32
		ldi r5, 10
		stm r5, 32
		ret