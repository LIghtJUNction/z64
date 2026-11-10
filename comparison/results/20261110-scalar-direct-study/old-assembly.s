_RNvCseSqpdtHE20y_5bench3old:
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
	movq	%rsi, 56(%rsp)
	movq	%rdi, 16(%rsp)
	leaq	_RNvNtCseSqpdtHE20y_5bench9candidate11URL_INVERSE(%rip), %rax
	leaq	_RNvNtCseSqpdtHE20y_5bench9candidate16STANDARD_INVERSE(%rip), %rcx
	testl	%r9d, %r9d
	cmovneq	%rax, %rcx
	movq	%rcx, 48(%rsp)
	cmpq	$8, %rdx
	jb	.LBB8_1
	xorl	%r12d, %r12d
	movq	%rdx, %rdi
	xorl	%eax, %eax
	movq	%rdx, 32(%rsp)
	movq	%r8, 88(%rsp)
	.p2align	4
.LBB8_7:
	cmpq	%rdx, %r12
	jae	.LBB8_32
	leaq	1(%r12), %r10
	cmpq	%rdx, %r10
	jae	.LBB8_9
	leaq	2(%r12), %r10
	cmpq	%rdx, %r10
	jae	.LBB8_34
	leaq	3(%r12), %r10
	cmpq	%rdx, %r10
	jae	.LBB8_36
	leaq	4(%r12), %r10
	cmpq	%rdx, %r10
	jae	.LBB8_38
	leaq	5(%r12), %r10
	cmpq	%rdx, %r10
	jae	.LBB8_40
	leaq	6(%r12), %r10
	cmpq	%rdx, %r10
	jae	.LBB8_42
	movq	%rax, 96(%rsp)
	movq	%rdi, 24(%rsp)
	leaq	7(%r12), %r10
	cmpq	%rdx, %r10
	jae	.LBB8_67
	movq	56(%rsp), %r10
	movzbl	(%r10,%r12), %eax
	movq	48(%rsp), %r11
	movq	%rax, 8(%rsp)
	movzbl	(%r11,%rax), %edi
	movzbl	1(%r10,%r12), %eax
	movq	%rax, 80(%rsp)
	movzbl	(%r11,%rax), %esi
	movzbl	2(%r10,%r12), %eax
	movq	%rax, 72(%rsp)
	movzbl	(%r11,%rax), %edx
	movzbl	3(%r10,%r12), %eax
	movzbl	(%r11,%rax), %r15d
	movzbl	4(%r10,%r12), %ecx
	movzbl	(%r11,%rcx), %ebx
	movzbl	5(%r10,%r12), %r8d
	movzbl	(%r11,%r8), %r14d
	movzbl	6(%r10,%r12), %r9d
	movq	%rdx, 64(%rsp)
	shll	$16, %edx
	movq	%rsi, %rbp
	shll	$8, %esi
	movq	%rdi, %r13
	orq	%rdi, %rsi
	orq	%rdx, %rsi
	movl	%r15d, %edx
	shll	$24, %edx
	orq	%rdx, %rsi
	movq	%rbx, %rdx
	shlq	$32, %rdx
	orq	%rdx, %rsi
	movq	%r14, %rdx
	shlq	$40, %rdx
	orq	%rdx, %rsi
	movzbl	(%r11,%r9), %edi
	movq	%rdi, %rdx
	shlq	$48, %rdx
	orq	%rdx, %rsi
	movzbl	7(%r10,%r12), %edx
	movzbl	(%r11,%rdx), %r11d
	movq	%r11, %r10
	shlq	$56, %r10
	orq	%r10, %rsi
	bswapq	%rsi
	movabsq	$-9187201950435737472, %r10
	testq	%r10, %rsi
	jne	.LBB8_47
	movq	96(%rsp), %rdi
	leaq	6(%rdi), %r10
	movq	88(%rsp), %r8
	cmpq	%r8, %r10
	movq	24(%rsp), %r9
	ja	.LBB8_49
	movq	%rsi, %rcx
	movabsq	$17733194119839807, %rax
	andq	%rax, %rcx
	shrq	$2, %rsi
	movabsq	$1134924423669747648, %rax
	andq	%rax, %rsi
	orq	%rcx, %rsi
	movq	%rsi, %rcx
	movabsq	$17587891081215, %rax
	andq	%rax, %rcx
	shrq	$4, %rsi
	movabsq	$72040001868656640, %rax
	andq	%rax, %rsi
	orq	%rcx, %rsi
	movl	%esi, %ecx
	shrq	$8, %rsi
	andq	$-16777216, %rsi
	orq	%rcx, %rsi
	bswapq	%rsi
	movq	%rsi, %rcx
	shrq	$16, %rcx
	shrq	$48, %rsi
	movq	40(%rsp), %rax
	movw	%si, 4(%rax,%rdi)
	movl	%ecx, (%rax,%rdi)
	addq	$8, %r12
	addq	$-8, %r9
	movq	%r10, %rax
	cmpq	$7, %r9
	movq	32(%rsp), %rdx
	movq	%r9, %rdi
	ja	.LBB8_7
	cmpq	%rdx, %r12
	jne	.LBB8_3
	jmp	.LBB8_21
