	.file	"main.c"
	.text
	.p2align 4
	.globl	cur_time
	.type	cur_time, @function
cur_time:
.LFB5382:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	time_handle(%rip), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	8+time_spec(%rip), %rcx
	movabsq	$4835703278458516699, %rdx
	imulq	$1000, time_spec(%rip), %rsi
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	movq	%rcx, %rax
	sarq	$63, %rcx
	imulq	%rdx
	sarq	$18, %rdx
	subq	%rcx, %rdx
	leaq	(%rsi,%rdx), %rax
	ret
	.cfi_endproc
.LFE5382:
	.size	cur_time, .-cur_time
	.p2align 4
	.globl	new_colour
	.type	new_colour, @function
new_colour:
.LFB5377:
	.cfi_startproc
	unpcklps	%xmm1, %xmm0
	unpcklps	%xmm3, %xmm2
	movaps	%xmm0, %xmm4
	movlhps	%xmm2, %xmm4
	movaps	%xmm4, -24(%rsp)
	movq	-16(%rsp), %rax
	movq	-24(%rsp), %xmm0
	movq	%rax, %xmm1
	ret
	.cfi_endproc
.LFE5377:
	.size	new_colour, .-new_colour
	.p2align 4
	.globl	new_particle
	.type	new_particle, @function
new_particle:
.LFB5378:
	.cfi_startproc
	movq	%xmm0, -24(%rsp)
	movq	%rdi, %rax
	movq	%xmm1, -16(%rsp)
	movaps	-24(%rsp), %xmm2
	movl	%esi, (%rdi)
	movl	$0, 20(%rdi)
	movups	%xmm2, 4(%rdi)
	ret
	.cfi_endproc
.LFE5378:
	.size	new_particle, .-new_particle
	.p2align 4
	.globl	new_pos
	.type	new_pos, @function
new_pos:
.LFB5379:
	.cfi_startproc
	movd	%edi, %xmm0
	movd	%esi, %xmm1
	movl	$0, -24(%rsp)
	punpckldq	%xmm1, %xmm0
	movq	%xmm0, -20(%rsp)
	movl	-16(%rsp), %edx
	movq	-24(%rsp), %rax
	ret
	.cfi_endproc
.LFE5379:
	.size	new_pos, .-new_pos
	.p2align 4
	.globl	new_t_info
	.type	new_t_info, @function
new_t_info:
.LFB5380:
	.cfi_startproc
	salq	$32, %rsi
	movl	%edi, %eax
	orq	%rsi, %rax
	ret
	.cfi_endproc
.LFE5380:
	.size	new_t_info, .-new_t_info
	.p2align 4
	.globl	new_log_info
	.type	new_log_info, @function
new_log_info:
.LFB5381:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$56, %rsp
	.cfi_def_cfa_offset 80
	cmpb	$0, (%rsi)
	je	.L11
	movl	$1, %eax
	.p2align 4,,10
	.p2align 3
.L10:
	movq	%rax, %rbx
	addq	$1, %rax
	cmpb	$0, -1(%rsi,%rax)
	jne	.L10
	movq	%rsp, %rcx
	movq	%rbx, %rdx
	movq	%rcx, %rdi
	call	memcpy@PLT
	movq	%rax, %rcx
	addq	%rbx, %rcx
.L9:
	movb	$0, (%rcx)
	movdqu	(%rsp), %xmm0
	movq	%r12, %rax
	movq	$0, 32(%r12)
	movdqu	16(%rsp), %xmm1
	movups	%xmm0, (%r12)
	movups	%xmm1, 16(%r12)
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	.cfi_restore_state
	movq	%rsp, %rcx
	jmp	.L9
	.cfi_endproc
.LFE5381:
	.size	new_log_info, .-new_log_info
	.p2align 4
	.globl	time_ns
	.type	time_ns, @function
time_ns:
.LFB5383:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	time_handle(%rip), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	imulq	$1000000000, time_spec(%rip), %rax
	addq	8+time_spec(%rip), %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5383:
	.size	time_ns, .-time_ns
	.p2align 4
	.globl	randf
	.type	randf, @function
randf:
.LFB5384:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	rand@PLT
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	mulss	.LC0(%rip), %xmm0
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5384:
	.size	randf, .-randf
	.p2align 4
	.globl	t_rand
	.type	t_rand, @function
t_rand:
.LFB5385:
	.cfi_startproc
	imulq	$536870923, (%rdi), %rcx
	pxor	%xmm0, %xmm0
	movabsq	$1152921501385621513, %rdx
	addq	$268435459, %rcx
	movq	%rcx, %rax
	imulq	%rdx
	movq	%rcx, %rax
	sarq	$63, %rax
	sarq	$26, %rdx
	subq	%rax, %rdx
	movq	%rdx, %rax
	salq	$29, %rax
	addq	%rdx, %rax
	leaq	(%rdx,%rax,2), %rax
	subq	%rax, %rcx
	cvtsi2sdq	%rcx, %xmm0
	movq	%rcx, (%rdi)
	cvtsd2ss	%xmm0, %xmm0
	cvtss2sd	%xmm0, %xmm0
	divsd	.LC1(%rip), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	ret
	.cfi_endproc
.LFE5385:
	.size	t_rand, .-t_rand
	.p2align 4
	.globl	str_len
	.type	str_len, @function
str_len:
.LFB5386:
	.cfi_startproc
	cmpb	$0, (%rdi)
	je	.L22
	movl	$1, %eax
	.p2align 4,,10
	.p2align 3
.L21:
	movl	%eax, %r8d
	addq	$1, %rax
	cmpb	$0, -1(%rdi,%rax)
	jne	.L21
	movl	%r8d, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L22:
	xorl	%r8d, %r8d
	movl	%r8d, %eax
	ret
	.cfi_endproc
.LFE5386:
	.size	str_len, .-str_len
	.p2align 4
	.globl	str_eq
	.type	str_eq, @function
str_eq:
.LFB5387:
	.cfi_startproc
	cmpb	$0, (%rdi)
	movzbl	(%rsi), %ecx
	je	.L25
	movl	$1, %eax
	.p2align 4,,10
	.p2align 3
.L26:
	movslq	%eax, %rdx
	addq	$1, %rax
	cmpb	$0, -1(%rdi,%rax)
	jne	.L26
	testb	%cl, %cl
	je	.L35
.L28:
	movl	$1, %eax
	.p2align 4,,10
	.p2align 3
.L30:
	movl	%eax, %ecx
	addq	$1, %rax
	cmpb	$0, -1(%rsi,%rax)
	jne	.L30
	xorl	%eax, %eax
	cmpl	%edx, %ecx
	jne	.L24
	xorl	%eax, %eax
	jmp	.L31
	.p2align 4,,10
	.p2align 3
.L41:
	addq	$1, %rax
	cmpq	%rax, %rdx
	je	.L40
.L31:
	movzbl	(%rsi,%rax), %ecx
	cmpb	%cl, (%rdi,%rax)
	je	.L41
.L35:
	xorl	%eax, %eax
.L24:
	ret
	.p2align 4,,10
	.p2align 3
.L25:
	xorl	%edx, %edx
	testb	%cl, %cl
	jne	.L28
.L40:
	movl	$1, %eax
	ret
	.cfi_endproc
.LFE5387:
	.size	str_eq, .-str_eq
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"clear"
	.text
	.p2align 4
	.globl	clear
	.type	clear, @function
clear:
.LFB5388:
	.cfi_startproc
	leaq	.LC2(%rip), %rdi
	jmp	system@PLT
	.cfi_endproc
.LFE5388:
	.size	clear, .-clear
	.p2align 4
	.globl	logger
	.type	logger, @function
logger:
.LFB5389:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	xorl	%edi, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$104, %rsp
	.cfi_def_cfa_offset 144
	movq	t(%rip), %rbx
	movq	time_handle(%rip), %rsi
	testq	%rbx, %rbx
	jne	.L44
	call	clock_gettime@PLT
	imulq	$1000000000, time_spec(%rip), %rax
	addq	8+time_spec(%rip), %rax
	movq	%rax, t(%rip)
.L45:
	movslq	cur_log(%rip), %rax
	leaq	logs(%rip), %r12
	cmpl	$-1, %eax
	je	.L46
	leaq	(%rax,%rax,4), %rax
	addq	%rbx, 32(%r12,%rax,8)
.L46:
	movzbl	0(%rbp), %r8d
	leaq	logs(%rip), %rdx
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L53:
	cmpb	$0, (%rdx)
	je	.L47
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L48:
	movl	%eax, %edi
	movl	%eax, %esi
	addq	$1, %rax
	cmpb	$0, (%rdx,%rax)
	jne	.L48
	testb	%r8b, %r8b
	je	.L49
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L50:
	movl	%eax, %ecx
	addq	$1, %rax
	cmpb	$0, 0(%rbp,%rax)
	jne	.L50
	cmpl	%ecx, %esi
	jne	.L49
	leal	1(%rdi), %ecx
	xorl	%eax, %eax
	jmp	.L51
	.p2align 4,,10
	.p2align 3
