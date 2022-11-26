
	.data
id:	.quad	985698654
count:	.quad	0
dec_2:	.byte	0
xor_13:	.byte	0
dec_unsigned_13:	.byte	0
byte_4:	.byte	0
	.section	.rodata
format:	.string "%ld\n"
true:	.string "True\n"
false:	.string "False\n"
	.text
.global main
	.type	main,	@function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	$format, %rdi
	movq	$id, %rsi
	movq	(%rsi), %rsi
	movq	$0, %rax
	call	printf
	movq	id(%rip), %rax
	sarq	$8, %rax
	andq	$255, %rax
	movq	%rax, dec_2(%rip)
	andq	$1, %rax
	je .EVEN
	movq	id(%rip), %rsi
	movq	$format, %rdi
	leaq	(%rsi,%rsi,2), %rsi
	movq	$0, %rax
	call	printf
	jmp	.CON
.EVEN:
	movq	id(%rip), %rax
	movq	$format, %rdi
	movq	$3, %rcx
	divq	%rcx
	leaq	(%rax,%rax,2), %rax
	subq	id(%rip), %rax
	movq	%rax, %rsi
	negq	%rsi
	movq	$0, %rax
	call	printf
	jmp .CON
.CON:
	movq	id(%rip), %rax
	sarq	$0, %rax
	andq	$255, %rax
	movq	id(%rip), %rdx
	sarq	$16, %rdx
	andq	$255, %rdx
	xorq	%rdx, %rax
	movq	%rax, xor_13(%rip)
	movq	%rax, dec_unsigned_13(%rip)
	cmpq	$127, dec_unsigned_13(%rip)
	ja .LC
	movq	$false, %rdi
	movq	$0, %rax
	call	printf
	jmp .FI
.LC:
	movq	$true, %rdi
	movq	$0, %rax
	call	printf
	jmp .FI
.FI:
	movq	id(%rip), %rax
	sarq	$24, %rax
	movq	%rax, byte_4(%rip)
	jmp .L3

.L1:
	movq	byte_4(%rip), %rax
	andq	$1, %rax
	testq	%rax, %rax	#check if value is 0 or 1
	je .L2
	movq	count(%rip), %rax
	addq	$1, %rax
	movq	%rax, count(%rip)
.L2:
	movq	byte_4(%rip), %rax
	sarq	$1, %rax
	movq	%rax, byte_4(%rip)
.L3:
	movq	byte_4(%rip), %rax
	testq	%rax, %rax
	jne .L1

	movq	$format, %rdi
	movq	count(%rip), %rsi
	movq	$0, %rax
	call	printf
	movq	%rbp, %rsp
	popq	%rbp
	ret