.LBB8_1:
	xorl	%r10d, %r10d
	xorl	%r12d, %r12d
	cmpq	%rdx, %r12
	je	.LBB8_21
.LBB8_3:
	jae	.LBB8_12
	leaq	1(%r12), %r9
	cmpq	%rdx, %r9
	jae	.LBB8_5
	leaq	2(%r12), %r11
	cmpq	%rdx, %r11
	jae	.LBB8_15
	leaq	3(%r12), %rbx
	cmpq	%rdx, %rbx
	jae	.LBB8_17
	movq	56(%rsp), %rax
	movzbl	(%rax,%r12), %ecx
	movq	48(%rsp), %rdx
	movzbl	(%rdx,%rcx), %ebp
	movzbl	(%rax,%r9), %esi
	movzbl	(%rdx,%rsi), %r14d
	movzbl	(%rax,%r11), %r9d
	movzbl	(%rdx,%r9), %edi
	movzbl	(%rax,%rbx), %r11d
	movzbl	(%rdx,%r11), %edx
	movl	%r14d, %ebx
	orb	%bpl, %bl
	orb	%dil, %bl
	orb	%dl, %bl
	js	.LBB8_22
	leaq	3(%r10), %rsi
	cmpq	%r8, %rsi
	ja	.LBB8_24
	shlb	$2, %bpl
	movl	%r14d, %eax
	shrb	$4, %al
	orb	%bpl, %al
	shlb	$4, %r14b
	movl	%edi, %ecx
	shrb	$2, %cl
	orb	%r14b, %cl
	shlb	$6, %dil
	orb	%dil, %dl
	movq	40(%rsp), %rsi
	movb	%al, (%rsi,%r10)
	movb	%cl, 1(%rsi,%r10)
	movb	%dl, 2(%rsi,%r10)
.LBB8_21:
	movq	16(%rsp), %rax
	movb	$-1, (%rax)
.LBB8_66:
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
.LBB8_47:
	.cfi_def_cfa_offset 160
	movq	%rbp, %r10
	movq	%r14, %rsi
	movq	64(%rsp), %r14
	movq	%r9, 24(%rsp)
	movq	%rcx, %r9
	movq	72(%rsp), %rbp
	movq	80(%rsp), %rcx
	cmpl	$255, %r13d
	je	.LBB8_48
	cmpl	$255, %r10d
	je	.LBB8_51
	cmpl	$255, %r14d
	je	.LBB8_53
	cmpl	$255, %r15d
	je	.LBB8_55
	cmpl	$255, %ebx
	je	.LBB8_57
	cmpl	$255, %esi
	je	.LBB8_60
	cmpb	$-1, %dil
	je	.LBB8_62
	cmpb	$-1, %r11b
	je	.LBB8_64
