_RNvCseSqpdtHE20y_5bench3new:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rcx, 40(%rsp)
	movq	%rsi, %r11
	movq	%rdi, %r14
	movq	160(%rsp), %r15
	leaq	_RNvNtCseSqpdtHE20y_5bench9candidate11URL_INVERSE(%rip), %rax
	leaq	_RNvNtCseSqpdtHE20y_5bench9candidate16STANDARD_INVERSE(%rip), %rcx
	testl	%r9d, %r9d
	cmovneq	%rax, %rcx
	movq	%rcx, 48(%rsp)
	cmpq	$8, %rdx
	jb	.LBB7_1
	movq	%r14, 32(%rsp)
	movabsq	$9223372036854775800, %rax
	andq	%rdx, %rax
	movq	%rax, 64(%rsp)
	negq	%r15
	xorl	%eax, %eax
	movq	%r8, 88(%rsp)
	.p2align	4
.LBB7_6:
	movq	%rax, 16(%rsp)
	movq	%rdx, 96(%rsp)
	movq	%r15, 56(%rsp)
	movq	%r11, %rsi
	movzbl	(%r11), %ecx
	movq	48(%rsp), %rax
	movq	%rcx, 8(%rsp)
	movzbl	(%rax,%rcx), %edi
	movzbl	1(%r11), %ecx
	movq	%rcx, 80(%rsp)
	movzbl	(%rax,%rcx), %r9d
	movzbl	2(%r11), %ecx
	movq	%rcx, 72(%rsp)
	movzbl	(%rax,%rcx), %ecx
	movzbl	3(%r11), %ebp
	movzbl	(%rax,%rbp), %r10d
	movzbl	4(%r11), %r12d
	movzbl	(%rax,%r12), %r15d
	movzbl	5(%r11), %ebx
	movzbl	(%rax,%rbx), %r13d
	movl	%ecx, 28(%rsp)
	movl	%ecx, %edx
	shll	$16, %edx
	movl	%r9d, %r8d
	shll	$8, %r9d
	movq	%rdi, %rcx
	orq	%rdi, %r9
	orq	%rdx, %r9
	movl	%r10d, %edx
	shll	$24, %edx
	orq	%rdx, %r9
	movq	%r15, %rdx
	shlq	$32, %rdx
	orq	%rdx, %r9
	movq	%r13, %rdx
	shlq	$40, %rdx
	orq	%rdx, %r9
	movzbl	6(%r11), %edx
	movzbl	(%rax,%rdx), %r14d
	movq	%r14, %rdi
	shlq	$48, %rdi
	orq	%rdi, %r9
	movzbl	7(%r11), %r11d
	movzbl	(%rax,%r11), %eax
	movq	%rax, %rdi
	shlq	$56, %rdi
	orq	%rdi, %r9
	bswapq	%r9
	movabsq	$-9187201950435737472, %rdi
	testq	%rdi, %r9
	jne	.LBB7_26
	movq	16(%rsp), %r10
	leaq	6(%r10), %rdi
	movq	88(%rsp), %r8
	cmpq	%r8, %rdi
	ja	.LBB7_48
	movq	96(%rsp), %rdx
	addq	$-8, %rdx
	movq	%r9, %rax
	movabsq	$17733194119839807, %rcx
	andq	%rcx, %rax
	shrq	$2, %r9
	movabsq	$1134924423669747648, %rcx
	andq	%rcx, %r9
	orq	%rax, %r9
	movq	%r9, %rax
	movabsq	$17587891081215, %rcx
	andq	%rcx, %rax
	shrq	$4, %r9
	movabsq	$72040001868656640, %rcx
	andq	%rcx, %r9
	orq	%rax, %r9
	movl	%r9d, %eax
	shrq	$8, %r9
	andq	$-16777216, %r9
	orq	%rax, %r9
	bswapq	%r9
	movq	%r9, %rax
	shrq	$16, %rax
	shrq	$48, %r9
	movq	40(%rsp), %rcx
	movw	%r9w, 4(%rcx,%r10)
	movl	%eax, (%rcx,%r10)
	movq	56(%rsp), %r15
	addq	$-8, %r15
	leaq	8(%rsi), %r11
	movq	%rdi, %rax
	cmpq	$7, %rdx
	ja	.LBB7_6
	addq	$8, %rsi
	movq	%rsi, %r11
	movq	32(%rsp), %r14
	movq	160(%rsp), %r15
	movq	64(%rsp), %r12
	testq	%rdx, %rdx
	jne	.LBB7_3
	jmp	.LBB7_15
.LBB7_1:
	xorl	%edi, %edi
	xorl	%r12d, %r12d
	testq	%rdx, %rdx
	je	.LBB7_15
