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
	movq	%r8, 32(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%rsi, 48(%rsp)
	movq	%rdi, (%rsp)
	leaq	_RNvNtCseSqpdtHE20y_5bench9candidate11URL_INVERSE(%rip), %rax
	leaq	_RNvNtCseSqpdtHE20y_5bench9candidate16STANDARD_INVERSE(%rip), %rcx
	testl	%r9d, %r9d
	cmovneq	%rax, %rcx
	movq	%rcx, 40(%rsp)
	cmpq	$8, %rdx
	jb	.LBB7_1
	xorl	%edi, %edi
	movq	%rdx, %rax
	xorl	%ecx, %ecx
	movq	%rdx, 16(%rsp)
	.p2align	4
.LBB7_7:
	cmpq	%rdx, %rdi
	jae	.LBB7_32
	leaq	1(%rdi), %r10
	cmpq	%rdx, %r10
	jae	.LBB7_9
	leaq	2(%rdi), %r10
	cmpq	%rdx, %r10
	jae	.LBB7_34
	leaq	3(%rdi), %r10
	cmpq	%rdx, %r10
	jae	.LBB7_36
	leaq	4(%rdi), %r10
	cmpq	%rdx, %r10
	jae	.LBB7_38
	leaq	5(%rdi), %r10
	cmpq	%rdx, %r10
	jae	.LBB7_40
	leaq	6(%rdi), %r10
	cmpq	%rdx, %r10
	jae	.LBB7_42
	movq	%rcx, 96(%rsp)
	movq	%rax, 8(%rsp)
	leaq	7(%rdi), %r10
	cmpq	%rdx, %r10
	jae	.LBB7_66
	movq	48(%rsp), %r10
	movzbl	(%r10,%rdi), %eax
	movq	40(%rsp), %rdx
	movq	%rax, 88(%rsp)
	movzbl	(%rdx,%rax), %r8d
	movzbl	1(%r10,%rdi), %eax
	movq	%rax, 80(%rsp)
	movzbl	(%rdx,%rax), %r15d
	movzbl	2(%r10,%rdi), %eax
	movq	%rax, 72(%rsp)
	movzbl	(%rdx,%rax), %ecx
	movzbl	3(%r10,%rdi), %eax
	movq	%rax, 64(%rsp)
	movzbl	(%rdx,%rax), %r14d
	movzbl	4(%r10,%rdi), %r9d
	movzbl	(%rdx,%r9), %eax
	movzbl	5(%r10,%rdi), %r11d
	movzbl	(%rdx,%r11), %r12d
	movzbl	6(%r10,%rdi), %esi
	movzbl	(%rdx,%rsi), %ebp
	movq	%rdi, 56(%rsp)
	movzbl	7(%r10,%rdi), %ebx
	movl	%r14d, %edi
	movl	%r15d, %r13d
	orb	%r8b, %r13b
	movl	%ecx, %r10d
	orb	%r14b, %r10b
	orb	%r13b, %r10b
	movl	%eax, %r14d
	orb	%r12b, %r14b
	orb	%bpl, %r14b
	orb	%r10b, %r14b
	movzbl	(%rdx,%rbx), %r13d
	orb	%r13b, %r14b
	js	.LBB7_47
	movq	96(%rsp), %r9
	leaq	6(%r9), %r14
	movq	32(%rsp), %rdx
	cmpq	%rdx, %r14
	movq	8(%rsp), %r10
	ja	.LBB7_49
	shlb	$2, %r8b
	movl	%r15d, %esi
	shrb	$4, %sil
	orb	%r8b, %sil
	shlb	$4, %r15b
	movl	%ecx, %r8d
	shrb	$2, %r8b
	orb	%r15b, %r8b
	shlb	$6, %cl
	orb	%cl, %dil
	shlb	$2, %al
	movl	%r12d, %ecx
	shrb	$4, %cl
	orb	%al, %cl
	shlb	$4, %r12b
	movl	%ebp, %edx
	shrb	$2, %dl
	orb	%r12b, %dl
	shlb	$6, %bpl
	orb	%bpl, %r13b
	movq	24(%rsp), %rax
	movb	%sil, (%rax,%r9)
	movb	%r8b, 1(%rax,%r9)
	movb	%dil, 2(%rax,%r9)
	movb	%cl, 3(%rax,%r9)
	movb	%dl, 4(%rax,%r9)
	movb	%r13b, 5(%rax,%r9)
	movq	56(%rsp), %rdi
	addq	$8, %rdi
	addq	$-8, %r10
	movq	%r14, %rcx
	cmpq	$7, %r10
	movq	16(%rsp), %rdx
	movq	%r10, %rax
	ja	.LBB7_7
	cmpq	%rdx, %rdi
	jne	.LBB7_3
	jmp	.LBB7_21
.LBB7_1:
	xorl	%r14d, %r14d
	xorl	%edi, %edi
	cmpq	%rdx, %rdi
	je	.LBB7_21
.LBB7_3:
	jae	.LBB7_12
	leaq	1(%rdi), %r9
	cmpq	%rdx, %r9
	jae	.LBB7_5
	leaq	2(%rdi), %r11
	cmpq	%rdx, %r11
	jae	.LBB7_15
	leaq	3(%rdi), %rbx
	cmpq	%rdx, %rbx
	jae	.LBB7_17
	movq	48(%rsp), %rax
	movzbl	(%rax,%rdi), %edx
	movq	40(%rsp), %rcx
	movzbl	(%rcx,%rdx), %r10d
	movzbl	(%rax,%r9), %esi
	movzbl	(%rcx,%rsi), %r9d
	movzbl	(%rax,%r11), %r11d
	movzbl	(%rcx,%r11), %r8d
	movzbl	(%rax,%rbx), %ebx
	movzbl	(%rcx,%rbx), %ecx
	movl	%r9d, %ebp
	orb	%r10b, %bpl
	orb	%r8b, %bpl
	orb	%cl, %bpl
	js	.LBB7_22
	leaq	3(%r14), %rsi
	movq	32(%rsp), %rdx
	cmpq	%rdx, %rsi
	ja	.LBB7_24
	shlb	$2, %r10b
	movl	%r9d, %eax
	shrb	$4, %al
	orb	%r10b, %al
	shlb	$4, %r9b
	movl	%r8d, %edx
	shrb	$2, %dl
	orb	%r9b, %dl
	shlb	$6, %r8b
	orb	%r8b, %cl
	movq	24(%rsp), %rsi
	movb	%al, (%rsi,%r14)
	movb	%dl, 1(%rsi,%r14)
	movb	%cl, 2(%rsi,%r14)
.LBB7_21:
	movq	(%rsp), %rax
	movb	$-1, (%rax)
.LBB7_65:
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
.LBB7_47:
	.cfi_def_cfa_offset 160
	movq	%rbx, 8(%rsp)
	movq	%rsi, %r14
	movl	%edi, %r10d
	movq	%r9, %rdi
	movq	64(%rsp), %rbx
	movq	72(%rsp), %r9
	movq	80(%rsp), %rdx
	movq	88(%rsp), %rsi
	cmpb	$-1, %r8b
	je	.LBB7_48
	cmpb	$-1, %r15b
	je	.LBB7_51
	cmpb	$-1, %cl
	je	.LBB7_53
	cmpb	$-1, %r10b
	je	.LBB7_55
	cmpb	$-1, %al
	je	.LBB7_57
	cmpb	$-1, %r12b
	je	.LBB7_59
	cmpb	$-1, %bpl
	je	.LBB7_61
	cmpb	$-1, %r13b
	je	.LBB7_63
.LBB7_67:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.43(%rip), %rdi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.60(%rip), %rdx
	movl	$181, %esi
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking9panic_fmt@GOTPCREL(%rip)
.LBB7_49:
	leaq	6(%r9), %rsi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.59(%rip), %rcx
	movq	%r9, %rdi
	callq	*_RNvNtNtCskADBYZwJmSU_4core5slice5index16slice_index_fail@GOTPCREL(%rip)
.LBB7_22:
	cmpb	$-1, %r10b
	je	.LBB7_23
	cmpb	$-1, %r9b
	je	.LBB7_26
	cmpb	$-1, %r8b
	je	.LBB7_28
	cmpb	$-1, %cl
	jne	.LBB7_67
	movl	$3, %ecx
	movl	%ebx, %edx
	jmp	.LBB7_31
.LBB7_24:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.50(%rip), %rcx
	movq	%r14, %rdi
	callq	*_RNvNtNtCskADBYZwJmSU_4core5slice5index16slice_index_fail@GOTPCREL(%rip)
.LBB7_66:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.58(%rip), %rdx
	movq	%r10, %rdi
	movq	16(%rsp), %rsi
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_42:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.57(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_40:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.56(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_38:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.55(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_36:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.54(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_34:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.53(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_9:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.52(%rip), %rax
	movq	%r10, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_32:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.51(%rip), %rcx
	movq	%rdx, %rsi
	movq	%rcx, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_12:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.46(%rip), %rcx
	movq	%rdx, %rsi
	movq	%rcx, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_5:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.47(%rip), %rax
	movq	%r9, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_15:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.48(%rip), %rax
	movq	%r11, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_17:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.49(%rip), %rax
	movq	%rbx, %rdi
	movq	%rdx, %rsi
	movq	%rax, %rdx
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.LBB7_48:
	xorl	%r8d, %r8d
	jmp	.LBB7_64
.LBB7_51:
	movl	$1, %r8d
	movl	%edx, %esi
	jmp	.LBB7_64
.LBB7_53:
	movl	$2, %r8d
	movl	%r9d, %esi
	jmp	.LBB7_64
.LBB7_55:
	movl	$3, %r8d
	movl	%ebx, %esi
	jmp	.LBB7_64
.LBB7_57:
	movl	$4, %r8d
	movl	%edi, %esi
	jmp	.LBB7_64
.LBB7_59:
	movl	$5, %r8d
	movl	%r11d, %esi
	jmp	.LBB7_64
.LBB7_61:
	movl	$6, %r8d
	movl	%r14d, %esi
	jmp	.LBB7_64
.LBB7_63:
	movl	$7, %r8d
	movq	8(%rsp), %rsi
.LBB7_64:
	cmpb	$61, %sil
	sete	%cl
	addb	$3, %cl
	addq	160(%rsp), %r8
	addq	56(%rsp), %r8
	movq	(%rsp), %rax
	movb	%cl, (%rax)
	movb	%sil, 1(%rax)
	movq	%r8, 8(%rax)
	jmp	.LBB7_65
.LBB7_23:
	xorl	%ecx, %ecx
	jmp	.LBB7_31
.LBB7_26:
	movl	$1, %ecx
	movl	%esi, %edx
	jmp	.LBB7_31
.LBB7_28:
	movl	$2, %ecx
	movl	%r11d, %edx
.LBB7_31:
	addq	160(%rsp), %rdi
	cmpb	$61, %dl
	sete	%sil
	addb	$3, %sil
	addq	%rcx, %rdi
	movq	(%rsp), %rax
	movb	%sil, (%rax)
	movb	%dl, 1(%rax)
	movq	%rdi, 8(%rax)
	jmp	.LBB7_65

