	.syntax	unified
	.eabi_attribute	67, "2.09"
	.eabi_attribute	6, 10
	.eabi_attribute	7, 65
	.eabi_attribute	8, 1
	.eabi_attribute	9, 2
	.fpu	vfpv3-d16
	.eabi_attribute	34, 1
	.eabi_attribute	15, 1
	.eabi_attribute	16, 1
	.eabi_attribute	17, 2
	.eabi_attribute	20, 1
	.eabi_attribute	21, 1
	.eabi_attribute	23, 3
	.eabi_attribute	24, 1
	.eabi_attribute	25, 1
	.eabi_attribute	28, 1
	.eabi_attribute	38, 1
	.eabi_attribute	14, 0
	.file	"enum_example_export.4fe8d3f5ee6f9d12-cgu.0"
	.section	.text.value_in_cents,"ax",%progbits
	.globl	value_in_cents
	.p2align	2
	.type	value_in_cents,%function
	.code	32
value_in_cents:
	.fnstart
	.pad	#16
	sub	sp, sp, #16
	str	r1, [sp, #4]
	uxtb	r0, r0
	mov	r1, r0
	str	r1, [sp, #8]
	cmp	r0, #3
	bhi	.LBB0_3
	ldr	r1, [sp, #8]
	adr	r0, .LJTI0_0
	ldr	r1, [r0, r1, lsl #2]
	add	pc, r0, r1
	.p2align	2
.LJTI0_0:
	.long	.LBB0_4-.LJTI0_0
	.long	.LBB0_5-.LJTI0_0
	.long	.LBB0_6-.LJTI0_0
	.long	.LBB0_7-.LJTI0_0
.LBB0_3:
	movw	r0, #2
	strb	r0, [sp, #14]
	b	.LBB0_8
.LBB0_4:
	movw	r0, #2
	strb	r0, [sp, #14]
	b	.LBB0_8
.LBB0_5:
	movw	r0, #3
	strb	r0, [sp, #14]
	b	.LBB0_8
.LBB0_6:
	movw	r0, #4
	strb	r0, [sp, #14]
	b	.LBB0_8
.LBB0_7:
	ldr	r0, [sp, #4]
	sxtb	r0, r0
	cmp	r0, #0
	beq	.LBB0_11
	b	.LBB0_12
.LBB0_8:
	ldrb	r0, [sp, #14]
	sub	r1, r0, #2
	uxtb	r1, r1
	cmp	r0, #1
	mov	r0, #3
	movhi	r0, r1
	str	r0, [sp]
	ldr	r1, [sp]
	adr	r0, .LJTI0_1
	ldr	r1, [r0, r1, lsl #2]
	add	pc, r0, r1
	.p2align	2
.LJTI0_1:
	.long	.LBB0_15-.LJTI0_1
	.long	.LBB0_16-.LJTI0_1
	.long	.LBB0_17-.LJTI0_1
	.long	.LBB0_18-.LJTI0_1
.LBB0_11:
	movw	r0, #0
	strb	r0, [sp, #15]
	b	.LBB0_13
.LBB0_12:
	movw	r0, #1
	strb	r0, [sp, #15]
.LBB0_13:
	ldrb	r0, [sp, #15]
	and	r0, r0, #1
	strb	r0, [sp, #14]
	b	.LBB0_8
	.inst	0xe7ffdefe
.LBB0_15:
	movw	r0, #1
	strb	r0, [sp, #13]
	b	.LBB0_19
.LBB0_16:
	movw	r0, #5
	strb	r0, [sp, #13]
	b	.LBB0_19
.LBB0_17:
	movw	r0, #10
	strb	r0, [sp, #13]
	b	.LBB0_19
.LBB0_18:
	movw	r0, #25
	strb	r0, [sp, #13]
.LBB0_19:
	ldrb	r0, [sp, #13]
	add	sp, sp, #16
	bx	lr
.Lfunc_end0:
	.size	value_in_cents, .Lfunc_end0-value_in_cents
	.fnend

	.ident	"rustc version 1.91.0 (f8297e351 2025-10-28)"
	.section	".note.GNU-stack","",%progbits
	.eabi_attribute	30, 5