.LBB7_3:
	cmpq	$1, %rdx
	je	.LBB7_4
	cmpq	$2, %rdx
	jbe	.LBB7_45
	cmpq	$3, %rdx
	je	.LBB7_46
	movzbl	(%r11), %eax
	movq	48(%rsp), %rcx
	movzbl	(%rcx,%rax), %r9d
	movzbl	1(%r11), %esi
	movzbl	(%rcx,%rsi), %ebp
	movzbl	2(%r11), %r10d
	movzbl	(%rcx,%r10), %edx
	movzbl	3(%r11), %r11d
	movzbl	(%rcx,%r11), %ecx
	movl	%ebp, %ebx
	orb	%r9b, %bl
	orb	%dl, %bl
	orb	%cl, %bl
	js	.LBB7_16
	leaq	3(%rdi), %rsi
	cmpq	%r8, %rsi
	ja	.LBB7_25
	shlb	$2, %r9b
	movl	%ebp, %eax
	shrb	$4, %al
	orb	%r9b, %al
	shlb	$4, %bpl
	movl	%edx, %esi
	shrb	$2, %sil
	orb	%bpl, %sil
	shlb	$6, %dl
	orb	%dl, %cl
	movq	40(%rsp), %rdx
	movb	%al, (%rdx,%rdi)
	movb	%sil, 1(%rdx,%rdi)
	movb	%cl, 2(%rdx,%rdi)
.LBB7_15:
	movb	$-1, (%r14)
.LBB7_44:
	movq	%r14, %rax
	addq	$104, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB7_26:
	.cfi_def_cfa_offset 160
	movl	28(%rsp), %esi
	movl	%r8d, %r9d
	movl	%r10d, %edi
	movq	80(%rsp), %r8
	movq	72(%rsp), %r10
	movq	%rbp, 16(%rsp)
	cmpb	$-1, %cl
	je	.LBB7_27
	cmpb	$-1, %r9b
	je	.LBB7_29
	cmpb	$-1, %sil
	je	.LBB7_31
	cmpb	$-1, %dil
	je	.LBB7_34
	cmpb	$-1, %r15b
	je	.LBB7_36
	cmpb	$-1, %r13b
	je	.LBB7_38
	cmpb	$-1, %r14b
	je	.LBB7_40
	cmpb	$-1, %al
	je	.LBB7_42
.LBB7_47:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.43(%rip), %rdi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.51(%rip), %rdx
	movl	$181, %esi
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking9panic_fmt@GOTPCREL(%rip)
.LBB7_48:
	leaq	6(%r10), %rsi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.50(%rip), %rcx
	movq	%r10, %rdi
	movq	%r8, %rdx
	callq	*_RNvNtNtCskADBYZwJmSU_4core5slice5index16slice_index_fail@GOTPCREL(%rip)
.LBB7_16:
	cmpb	$-1, %r9b
	je	.LBB7_17
	cmpb	$-1, %bpl
	je	.LBB7_19
	cmpb	$-1, %dl
	je	.LBB7_21
	cmpb	$-1, %cl
	jne	.LBB7_47
	movl	$3, %ecx
	movl	%r11d, %eax
	jmp	.LBB7_24
.LBB7_25:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.49(%rip), %rcx
	movq	%r8, %rdx
	callq	*_RNvNtNtCskADBYZwJmSU_4core5slice5index16slice_index_fail@GOTPCREL(%rip)
.LBB7_4:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.46(%rip), %rdx
	movl	$1, %edi
	movl	$1, %esi
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_45:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.47(%rip), %rdx
	movl	$2, %edi
	movl	$2, %esi
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_46:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.48(%rip), %rdx
	movl	$3, %edi
	movl	$3, %esi
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_27:
	xorl	%eax, %eax
	jmp	.LBB7_43
.LBB7_29:
	movl	$1, %eax
	movq	%r8, 8(%rsp)
	jmp	.LBB7_43
.LBB7_31:
	movl	$2, %eax
	movq	%r10, 8(%rsp)
	jmp	.LBB7_43
.LBB7_34:
	movl	$3, %eax
	movq	16(%rsp), %r10
	movq	%r10, 8(%rsp)
	jmp	.LBB7_43
.LBB7_36:
	movl	$4, %eax
	movq	%r12, 8(%rsp)
	jmp	.LBB7_43
.LBB7_38:
	movl	$5, %eax
	movq	%rbx, 8(%rsp)
	jmp	.LBB7_43
.LBB7_40:
	movl	$6, %eax
	movq	%rdx, 8(%rsp)
	jmp	.LBB7_43
.LBB7_42:
	movl	$7, %eax
	movq	%r11, 8(%rsp)
.LBB7_43:
	movq	8(%rsp), %r15
	cmpb	$61, %r15b
	sete	%cl
	addb	$3, %cl
	subq	56(%rsp), %rax
	movq	32(%rsp), %r14
	movb	%cl, (%r14)
	movb	%r15b, 1(%r14)
	movq	%rax, 8(%r14)
	jmp	.LBB7_44
.LBB7_17:
	xorl	%ecx, %ecx
	jmp	.LBB7_24
.LBB7_19:
	movl	$1, %ecx
	movl	%esi, %eax
	jmp	.LBB7_24
.LBB7_21:
	movl	$2, %ecx
	movl	%r10d, %eax
.LBB7_24:
	addq	%r15, %r12
	cmpb	$61, %al
	sete	%dl
	addb	$3, %dl
	addq	%rcx, %r12
	movb	%dl, (%r14)
	movb	%al, 1(%r14)
	movq	%r12, 8(%r14)
	jmp	.LBB7_44