.LBB8_68:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.43(%rip), %rdi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.44(%rip), %rdx
	movl	$181, %esi
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking9panic_fmt@GOTPCREL(%rip)
.LBB8_49:
	leaq	6(%rdi), %rsi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.42(%rip), %rcx
	movq	%r8, %rdx
	callq	*_RNvNtNtCskADBYZwJmSU_4core5slice5index16slice_index_fail@GOTPCREL(%rip)
.LBB8_22:
	cmpb	$-1, %bpl
	je	.LBB8_23
	cmpb	$-1, %r14b
	je	.LBB8_26
	cmpb	$-1, %dil
	je	.LBB8_28
	cmpb	$-1, %dl
	jne	.LBB8_68
	movl	$3, %edx
	movl	%r11d, %ecx
	jmp	.LBB8_31
.LBB8_24:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.33(%rip), %rcx
	movq	%r10, %rdi
	movq	%r8, %rdx
	callq	*_RNvNtNtCskADBYZwJmSU_4core5slice5index16slice_index_fail@GOTPCREL(%rip)
.LBB8_67:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.41(%rip), %rdx
	movq	%r10, %rdi
	movq	32(%rsp), %rsi
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_42:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.40(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_40:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.39(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_38:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.38(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_36:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.37(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_34:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.36(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_9:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.35(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_32:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.34(%rip), %rcx
	movq	%r12, %rdi
	movq	%rdx, %rsi
	movq	%rcx, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_12:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.29(%rip), %rcx
	movq	%r12, %rdi
	movq	%rdx, %rsi
	movq	%rcx, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_5:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.30(%rip), %rax
	movq	%r9, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_15:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.31(%rip), %rax
	movq	%r11, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_17:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.32(%rip), %rax
	movq	%rbx, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB8_48:
	xorl	%esi, %esi
	jmp	.LBB8_65
.LBB8_51:
	movl	$1, %esi
	movq	%rcx, 8(%rsp)
	jmp	.LBB8_65
.LBB8_53:
	movl	$2, %esi
	movq	%rbp, 8(%rsp)
	jmp	.LBB8_65
.LBB8_55:
	movl	$3, %esi
	movq	%rax, 8(%rsp)
	jmp	.LBB8_65
.LBB8_57:
	movl	$4, %esi
	movq	%r9, 8(%rsp)
	jmp	.LBB8_65
.LBB8_60:
	movl	$5, %esi
	movq	%r8, 8(%rsp)
	jmp	.LBB8_65
.LBB8_62:
	movl	$6, %esi
	movq	24(%rsp), %r9
	movq	%r9, 8(%rsp)
	jmp	.LBB8_65
.LBB8_64:
	movl	$7, %esi
	movq	%rdx, 8(%rsp)
.LBB8_65:
	movq	8(%rsp), %rbx
	cmpb	$61, %bl
	sete	%dl
	addb	$3, %dl
	addq	160(%rsp), %rsi
	addq	%r12, %rsi
	movq	16(%rsp), %rax
	movb	%dl, (%rax)
	movb	%bl, 1(%rax)
	movq	%rsi, 8(%rax)
	jmp	.LBB8_66
.LBB8_23:
	xorl	%edx, %edx
	jmp	.LBB8_31
.LBB8_26:
	movl	$1, %edx
	movl	%esi, %ecx
	jmp	.LBB8_31
.LBB8_28:
	movl	$2, %edx
	movl	%r9d, %ecx
.LBB8_31:
	addq	160(%rsp), %r12
	cmpb	$61, %cl
	sete	%sil
	addb	$3, %sil
	addq	%rdx, %r12
	movq	16(%rsp), %rax
	movb	%sil, (%rax)
	movb	%cl, 1(%rax)
	movq	%r12, 8(%rax)
	jmp	.LBB8_66

