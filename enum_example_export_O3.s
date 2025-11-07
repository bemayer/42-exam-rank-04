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
	movw	r2, #1281
	lsl	r1, r0, #3
	movt	r2, #6410
	mov	r3, #1
	cmp	r0, #4
	lsrlo	r3, r2, r1
	uxtb	r0, r3
	bx	lr
.Lfunc_end0:
	.size	value_in_cents, .Lfunc_end0-value_in_cents
	.fnend

	.ident	"rustc version 1.91.0 (f8297e351 2025-10-28)"
	.section	".note.GNU-stack","",%progbits
	.eabi_attribute	30, 2