.L72:
	addq	$1, %rax
	cmpq	%rcx, %rax
	je	.L71
.L51:
	movzbl	0(%rbp,%rax), %edi
	cmpb	%dil, (%rdx,%rax)
	je	.L72
.L49:
	addl	$1, %ebx
	addq	$40, %rdx
	cmpl	$256, %ebx
	jne	.L53
	movl	$-1, %ebx
	.p2align 4,,10
	.p2align 3
.L47:
	testb	%r8b, %r8b
	je	.L57
	movl	$1, %eax
	.p2align 4,,10
	.p2align 3
.L55:
	movq	%rax, %r13
	addq	$1, %rax
	cmpb	$0, -1(%rbp,%rax)
	jne	.L55
	movq	%rsp, %rcx
	movq	%r13, %rdx
	movq	%rbp, %rsi
	movq	%rcx, %rdi
	call	memcpy@PLT
	movq	%rax, %rcx
	addq	%r13, %rcx
.L54:
	movslq	%ebx, %rax
	movb	$0, (%rcx)
	movdqu	(%rsp), %xmm0
	movdqu	16(%rsp), %xmm1
	leaq	(%rax,%rax,4), %rax
	movl	%ebx, cur_log(%rip)
	leaq	(%r12,%rax,8), %rax
	movq	$0, 32(%rax)
	movups	%xmm0, (%rax)
	movups	%xmm1, 16(%rax)
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L71:
	.cfi_restore_state
	movl	%ebx, cur_log(%rip)
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L44:
	.cfi_restore_state
	call	clock_gettime@PLT
	imulq	$1000000000, time_spec(%rip), %rax
	addq	8+time_spec(%rip), %rax
	movq	%rax, %rbx
	subq	t(%rip), %rbx
	movq	%rax, t(%rip)
	jmp	.L45
.L57:
	movq	%rsp, %rcx
	jmp	.L54
	.cfi_endproc
.LFE5389:
	.size	logger, .-logger
	.section	.rodata.str1.1
.LC3:
	.string	"%s: %luns\n"
.LC5:
	.string	"%s: %f%%\n"
.LC6:
	.string	"total: %luns\n"
.LC8:
	.string	"sum fps: %f\n"
	.text
	.p2align 4
	.globl	show_logs
	.type	show_logs, @function
