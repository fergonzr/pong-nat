		ldi r5, 73
		stm r5, 32
		ldi r5, 115
		stm r5, 32
		ldi r5, 97
		stm r5, 32
		ldi r5, 98
		stm r5, 32
		ldi r5, 101
		stm r5, 32
		ldi r5, 108
		stm r5, 32
		ldi r5, 97
		stm r5, 32
		ldi r5, 44
		stm r5, 32
		ldi r5, 32
		stm r5, 32
		ldi r5, 70
		stm r5, 32
		ldi r5, 101
		stm r5, 32
		ldi r5, 114
		stm r5, 32
		ldi r5, 110
		stm r5, 32
		ldi r5, 97
		stm r5, 32
		ldi r5, 110
		stm r5, 32
		ldi r5, 100
		stm r5, 32
		ldi r5, 111
		stm r5, 32
		ldi r5, 10
		stm r5, 32
		ldi r5, 10
		stm r5, 32
		ldi r0, 0
		stm r0, 1
		stm r0, 2
		ldi r4, 7
init	ldi r5, 0
		stm r5, 3
		csr pt_scr
		ldi r1, 20
		ldi r2, 10
		ldi r3, 16
		ldi r5, 19
		stm r0, 192
		stm r4, 128
		stm r1, 64
		stm r2, 96
		stm r0, 160
		ldi r6, 31
		ldi r7, 27
		stm r3, 0
rgt_dwn	cmp r1, r6
		csz rstb_x
		stm r0, 192
		adi r1, 1
		adi r2, 1
		stm r1, 64
		stm r2, 96
		csr ch_clr
		stm r0, 160
		csr rd_joy
		cmp r2, r7
		csz chk_bll
		ldm r5, 3
		cmp r5, r0
		jnz init
		cmp r1, r6
		jpz lft_dwn
		cmp r2, r7
		jpz rgt_up
		jmp rgt_dwn
lft_dwn	cmp r2, r7
		csz rstb_y
		stm r0, 192
		adi r1, 255
		adi r2, 1
		stm r1, 64
		stm r2, 96
		csr ch_clr
		stm r0, 160
		csr rd_joy
		cmp r2, r7
		csz chk_bll
		ldm r5, 3
		cmp r5, r0
		jnz init
		cmp r2, r7
		jpz lft_up
		cmp r1, r0
		jpz rgt_dwn
		jmp lft_dwn
lft_up	cmp r1, r0
		csz rstb_x
		stm r0, 192
		adi r1, 255
		adi r2, 255
		stm r1, 64
		stm r2, 96
		csr ch_clr
		stm r0, 160
		csr rd_joy
		cmp r2, r7
		csz chk_bll
		ldm r5, 3
		cmp r5, r0
		jnz init
		cmp r1, r0
		jpz rgt_up
		cmp r2, r0
		jpz lft_dwn
		jmp lft_up
rgt_up	cmp r2, r0
		csz rstb_y
		stm r0, 192
		adi r1, 1
		adi r2, 255
		stm r1, 64
		stm r2, 96
		csr ch_clr
		stm r0, 160
		csr rd_joy
		cmp r2, r7
		csz chk_bll
		ldm r5, 3
		cmp r5, r0
		jnz init
		cmp r2, r0
		jpz rgt_dwn
		cmp r1, r6
		jpz lft_up
		jmp rgt_up
rstb_y	ldi r2, 10
		ret
rstb_x	ldi r1, 21
		ret
rd_joy	stm r4, 4
		ldi r4, 3
		stm r4, 128
		ldi r5, 1
		ldm r3, 32
		cmp r3, r5
		jpz pad_up
		ldi r5, 3
		ldm r3, 32
		cmp r3, r5
		jpz pad_dwn
		jmp pt_pad
pad_up	ldm r3, 0
		adi r3, 255
		stm r3, 0
		jmp pt_pad
pad_dwn	ldm r3, 0
		adi r3, 1
		stm r3, 0
pt_pad	stm r7, 96
		ldm r3, 0
		stm r3, 64
		stm r0, 160
		adi r3, 1
		stm r3, 64
		stm r0, 160
		adi r3, 1
		stm r3, 64
		stm r0, 160
		adi r3, 1
		stm r3, 64
		stm r0, 160
		adi r3, 1
		stm r3, 64
		stm r0, 160
		ldm r4, 4
		stm r4, 128
		ret
chk_bll	ldm r3, 0
		cmp r1, r3
		jnc gt_pad
		jmp fail
gt_pad	adi r3, 4
		cmp r3, r1
		jpc fail
		ldm r5, 1
		adi r5, 1
		stm r5, 1
		csr pt_scr
		ret
fail	ldm r5, 2
		adi r5, 1
		stm r5, 2
		ldi r5, 1
		stm r5, 3
		ret
ch_clr	ldi r5, 7
		cmp r4, r5
		jnz inc_clr
		ldi r4, 0
inc_clr	adi r4, 1
		stm r4, 128
		ldi r5, 0
		ret
pt_scr	ldi r5, 85
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