show_logs:
.LFB5390:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xorl	%eax, %eax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	logs(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%r14, %rdx
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	jmp	.L77
	.p2align 4,,10
	.p2align 3
.L74:
	addl	$1, %eax
	addq	$40, %rdx
	cmpl	$256, %eax
	je	.L92
.L77:
	cmpb	$0, (%rdx)
	jne	.L74
	testl	%eax, %eax
	je	.L92
	subl	$1, %eax
	xorl	%ebx, %ebx
	leaq	.LC3(%rip), %r15
	leaq	(%rax,%rax,4), %rdx
	leaq	40+logs(%rip), %rax
	leaq	(%rax,%rdx,8), %rbp
	leaq	-40(%rax), %r12
	.p2align 4,,10
	.p2align 3
.L78:
	movq	32(%r12), %rdx
	movq	%r12, %rsi
	movq	%r15, %rdi
	xorl	%eax, %eax
	addq	$40, %r12
	call	printf@PLT
	addq	-8(%r12), %rbx
	cmpq	%r12, %rbp
	jne	.L78
	testq	%rbx, %rbx
	js	.L79
	pxor	%xmm3, %xmm3
	cvtsi2ssq	%rbx, %xmm3
	movss	%xmm3, 12(%rsp)
.L80:
	leaq	.LC5(%rip), %r12
	jmp	.L83
	.p2align 4,,10
	.p2align 3
.L93:
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
.L82:
	divss	12(%rsp), %xmm0
	cvtss2sd	%xmm0, %xmm0
	movq	%r14, %rsi
	movq	%r12, %rdi
	mulsd	.LC4(%rip), %xmm0
	movl	$1, %eax
	addq	$40, %r14
	call	printf@PLT
	cmpq	%rbp, %r14
	je	.L76
.L83:
	movq	32(%r14), %rax
	testq	%rax, %rax
	jns	.L93
	movq	%rax, %rdx
	andl	$1, %eax
	pxor	%xmm0, %xmm0
	shrq	%rdx
	orq	%rax, %rdx
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
	jmp	.L82
.L79:
	movq	%rbx, %rax
	movq	%rbx, %rdx
	pxor	%xmm0, %xmm0
	shrq	%rax
	andl	$1, %edx
	orq	%rdx, %rax
	cvtsi2ssq	%rax, %xmm0
	addss	%xmm0, %xmm0
	movss	%xmm0, 12(%rsp)
	jmp	.L80
.L92:
	xorl	%ebx, %ebx
.L76:
	xorl	%eax, %eax
	movq	%rbx, %rsi
	leaq	.LC6(%rip), %rdi
	call	printf@PLT
	testq	%r13, %r13
	js	.L84
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%r13, %xmm0
	testq	%rbx, %rbx
	js	.L86
.L94:
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rbx, %xmm1
.L87:
	divsd	.LC7(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movl	$1, %eax
	leaq	.LC8(%rip), %rdi
	call	printf@PLT
	movq	stdout(%rip), %rdi
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	fflush@PLT
.L84:
	.cfi_restore_state
	movq	%r13, %rax
	andl	$1, %r13d
	pxor	%xmm0, %xmm0
	shrq	%rax
	orq	%r13, %rax
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm0, %xmm0
	testq	%rbx, %rbx
	jns	.L94
.L86:
	movq	%rbx, %rax
	andl	$1, %ebx
	pxor	%xmm1, %xmm1
	shrq	%rax
	orq	%rbx, %rax
	cvtsi2sdq	%rax, %xmm1
	addsd	%xmm1, %xmm1
	jmp	.L87
	.cfi_endproc
.LFE5390:
	.size	show_logs, .-show_logs
	.p2align 4
	.globl	get_particle
	.type	get_particle, @function
get_particle:
.LFB5391:
	.cfi_startproc
	movaps	.LC9(%rip), %xmm0
	movslq	%esi, %rsi
	movl	$0, -84(%rsp)
	movq	%rdi, %rax
	leaq	(%rsi,%rsi,2), %rdx
	movl	$1, -80(%rsp)
	movups	%xmm0, -100(%rsp)
	movaps	.LC10(%rip), %xmm0
	salq	$3, %rdx
	movl	$0, -60(%rsp)
	movups	%xmm0, -76(%rsp)
	movaps	.LC11(%rip), %xmm0
	movl	$2, -56(%rsp)
	movups	%xmm0, -52(%rsp)
	movaps	.LC12(%rip), %xmm0
	movl	$0, -36(%rsp)
	movl	$3, -32(%rsp)
	movl	$0, -12(%rsp)
	movups	%xmm0, -28(%rsp)
	movl	$0, -104(%rsp)
	movdqu	-104(%rsp,%rdx), %xmm1
	movq	-88(%rsp,%rdx), %rdx
	movups	%xmm1, (%rdi)
	movq	%rdx, 16(%rdi)
	ret
	.cfi_endproc
.LFE5391:
	.size	get_particle, .-get_particle
	.p2align 4
	.globl	tick_powder
	.type	tick_powder, @function
tick_powder:
.LFB5392:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L116
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	density(%rip), %r9
	movslq	%edi, %r10
	leal	-1(%rsi), %ecx
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	24(%rsp), %eax
	movslq	%ecx, %rcx
	movq	%rdx, %rbx
	leaq	(%rcx,%rcx,2), %rdx
	leaq	world(%rip), %r8
	movss	(%r9,%rax,4), %xmm1
	leaq	(%r10,%r10,2), %rax
	leaq	(%rax,%rax,8), %r11
	salq	$7, %r11
	leaq	(%r11,%rdx,8), %rax
	addq	%r8, %rax
	movl	(%rax), %edx
	comiss	(%r9,%rdx,4), %xmm1
	movq	%rdx, %rbp
	ja	.L117
	imulq	$536870923, (%rbx), %r11
	pxor	%xmm0, %xmm0
	movabsq	$1152921501385621513, %rdx
	addq	$268435459, %r11
	movq	%r11, %rax
	imulq	%rdx
	movq	%r11, %rax
	sarq	$63, %rax
	sarq	$26, %rdx
	subq	%rax, %rdx
	movq	%rdx, %rax
	salq	$29, %rax
	addq	%rdx, %rax
	leaq	(%rdx,%rax,2), %rax
	movq	%r11, %rdx
	subq	%rax, %rdx
	movl	$1, %eax
	cvtsi2sdq	%rdx, %xmm0
	movq	%rdx, (%rbx)
	cvtsd2ss	%xmm0, %xmm0
	cvtss2sd	%xmm0, %xmm0
	divsd	.LC1(%rip), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	comiss	.LC13(%rip), %xmm0
	ja	.L118
	testl	%edi, %edi
	jle	.L96
	movl	$-1, %eax
.L103:
	addl	%eax, %edi
	leaq	(%rcx,%rcx,2), %rdx
	movslq	%edi, %rdi
	leaq	(%rdi,%rdi,2), %rax
	leaq	(%rax,%rax,8), %rax
	salq	$7, %rax
	leaq	(%rax,%rdx,8), %rax
	addq	%r8, %rax
	movl	(%rax), %ecx
	comiss	(%r9,%rcx,4), %xmm1
	movq	%rcx, %rdx
	jbe	.L104
	movl	$1, 44(%rsp)
	movdqu	24(%rsp), %xmm5
	movslq	%esi, %rsi
	movq	40(%rsp), %rdi
	movss	4(%rax), %xmm0
	leaq	(%rsi,%rsi,2), %rsi
	movss	8(%rax), %xmm2
	movss	12(%rax), %xmm1
	movups	%xmm5, (%rax)
	movss	16(%rax), %xmm3
	movl	20(%rax), %ecx
	movq	%rdi, 16(%rax)
	leaq	(%r10,%r10,2), %rax
	leaq	(%rax,%rax,8), %rax
	unpcklps	%xmm2, %xmm0
	salq	$7, %rax
	unpcklps	%xmm3, %xmm1
	leaq	(%rax,%rsi,8), %rax
	movlhps	%xmm1, %xmm0
	addq	%rax, %r8
	movl	%edx, (%r8)
	leaq	4+world(%rip), %rdx
	movups	%xmm0, (%rdx,%rax)
	movl	$1, %eax
	movl	%ecx, 20(%r8)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L117:
	.cfi_restore_state
	movl	$1, 44(%rsp)
	movdqu	24(%rsp), %xmm4
	movslq	%esi, %rsi
	movq	40(%rsp), %rcx
	movss	4(%rax), %xmm0
	movss	8(%rax), %xmm2
	movss	12(%rax), %xmm1
	movups	%xmm4, (%rax)
	movss	16(%rax), %xmm3
	movl	20(%rax), %edx
	movq	%rcx, 16(%rax)
	leaq	(%rsi,%rsi,2), %rax
	leaq	(%r11,%rax,8), %rax
	unpcklps	%xmm2, %xmm0
	leaq	4+world(%rip), %rcx
	unpcklps	%xmm3, %xmm1
	addq	%rax, %r8
	movlhps	%xmm1, %xmm0
	movl	%ebp, (%r8)
	movups	%xmm0, (%rcx,%rax)
	movl	$1, %eax
	movl	%edx, 20(%r8)
.L96:
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L116:
	.cfi_restore 3
	.cfi_restore 6
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L118:
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	cmpl	$214, %edi
	jle	.L103
	jmp	.L96
	.p2align 4,,10
	.p2align 3
.L104:
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5392:
	.size	tick_powder, .-tick_powder
	.p2align 4
	.globl	tick_liquid
	.type	tick_liquid, @function
tick_liquid:
.LFB5393:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdx, %r9
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	32(%rsp), %r8d
	testl	%esi, %esi
	jle	.L120
	leaq	density(%rip), %r11
	movl	%r8d, %eax
	leal	-1(%rsi), %ecx
	movslq	%edi, %rbx
	movss	(%r11,%rax,4), %xmm4
	leaq	(%rbx,%rbx,2), %rax
	movslq	%ecx, %rcx
	leaq	world(%rip), %r10
	leaq	(%rax,%rax,8), %rdx
	leaq	(%rcx,%rcx,2), %rbp
	movss	36(%rsp), %xmm1
	movss	40(%rsp), %xmm5
	salq	$7, %rdx
	movss	44(%rsp), %xmm3
	movss	48(%rsp), %xmm6
	leaq	(%rdx,%rbp,8), %rax
	addq	%r10, %rax
	movl	(%rax), %r12d
	comiss	(%r11,%r12,4), %xmm4
	ja	.L144
	imulq	$536870923, (%r9), %rbp
	pxor	%xmm0, %xmm0
	movabsq	$1152921501385621513, %rdx
	movsd	.LC1(%rip), %xmm2
	addq	$268435459, %rbp
	movq	%rbp, %rax
	imulq	%rdx
	movq	%rbp, %rax
	sarq	$63, %rax
	sarq	$26, %rdx
	subq	%rax, %rdx
	movq	%rdx, %rax
	salq	$29, %rax
	addq	%rdx, %rax
	leaq	(%rdx,%rax,2), %rax
	movq	%rbp, %rdx
	subq	%rax, %rdx
	cvtsi2sdq	%rdx, %xmm0
	movq	%rdx, (%r9)
	cvtsd2ss	%xmm0, %xmm0
	cvtss2sd	%xmm0, %xmm0
	divsd	%xmm2, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	comiss	.LC13(%rip), %xmm0
	ja	.L145
	testl	%edi, %edi
	jle	.L119
	movl	$-1, %eax
.L126:
	addl	%edi, %eax
	leaq	(%rcx,%rcx,2), %rcx
	cltq
	leaq	(%rax,%rax,2), %rax
	leaq	(%rax,%rax,8), %rax
	salq	$7, %rax
	leaq	(%rax,%rcx,8), %rcx
	addq	%r10, %rcx
	movl	(%rcx), %ebp
	comiss	(%r11,%rbp,4), %xmm4
	jbe	.L128
	leaq	(%rbx,%rbx,2), %rdx
	unpcklps	%xmm6, %xmm3
	unpcklps	%xmm5, %xmm1
	movslq	%esi, %rsi
	movlhps	%xmm3, %xmm1
	leaq	(%rdx,%rdx,8), %rdx
	movl	%r8d, (%rcx)
	movups	4(%rcx), %xmm0
	movl	20(%rcx), %edi
	movups	%xmm1, 4(%rcx)
	salq	$7, %rdx
	leaq	4+world(%rip), %rax
	movl	$1, 20(%rcx)
	leaq	(%rsi,%rsi,2), %rcx
	leaq	(%rdx,%rcx,8), %rdx
	addq	%rdx, %r10
	movl	%ebp, (%r10)
	movups	%xmm0, (%rax,%rdx)
	movl	%edi, 20(%r10)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L144:
	.cfi_restore_state
	unpcklps	%xmm6, %xmm3
	unpcklps	%xmm5, %xmm1
	movslq	%esi, %rsi
	movups	4(%rax), %xmm0
	movlhps	%xmm3, %xmm1
	movl	20(%rax), %ecx
	movl	%r8d, (%rax)
	movups	%xmm1, 4(%rax)
	movl	$1, 20(%rax)
	leaq	(%rsi,%rsi,2), %rax
	leaq	(%rdx,%rax,8), %rax
	leaq	4+world(%rip), %rdx
	addq	%rax, %r10
	movl	%r12d, (%r10)
	movups	%xmm0, (%rdx,%rax)
	movl	%ecx, 20(%r10)
.L119:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L120:
	.cfi_restore_state
	movq	(%rdx), %rdx
	movsd	.LC1(%rip), %xmm2
.L128:
	imulq	$536870923, %rdx, %rdx
	pxor	%xmm0, %xmm0
	leaq	268435459(%rdx), %rcx
	movabsq	$1152921501385621513, %rdx
	movq	%rcx, %rax
	imulq	%rdx
	movq	%rcx, %rax
	sarq	$63, %rax
	sarq	$26, %rdx
	subq	%rax, %rdx
	movq	%rdx, %rax
	salq	$29, %rax
	addq	%rdx, %rax
	leaq	(%rdx,%rax,2), %rax
	subq	%rax, %rcx
	cvtsi2sdq	%rcx, %xmm0
	movq	%rcx, (%r9)
	cvtsd2ss	%xmm0, %xmm0
	cvtss2sd	%xmm0, %xmm0
	divsd	%xmm2, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	comiss	.LC13(%rip), %xmm0
	jbe	.L142
	movl	$1, %eax
	cmpl	$214, %edi
	jg	.L119
.L132:
	addl	%edi, %eax
	movslq	%esi, %rsi
	leaq	world(%rip), %rcx
	cltq
	leaq	(%rsi,%rsi,2), %rdx
	leaq	density(%rip), %rsi
	leaq	(%rax,%rax,2), %rax
	salq	$3, %rdx
	movss	(%rsi,%r8,4), %xmm0
	leaq	(%rax,%rax,8), %rax
	salq	$7, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	movl	(%rax), %r10d
	comiss	(%rsi,%r10,4), %xmm0
	jbe	.L119
	movl	$1, 52(%rsp)
	movdqu	32(%rsp), %xmm7
	movslq	%edi, %rdi
	movq	48(%rsp), %r8
	movss	4(%rax), %xmm0
	movss	8(%rax), %xmm2
	movss	12(%rax), %xmm1
	movups	%xmm7, (%rax)
	movss	16(%rax), %xmm3
	movl	20(%rax), %esi
	movq	%r8, 16(%rax)
	leaq	(%rdi,%rdi,2), %rax
	leaq	(%rax,%rax,8), %rax
	unpcklps	%xmm2, %xmm0
	salq	$7, %rax
	unpcklps	%xmm3, %xmm1
	addq	%rax, %rdx
	movlhps	%xmm1, %xmm0
	leaq	(%rcx,%rdx), %rax
	movl	%r10d, (%rax)
	movups	%xmm0, 4(%rcx,%rdx)
	movl	%esi, 20(%rax)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L142:
	.cfi_restore_state
	testl	%edi, %edi
	jle	.L119
	movl	$-1, %eax
	jmp	.L132
	.p2align 4,,10
	.p2align 3
.L145:
	movl	$1, %eax
	cmpl	$214, %edi
	jle	.L126
	jmp	.L119
	.cfi_endproc
.LFE5393:
	.size	tick_liquid, .-tick_liquid
	.p2align 4
	.globl	tick_gas
	.type	tick_gas, @function
tick_gas:
.LFB5394:
	.cfi_startproc
	cmpl	$142, %esi
	jg	.L166
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	density(%rip), %r9
	movslq	%edi, %r10
	leal	1(%rsi), %ecx
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	24(%rsp), %eax
	movslq	%ecx, %rcx
	movq	%rdx, %rbx
	leaq	(%rcx,%rcx,2), %rdx
	leaq	world(%rip), %r8
	movss	(%r9,%rax,4), %xmm1
	leaq	(%r10,%r10,2), %rax
	leaq	(%rax,%rax,8), %r11
	salq	$7, %r11
	leaq	(%r11,%rdx,8), %rax
	addq	%r8, %rax
	movl	(%rax), %edx
	comiss	(%r9,%rdx,4), %xmm1
	movq	%rdx, %rbp
	ja	.L169
	imulq	$536870923, (%rbx), %r11
	pxor	%xmm0, %xmm0
	movabsq	$1152921501385621513, %rdx
	addq	$268435459, %r11
	movq	%r11, %rax
	imulq	%rdx
	movq	%r11, %rax
	sarq	$63, %rax
	sarq	$26, %rdx
	subq	%rax, %rdx
	movq	%rdx, %rax
	salq	$29, %rax
	addq	%rdx, %rax
	leaq	(%rdx,%rax,2), %rax
	movq	%r11, %rdx
	subq	%rax, %rdx
	cvtsi2sdq	%rdx, %xmm0
	movq	%rdx, (%rbx)
	cvtsd2ss	%xmm0, %xmm0
	cvtss2sd	%xmm0, %xmm0
	divsd	.LC1(%rip), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	comiss	.LC13(%rip), %xmm0
	jbe	.L163
	movl	$1, %eax
	cmpl	$214, %edi
	jg	.L146
.L154:
	addl	%eax, %edi
	leaq	(%rcx,%rcx,2), %rdx
	movslq	%edi, %rdi
	leaq	(%rdi,%rdi,2), %rax
	leaq	(%rax,%rax,8), %rax
	salq	$7, %rax
	leaq	(%rax,%rdx,8), %rdx
	addq	%r8, %rdx
	movl	(%rdx), %ecx
	comiss	(%r9,%rcx,4), %xmm1
	movq	%rcx, %rdi
	ja	.L170
	movslq	%esi, %rsi
	leaq	(%rsi,%rsi,2), %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	addq	%r8, %rax
	movl	(%rax), %esi
	comiss	(%r9,%rsi,4), %xmm1
	movq	%rsi, %rcx
	jbe	.L146
	movl	$1, 44(%rsp)
	movdqu	24(%rsp), %xmm6
	movq	40(%rsp), %rdi
	movss	4(%rax), %xmm0
	movss	8(%rax), %xmm2
	movss	12(%rax), %xmm1
	movups	%xmm6, (%rax)
	movss	16(%rax), %xmm3
	movl	20(%rax), %esi
	movq	%rdi, 16(%rax)
	leaq	(%r10,%r10,2), %rax
	leaq	(%rax,%rax,8), %rax
	unpcklps	%xmm2, %xmm0
	salq	$7, %rax
	unpcklps	%xmm3, %xmm1
	addq	%rax, %rdx
	movlhps	%xmm1, %xmm0
	leaq	4+world(%rip), %rax
	addq	%rdx, %r8
	movl	%ecx, (%r8)
	movups	%xmm0, (%rax,%rdx)
	movl	%esi, 20(%r8)
	jmp	.L146
	.p2align 4,,10
	.p2align 3
.L169:
	movl	$1, 44(%rsp)
	movdqu	24(%rsp), %xmm4
	movslq	%esi, %rsi
	movq	40(%rsp), %rcx
	movss	4(%rax), %xmm0
	movss	8(%rax), %xmm2
	movss	12(%rax), %xmm1
	movups	%xmm4, (%rax)
	movss	16(%rax), %xmm3
	movl	20(%rax), %edx
	movq	%rcx, 16(%rax)
	leaq	(%rsi,%rsi,2), %rax
	leaq	(%r11,%rax,8), %rax
	unpcklps	%xmm2, %xmm0
	leaq	4+world(%rip), %rcx
	unpcklps	%xmm3, %xmm1
	addq	%rax, %r8
	movlhps	%xmm1, %xmm0
	movl	%ebp, (%r8)
	movups	%xmm0, (%rcx,%rax)
	movl	%edx, 20(%r8)
.L146:
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L166:
	.cfi_restore 3
	.cfi_restore 6
	ret
	.p2align 4,,10
	.p2align 3
.L163:
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	testl	%edi, %edi
	jle	.L146
	movl	$-1, %eax
	jmp	.L154
	.p2align 4,,10
	.p2align 3
.L170:
	movl	$1, 44(%rsp)
	movq	40(%rsp), %rax
	movslq	%esi, %rsi
	movss	16(%rdx), %xmm3
	movl	20(%rdx), %ecx
	movdqu	24(%rsp), %xmm5
	movss	4(%rdx), %xmm0
	movq	%rax, 16(%rdx)
	leaq	(%r10,%r10,2), %rax
	movss	8(%rdx), %xmm2
	movss	12(%rdx), %xmm1
	leaq	(%rax,%rax,8), %rax
	movups	%xmm5, (%rdx)
	salq	$7, %rax
	leaq	(%rsi,%rsi,2), %rdx
	leaq	(%rax,%rdx,8), %rax
	unpcklps	%xmm3, %xmm1
	unpcklps	%xmm2, %xmm0
	addq	%rax, %r8
	movlhps	%xmm1, %xmm0
	leaq	4+world(%rip), %rdx
	movl	%edi, (%r8)
	movups	%xmm0, (%rdx,%rax)
	movl	%ecx, 20(%r8)
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5394:
	.size	tick_gas, .-tick_gas
	.section	.rodata.str1.1
.LC14:
	.string	"invalid material @ %d %d"
	.text
	.p2align 4
	.globl	tick_pos
	.type	tick_pos, @function
tick_pos:
.LFB5395:
	.cfi_startproc
	movslq	%edi, %rax
	movq	%rdx, %r8
	movslq	%esi, %rdx
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	leaq	(%rax,%rax,2), %rax
	leaq	(%rdx,%rdx,2), %rdx
	leaq	(%rax,%rax,8), %rax
	leaq	world(%rip), %rbx
	salq	$7, %rax
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	leaq	(%rax,%rdx,8), %rax
	addq	%rax, %rbx
	movq	16(%rbx), %rax
	movdqu	(%rbx), %xmm1
	movq	%rax, 16(%rsp)
	movl	20(%rbx), %eax
	movups	%xmm1, (%rsp)
	testl	%eax, %eax
	jne	.L171
	movl	(%rbx), %edx
	leaq	types(%rip), %rax
	cmpl	$4, (%rax,%rdx,4)
	ja	.L174
	movl	(%rax,%rdx,4), %eax
	leaq	.L176(%rip), %rdx
	movslq	(%rdx,%rax,4), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L176:
	.long	.L171-.L176
	.long	.L179-.L176
	.long	.L178-.L176
	.long	.L177-.L176
	.long	.L171-.L176
	.text
.L174:
	movl	%esi, %edx
	xorl	%eax, %eax
	movl	%edi, %esi
	leaq	.LC14(%rip), %rdi
	call	printf@PLT
	movq	stdout(%rip), %rdi
	call	fflush@PLT
	movaps	.LC9(%rip), %xmm0
	movl	$0, (%rbx)
	movl	$0, 20(%rbx)
	movups	%xmm0, 4(%rbx)
.L171:
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L178:
	.cfi_restore_state
	subq	$8, %rsp
	.cfi_def_cfa_offset 56
	movq	%r8, %rdx
	pushq	24(%rsp)
	.cfi_def_cfa_offset 64
	pushq	24(%rsp)
	.cfi_def_cfa_offset 72
	pushq	24(%rsp)
	.cfi_def_cfa_offset 80
	call	tick_powder
	addq	$32, %rsp
	.cfi_def_cfa_offset 48
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L177:
	.cfi_restore_state
	subq	$8, %rsp
	.cfi_def_cfa_offset 56
	movq	%r8, %rdx
	pushq	24(%rsp)
	.cfi_def_cfa_offset 64
	pushq	24(%rsp)
	.cfi_def_cfa_offset 72
	pushq	24(%rsp)
	.cfi_def_cfa_offset 80
	call	tick_liquid
	addq	$32, %rsp
	.cfi_def_cfa_offset 48
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L179:
	.cfi_restore_state
	subq	$8, %rsp
	.cfi_def_cfa_offset 56
	movq	%r8, %rdx
	pushq	24(%rsp)
	.cfi_def_cfa_offset 64
	pushq	24(%rsp)
	.cfi_def_cfa_offset 72
	pushq	24(%rsp)
	.cfi_def_cfa_offset 80
	call	tick_gas
	addq	$32, %rsp
	.cfi_def_cfa_offset 48
	addq	$32, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5395:
	.size	tick_pos, .-tick_pos
	.p2align 4
	.globl	x_handler
	.type	x_handler, @function
x_handler:
.LFB5396:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leal	(%rdx,%rdx,8), %eax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rcx, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	leal	(%rdi,%rax,8), %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	leal	(%rsi,%rsi,8), %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sall	$3, %ebp
	subq	$56, %rsp
	.cfi_def_cfa_offset 112
	movl	cur_tick_index(%rip), %eax
	andl	$-2147483645, %eax
	cmpl	$3, %eax
	je	.L197
	movslq	%ebp, %rdx
	movslq	%r12d, %rax
	leaq	world(%rip), %rcx
	leaq	(%rdx,%rdx,2), %rdx
	leaq	(%rax,%rax,2), %rax
	leaq	(%rdx,%rdx,8), %rdx
	salq	$3, %rax
	leaq	248832(%rcx), %r13
	salq	$7, %rdx
	leaq	types(%rip), %r8
	leaq	(%rax,%rdx), %rbx
	addq	%r13, %rdx
	leaq	.L188(%rip), %r13
	addq	%rdx, %rax
	addq	%rcx, %rbx
	movq	%rax, 8(%rsp)
	movq	%rbx, %r15
	.p2align 4,,10
	.p2align 3
.L192:
	movq	16(%rbx), %rax
	movdqu	(%rbx), %xmm0
	movq	%rax, 32(%rsp)
	movl	20(%rbx), %eax
	movups	%xmm0, 16(%rsp)
	testl	%eax, %eax
	jne	.L185
	movl	(%rbx), %eax
	cmpl	$4, (%r8,%rax,4)
	ja	.L186
	movl	(%r8,%rax,4), %eax
	movslq	0(%r13,%rax,4), %rax
	addq	%r13, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L188:
	.long	.L185-.L188
	.long	.L191-.L188
	.long	.L190-.L188
	.long	.L189-.L188
	.long	.L185-.L188
	.text
.L186:
	movl	%r12d, %edx
	movl	%ebp, %esi
	leaq	.LC14(%rip), %rdi
	xorl	%eax, %eax
	call	printf@PLT
	movq	stdout(%rip), %rdi
	call	fflush@PLT
	movaps	.LC9(%rip), %xmm1
	movl	$0, (%r15)
	leaq	types(%rip), %r8
	movl	$0, 20(%r15)
	movups	%xmm1, 4(%r15)
	.p2align 4,,10
	.p2align 3
.L185:
	addq	$3456, %rbx
	addl	$1, %ebp
	addq	$3456, %r15
	cmpq	8(%rsp), %rbx
	jne	.L192
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L190:
	.cfi_restore_state
	subq	$8, %rsp
	.cfi_def_cfa_offset 120
	movq	%r14, %rdx
	movl	%r12d, %esi
	movl	%ebp, %edi
	pushq	40(%rsp)
	.cfi_def_cfa_offset 128
	pushq	40(%rsp)
	.cfi_def_cfa_offset 136
	pushq	40(%rsp)
	.cfi_def_cfa_offset 144
	call	tick_powder
	addq	$32, %rsp
	.cfi_def_cfa_offset 112
	leaq	types(%rip), %r8
	jmp	.L185
	.p2align 4,,10
	.p2align 3
.L189:
	subq	$8, %rsp
	.cfi_def_cfa_offset 120
	movq	%r14, %rdx
	movl	%r12d, %esi
	movl	%ebp, %edi
	pushq	40(%rsp)
	.cfi_def_cfa_offset 128
	pushq	40(%rsp)
	.cfi_def_cfa_offset 136
	pushq	40(%rsp)
	.cfi_def_cfa_offset 144
	call	tick_liquid
	addq	$32, %rsp
	.cfi_def_cfa_offset 112
	leaq	types(%rip), %r8
	jmp	.L185
	.p2align 4,,10
	.p2align 3
.L191:
	subq	$8, %rsp
	.cfi_def_cfa_offset 120
	movq	%r14, %rdx
	movl	%r12d, %esi
	movl	%ebp, %edi
	pushq	40(%rsp)
	.cfi_def_cfa_offset 128
	pushq	40(%rsp)
	.cfi_def_cfa_offset 136
	pushq	40(%rsp)
	.cfi_def_cfa_offset 144
	call	tick_gas
	addq	$32, %rsp
	.cfi_def_cfa_offset 112
	leaq	types(%rip), %r8
	jmp	.L185
.L197:
	leal	71(%rbp), %ebx
	.p2align 4,,10
	.p2align 3
.L183:
	movl	%ebx, %edi
	movq	%r14, %rdx
	movl	%r12d, %esi
	call	tick_pos
	movl	%ebx, %eax
	subl	$1, %ebx
	cmpl	%ebp, %eax
	jne	.L183
	addq	$56, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5396:
	.size	x_handler, .-x_handler
	.p2align 4
	.globl	tick_chunk
	.type	tick_chunk, @function
tick_chunk:
.LFB5397:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leal	(%rsi,%rsi,8), %r15d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leal	(%rdi,%rdi,8), %r14d
	sall	$3, %r15d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	leal	0(,%r14,8), %edi
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdx, %rbx
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movl	cur_tick_index(%rip), %eax
	movl	%edi, 4(%rsp)
	testb	$1, %al
	jne	.L199
	movslq	%edi, %rdx
	movslq	%r15d, %rcx
	movl	%r15d, %r13d
	andl	$-2147483645, %eax
	leaq	(%rdx,%rdx,2), %rdx
	leaq	(%rcx,%rcx,2), %rcx
	salq	$3, %rcx
	leaq	(%rdx,%rdx,8), %rdx
	leaq	248832+world(%rip), %r15
	salq	$7, %rdx
	addq	%rcx, %r15
	leaq	250560+world(%rip), %rsi
	leaq	(%r15,%rdx), %rdi
	addq	%rsi, %rcx
	leaq	types(%rip), %r12
	movq	%rdi, 8(%rsp)
	leaq	(%rcx,%rdx), %rdi
	leaq	.L215(%rip), %rbp
	movq	%rdi, 24(%rsp)
	cmpl	$3, %eax
	je	.L227
	.p2align 4,,10
	.p2align 3
.L208:
	movq	8(%rsp), %rax
	movl	4(%rsp), %r15d
	leaq	-248832(%rax), %rcx
	movq	%rcx, %r14
	.p2align 4,,10
	.p2align 3
.L219:
	movq	16(%rcx), %rax
	movdqu	(%rcx), %xmm0
	movq	%rax, 48(%rsp)
	movl	20(%rcx), %eax
	movups	%xmm0, 32(%rsp)
	testl	%eax, %eax
	jne	.L212
	movl	(%rcx), %eax
	cmpl	$4, (%r12,%rax,4)
	ja	.L213
	movl	(%r12,%rax,4), %eax
	movslq	0(%rbp,%rax,4), %rax
	addq	%rbp, %rax
	jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L215:
	.long	.L212-.L215
	.long	.L218-.L215
	.long	.L217-.L215
	.long	.L216-.L215
	.long	.L212-.L215
	.text
.L213:
	movl	%r13d, %edx
	movl	%r15d, %esi
	leaq	.LC14(%rip), %rdi
	xorl	%eax, %eax
	movq	%rcx, 16(%rsp)
	call	printf@PLT
	movq	stdout(%rip), %rdi
	call	fflush@PLT
	movaps	.LC9(%rip), %xmm1
	movq	16(%rsp), %rcx
	movl	$0, (%r14)
	movl	$0, 20(%r14)
	movups	%xmm1, 4(%r14)
	.p2align 4,,10
	.p2align 3
.L212:
	addq	$3456, %rcx
	addl	$1, %r15d
	addq	$3456, %r14
	cmpq	8(%rsp), %rcx
	jne	.L219
.L220:
	addq	$24, 8(%rsp)
	addl	$1, %r13d
	movq	8(%rsp), %rax
	cmpq	24(%rsp), %rax
	je	.L198
	movl	cur_tick_index(%rip), %eax
	andl	$-2147483645, %eax
	cmpl	$3, %eax
	jne	.L208
.L227:
	movl	4(%rsp), %eax
	leal	71(%rax), %r14d
	.p2align 4,,10
	.p2align 3
.L209:
	movq	%rbx, %rdx
	movl	%r14d, %edi
	movl	%r13d, %esi
	call	tick_pos
	movl	%r14d, %edx
	subl	$1, %r14d
	cmpl	%edx, 4(%rsp)
	jne	.L209
	jmp	.L220
	.p2align 4,,10
	.p2align 3
.L217:
	movq	%rcx, 16(%rsp)
	subq	$8, %rsp
	.cfi_def_cfa_offset 136
	movq	%rbx, %rdx
	movl	%r13d, %esi
	pushq	56(%rsp)
	.cfi_def_cfa_offset 144
	movl	%r15d, %edi
	pushq	56(%rsp)
	.cfi_def_cfa_offset 152
	pushq	56(%rsp)
	.cfi_def_cfa_offset 160
	call	tick_powder
	addq	$32, %rsp
	.cfi_def_cfa_offset 128
	movq	16(%rsp), %rcx
	jmp	.L212
	.p2align 4,,10
	.p2align 3
.L216:
	movq	%rcx, 16(%rsp)
	subq	$8, %rsp
	.cfi_def_cfa_offset 136
	movq	%rbx, %rdx
	movl	%r13d, %esi
	pushq	56(%rsp)
	.cfi_def_cfa_offset 144
	movl	%r15d, %edi
	pushq	56(%rsp)
	.cfi_def_cfa_offset 152
	pushq	56(%rsp)
	.cfi_def_cfa_offset 160
	call	tick_liquid
	addq	$32, %rsp
	.cfi_def_cfa_offset 128
	movq	16(%rsp), %rcx
	jmp	.L212
	.p2align 4,,10
	.p2align 3
.L218:
	movq	%rcx, 16(%rsp)
	subq	$8, %rsp
	.cfi_def_cfa_offset 136
	movq	%rbx, %rdx
	movl	%r13d, %esi
	pushq	56(%rsp)
	.cfi_def_cfa_offset 144
	movl	%r15d, %edi
	pushq	56(%rsp)
	.cfi_def_cfa_offset 152
	pushq	56(%rsp)
	.cfi_def_cfa_offset 160
	call	tick_gas
	addq	$32, %rsp
	.cfi_def_cfa_offset 128
	movq	16(%rsp), %rcx
	jmp	.L212
.L198:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L199:
	.cfi_restore_state
	andl	$-2147483645, %eax
	movl	4(%rsp), %ebp
	leal	71(%r15), %r12d
	leal	72(%rdi), %r13d
	cmpl	$3, %eax
	je	.L228
	.p2align 4,,10
	.p2align 3
.L205:
	movl	%ebp, %edi
	movq	%rbx, %rdx
	movl	%r12d, %esi
	addl	$1, %ebp
	call	tick_pos
	cmpl	%ebp, %r13d
	jne	.L205
.L206:
	leal	-1(%r12), %edx
	cmpl	%r15d, %r12d
	je	.L198
	movl	cur_tick_index(%rip), %eax
	movl	4(%rsp), %ebp
	movl	%edx, %r12d
	andl	$-2147483645, %eax
	cmpl	$3, %eax
	jne	.L205
.L228:
	leal	71(%rbp), %ebp
	.p2align 4,,10
	.p2align 3
.L202:
	movl	%ebp, %edi
	movq	%rbx, %rdx
	movl	%r12d, %esi
	call	tick_pos
	movl	%ebp, %eax
	subl	$1, %ebp
	cmpl	%eax, 4(%rsp)
	jne	.L202
	jmp	.L206
	.cfi_endproc
.LFE5397:
	.size	tick_chunk, .-tick_chunk
	.p2align 4
	.globl	thread_process
	.type	thread_process, @function
thread_process:
.LFB5398:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rax
	movl	4(%rdi), %esi
	movl	(%rdi), %edi
	leaq	8(%rsp), %rdx
	movq	%rax, 8(%rsp)
	call	tick_chunk
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5398:
	.size	thread_process, .-thread_process
	.section	.rodata.str1.1
.LC15:
	.string	"creation"
.LC16:
	.string	"joining"
	.text
	.p2align 4
	.globl	tick_grid
	.type	tick_grid, @function
tick_grid:
.LFB5399:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movl	%esi, %ebx
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movl	%edi, 4(%rsp)
	leaq	.LC15(%rip), %rdi
	movl	%esi, 8(%rsp)
	call	logger
	cmpl	$2, 4(%rsp)
	jg	.L232
	movl	$1, %r15d
	xorl	%r13d, %r13d
	movabsq	$1152921501385621513, %r12
	subl	%ebx, %r15d
	shrl	%r15d
	movl	%r15d, 12(%rsp)
	.p2align 4,,10
	.p2align 3
.L233:
	cmpl	$1, 8(%rsp)
	jg	.L237
	movslq	%r13d, %rbx
	movl	8(%rsp), %r15d
	leaq	16(%rsp), %rbp
	movq	random_base(%rip), %rcx
	movq	%rbx, %rax
	salq	$4, %rax
	leaq	32(%rsp,%rax), %r14
	.p2align 4,,10
	.p2align 3
.L234:
	imulq	$536870923, %rcx, %rcx
	movd	4(%rsp), %xmm0
	movd	%r15d, %xmm1
	xorl	%esi, %esi
	leaq	0(%rbp,%rbx,8), %rdi
	addl	$2, %r15d
	punpckldq	%xmm1, %xmm0
	addq	$268435459, %rcx
	movq	%xmm0, (%r14)
	movq	%rcx, %rax
	imulq	%r12
	movq	%rcx, %rax
	sarq	$63, %rax
	sarq	$26, %rdx
	subq	%rax, %rdx
	movq	%rdx, %rax
	salq	$29, %rax
	addq	%rdx, %rax
	leaq	(%rdx,%rax,2), %rax
	leaq	thread_process(%rip), %rdx
	subq	%rax, %rcx
	movq	%rcx, 8(%r14)
	movq	%rcx, random_base(%rip)
	movq	%r14, %rcx
	addq	$16, %r14
	call	pthread_create@PLT
	movq	random_base(%rip), %rcx
	addq	%rbx, %rcx
	addq	$1, %rbx
	movq	%rcx, random_base(%rip)
	cmpl	$1, %r15d
	jle	.L234
	movl	12(%rsp), %eax
	leal	1(%r13,%rax), %r13d
.L237:
	addl	$2, 4(%rsp)
	movl	4(%rsp), %eax
	cmpl	$2, %eax
	jle	.L233
	leaq	.LC16(%rip), %rdi
	call	logger
	testl	%r13d, %r13d
	je	.L231
	leal	-1(%r13), %eax
	leaq	16(%rsp), %rbx
	leaq	24(%rsp,%rax,8), %rbp
	.p2align 4,,10
	.p2align 3
.L240:
	movq	(%rbx), %rdi
	xorl	%esi, %esi
	addq	$8, %rbx
	call	pthread_join@PLT
	cmpq	%rbx, %rbp
	jne	.L240
.L231:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L232:
	.cfi_restore_state
	addq	$72, %rsp
	.cfi_def_cfa_offset 56
	leaq	.LC16(%rip), %rdi
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	logger
	.cfi_endproc
.LFE5399:
	.size	tick_grid, .-tick_grid
	.p2align 4
	.globl	tick
	.type	tick, @function
tick:
.LFB5400:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	xorl	%esi, %esi
	xorl	%edi, %edi
	call	tick_grid
	movl	$1, %esi
	xorl	%edi, %edi
	call	tick_grid
	xorl	%esi, %esi
	movl	$1, %edi
	call	tick_grid
	movl	$1, %esi
	movl	$1, %edi
	call	tick_grid
	leaq	3476+world(%rip), %rdx
	leaq	746496(%rdx), %rcx
.L246:
	leaq	-3456(%rdx), %rax
	.p2align 4,,10
	.p2align 3
.L247:
	movl	$0, (%rax)
	addq	$24, %rax
	cmpq	%rdx, %rax
	jne	.L247
	leaq	3456(%rax), %rdx
	cmpq	%rdx, %rcx
	jne	.L246
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5400:
	.size	tick, .-tick
	.p2align 4
	.globl	init_sim
	.type	init_sim, @function
init_sim:
.LFB5401:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	$-107, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	leaq	3456+world(%rip), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	leaq	746496(%rbp), %r13
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
.L252:
	cmpl	$2, %r12d
	jbe	.L265
	leaq	-3456(%rbp), %rbx
	jmp	.L260
	.p2align 4,,10
	.p2align 3
.L256:
	movaps	.LC12(%rip), %xmm2
	movl	$3, (%rbx)
	movl	$0, 20(%rbx)
	movups	%xmm2, 4(%rbx)
.L259:
	addq	$24, %rbx
	cmpq	%rbx, %rbp
	je	.L261
.L260:
	call	rand@PLT
	pxor	%xmm0, %xmm0
	movsd	.LC17(%rip), %xmm1
	cvtsi2ssl	%eax, %xmm0
	mulss	.LC0(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	comisd	%xmm0, %xmm1
	ja	.L256
	call	rand@PLT
	pxor	%xmm0, %xmm0
	movsd	.LC17(%rip), %xmm3
	cvtsi2ssl	%eax, %xmm0
	mulss	.LC0(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	comisd	%xmm0, %xmm3
	jbe	.L266
	movaps	.LC10(%rip), %xmm4
	movl	$1, (%rbx)
	addq	$24, %rbx
	movl	$0, -4(%rbx)
	movups	%xmm4, -20(%rbx)
	cmpq	%rbx, %rbp
	jne	.L260
.L261:
	addq	$3456, %rbp
	addl	$1, %r12d
	cmpq	%rbp, %r13
	jne	.L252
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L266:
	.cfi_restore_state
	call	rand@PLT
	pxor	%xmm0, %xmm0
	movsd	.LC17(%rip), %xmm5
	cvtsi2ssl	%eax, %xmm0
	mulss	.LC0(%rip), %xmm0
	cvtss2sd	%xmm0, %xmm0
	comisd	%xmm0, %xmm5
	ja	.L258
	movaps	.LC9(%rip), %xmm6
	movl	$0, (%rbx)
	movl	$0, 20(%rbx)
	movups	%xmm6, 4(%rbx)
	jmp	.L259
	.p2align 4,,10
	.p2align 3
.L258:
	movaps	.LC11(%rip), %xmm7
	movl	$2, (%rbx)
	movl	$0, 20(%rbx)
	movups	%xmm7, 4(%rbx)
	jmp	.L259
.L265:
	movaps	.LC12(%rip), %xmm0
	leaq	-3456(%rbp), %rax
	movl	$144, %edx
.L253:
	movl	$3, (%rax)
	addq	$24, %rax
	movups	%xmm0, -20(%rax)
	movl	$0, -4(%rax)
	subl	$1, %edx
	jne	.L253
	jmp	.L261
	.cfi_endproc
.LFE5401:
	.size	init_sim, .-init_sim
	.section	.rodata.str1.1
.LC18:
	.string	"Sand Sim"
	.text
	.p2align 4
	.globl	init_render
	.type	init_render, @function
init_render:
.LFB5402:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	xorl	%edi, %edi
	call	SDL_Init@PLT
	movl	$4, %r9d
	movl	$144, %r8d
	movl	$216, %ecx
	movl	$536805376, %edx
	movl	$536805376, %esi
	leaq	.LC18(%rip), %rdi
	call	SDL_CreateWindow@PLT
	xorl	%edx, %edx
	movl	$-1, %esi
	movq	%rax, %rdi
	movq	%rax, window(%rip)
	call	SDL_CreateRenderer@PLT
	movl	$144, %r8d
	movl	$216, %ecx
	movl	$1, %edx
	movq	%rax, %rdi
	movl	$376840196, %esi
	movq	%rax, renderer(%rip)
	call	SDL_CreateTexture@PLT
	movq	%rax, texture(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5402:
	.size	init_render, .-init_render
	.p2align 4
	.globl	display
	.type	display, @function
display:
.LFB5403:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	732676+world(%rip), %rcx
	movapd	.LC19(%rip), %xmm2
	movdqa	.LC20(%rip), %xmm7
	leaq	-732672(%rcx), %rdi
	leaq	123552+screen(%rip), %rsi
	leaq	3456(%rcx), %r8
.L270:
	movq	%rsi, %rdx
	movq	%rdi, %rax
	.p2align 4,,10
	.p2align 3
.L272:
	movlps	8(%rax), %xmm3
	cvtps2pd	(%rax), %xmm0
	movlps	3464(%rax), %xmm4
	movlps	6920(%rax), %xmm5
	mulpd	%xmm2, %xmm0
	cvtps2pd	%xmm3, %xmm1
	cvtps2pd	%xmm4, %xmm12
	movlps	10376(%rax), %xmm6
	mulpd	%xmm2, %xmm1
	cvtps2pd	%xmm6, %xmm13
	addq	$16, %rdx
	mulpd	%xmm2, %xmm12
	mulpd	%xmm2, %xmm13
	cvttpd2dq	%xmm0, %xmm0
	cvttpd2dq	%xmm1, %xmm1
	punpcklqdq	%xmm1, %xmm0
	cvtps2pd	3456(%rax), %xmm1
	mulpd	%xmm2, %xmm1
	cvttpd2dq	%xmm12, %xmm12
	cvttpd2dq	%xmm13, %xmm13
	cvttpd2dq	%xmm1, %xmm1
	punpcklqdq	%xmm12, %xmm1
	movdqa	%xmm0, %xmm12
	punpcklwd	%xmm1, %xmm0
	punpckhwd	%xmm1, %xmm12
	movdqa	%xmm0, %xmm1
	punpcklwd	%xmm12, %xmm0
	punpckhwd	%xmm12, %xmm1
	cvtps2pd	%xmm5, %xmm12
	mulpd	%xmm2, %xmm12
	punpcklwd	%xmm1, %xmm0
	cvtps2pd	6912(%rax), %xmm1
	mulpd	%xmm2, %xmm1
	pand	%xmm7, %xmm0
	cvttpd2dq	%xmm12, %xmm12
	cvttpd2dq	%xmm1, %xmm1
	punpcklqdq	%xmm12, %xmm1
	cvtps2pd	10368(%rax), %xmm12
	addq	$13824, %rax
	mulpd	%xmm2, %xmm12
	cvttpd2dq	%xmm12, %xmm12
	punpcklqdq	%xmm13, %xmm12
	movdqa	%xmm1, %xmm13
	punpcklwd	%xmm12, %xmm1
	punpckhwd	%xmm12, %xmm13
	movdqa	%xmm1, %xmm12
	punpcklwd	%xmm13, %xmm1
	punpckhwd	%xmm13, %xmm12
	punpcklwd	%xmm12, %xmm1
	pand	%xmm7, %xmm1
	packuswb	%xmm1, %xmm0
	movaps	%xmm0, -16(%rdx)
	cmpq	%rcx, %rax
	jne	.L272
	movlps	8(%rax), %xmm8
	cvtps2pd	(%rax), %xmm0
	movlps	3464(%rax), %xmm9
	movlps	6920(%rax), %xmm10
	mulpd	%xmm2, %xmm0
	cvtps2pd	%xmm8, %xmm1
	cvtps2pd	%xmm9, %xmm12
	movlps	10376(%rax), %xmm11
	mulpd	%xmm2, %xmm1
	cvtps2pd	%xmm11, %xmm13
	leaq	24(%rax), %rcx
	addq	$24, %rdi
	mulpd	%xmm2, %xmm12
	subq	$864, %rsi
	mulpd	%xmm2, %xmm13
	cvttpd2dq	%xmm0, %xmm0
	cvttpd2dq	%xmm1, %xmm1
	punpcklqdq	%xmm1, %xmm0
	cvtps2pd	3456(%rax), %xmm1
	mulpd	%xmm2, %xmm1
	cvttpd2dq	%xmm12, %xmm12
	cvttpd2dq	%xmm13, %xmm13
	cvttpd2dq	%xmm1, %xmm1
	punpcklqdq	%xmm12, %xmm1
	movdqa	%xmm0, %xmm12
	punpcklwd	%xmm1, %xmm0
	punpckhwd	%xmm1, %xmm12
	movdqa	%xmm0, %xmm1
	punpcklwd	%xmm12, %xmm0
	punpckhwd	%xmm12, %xmm1
	cvtps2pd	%xmm10, %xmm12
	mulpd	%xmm2, %xmm12
	punpcklwd	%xmm1, %xmm0
	cvtps2pd	6912(%rax), %xmm1
	mulpd	%xmm2, %xmm1
	pand	%xmm7, %xmm0
	cvttpd2dq	%xmm12, %xmm12
	cvttpd2dq	%xmm1, %xmm1
	punpcklqdq	%xmm12, %xmm1
	cvtps2pd	10368(%rax), %xmm12
	mulpd	%xmm2, %xmm12
	cvttpd2dq	%xmm12, %xmm12
	punpcklqdq	%xmm13, %xmm12
	movdqa	%xmm1, %xmm13
	punpcklwd	%xmm12, %xmm1
	punpckhwd	%xmm12, %xmm13
	movdqa	%xmm1, %xmm12
	punpcklwd	%xmm13, %xmm1
	punpckhwd	%xmm13, %xmm12
	punpcklwd	%xmm12, %xmm1
	pand	%xmm7, %xmm1
	packuswb	%xmm1, %xmm0
	movaps	%xmm0, 1712(%rsi)
	cmpq	%r8, %rcx
	jne	.L270
	movq	texture(%rip), %rdi
	movl	$864, %ecx
	leaq	screen(%rip), %rdx
	xorl	%esi, %esi
	call	SDL_UpdateTexture@PLT
	movq	renderer(%rip), %rdi
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	texture(%rip), %rsi
	call	SDL_RenderCopy@PLT
	movq	renderer(%rip), %rdi
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	SDL_RenderPresent@PLT
	.cfi_endproc
.LFE5403:
	.size	display, .-display
	.p2align 4
	.globl	handle_input
	.type	handle_input, @function
handle_input:
.LFB5404:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$64, %rsp
	.cfi_def_cfa_offset 80
	movq	%rsp, %rbx
.L285:
	movq	%rbx, %rdi
	call	SDL_PollEvent@PLT
	testl	%eax, %eax
	je	.L279
	movl	(%rsp), %eax
	cmpl	$256, %eax
	je	.L284
	cmpl	$768, %eax
	jne	.L285
	cmpl	$27, 20(%rsp)
	jne	.L285
	.p2align 4,,10
	.p2align 3
.L284:
	movl	$1, %eax
.L279:
	addq	$64, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE5404:
	.size	handle_input, .-handle_input
	.section	.rodata.str1.1
.LC21:
	.string	"Init Done."
.LC22:
	.string	"Quitting!"
.LC23:
	.string	"display"
.LC24:
	.string	"garbage"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB5405:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	time_spec(%rip), %rax
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	leaq	20+world(%rip), %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movabsq	$-3689348814741910323, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movabsq	$1844674407370955161, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	$1, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leaq	746496(%r14), %rbx
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%rax, time_handle(%rip)
	leaq	cur_time(%rip), %rax
	cqto
	movq	%rsp, %r15
	shrq	$33, %rdx
	leaq	(%rax,%rdx), %rdi
	andl	$2147483647, %edi
	subq	%rdx, %rdi
	call	srand@PLT
	call	SDL_GetError@PLT
	xorl	%eax, %eax
	call	init_sim
	xorl	%eax, %eax
	call	init_render
	leaq	.LC21(%rip), %rdi
	call	puts@PLT
.L296:
	movq	time_handle(%rip), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
.L302:
	movq	%r15, %rdi
	call	SDL_PollEvent@PLT
	testl	%eax, %eax
	je	.L307
	movl	(%rsp), %eax
	cmpl	$256, %eax
	je	.L298
	cmpl	$768, %eax
	jne	.L302
	cmpl	$27, 20(%rsp)
	jne	.L302
.L298:
	leaq	.LC22(%rip), %rdi
	call	puts@PLT
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L307:
	.cfi_restore_state
	xorl	%esi, %esi
	xorl	%edi, %edi
	call	tick_grid
	movl	$1, %esi
	xorl	%edi, %edi
	call	tick_grid
	xorl	%esi, %esi
	movl	$1, %edi
	call	tick_grid
	movl	$1, %esi
	movl	$1, %edi
	call	tick_grid
	movq	%r14, %rax
.L297:
	leaq	3456(%rax), %rdx
.L293:
	movl	$0, (%rax)
	addq	$24, %rax
	cmpq	%rdx, %rax
	jne	.L293
	cmpq	%rax, %rbx
	jne	.L297
	leaq	.LC23(%rip), %rdi
	call	logger
	xorl	%eax, %eax
	call	display
	leaq	.LC24(%rip), %rdi
	call	logger
	movq	time_handle(%rip), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	%rbp, %rax
	imulq	%r13, %rax
	rorq	%rax
	cmpq	%r12, %rax
	jbe	.L308
.L295:
	addq	$1, %rbp
	jmp	.L296
.L308:
	movq	%rbp, %rdi
	call	show_logs
	movq	%rbp, %rdi
	call	show_logs
	jmp	.L295
	.cfi_endproc
.LFE5405:
	.size	main, .-main
	.globl	screen
	.bss
	.align 32
	.type	screen, @object
	.size	screen, 124416
screen:
	.zero	124416
	.globl	texture
	.align 8
	.type	texture, @object
	.size	texture, 8
texture:
	.zero	8
	.globl	renderer
	.align 8
	.type	renderer, @object
	.size	renderer, 8
renderer:
	.zero	8
	.globl	window
	.align 8
	.type	window, @object
	.size	window, 8
window:
	.zero	8
	.globl	first_time
	.data
	.align 4
	.type	first_time, @object
	.size	first_time, 4
first_time:
	.long	1
	.globl	cur_tick_index
	.bss
	.align 4
	.type	cur_tick_index, @object
	.size	cur_tick_index, 4
cur_tick_index:
	.zero	4
	.globl	world
	.align 32
	.type	world, @object
	.size	world, 746496
world:
	.zero	746496
	.globl	random_base
	.data
	.align 8
	.type	random_base, @object
	.size	random_base, 8
random_base:
	.quad	16137
	.globl	density
	.align 16
	.type	density, @object
	.size	density, 16
density:
	.long	0
	.long	1065353216
	.long	1056964608
	.long	1028443341
	.globl	types
	.align 16
	.type	types, @object
	.size	types, 16
types:
	.long	0
	.long	2
	.long	3
	.long	1
	.globl	cur_log
	.align 4
	.type	cur_log, @object
	.size	cur_log, 4
cur_log:
	.long	-1
	.globl	t
	.bss
	.align 8
	.type	t, @object
	.size	t, 8
t:
	.zero	8
	.globl	logs
	.align 32
	.type	logs, @object
	.size	logs, 10240
logs:
	.zero	10240
	.globl	time_handle
	.align 8
	.type	time_handle, @object
	.size	time_handle, 8
time_handle:
	.zero	8
	.globl	time_spec
	.align 16
	.type	time_spec, @object
	.size	time_spec, 16
time_spec:
	.zero	16
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC0:
	.long	805306368
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	12582912
	.long	1104150528
	.align 8
.LC4:
	.long	0
	.long	1079574528
	.align 8
.LC7:
	.long	0
	.long	1104006501
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC9:
	.long	1058642330
	.long	1058642330
	.long	1058642330
	.long	1065353216
	.align 16
.LC10:
	.long	1065353216
	.long	1065353216
	.long	0
	.long	1065353216
	.align 16
.LC11:
	.long	0
	.long	0
	.long	1060320051
	.long	1056964608
	.align 16
.LC12:
	.long	1045220557
	.long	1045220557
	.long	1045220557
	.long	1056964608
	.section	.rodata.cst4
	.align 4
.LC13:
	.long	1056964608
	.section	.rodata.cst8
	.align 8
.LC17:
	.long	-1717986918
	.long	1069128089
	.section	.rodata.cst16
	.align 16
.LC19:
	.long	-858993459
	.long	1081081036
	.long	-858993459
	.long	1081081036
	.align 16
.LC20:
	.value	255
	.value	255
	.value	255
	.value	255
	.value	255
	.value	255
	.value	255
	.value	255
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
