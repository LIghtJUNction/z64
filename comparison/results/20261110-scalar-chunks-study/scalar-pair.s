	.att_syntax
	.file	"bench.ad4a9774b70cdcbc-cgu.0"
	.section	.text._RINvNtCs8ZKwes1zzDd_3std2rt10lang_startuECseSqpdtHE20y_5bench,"ax",@progbits
	.hidden	_RINvNtCs8ZKwes1zzDd_3std2rt10lang_startuECseSqpdtHE20y_5bench
	.globl	_RINvNtCs8ZKwes1zzDd_3std2rt10lang_startuECseSqpdtHE20y_5bench
	.prefalign	4, .Lfunc_end0, nop
	.type	_RINvNtCs8ZKwes1zzDd_3std2rt10lang_startuECseSqpdtHE20y_5bench,@function
_RINvNtCs8ZKwes1zzDd_3std2rt10lang_startuECseSqpdtHE20y_5bench:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	%ecx, %r8d
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rdi, (%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.1(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_RNvNtCs8ZKwes1zzDd_3std2rt19lang_start_internal@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	_RINvNtCs8ZKwes1zzDd_3std2rt10lang_startuECseSqpdtHE20y_5bench, .Lfunc_end0-_RINvNtCs8ZKwes1zzDd_3std2rt10lang_startuECseSqpdtHE20y_5bench
	.cfi_endproc

	.section	.text._RINvNtCskADBYZwJmSU_4core3ptr9drop_glueNtNtCs8ZKwes1zzDd_3std3env4ArgsECseSqpdtHE20y_5bench,"ax",@progbits
	.prefalign	4, .Lfunc_end1, nop
	.type	_RINvNtCskADBYZwJmSU_4core3ptr9drop_glueNtNtCs8ZKwes1zzDd_3std3env4ArgsECseSqpdtHE20y_5bench,@function
_RINvNtCskADBYZwJmSU_4core3ptr9drop_glueNtNtCs8ZKwes1zzDd_3std3env4ArgsECseSqpdtHE20y_5bench:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, %rbx
	movq	8(%rdi), %r15
	movq	24(%rdi), %rcx
	movq	%rcx, %rax
	subq	%r15, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r15, %rcx
	je	.LBB1_5
	movq	%rdx, %r14
	shrq	$4, %r14
	addq	$8, %r15
	movq	_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB1_2
	.p2align	4
.LBB1_4:
	addq	$24, %r15
	decq	%r14
	je	.LBB1_5
.LBB1_2:
	movq	-8(%r15), %rsi
	testq	%rsi, %rsi
	je	.LBB1_4
	movq	(%r15), %rdi
	movl	$1, %edx
	callq	*%r12
	jmp	.LBB1_4
.LBB1_5:
	movq	16(%rbx), %rax
	testq	%rax, %rax
	je	.LBB1_6
	movq	(%rbx), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmpq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB1_6:
	.cfi_def_cfa_offset 48
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	_RINvNtCskADBYZwJmSU_4core3ptr9drop_glueNtNtCs8ZKwes1zzDd_3std3env4ArgsECseSqpdtHE20y_5bench, .Lfunc_end1-_RINvNtCskADBYZwJmSU_4core3ptr9drop_glueNtNtCs8ZKwes1zzDd_3std3env4ArgsECseSqpdtHE20y_5bench
	.cfi_endproc

	.section	.text.unlikely._RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtB4_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorEBM_EB1b_,"ax",@progbits
	.type	_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtB4_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorEBM_EB1b_,@function
_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtB4_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorEBM_EB1b_:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	leaq	24(%rsp), %rax
	movq	%rdi, (%rax)
	leaq	32(%rsp), %rcx
	movq	%rsi, (%rcx)
	movq	%rdx, 8(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.2(%rip), %rdx
	xorl	%edi, %edi
	movq	%rax, %rsi
	movq	%rdx, %r8
	xorl	%r9d, %r9d
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking19assert_failed_inner@GOTPCREL(%rip)
.Lfunc_end2:
	.size	_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtB4_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorEBM_EB1b_, .Lfunc_end2-_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtB4_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorEBM_EB1b_
	.cfi_endproc

	.section	.text.unlikely._RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtCsgFX3jaOk65H_5alloc3vec3VechEBM_ECseSqpdtHE20y_5bench,"ax",@progbits
	.type	_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtCsgFX3jaOk65H_5alloc3vec3VechEBM_ECseSqpdtHE20y_5bench,@function
_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtCsgFX3jaOk65H_5alloc3vec3VechEBM_ECseSqpdtHE20y_5bench:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%r8, %rax
	movq	%rcx, %r10
	movq	%rdx, %r9
	leaq	8(%rsp), %rdx
	movq	%rdi, (%rdx)
	leaq	16(%rsp), %rcx
	movq	%rsi, (%rcx)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.3(%rip), %r8
	xorl	%edi, %edi
	movq	%rdx, %rsi
	movq	%r8, %rdx
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking19assert_failed_inner@GOTPCREL(%rip)
.Lfunc_end3:
	.size	_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtCsgFX3jaOk65H_5alloc3vec3VechEBM_ECseSqpdtHE20y_5bench, .Lfunc_end3-_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtCsgFX3jaOk65H_5alloc3vec3VechEBM_ECseSqpdtHE20y_5bench
	.cfi_endproc

	.section	.text._RINvNtNtCs8ZKwes1zzDd_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECseSqpdtHE20y_5bench,"ax",@progbits
	.prefalign	4, .Lfunc_end4, nop
	.type	_RINvNtNtCs8ZKwes1zzDd_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECseSqpdtHE20y_5bench,@function
_RINvNtNtCs8ZKwes1zzDd_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECseSqpdtHE20y_5bench:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	*%rdi
	#APP
	#NO_APP
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	_RINvNtNtCs8ZKwes1zzDd_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECseSqpdtHE20y_5bench, .Lfunc_end4-_RINvNtNtCs8ZKwes1zzDd_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECseSqpdtHE20y_5bench
	.cfi_endproc

	.section	.text._RNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0CseSqpdtHE20y_5bench,"ax",@progbits
	.prefalign	4, .Lfunc_end5, nop
	.type	_RNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0CseSqpdtHE20y_5bench,@function
_RNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0CseSqpdtHE20y_5bench:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs8ZKwes1zzDd_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECseSqpdtHE20y_5bench
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	_RNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0CseSqpdtHE20y_5bench, .Lfunc_end5-_RNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0CseSqpdtHE20y_5bench
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0INtNtNtCskADBYZwJmSU_4core3ops8function6FnOnceuE9call_once6vtableCseSqpdtHE20y_5bench,"ax",@progbits
	.prefalign	4, .Lfunc_end6, nop
	.type	_RNSNvYNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0INtNtNtCskADBYZwJmSU_4core3ops8function6FnOnceuE9call_once6vtableCseSqpdtHE20y_5bench,@function
_RNSNvYNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0INtNtNtCskADBYZwJmSU_4core3ops8function6FnOnceuE9call_once6vtableCseSqpdtHE20y_5bench:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs8ZKwes1zzDd_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECseSqpdtHE20y_5bench
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	_RNSNvYNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0INtNtNtCskADBYZwJmSU_4core3ops8function6FnOnceuE9call_once6vtableCseSqpdtHE20y_5bench, .Lfunc_end6-_RNSNvYNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0INtNtNtCskADBYZwJmSU_4core3ops8function6FnOnceuE9call_once6vtableCseSqpdtHE20y_5bench
	.cfi_endproc

	.section	.text._RNvCseSqpdtHE20y_5bench3new,"ax",@progbits
	.prefalign	4, .Lfunc_end7, nop
	.type	_RNvCseSqpdtHE20y_5bench3new,@function
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
.Lfunc_end7:
	.size	_RNvCseSqpdtHE20y_5bench3new, .Lfunc_end7-_RNvCseSqpdtHE20y_5bench3new
	.cfi_endproc

	.section	.text._RNvCseSqpdtHE20y_5bench3old,"ax",@progbits
	.prefalign	4, .Lfunc_end8, nop
	.type	_RNvCseSqpdtHE20y_5bench3old,@function
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
.Lfunc_end8:
	.size	_RNvCseSqpdtHE20y_5bench3old, .Lfunc_end8-_RNvCseSqpdtHE20y_5bench3old
	.cfi_endproc

	.section	.text._RNvCseSqpdtHE20y_5bench4main,"ax",@progbits
	.hidden	_RNvCseSqpdtHE20y_5bench4main
	.globl	_RNvCseSqpdtHE20y_5bench4main
	.prefalign	4, .Lfunc_end9, nop
	.type	_RNvCseSqpdtHE20y_5bench4main,@function
_RNvCseSqpdtHE20y_5bench4main:
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, DW.ref.rust_eh_personality
	.cfi_lsda 27, .Lexception0
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
	subq	$568, %rsp
	.cfi_def_cfa_offset 624
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	$0, 328(%rsp)
	movq	$2, 336(%rsp)
	movw	$256, 344(%rsp)
	movq	$0, 352(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.16(%rip), %rcx
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.15(%rip), %rdx
	movq	memset@GOTPCREL(%rip), %r15
	movq	_RNvCs5fGHjzWXRav_7___rustc12___rust_alloc@GOTPCREL(%rip), %rbp
	xorl	%eax, %eax
.LBB9_1:
	movq	%r15, %r13
	movzbl	344(%rsp,%rax), %eax
	testb	%al, %al
	cmovneq	%rcx, %rdx
	movq	%rdx, 360(%rsp)
	movb	%al, 144(%rsp)
	movzbl	%al, %eax
	movl	%eax, 72(%rsp)
	xorl	%ebx, %ebx
	xorl	%r15d, %r15d
	jmp	.LBB9_2
	.p2align	4
.LBB9_93:
	movl	$3, %ebx
	cmpq	$128, %r14
	movq	544(%rsp), %r15
	je	.LBB9_3
.LBB9_2:
	leaq	(%r15,%rbx), %r14
	cmpq	$129, %r14
	jae	.LBB9_3
	testq	%r14, %r14
	je	.LBB9_19
	callq	*_RNvCs5fGHjzWXRav_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$1, %esi
	movq	%r14, %rdi
	callq	*%rbp
	testq	%rax, %rax
	je	.LBB9_23
	leaq	-1(%r15), %rcx
	addq	%rbx, %rcx
	movq	360(%rsp), %rdi
	movq	%rax, 64(%rsp)
	jne	.LBB9_24
	movabsq	$7640891576956012809, %rdx
	xorl	%r8d, %r8d
	jmp	.LBB9_27
	.p2align	4
.LBB9_19:
	movl	$1, %eax
	movq	%rax, 64(%rsp)
	jmp	.LBB9_28
	.p2align	4
.LBB9_24:
	movl	%r14d, %ecx
	andl	$254, %ecx
	movabsq	$7640891576956012809, %rdx
	xorl	%r8d, %r8d
	.p2align	4
.LBB9_25:
	movq	%rdx, %rsi
	shlq	$13, %rsi
	xorq	%rdx, %rsi
	movq	%rsi, %rdx
	shrq	$7, %rdx
	xorq	%rsi, %rdx
	movq	%rdx, %rsi
	shlq	$17, %rsi
	xorq	%rdx, %rsi
	andl	$63, %edx
	movzbl	(%rdi,%rdx), %edx
	movb	%dl, (%rax,%r8)
	movq	%rsi, %rdx
	shlq	$13, %rdx
	xorq	%rsi, %rdx
	movq	%rdx, %rsi
	shrq	$7, %rsi
	xorq	%rdx, %rsi
	movq	%rsi, %rdx
	shlq	$17, %rdx
	xorq	%rsi, %rdx
	andl	$63, %esi
	movzbl	(%rdi,%rsi), %esi
	movb	%sil, 1(%rax,%r8)
	addq	$2, %r8
	cmpq	%r8, %rcx
	jne	.LBB9_25
	testb	$1, %r14b
	je	.LBB9_28
.LBB9_27:
	movl	%edx, %ecx
	shrl	$7, %ecx
	xorl	%edx, %ecx
	andl	$63, %ecx
	movzbl	(%rdi,%rcx), %ecx
	movb	%cl, (%rax,%r8)
.LBB9_28:
	addq	%rbx, %r15
	incq	%r15
	movq	%r15, 544(%rsp)
	movq	%r14, %rax
	shrq	$2, %rax
	leaq	(%rax,%rax,2), %rax
	movq	%rax, 32(%rsp)
	xorl	%r15d, %r15d
	movq	%r14, 24(%rsp)
	jmp	.LBB9_29
	.p2align	4
.LBB9_148:
	incq	%r15
	cmpq	$32, %r15
	movq	_RNvCs5fGHjzWXRav_7___rustc12___rust_alloc@GOTPCREL(%rip), %rbp
	movq	memset@GOTPCREL(%rip), %r13
	movq	24(%rsp), %r14
	je	.LBB9_91
.LBB9_29:
	movq	%r15, %r12
	addq	%r14, %r12
	je	.LBB9_30
	movq	_RNvCs5fGHjzWXRav_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip), %rbx
	callq	*%rbx
	movl	$1, %esi
	movq	%r12, %rdi
	callq	*%rbp
	testq	%rax, %rax
	jne	.LBB9_31
	jmp	.LBB9_95
	.p2align	4
.LBB9_30:
	movl	$1, %eax
	movq	_RNvCs5fGHjzWXRav_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip), %rbx
.LBB9_31:
	movq	%rax, %rdi
	movl	$165, %esi
	movq	%r12, 40(%rsp)
	movq	%rax, %r14
	movq	%r12, %rdx
	callq	*%r13
	movq	%r14, 128(%rsp)
	leaq	(%r14,%r15), %rdi
	movq	%rdi, 16(%rsp)
	movq	64(%rsp), %rsi
	movq	24(%rsp), %rdx
	callq	*memcpy@GOTPCREL(%rip)
	movq	32(%rsp), %rax
	leaq	(%r15,%rax), %r12
	addq	$17, %r12
	callq	*%rbx
	movl	$1, %esi
	movq	%r12, %rdi
	callq	*%rbp
	testq	%rax, %rax
	je	.LBB9_32
	movq	%rax, %r14
	movq	%r12, 448(%rsp)
	movq	%rax, 456(%rsp)
	movq	%rax, %rdi
	movl	$165, %esi
	movq	%r12, %rdx
	callq	*%r13
	movq	%r12, 464(%rsp)
	callq	*%rbx
	movl	$1, %esi
	movq	%r12, %rdi
	callq	*%rbp
	testq	%rax, %rax
	je	.LBB9_104
	movq	%rax, %rbx
	movq	%r12, 160(%rsp)
	movq	%rax, 168(%rsp)
	movq	%rax, %rdi
	movq	%r14, %rsi
	movq	%r12, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	movq	%r12, 48(%rsp)
	movq	%r12, 176(%rsp)
	movq	%r14, 56(%rsp)
	movq	%r14, %rcx
	addq	%r15, %rcx
.Ltmp3:
	movq	$19, (%rsp)
	leaq	80(%rsp), %rdi
	movq	16(%rsp), %r12
	movq	%r12, %rsi
	movq	24(%rsp), %r14
	movq	%r14, %rdx
	movq	32(%rsp), %r13
	movq	%r13, %r8
	movl	72(%rsp), %ebp
	movl	%ebp, %r9d
	callq	_RNvCseSqpdtHE20y_5bench3old
.Ltmp4:
	movq	%rbx, %rcx
	addq	%r15, %rcx
.Ltmp5:
	movq	$19, (%rsp)
	leaq	368(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r14, %rdx
	movq	%r13, %r8
	movl	%ebp, %r9d
	callq	_RNvCseSqpdtHE20y_5bench3new
.Ltmp6:
	movzbl	80(%rsp), %eax
	cmpl	$255, %eax
	setne	%dl
	movzbl	368(%rsp), %ecx
	cmpb	$-1, %cl
	sete	%sil
	cmpb	%sil, %dl
	je	.LBB9_120
	cmpl	$255, %eax
	je	.LBB9_122
	cmpb	%cl, %al
	jne	.LBB9_120
	movl	%eax, %eax
	leaq	.LJTI9_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB9_119:
	movq	88(%rsp), %rax
	cmpq	376(%rsp), %rax
	jne	.LBB9_120
.LBB9_122:
	movq	56(%rsp), %rbp
	movq	%rbp, %rdi
	movq	%rbx, %rsi
	movq	48(%rsp), %r12
	movq	%r12, %rdx
	callq	*bcmp@GOTPCREL(%rip)
	testl	%eax, %eax
	movq	40(%rsp), %r14
	jne	.LBB9_123
	testq	%r15, %r15
	movq	32(%rsp), %rcx
	je	.LBB9_128
	xorl	%eax, %eax
	.p2align	4
.LBB9_126:
	cmpb	$-91, (%rbx,%rax)
	jne	.LBB9_145
	incq	%rax
	cmpq	%rax, %r15
	jne	.LBB9_126
.LBB9_128:
	leaq	(%r15,%rcx), %rax
	cmpb	$-91, (%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 1(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 2(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 3(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 4(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 5(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 6(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 7(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 8(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 9(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 10(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 11(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 12(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 13(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 14(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 15(%rbx,%rax)
	jne	.LBB9_145
	cmpb	$-91, 16(%rbx,%rax)
	jne	.LBB9_145
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	%r12, %rsi
	movq	_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip), %rbx
	callq	*%rbx
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	%r12, %rsi
	callq	*%rbx
	testq	%r14, %r14
	je	.LBB9_148
	movl	$1, %edx
	movq	128(%rsp), %rdi
	movq	%r14, %rsi
	callq	*%rbx
	jmp	.LBB9_148
.LBB9_118:
	movzbl	81(%rsp), %eax
	cmpb	369(%rsp), %al
	je	.LBB9_119
	jmp	.LBB9_120
	.p2align	4
.LBB9_91:
	testq	%r14, %r14
	je	.LBB9_93
	movl	$1, %edx
	movq	64(%rsp), %rdi
	movq	%r14, %rsi
	callq	*%rbx
	jmp	.LBB9_93
	.p2align	4
.LBB9_3:
	xorl	%ebx, %ebx
	movq	_RNvCs5fGHjzWXRav_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip), %rcx
	movq	%r13, %r15
.LBB9_4:
	movq	%rbx, %rax
	shrq	$2, %rax
	andq	$-2, %rax
	leaq	(%rax,%rax,2), %rax
	movq	%rax, 56(%rsp)
	leaq	1(%rbx), %rax
	movq	%rax, 64(%rsp)
	movq	%rbx, 112(%rsp)
	xorl	%r14d, %r14d
	movq	%rbx, 128(%rsp)
	jmp	.LBB9_5
	.p2align	4
.LBB9_66:
	movl	$64, %esi
	movl	$1, %edx
	movq	40(%rsp), %rdi
	callq	*%rbx
	movl	48(%rsp), %r14d
	incb	%r14b
	movq	_RNvCs5fGHjzWXRav_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip), %rcx
	movq	128(%rsp), %rbx
	je	.LBB9_67
.LBB9_5:
	movb	%r14b, 312(%rsp)
	callq	*%rcx
	movl	$64, %edi
	movl	$1, %esi
	callq	*%rbp
	testq	%rax, %rax
	je	.LBB9_76
	movabsq	$7640891576956012809, %rcx
	xorl	%edi, %edi
	movq	360(%rsp), %rsi
	.p2align	4
.LBB9_7:
	movq	%rcx, %rdx
	shlq	$13, %rdx
	xorq	%rcx, %rdx
	movq	%rdx, %rcx
	shrq	$7, %rcx
	xorq	%rdx, %rcx
	movq	%rcx, %rdx
	shlq	$17, %rdx
	xorq	%rcx, %rdx
	andl	$63, %ecx
	movzbl	(%rsi,%rcx), %ecx
	movb	%cl, (%rax,%rdi)
	movq	%rdx, %rcx
	shlq	$13, %rcx
	xorq	%rdx, %rcx
	movq	%rcx, %rdx
	shrq	$7, %rdx
	xorq	%rcx, %rdx
	movq	%rdx, %rcx
	shlq	$17, %rcx
	xorq	%rdx, %rcx
	andl	$63, %edx
	movzbl	(%rsi,%rdx), %edx
	movb	%dl, 1(%rax,%rdi)
	addq	$2, %rdi
	cmpq	$64, %rdi
	jne	.LBB9_7
	movq	%rax, 40(%rsp)
	movl	%r14d, 48(%rsp)
	movb	%r14b, (%rax,%rbx)
	xorl	%r14d, %r14d
	jmp	.LBB9_9
	.p2align	4
.LBB9_65:
	incq	%r14
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip), %rbx
	callq	*%rbx
	movl	$1, %edx
	movq	32(%rsp), %rdi
	movq	%r13, %rsi
	callq	*%rbx
	movl	$1, %edx
	movq	24(%rsp), %rdi
	movq	%r12, %rsi
	callq	*%rbx
	cmpq	$32, %r14
	movq	_RNvCs5fGHjzWXRav_7___rustc12___rust_alloc@GOTPCREL(%rip), %rbp
	movq	memset@GOTPCREL(%rip), %r15
	je	.LBB9_66
.LBB9_9:
	movq	%r14, 288(%rsp)
	leaq	64(%r14), %r12
	movq	_RNvCs5fGHjzWXRav_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip), %rbx
	callq	*%rbx
	movl	$1, %esi
	movq	%r12, %rdi
	callq	*%rbp
	testq	%rax, %rax
	je	.LBB9_78
	movq	%rax, %r13
	movq	%rax, %rdi
	movl	$165, %esi
	movq	%r12, %rdx
	callq	*%r15
	movq	40(%rsp), %rax
	movupd	(%rax), %xmm0
	movupd	16(%rax), %xmm1
	movups	32(%rax), %xmm2
	movups	48(%rax), %xmm3
	movupd	%xmm0, (%r13,%r14)
	movupd	%xmm1, 16(%r13,%r14)
	movups	%xmm2, 32(%r13,%r14)
	movq	%r13, 24(%rsp)
	movups	%xmm3, 48(%r13,%r14)
	leaq	65(%r14), %r13
	callq	*%rbx
	movl	$1, %esi
	movq	%r13, %rdi
	callq	*%rbp
	testq	%rax, %rax
	je	.LBB9_82
	movq	%r15, %rcx
	movq	%rax, %r15
	movq	%r13, 368(%rsp)
	movq	%rax, 376(%rsp)
	movq	%rax, %rdi
	movl	$165, %esi
	movq	%r13, %rdx
	callq	*%rcx
	movq	%r13, 384(%rsp)
	callq	*%rbx
	movl	$1, %esi
	movq	%r13, %rdi
	callq	*%rbp
	testq	%rax, %rax
	je	.LBB9_83
	movq	%rax, %rbx
	movq	%r12, 16(%rsp)
	movq	24(%rsp), %r12
	addq	%r14, %r12
	movq	%r13, 448(%rsp)
	movq	%rax, 456(%rsp)
	movq	%rax, %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	movq	%r13, 464(%rsp)
	movq	%r15, 32(%rsp)
	addq	%r14, %r15
.Ltmp16:
	movq	$19, (%rsp)
	movl	$64, %edx
	movl	$48, %r8d
	leaq	80(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r15, %rcx
	movl	72(%rsp), %r15d
	movl	%r15d, %r9d
	callq	_RNvCseSqpdtHE20y_5bench3old
.Ltmp17:
	movq	%rbx, %rbp
	addq	%r14, %rbp
.Ltmp18:
	movq	$19, (%rsp)
	movl	$64, %edx
	movl	$48, %r8d
	leaq	160(%rsp), %rdi
	movq	%r12, %rsi
	movq	%rbp, %rcx
	movl	%r15d, %r9d
	callq	_RNvCseSqpdtHE20y_5bench3new
.Ltmp19:
	movzbl	80(%rsp), %r12d
	cmpl	$255, %r12d
	setne	%cl
	movzbl	160(%rsp), %eax
	cmpb	$-1, %al
	sete	%dl
	cmpb	%dl, %cl
	je	.LBB9_89
	cmpl	$255, %r12d
	je	.LBB9_35
	cmpb	%al, %r12b
	jne	.LBB9_89
	movl	%r12d, %eax
	leaq	.LJTI9_1(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB9_34:
	movq	88(%rsp), %rax
	cmpq	168(%rsp), %rax
	jne	.LBB9_89
.LBB9_35:
	movq	32(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	*bcmp@GOTPCREL(%rip)
	testl	%eax, %eax
	jne	.LBB9_90
	testq	%r14, %r14
	je	.LBB9_41
	xorl	%eax, %eax
	.p2align	4
.LBB9_39:
	cmpb	$-91, (%rbx,%rax)
	jne	.LBB9_40
	incq	%rax
	cmpq	%rax, %r14
	jne	.LBB9_39
.LBB9_41:
	movl	$79, %esi
	cmpb	$-91, 48(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 49(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 50(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 51(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 52(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 53(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 54(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 55(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 56(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 57(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 58(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 59(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 60(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 61(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 62(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 63(%rbp)
	jne	.LBB9_42
	cmpb	$-91, 64(%rbp)
	jne	.LBB9_42
	cmpl	$255, %r12d
	leaq	64(%r14), %r12
	je	.LBB9_65
	movq	56(%rsp), %rax
	.p2align	4
.LBB9_62:
	cmpb	$-91, (%rbp,%rax)
	jne	.LBB9_63
	incq	%rax
	cmpq	$65, %rax
	jne	.LBB9_62
	jmp	.LBB9_65
.LBB9_33:
	movzbl	81(%rsp), %eax
	cmpb	161(%rsp), %al
	je	.LBB9_34
	jmp	.LBB9_89
	.p2align	4
.LBB9_67:
	movq	64(%rsp), %rax
	movq	%rax, %rbx
	cmpq	$64, %rax
	jne	.LBB9_4
	movl	$1, %eax
	testb	$1, 352(%rsp)
	movb	$1, %cl
	movq	%rcx, 352(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.16(%rip), %rcx
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.15(%rip), %rdx
	je	.LBB9_1
	leaq	160(%rsp), %rbx
	movq	%rbx, %rdi
	callq	*_RNvNtCs8ZKwes1zzDd_3std3env4args@GOTPCREL(%rip)
.Ltmp29:
	leaq	448(%rsp), %rdi
	movq	%rbx, %rsi
	callq	*_RNvXsc_NtCs8ZKwes1zzDd_3std3envNtB5_4ArgsNtNtNtNtCskADBYZwJmSU_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp30:
	movq	448(%rsp), %rsi
	cmpq	$-1, %rsi
	je	.LBB9_155
	movl	$1751330093, %ebp
	movl	$1801676136, %r15d
	leaq	448(%rsp), %rbx
	leaq	160(%rsp), %r14
	movq	_RNvXsc_NtCs8ZKwes1zzDd_3std3envNtB5_4ArgsNtNtNtNtCskADBYZwJmSU_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip), %r12
.LBB9_72:
	movq	456(%rsp), %rdi
	cmpq	$7, 464(%rsp)
	jne	.LBB9_73
	movl	(%rdi), %eax
	xorl	%ebp, %eax
	movl	3(%rdi), %ecx
	xorl	%r15d, %ecx
	orl	%eax, %ecx
	sete	%r13b
	jmp	.LBB9_150
.LBB9_73:
	xorl	%r13d, %r13d
.LBB9_150:
	testq	%rsi, %rsi
	je	.LBB9_152
	movl	$1, %edx
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_152:
	testb	%r13b, %r13b
	jne	.LBB9_171
.Ltmp32:
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	*%r12
.Ltmp33:
	movq	448(%rsp), %rsi
	cmpq	$-1, %rsi
	jne	.LBB9_72
.LBB9_155:
	movq	168(%rsp), %r14
	movq	184(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	je	.LBB9_160
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	jmp	.LBB9_157
.LBB9_89:
.Ltmp21:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.17(%rip), %rdx
	leaq	80(%rsp), %rdi
	leaq	160(%rsp), %rsi
	callq	_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtB4_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorEBM_EB1b_
.Ltmp22:
	jmp	.LBB9_121
.LBB9_120:
.Ltmp8:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.24(%rip), %rdx
	leaq	80(%rsp), %rdi
	leaq	368(%rsp), %rsi
	movq	40(%rsp), %r14
	movq	56(%rsp), %rbp
	movq	48(%rsp), %r12
	callq	_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtB4_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorEBM_EB1b_
.Ltmp9:
	jmp	.LBB9_121
.LBB9_90:
	leaq	144(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	_RNvXsg_NtCskADBYZwJmSU_4core3fmtbNtB5_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 168(%rsp)
	leaq	312(%rsp), %rax
	movq	%rax, 176(%rsp)
	movq	_RNvXNtNtNtCskADBYZwJmSU_4core3fmt3num3imphNtB6_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 184(%rsp)
	leaq	112(%rsp), %rax
	movq	%rax, 192(%rsp)
	movq	_RNvXsi_NtNtNtCskADBYZwJmSU_4core3fmt3num3impjNtB9_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 200(%rsp)
	leaq	288(%rsp), %rcx
	movq	%rcx, 208(%rsp)
	movq	%rax, 216(%rsp)
.Ltmp23:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.18(%rip), %rdx
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.19(%rip), %r8
	leaq	368(%rsp), %rdi
	leaq	448(%rsp), %rsi
	leaq	160(%rsp), %rcx
	callq	_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtCsgFX3jaOk65H_5alloc3vec3VechEBM_ECseSqpdtHE20y_5bench
.Ltmp24:
	jmp	.LBB9_121
.LBB9_123:
.Ltmp10:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.25(%rip), %r8
	leaq	448(%rsp), %rdi
	leaq	160(%rsp), %rsi
	xorl	%edx, %edx
	callq	_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtCsgFX3jaOk65H_5alloc3vec3VechEBM_ECseSqpdtHE20y_5bench
.Ltmp11:
	jmp	.LBB9_121
.LBB9_145:
.Ltmp13:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.26(%rip), %rdi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.27(%rip), %rdx
	movl	$84, %esi
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking5panic@GOTPCREL(%rip)
.Ltmp14:
	jmp	.LBB9_121
.LBB9_40:
	movl	$79, %esi
.LBB9_42:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.21(%rip), %rdx
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.20(%rip), %rdi
	movq	16(%rsp), %r12
	jmp	.LBB9_64
.LBB9_63:
	movl	$74, %esi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.22(%rip), %rdi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.23(%rip), %rdx
.LBB9_64:
.Ltmp26:
	movq	32(%rsp), %r15
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking5panic@GOTPCREL(%rip)
.Ltmp27:
	jmp	.LBB9_121
.LBB9_159:
	addq	$24, %r14
	decq	%rbx
	je	.LBB9_160
.LBB9_157:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB9_159
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB9_159
.LBB9_83:
.Ltmp67:
	movl	$1, %edi
	movq	%r13, %rsi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp68:
	jmp	.LBB9_121
.LBB9_78:
.Ltmp73:
	movl	$1, %edi
	movq	%r12, %rsi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp74:
	jmp	.LBB9_121
.LBB9_82:
.Ltmp70:
	movl	$1, %edi
	movq	%r13, %rsi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp71:
	jmp	.LBB9_121
.LBB9_32:
.Ltmp79:
	movl	$1, %edi
	movq	%r12, %rsi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp80:
	jmp	.LBB9_121
.LBB9_104:
.Ltmp76:
	movq	%r14, %rbp
	movl	$1, %edi
	movq	%r12, %rsi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp77:
	jmp	.LBB9_121
.LBB9_160:
	movq	176(%rsp), %rax
	testq	%rax, %rax
	je	.LBB9_162
	movq	160(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_162:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.5(%rip), %rdi
	movl	$143, %esi
	callq	*_RNvNtNtCs8ZKwes1zzDd_3std2io5stdio6__print@GOTPCREL(%rip)
	movq	$0, 288(%rsp)
	movq	$2, 296(%rsp)
	movw	$256, 304(%rsp)
	xorl	%ecx, %ecx
	movq	_RNvCs5fGHjzWXRav_7___rustc12___rust_alloc@GOTPCREL(%rip), %r12
.LBB9_163:
	movzbl	304(%rsp,%rcx), %eax
	incq	%rcx
	movq	%rcx, 48(%rsp)
	movb	%al, 15(%rsp)
	movq	$0, 448(%rsp)
	movq	$10, 456(%rsp)
	movq	$4, 464(%rsp)
	movq	$8, 472(%rsp)
	movq	$12, 480(%rsp)
	movq	$16, 488(%rsp)
	movq	$20, 496(%rsp)
	movq	$24, 504(%rsp)
	movq	$28, 512(%rsp)
	movq	$32, 520(%rsp)
	movq	$64, 528(%rsp)
	movq	$4096, 536(%rsp)
	xorl	%ecx, %ecx
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.16(%rip), %rax
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.15(%rip), %r15
.LBB9_164:
	movq	464(%rsp,%rcx,8), %rbx
	incq	%rcx
	movq	%rbx, 104(%rsp)
	cmpb	$0, 15(%rsp)
	cmovneq	%rax, %r15
	testq	%rbx, %rbx
	js	.LBB9_165
	movq	%rcx, 56(%rsp)
	je	.LBB9_180
	callq	*_RNvCs5fGHjzWXRav_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$1, %r14d
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	*%r12
	testq	%rax, %rax
	je	.LBB9_166
	cmpq	$1, %rbx
	movq	%rax, 16(%rsp)
	jne	.LBB9_184
	movabsq	$7640891576956012809, %rdx
	xorl	%edi, %edi
	jmp	.LBB9_187
.LBB9_180:
	movl	$1, %eax
	movq	%rax, 16(%rsp)
	jmp	.LBB9_188
.LBB9_184:
	movq	%rbx, %rcx
	movabsq	$9223372036854775806, %rdx
	andq	%rdx, %rcx
	movabsq	$7640891576956012809, %rdx
	xorl	%edi, %edi
.LBB9_185:
	movq	%rdx, %rsi
	shlq	$13, %rsi
	xorq	%rdx, %rsi
	movq	%rsi, %rdx
	shrq	$7, %rdx
	xorq	%rsi, %rdx
	movq	%rdx, %rsi
	shlq	$17, %rsi
	xorq	%rdx, %rsi
	andl	$63, %edx
	movzbl	(%r15,%rdx), %edx
	movb	%dl, (%rax,%rdi)
	movq	%rsi, %rdx
	shlq	$13, %rdx
	xorq	%rsi, %rdx
	movq	%rdx, %rsi
	shrq	$7, %rsi
	xorq	%rdx, %rsi
	movq	%rsi, %rdx
	shlq	$17, %rdx
	xorq	%rsi, %rdx
	andl	$63, %esi
	movzbl	(%r15,%rsi), %esi
	movb	%sil, 1(%rax,%rdi)
	addq	$2, %rdi
	cmpq	%rdi, %rcx
	jne	.LBB9_185
	testb	$1, %bl
	je	.LBB9_188
.LBB9_187:
	movl	%edx, %ecx
	shrl	$7, %ecx
	xorl	%edx, %ecx
	andl	$63, %ecx
	movzbl	(%r15,%rcx), %ecx
	movb	%cl, (%rax,%rdi)
.LBB9_188:
	movq	$0, 368(%rsp)
	movq	$4, 376(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.6(%rip), %rax
	movq	%rax, 384(%rsp)
	movq	$5, 392(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.7(%rip), %rax
	movq	%rax, 400(%rsp)
	movq	$12, 408(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.8(%rip), %rax
	movq	%rax, 416(%rsp)
	movq	$14, 424(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.9(%rip), %rax
	movq	%rax, 432(%rsp)
	movq	$12, 440(%rsp)
	xorl	%r13d, %r13d
	jmp	.LBB9_189
.LBB9_252:
	cmpq	$4, %r13
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.16(%rip), %rax
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.15(%rip), %r15
	je	.LBB9_197
.LBB9_189:
	movq	%r13, %rax
	shlq	$4, %rax
	leaq	384(%rsp), %rcx
	movq	(%rcx,%rax), %rsi
	movq	8(%rcx,%rax), %r8
	movq	%rsi, 312(%rsp)
	movq	%r8, 320(%rsp)
	testq	%rbx, %rbx
	je	.LBB9_190
	callq	*_RNvCs5fGHjzWXRav_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	*%r12
	testq	%rax, %rax
	je	.LBB9_192
	movq	%rax, %r14
	movq	%rax, %rdi
	movq	16(%rsp), %rsi
	movq	%rbx, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	movq	312(%rsp), %rsi
	movq	320(%rsp), %r8
	jmp	.LBB9_200
.LBB9_190:
	movl	$1, %r14d
.LBB9_200:
	cmpq	$14, %r8
	je	.LBB9_211
	cmpq	$12, %r8
	je	.LBB9_209
	cmpq	$5, %r8
	jne	.LBB9_212
	movl	(%rsi), %eax
	movl	$1768710518, %ecx
	xorl	%ecx, %eax
	movzbl	4(%rsi), %ecx
	xorl	$100, %ecx
	orl	%eax, %ecx
	jne	.LBB9_212
	jmp	.LBB9_204
.LBB9_209:
	movq	(%rsi), %rax
	movabsq	$6873734845486755433, %rcx
	xorq	%rcx, %rax
	movl	8(%rsi), %ecx
	xorq	$1684104552, %rcx
	orq	%rax, %rcx
	jne	.LBB9_212
	xorl	%edi, %edi
	cmpq	%rbx, %rdi
	jb	.LBB9_215
	jmp	.LBB9_218
.LBB9_211:
	movq	(%rsi), %rax
	movabsq	$6873734845486755433, %rcx
	xorq	%rcx, %rax
	movq	6(%rsi), %rcx
	movabsq	$7308326677743755108, %rdx
	xorq	%rdx, %rcx
	orq	%rax, %rcx
	je	.LBB9_213
.LBB9_212:
	movq	104(%rsp), %rdi
	decq	%rdi
	cmpq	%rbx, %rdi
	jae	.LBB9_218
.LBB9_215:
	movb	$33, (%r14,%rdi)
.LBB9_204:
	movq	104(%rsp), %rax
	shrq	$2, %rax
	leaq	(%rax,%rax,2), %rbp
	testq	%rbp, %rbp
	js	.LBB9_205
	movq	%r8, 24(%rsp)
	movq	%rsi, 32(%rsp)
	incq	%r13
	movq	%rax, 40(%rsp)
	testq	%rax, %rax
	movq	%r13, 72(%rsp)
	je	.LBB9_225
	movq	_RNvCs5fGHjzWXRav_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip), %r13
	callq	*%r13
	movl	$1, %r12d
	movl	$1, %esi
	movq	%rbp, %rdi
	callq	*_RNvCs5fGHjzWXRav_7___rustc19___rust_alloc_zeroed@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB9_208
	movq	%rax, %r15
	movq	%rbp, 80(%rsp)
	movq	%rax, 88(%rsp)
	movq	%rbp, 96(%rsp)
	callq	*%r13
	movl	$1, %esi
	movq	%rbp, %rdi
	callq	*_RNvCs5fGHjzWXRav_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB9_220
	movq	%rax, %r12
	movq	%rbp, 328(%rsp)
	movq	%rax, 336(%rsp)
	movq	%rax, %rdi
	movq	%r15, %rsi
	movq	%rbp, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	movq	72(%rsp), %r13
	jmp	.LBB9_226
.LBB9_225:
	movq	%rbp, 80(%rsp)
	movq	$1, 88(%rsp)
	movq	%rbp, 96(%rsp)
	movq	$0, 328(%rsp)
	movq	$1, 336(%rsp)
	movl	$1, %r15d
	movl	$1, %r12d
.LBB9_226:
	movq	%rbp, 344(%rsp)
	movzbl	15(%rsp), %r9d
.Ltmp46:
	movq	$19, (%rsp)
	leaq	112(%rsp), %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	movq	%r12, %rcx
	movq	%rbp, %r8
	callq	_RNvCseSqpdtHE20y_5bench3old
.Ltmp47:
	movzbl	15(%rsp), %r9d
.Ltmp48:
	movq	$19, (%rsp)
	leaq	160(%rsp), %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	movq	%r15, %rcx
	movq	%rbp, %r8
	callq	_RNvCseSqpdtHE20y_5bench3new
.Ltmp49:
	movzbl	160(%rsp), %eax
	cmpl	$255, %eax
	setne	%dl
	movzbl	112(%rsp), %ecx
	cmpb	$-1, %cl
	sete	%sil
	cmpb	%sil, %dl
	je	.LBB9_238
	cmpl	$255, %eax
	je	.LBB9_239
	cmpb	%cl, %al
	jne	.LBB9_238
	movl	%eax, %eax
	leaq	.LJTI9_2(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB9_237:
	movq	168(%rsp), %rax
	cmpq	120(%rsp), %rax
	jne	.LBB9_238
.LBB9_239:
	movq	%r15, %rdi
	movq	%r12, %rsi
	movq	%rbp, %rdx
	callq	*bcmp@GOTPCREL(%rip)
	testl	%eax, %eax
	jne	.LBB9_240
	movl	$500000, %eax
	cmpq	$65, 104(%rsp)
	jb	.LBB9_245
	movl	$3000, %eax
	cmpq	$12, 24(%rsp)
	jne	.LBB9_245
	movq	32(%rsp), %rdx
	movq	(%rdx), %rax
	movabsq	$6873734845486755433, %rcx
	xorq	%rcx, %rax
	movl	8(%rdx), %ecx
	xorq	$1684104552, %rcx
	orq	%rax, %rcx
	movl	$3000, %eax
	movl	$500000, %ecx
	cmoveq	%rcx, %rax
.LBB9_245:
	movq	%rax, 136(%rsp)
	xorl	%r13d, %r13d
	.p2align	4
.LBB9_246:
	movl	%r13d, 156(%rsp)
	movq	136(%rsp), %rax
	movzbl	15(%rsp), %r9d
	testb	$1, %r13b
	jne	.LBB9_253
.Ltmp57:
	movq	%rax, (%rsp)
	leaq	_RNvCseSqpdtHE20y_5bench3old(%rip), %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	movq	%r15, %rcx
	movq	%rbp, %r8
	callq	_RNvCseSqpdtHE20y_5bench6sample
.Ltmp58:
	movq	136(%rsp), %rax
	movzbl	15(%rsp), %r9d
.Ltmp59:
	movq	%rax, (%rsp)
	leaq	_RNvCseSqpdtHE20y_5bench3new(%rip), %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	movq	%r15, %rcx
	movq	%rbp, %r8
	movsd	%xmm0, 24(%rsp)
	callq	_RNvCseSqpdtHE20y_5bench6sample
	movapd	%xmm0, %xmm1
	movsd	24(%rsp), %xmm0
.Ltmp60:
	jmp	.LBB9_255
	.p2align	4
.LBB9_253:
.Ltmp53:
	movq	%rax, (%rsp)
	leaq	_RNvCseSqpdtHE20y_5bench3new(%rip), %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	movq	%r15, %rcx
	movq	%rbp, %r8
	callq	_RNvCseSqpdtHE20y_5bench6sample
.Ltmp54:
	movq	136(%rsp), %rax
	movzbl	15(%rsp), %r9d
.Ltmp55:
	movq	%rax, (%rsp)
	leaq	_RNvCseSqpdtHE20y_5bench3old(%rip), %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	movq	%r15, %rcx
	movq	%rbp, %r8
	movsd	%xmm0, 32(%rsp)
	callq	_RNvCseSqpdtHE20y_5bench6sample
	movsd	32(%rsp), %xmm1
.Ltmp56:
.LBB9_255:
	movsd	%xmm1, 32(%rsp)
	movsd	%xmm0, 24(%rsp)
	movsd	%xmm0, 552(%rsp)
	movsd	%xmm1, 560(%rsp)
	movq	%r15, %rdi
	movq	%r12, %rsi
	movq	%rbp, %rdx
	callq	*bcmp@GOTPCREL(%rip)
	testl	%eax, %eax
	jne	.LBB9_256
	movsd	24(%rsp), %xmm0
	divsd	32(%rsp), %xmm0
	movsd	%xmm0, 144(%rsp)
	leaq	312(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	_RNvXs1i_NtCskADBYZwJmSU_4core3fmtReNtB6_7Display3fmtCseSqpdtHE20y_5bench(%rip), %rax
	movq	%rax, 168(%rsp)
	leaq	15(%rsp), %rax
	movq	%rax, 176(%rsp)
	movq	_RNvXsg_NtCskADBYZwJmSU_4core3fmtbNtB5_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 184(%rsp)
	leaq	104(%rsp), %rax
	movq	%rax, 192(%rsp)
	movq	_RNvXsi_NtNtNtCskADBYZwJmSU_4core3fmt3num3impjNtB9_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 200(%rsp)
	leaq	156(%rsp), %rcx
	movq	%rcx, 208(%rsp)
	movq	_RNvXs9_NtNtNtCskADBYZwJmSU_4core3fmt3num3implNtB9_7Display3fmt@GOTPCREL(%rip), %rcx
	movq	%rcx, 216(%rsp)
	leaq	136(%rsp), %rcx
	movq	%rcx, 224(%rsp)
	movq	%rax, 232(%rsp)
	leaq	552(%rsp), %rax
	movq	%rax, 240(%rsp)
	movq	_RNvXs7_NtNtCskADBYZwJmSU_4core3fmt5floatdNtB7_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 248(%rsp)
	leaq	560(%rsp), %rcx
	movq	%rcx, 256(%rsp)
	movq	%rax, 264(%rsp)
	leaq	144(%rsp), %rcx
	movq	%rcx, 272(%rsp)
	movq	%rax, 280(%rsp)
.Ltmp64:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.14(%rip), %rdi
	leaq	160(%rsp), %rsi
	callq	*_RNvNtNtCs8ZKwes1zzDd_3std2io5stdio6__print@GOTPCREL(%rip)
.Ltmp65:
	incl	%r13d
	cmpl	$7, %r13d
	jne	.LBB9_246
	cmpq	$0, 40(%rsp)
	je	.LBB9_251
	movl	$1, %edx
	movq	%r12, %rdi
	movq	%rbp, %rsi
	movq	_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	callq	*%r12
	movl	$1, %edx
	movq	%r15, %rdi
	movq	%rbp, %rsi
	callq	*%r12
.LBB9_251:
	movq	_RNvCs5fGHjzWXRav_7___rustc12___rust_alloc@GOTPCREL(%rip), %r12
	movq	72(%rsp), %r13
	testq	%rbx, %rbx
	je	.LBB9_252
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	cmpq	$4, %r13
	jne	.LBB9_189
	jmp	.LBB9_196
.LBB9_236:
	movzbl	161(%rsp), %eax
	cmpb	113(%rsp), %al
	je	.LBB9_237
	jmp	.LBB9_238
.LBB9_213:
	movq	104(%rsp), %rdi
	shrq	%rdi
	cmpq	%rbx, %rdi
	jb	.LBB9_215
	jmp	.LBB9_218
.LBB9_196:
	movl	$1, %edx
	movq	16(%rsp), %rdi
	movq	%rbx, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.15(%rip), %r15
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.16(%rip), %rax
.LBB9_197:
	movq	56(%rsp), %rcx
	cmpq	$10, %rcx
	jne	.LBB9_164
	cmpq	$2, 48(%rsp)
	movl	$1, %ecx
	jne	.LBB9_163
	jmp	.LBB9_178
.LBB9_256:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.13(%rip), %r8
.LBB9_241:
	movq	48(%rsp), %rax
	movq	%rax, 288(%rsp)
	movq	56(%rsp), %rax
	movq	%rax, 448(%rsp)
	movq	72(%rsp), %rax
	movq	%rax, 368(%rsp)
.Ltmp61:
	leaq	80(%rsp), %rdi
	leaq	328(%rsp), %rsi
	xorl	%edx, %edx
	callq	_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtCsgFX3jaOk65H_5alloc3vec3VechEBM_ECseSqpdtHE20y_5bench
.Ltmp62:
	jmp	.LBB9_121
.LBB9_95:
.Ltmp0:
	movl	$1, %edi
	movq	%r12, %rsi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp1:
	jmp	.LBB9_121
.LBB9_171:
	movq	168(%rsp), %r14
	movq	184(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	je	.LBB9_176
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	jmp	.LBB9_173
.LBB9_175:
	addq	$24, %r14
	decq	%rbx
	je	.LBB9_176
.LBB9_173:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB9_175
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB9_175
.LBB9_176:
	movq	176(%rsp), %rax
	testq	%rax, %rax
	je	.LBB9_178
	movq	160(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_178:
	addq	$568, %rsp
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
.LBB9_238:
	.cfi_def_cfa_offset 624
	movq	48(%rsp), %rax
	movq	%rax, 288(%rsp)
	movq	56(%rsp), %rax
	movq	%rax, 448(%rsp)
	movq	%r13, 368(%rsp)
.Ltmp51:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.11(%rip), %rdx
	leaq	160(%rsp), %rdi
	leaq	112(%rsp), %rsi
	callq	_RINvNtCskADBYZwJmSU_4core9panicking13assert_failedINtNtB4_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorEBM_EB1b_
.Ltmp52:
	jmp	.LBB9_121
.LBB9_76:
	movl	$1, %edi
	movl	$64, %esi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.LBB9_240:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.12(%rip), %r8
	jmp	.LBB9_241
.LBB9_23:
	movl	$1, %edi
	movq	%r14, %rsi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.LBB9_205:
	xorl	%r12d, %r12d
.LBB9_208:
.Ltmp43:
	movq	%r12, %rdi
	movq	%rbp, %rsi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp44:
	jmp	.LBB9_121
.LBB9_218:
.Ltmp38:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.10(%rip), %rdx
	movq	%rbx, %rsi
	callq	*_RNvNtCskADBYZwJmSU_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp39:
	jmp	.LBB9_121
.LBB9_192:
.Ltmp35:
	movl	$1, %edi
	movq	%rbx, %rsi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp36:
	jmp	.LBB9_121
.LBB9_220:
	movq	48(%rsp), %rax
	movq	%rax, 288(%rsp)
	movq	56(%rsp), %rax
	movq	%rax, 448(%rsp)
	movq	72(%rsp), %rax
	movq	%rax, 368(%rsp)
.Ltmp40:
	movl	$1, %edi
	movq	%rbp, %rsi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp41:
.LBB9_121:
	ud2
.LBB9_165:
	xorl	%r14d, %r14d
.LBB9_166:
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	*_RNvNtCsgFX3jaOk65H_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.LBB9_168:
.Ltmp31:
	jmp	.LBB9_169
.LBB9_167:
.Ltmp34:
.LBB9_169:
	movq	%rax, %rbp
	leaq	160(%rsp), %rdi
	callq	_RINvNtCskADBYZwJmSU_4core3ptr9drop_glueNtNtCs8ZKwes1zzDd_3std3env4ArgsECseSqpdtHE20y_5bench
	movq	%rbp, %rdi
	callq	_Unwind_Resume@PLT
.LBB9_224:
.Ltmp42:
	movq	%rax, 24(%rsp)
	jmp	.LBB9_223
.LBB9_259:
.Ltmp37:
	movq	%rax, %rbp
	jmp	.LBB9_194
.LBB9_233:
.Ltmp50:
	movq	%rax, 24(%rsp)
	movq	48(%rsp), %rax
	movq	%rax, 288(%rsp)
	movq	56(%rsp), %rax
	movq	%rax, 448(%rsp)
	movq	%r13, 368(%rsp)
	jmp	.LBB9_235
.LBB9_216:
.Ltmp45:
	movq	%rax, 24(%rsp)
	jmp	.LBB9_217
.LBB9_232:
.Ltmp66:
	movq	%rax, 24(%rsp)
	movq	48(%rsp), %rax
	movq	%rax, 288(%rsp)
	movq	56(%rsp), %rax
	movq	%rax, 448(%rsp)
	movq	72(%rsp), %rax
	movq	%rax, 368(%rsp)
	jmp	.LBB9_235
.LBB9_96:
.Ltmp2:
	movq	%rax, %rbp
	movq	64(%rsp), %r15
	testq	%r14, %r14
	jne	.LBB9_98
	jmp	.LBB9_170
.LBB9_234:
.Ltmp63:
	movq	%rax, 24(%rsp)
.LBB9_235:
	cmpq	$0, 40(%rsp)
	je	.LBB9_217
	movl	$1, %edx
	movq	%r12, %rdi
	movq	%rbp, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_223:
	movl	$1, %edx
	movq	%r15, %rdi
	movq	%rbp, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_217:
	testq	%rbx, %rbx
	movq	24(%rsp), %rbp
	je	.LBB9_170
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_194:
	movl	$1, %edx
	movq	16(%rsp), %rdi
	movq	%rbx, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%rbp, %rdi
	callq	_Unwind_Resume@PLT
.LBB9_105:
.Ltmp78:
	movq	%rax, %r13
	movq	64(%rsp), %r15
	movq	40(%rsp), %r14
	jmp	.LBB9_111
.LBB9_99:
.Ltmp81:
	movq	%rax, %rbp
	movq	64(%rsp), %r15
	movq	40(%rsp), %r14
	jmp	.LBB9_100
.LBB9_79:
.Ltmp72:
	movq	%rax, %rbp
	movq	24(%rsp), %rbx
	jmp	.LBB9_80
.LBB9_77:
.Ltmp75:
	movq	%rax, %rbp
	jmp	.LBB9_81
.LBB9_84:
.Ltmp69:
	movq	%rax, %rbp
	jmp	.LBB9_88
.LBB9_106:
.Ltmp7:
	movq	%rax, %r13
	movq	64(%rsp), %r15
	movq	40(%rsp), %r14
	movq	56(%rsp), %rbp
	movq	48(%rsp), %r12
	jmp	.LBB9_110
.LBB9_74:
.Ltmp20:
	jmp	.LBB9_75
.LBB9_108:
.Ltmp15:
	jmp	.LBB9_109
.LBB9_86:
.Ltmp28:
	movq	%rax, %rbp
	jmp	.LBB9_87
.LBB9_107:
.Ltmp12:
.LBB9_109:
	movq	%rax, %r13
	movq	64(%rsp), %r15
.LBB9_110:
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_111:
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	%r12, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%r13, %rbp
.LBB9_100:
	testq	%r14, %r14
	jne	.LBB9_102
	movq	24(%rsp), %r14
	testq	%r14, %r14
	je	.LBB9_170
.LBB9_98:
	movl	$1, %edx
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%rbp, %rdi
	callq	_Unwind_Resume@PLT
.LBB9_102:
	movl	$1, %edx
	movq	128(%rsp), %rdi
	movq	%r14, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	24(%rsp), %r14
	testq	%r14, %r14
	jne	.LBB9_98
.LBB9_170:
	movq	%rbp, %rdi
	callq	_Unwind_Resume@PLT
.LBB9_85:
.Ltmp25:
.LBB9_75:
	movq	%rax, %rbp
	movq	16(%rsp), %r12
	movq	32(%rsp), %r15
.LBB9_87:
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	%r13, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_88:
	movq	24(%rsp), %rbx
	movl	$1, %edx
	movq	%r15, %rdi
	movq	%r13, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_80:
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_81:
	movq	40(%rsp), %rdi
	movl	$64, %esi
	movl	$1, %edx
	callq	*_RNvCs5fGHjzWXRav_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%rbp, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end9:
	.size	_RNvCseSqpdtHE20y_5bench4main, .Lfunc_end9-_RNvCseSqpdtHE20y_5bench4main
	.cfi_endproc
	.section	.rodata._RNvCseSqpdtHE20y_5bench4main,"a",@progbits
	.p2align	2, 0x0
.LJTI9_0:
	.long	.LBB9_122-.LJTI9_0
	.long	.LBB9_119-.LJTI9_0
	.long	.LBB9_119-.LJTI9_0
	.long	.LBB9_118-.LJTI9_0
	.long	.LBB9_119-.LJTI9_0
	.long	.LBB9_119-.LJTI9_0
.LJTI9_1:
	.long	.LBB9_35-.LJTI9_1
	.long	.LBB9_34-.LJTI9_1
	.long	.LBB9_34-.LJTI9_1
	.long	.LBB9_33-.LJTI9_1
	.long	.LBB9_34-.LJTI9_1
	.long	.LBB9_34-.LJTI9_1
.LJTI9_2:
	.long	.LBB9_239-.LJTI9_2
	.long	.LBB9_237-.LJTI9_2
	.long	.LBB9_237-.LJTI9_2
	.long	.LBB9_236-.LJTI9_2
	.long	.LBB9_237-.LJTI9_2
	.long	.LBB9_237-.LJTI9_2
	.section	.gcc_except_table._RNvCseSqpdtHE20y_5bench4main,"a",@progbits
	.p2align	2, 0x0
GCC_except_table9:
.Lexception0:
	.byte	255
	.byte	255
	.byte	1
	.uleb128 .Lcst_end0-.Lcst_begin0
.Lcst_begin0:
	.uleb128 .Lfunc_begin0-.Lfunc_begin0
	.uleb128 .Ltmp3-.Lfunc_begin0
	.byte	0
	.byte	0
	.uleb128 .Ltmp3-.Lfunc_begin0
	.uleb128 .Ltmp6-.Ltmp3
	.uleb128 .Ltmp7-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp6-.Lfunc_begin0
	.uleb128 .Ltmp16-.Ltmp6
	.byte	0
	.byte	0
	.uleb128 .Ltmp16-.Lfunc_begin0
	.uleb128 .Ltmp19-.Ltmp16
	.uleb128 .Ltmp20-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp19-.Lfunc_begin0
	.uleb128 .Ltmp29-.Ltmp19
	.byte	0
	.byte	0
	.uleb128 .Ltmp29-.Lfunc_begin0
	.uleb128 .Ltmp30-.Ltmp29
	.uleb128 .Ltmp31-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp32-.Lfunc_begin0
	.uleb128 .Ltmp33-.Ltmp32
	.uleb128 .Ltmp34-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp21-.Lfunc_begin0
	.uleb128 .Ltmp22-.Ltmp21
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp8-.Lfunc_begin0
	.uleb128 .Ltmp9-.Ltmp8
	.uleb128 .Ltmp12-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp23-.Lfunc_begin0
	.uleb128 .Ltmp24-.Ltmp23
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp10-.Lfunc_begin0
	.uleb128 .Ltmp11-.Ltmp10
	.uleb128 .Ltmp12-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp13-.Lfunc_begin0
	.uleb128 .Ltmp14-.Ltmp13
	.uleb128 .Ltmp15-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp26-.Lfunc_begin0
	.uleb128 .Ltmp27-.Ltmp26
	.uleb128 .Ltmp28-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp67-.Lfunc_begin0
	.uleb128 .Ltmp68-.Ltmp67
	.uleb128 .Ltmp69-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp73-.Lfunc_begin0
	.uleb128 .Ltmp74-.Ltmp73
	.uleb128 .Ltmp75-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp70-.Lfunc_begin0
	.uleb128 .Ltmp71-.Ltmp70
	.uleb128 .Ltmp72-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp79-.Lfunc_begin0
	.uleb128 .Ltmp80-.Ltmp79
	.uleb128 .Ltmp81-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp76-.Lfunc_begin0
	.uleb128 .Ltmp77-.Ltmp76
	.uleb128 .Ltmp78-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp77-.Lfunc_begin0
	.uleb128 .Ltmp46-.Ltmp77
	.byte	0
	.byte	0
	.uleb128 .Ltmp46-.Lfunc_begin0
	.uleb128 .Ltmp49-.Ltmp46
	.uleb128 .Ltmp50-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp57-.Lfunc_begin0
	.uleb128 .Ltmp65-.Ltmp57
	.uleb128 .Ltmp66-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp65-.Lfunc_begin0
	.uleb128 .Ltmp61-.Ltmp65
	.byte	0
	.byte	0
	.uleb128 .Ltmp61-.Lfunc_begin0
	.uleb128 .Ltmp62-.Ltmp61
	.uleb128 .Ltmp63-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp0-.Lfunc_begin0
	.uleb128 .Ltmp1-.Ltmp0
	.uleb128 .Ltmp2-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp51-.Lfunc_begin0
	.uleb128 .Ltmp52-.Ltmp51
	.uleb128 .Ltmp63-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp52-.Lfunc_begin0
	.uleb128 .Ltmp43-.Ltmp52
	.byte	0
	.byte	0
	.uleb128 .Ltmp43-.Lfunc_begin0
	.uleb128 .Ltmp39-.Ltmp43
	.uleb128 .Ltmp45-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp35-.Lfunc_begin0
	.uleb128 .Ltmp36-.Ltmp35
	.uleb128 .Ltmp37-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp40-.Lfunc_begin0
	.uleb128 .Ltmp41-.Ltmp40
	.uleb128 .Ltmp42-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp41-.Lfunc_begin0
	.uleb128 .Lfunc_end9-.Ltmp41
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI10_0:
	.long	1127219200
	.long	1160773632
	.long	0
	.long	0
.LCPI10_1:
	.quad	0x4330000000000000
	.quad	0x4530000000000000
	.section	.text._RNvCseSqpdtHE20y_5bench6sample,"ax",@progbits
	.prefalign	4, .Lfunc_end10, nop
	.type	_RNvCseSqpdtHE20y_5bench6sample,@function
_RNvCseSqpdtHE20y_5bench6sample:
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
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%r9d, 12(%rsp)
	movq	%r8, %r15
	movq	%rcx, %r12
	movq	%rdx, %r13
	movq	%rsi, %rbp
	movq	%rdi, %r14
	callq	*_RNvMNtCs8ZKwes1zzDd_3std4timeNtB2_7Instant3now@GOTPCREL(%rip)
	movq	%rax, 88(%rsp)
	movl	%edx, 96(%rsp)
	leaq	88(%rsp), %rdi
	callq	*_RNvMNtCs8ZKwes1zzDd_3std4timeNtB2_7Instant7elapsed@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB10_3
	leaq	48(%rsp), %rbx
	.p2align	4
.LBB10_2:
	cmpl	$1000000, %edx
	jae	.LBB10_3
	movq	%rbp, 16(%rsp)
	movq	%r13, 24(%rsp)
	leaq	16(%rsp), %rax
	#APP
	#NO_APP
	movq	%r12, 32(%rsp)
	movq	%r15, 40(%rsp)
	leaq	32(%rsp), %rax
	#APP
	#NO_APP
	movl	12(%rsp), %eax
	movb	%al, 64(%rsp)
	leaq	64(%rsp), %rax
	#APP
	#NO_APP
	movq	$19, 48(%rsp)
	#APP
	#NO_APP
	movq	16(%rsp), %rsi
	movq	24(%rsp), %rdx
	movq	32(%rsp), %rcx
	movq	40(%rsp), %r8
	movzbl	64(%rsp), %r9d
	movq	48(%rsp), %rax
	movq	%rax, (%rsp)
	leaq	104(%rsp), %rdi
	callq	*%r14
	movupd	104(%rsp), %xmm0
	movapd	%xmm0, 48(%rsp)
	#APP
	#NO_APP
	leaq	88(%rsp), %rdi
	callq	*_RNvMNtCs8ZKwes1zzDd_3std4timeNtB2_7Instant7elapsed@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB10_2
.LBB10_3:
	callq	*_RNvMNtCs8ZKwes1zzDd_3std4timeNtB2_7Instant3now@GOTPCREL(%rip)
	movq	%rax, 64(%rsp)
	movl	%edx, 72(%rsp)
	cmpq	$0, 176(%rsp)
	movl	12(%rsp), %ebx
	je	.LBB10_6
	movq	%r15, %rdi
	movq	%r14, %r10
	movq	176(%rsp), %r15
	movq	%rbp, 80(%rsp)
	.p2align	4
.LBB10_5:
	movq	%rbp, 16(%rsp)
	movq	%r13, 24(%rsp)
	leaq	16(%rsp), %rsi
	#APP
	#NO_APP
	movq	%r12, 32(%rsp)
	movq	%rdi, 40(%rsp)
	leaq	32(%rsp), %rsi
	#APP
	#NO_APP
	movb	%bl, 11(%rsp)
	leaq	11(%rsp), %rsi
	#APP
	#NO_APP
	movq	$19, 48(%rsp)
	leaq	48(%rsp), %rsi
	#APP
	#NO_APP
	movq	16(%rsp), %rsi
	movq	24(%rsp), %rdx
	movq	32(%rsp), %rcx
	movq	40(%rsp), %r8
	movzbl	11(%rsp), %r9d
	movq	48(%rsp), %rax
	movq	%rax, (%rsp)
	movq	%rdi, %r14
	leaq	104(%rsp), %rdi
	movq	%r10, %rbp
	callq	*%r10
	movq	%rbp, %r10
	movq	%r14, %rdi
	movq	80(%rsp), %rbp
	movupd	104(%rsp), %xmm0
	movapd	%xmm0, 48(%rsp)
	leaq	48(%rsp), %rsi
	#APP
	#NO_APP
	decq	%r15
	jne	.LBB10_5
.LBB10_6:
	leaq	64(%rsp), %rdi
	callq	*_RNvMNtCs8ZKwes1zzDd_3std4timeNtB2_7Instant7elapsed@GOTPCREL(%rip)
	movl	%edx, %ecx
	movl	$1000000000, %edx
	mulq	%rdx
	movl	%ecx, %edi
	addq	%rax, %rdi
	adcq	$0, %rdx
	movq	%rdx, %rsi
	callq	*__floattidf@GOTPCREL(%rip)
	movsd	176(%rsp), %xmm1
	unpcklps	.LCPI10_0(%rip), %xmm1
	subpd	.LCPI10_1(%rip), %xmm1
	movapd	%xmm1, %xmm2
	unpckhpd	%xmm1, %xmm2
	addsd	%xmm1, %xmm2
	divsd	%xmm2, %xmm0
	addq	$120, %rsp
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
.Lfunc_end10:
	.size	_RNvCseSqpdtHE20y_5bench6sample, .Lfunc_end10-_RNvCseSqpdtHE20y_5bench6sample
	.cfi_endproc

	.section	.text._RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtB8_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorENtB6_5Debug3fmtBV_,"ax",@progbits
	.prefalign	4, .Lfunc_end11, nop
	.type	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtB8_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorENtB6_5Debug3fmtBV_,@function
_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtB8_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorENtB6_5Debug3fmtBV_:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	cmpb	$-1, (%rcx)
	je	.LBB11_2
	movq	%rcx, (%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.67(%rip), %rsi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.66(%rip), %r8
	movq	%rsp, %rcx
	movl	$3, %edx
	movq	%rax, %rdi
	callq	*_RNvMsa_NtCskADBYZwJmSU_4core3fmtNtB5_9Formatter25debug_tuple_field1_finish@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB11_2:
	.cfi_def_cfa_offset 16
	movq	%rcx, (%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.65(%rip), %rsi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.64(%rip), %r8
	movq	%rsp, %rcx
	movl	$2, %edx
	movq	%rax, %rdi
	callq	*_RNvMsa_NtCskADBYZwJmSU_4core3fmtNtB5_9Formatter25debug_tuple_field1_finish@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end11:
	.size	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtB8_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorENtB6_5Debug3fmtBV_, .Lfunc_end11-_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtB8_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorENtB6_5Debug3fmtBV_
	.cfi_endproc

	.section	.text._RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtCsgFX3jaOk65H_5alloc3vec3VechENtB6_5Debug3fmtCseSqpdtHE20y_5bench,"ax",@progbits
	.prefalign	4, .Lfunc_end12, nop
	.type	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtCsgFX3jaOk65H_5alloc3vec3VechENtB6_5Debug3fmtCseSqpdtHE20y_5bench,@function
_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtCsgFX3jaOk65H_5alloc3vec3VechENtB6_5Debug3fmtCseSqpdtHE20y_5bench:
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	(%rdi), %rax
	movq	8(%rax), %r12
	movq	16(%rax), %r13
	leaq	8(%rsp), %rdi
	callq	*_RNvMsa_NtCskADBYZwJmSU_4core3fmtNtB5_9Formatter10debug_list@GOTPCREL(%rip)
	testq	%r13, %r13
	je	.LBB12_3
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.0(%rip), %rbx
	leaq	8(%rsp), %r14
	movq	%rsp, %r15
	movq	_RNvMs6_NtNtCskADBYZwJmSU_4core3fmt8buildersNtB5_9DebugList5entry@GOTPCREL(%rip), %rbp
	.p2align	4
.LBB12_2:
	movq	%r12, (%rsp)
	incq	%r12
	movq	%r14, %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	*%rbp
	decq	%r13
	jne	.LBB12_2
.LBB12_3:
	leaq	8(%rsp), %rdi
	callq	*_RNvMs6_NtNtCskADBYZwJmSU_4core3fmt8buildersNtB5_9DebugList6finish@GOTPCREL(%rip)
	addq	$24, %rsp
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
.Lfunc_end12:
	.size	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtCsgFX3jaOk65H_5alloc3vec3VechENtB6_5Debug3fmtCseSqpdtHE20y_5bench, .Lfunc_end12-_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtCsgFX3jaOk65H_5alloc3vec3VechENtB6_5Debug3fmtCseSqpdtHE20y_5bench
	.cfi_endproc

	.section	.text._RNvXs1g_NtCskADBYZwJmSU_4core3fmtRNtCseSqpdtHE20y_5bench5ErrorNtB6_5Debug3fmtBy_,"ax",@progbits
	.prefalign	4, .Lfunc_end13, nop
	.type	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRNtCseSqpdtHE20y_5bench5ErrorNtB6_5Debug3fmtBy_,@function
_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRNtCseSqpdtHE20y_5bench5ErrorNtB6_5Debug3fmtBy_:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	movzbl	(%rcx), %edx
	leaq	.LJTI13_0(%rip), %rsi
	movslq	(%rsi,%rdx,4), %rdx
	addq	%rsi, %rdx
	jmpq	*%rdx
.LBB13_1:
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.52(%rip), %rsi
	movl	$14, %edx
	movq	%rax, %rdi
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	jmpq	*_RNvMsa_NtCskADBYZwJmSU_4core3fmtNtB5_9Formatter9write_str@GOTPCREL(%rip)
.LBB13_5:
	.cfi_def_cfa_offset 64
	addq	$8, %rcx
	movq	%rcx, 48(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.53(%rip), %rcx
	movq	%rcx, (%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.61(%rip), %rsi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.57(%rip), %rcx
	leaq	48(%rsp), %r9
	movl	$14, %edx
	jmp	.LBB13_7
.LBB13_3:
	addq	$8, %rcx
	movq	%rcx, 48(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.53(%rip), %rcx
	movq	%rcx, (%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.56(%rip), %rsi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.57(%rip), %rcx
	leaq	48(%rsp), %r9
	movl	$13, %edx
	jmp	.LBB13_7
.LBB13_4:
	leaq	8(%rcx), %r9
	incq	%rcx
	movq	%rcx, 48(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.0(%rip), %rcx
	movq	%rcx, 32(%rsp)
	leaq	48(%rsp), %rcx
	movq	%rcx, 24(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.60(%rip), %rcx
	movq	%rcx, 8(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.58(%rip), %rcx
	movq	%rcx, (%rsp)
	movq	$4, 16(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.59(%rip), %rsi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.57(%rip), %rcx
	movl	$11, %edx
	movl	$5, %r8d
	movq	%rax, %rdi
	callq	*_RNvMsa_NtCskADBYZwJmSU_4core3fmtNtB5_9Formatter26debug_struct_field2_finish@GOTPCREL(%rip)
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB13_2:
	.cfi_def_cfa_offset 64
	addq	$8, %rcx
	movq	%rcx, 48(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.53(%rip), %rcx
	movq	%rcx, (%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.54(%rip), %rsi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.55(%rip), %rcx
	leaq	48(%rsp), %r9
	movl	$14, %edx
	movl	$8, %r8d
	movq	%rax, %rdi
	callq	*_RNvMsa_NtCskADBYZwJmSU_4core3fmtNtB5_9Formatter26debug_struct_field1_finish@GOTPCREL(%rip)
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB13_6:
	.cfi_def_cfa_offset 64
	addq	$8, %rcx
	movq	%rcx, 48(%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.53(%rip), %rcx
	movq	%rcx, (%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.62(%rip), %rsi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.57(%rip), %rcx
	leaq	48(%rsp), %r9
	movl	$12, %edx
.LBB13_7:
	movl	$5, %r8d
	movq	%rax, %rdi
	callq	*_RNvMsa_NtCskADBYZwJmSU_4core3fmtNtB5_9Formatter26debug_struct_field1_finish@GOTPCREL(%rip)
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end13:
	.size	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRNtCseSqpdtHE20y_5bench5ErrorNtB6_5Debug3fmtBy_, .Lfunc_end13-_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRNtCseSqpdtHE20y_5bench5ErrorNtB6_5Debug3fmtBy_
	.cfi_endproc
	.section	.rodata._RNvXs1g_NtCskADBYZwJmSU_4core3fmtRNtCseSqpdtHE20y_5bench5ErrorNtB6_5Debug3fmtBy_,"a",@progbits
	.p2align	2, 0x0
.LJTI13_0:
	.long	.LBB13_1-.LJTI13_0
	.long	.LBB13_2-.LJTI13_0
	.long	.LBB13_3-.LJTI13_0
	.long	.LBB13_4-.LJTI13_0
	.long	.LBB13_5-.LJTI13_0
	.long	.LBB13_6-.LJTI13_0

	.section	.text._RNvXs1g_NtCskADBYZwJmSU_4core3fmtRhNtB6_5Debug3fmtCseSqpdtHE20y_5bench,"ax",@progbits
	.prefalign	4, .Lfunc_end14, nop
	.type	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRhNtB6_5Debug3fmtCseSqpdtHE20y_5bench,@function
_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRhNtB6_5Debug3fmtCseSqpdtHE20y_5bench:
	.cfi_startproc
	movq	(%rdi), %rdi
	movl	16(%rsi), %eax
	testl	$33554432, %eax
	jne	.LBB14_3
	testl	$67108864, %eax
	jne	.LBB14_2
	jmpq	*_RNvXNtNtNtCskADBYZwJmSU_4core3fmt3num3imphNtB6_7Display3fmt@GOTPCREL(%rip)
.LBB14_3:
	jmpq	*_RNvXse_NtNtCskADBYZwJmSU_4core3fmt3numhNtB7_8LowerHex3fmt@GOTPCREL(%rip)
.LBB14_2:
	jmpq	*_RNvXsg_NtNtCskADBYZwJmSU_4core3fmt3numhNtB7_8UpperHex3fmt@GOTPCREL(%rip)
.Lfunc_end14:
	.size	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRhNtB6_5Debug3fmtCseSqpdtHE20y_5bench, .Lfunc_end14-_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRhNtB6_5Debug3fmtCseSqpdtHE20y_5bench
	.cfi_endproc

	.section	.text._RNvXs1g_NtCskADBYZwJmSU_4core3fmtRjNtB6_5Debug3fmtCseSqpdtHE20y_5bench,"ax",@progbits
	.prefalign	4, .Lfunc_end15, nop
	.type	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRjNtB6_5Debug3fmtCseSqpdtHE20y_5bench,@function
_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRjNtB6_5Debug3fmtCseSqpdtHE20y_5bench:
	.cfi_startproc
	movq	(%rdi), %rdi
	movl	16(%rsi), %eax
	testl	$33554432, %eax
	jne	.LBB15_3
	testl	$67108864, %eax
	jne	.LBB15_2
	jmpq	*_RNvXsi_NtNtNtCskADBYZwJmSU_4core3fmt3num3impjNtB9_7Display3fmt@GOTPCREL(%rip)
.LBB15_3:
	jmpq	*_RNvXs6_NtNtCskADBYZwJmSU_4core3fmt3numjNtB7_8LowerHex3fmt@GOTPCREL(%rip)
.LBB15_2:
	jmpq	*_RNvXs8_NtNtCskADBYZwJmSU_4core3fmt3numjNtB7_8UpperHex3fmt@GOTPCREL(%rip)
.Lfunc_end15:
	.size	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRjNtB6_5Debug3fmtCseSqpdtHE20y_5bench, .Lfunc_end15-_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRjNtB6_5Debug3fmtCseSqpdtHE20y_5bench
	.cfi_endproc

	.section	.text._RNvXs1g_NtCskADBYZwJmSU_4core3fmtRuNtB6_5Debug3fmtCseSqpdtHE20y_5bench,"ax",@progbits
	.prefalign	4, .Lfunc_end16, nop
	.type	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRuNtB6_5Debug3fmtCseSqpdtHE20y_5bench,@function
_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRuNtB6_5Debug3fmtCseSqpdtHE20y_5bench:
	.cfi_startproc
	movq	%rsi, %rdi
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.63(%rip), %rsi
	movl	$2, %edx
	jmpq	*_RNvMsa_NtCskADBYZwJmSU_4core3fmtNtB5_9Formatter3pad@GOTPCREL(%rip)
.Lfunc_end16:
	.size	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRuNtB6_5Debug3fmtCseSqpdtHE20y_5bench, .Lfunc_end16-_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRuNtB6_5Debug3fmtCseSqpdtHE20y_5bench
	.cfi_endproc

	.section	.text._RNvXs1i_NtCskADBYZwJmSU_4core3fmtReNtB6_7Display3fmtCseSqpdtHE20y_5bench,"ax",@progbits
	.prefalign	4, .Lfunc_end17, nop
	.type	_RNvXs1i_NtCskADBYZwJmSU_4core3fmtReNtB6_7Display3fmtCseSqpdtHE20y_5bench,@function
_RNvXs1i_NtCskADBYZwJmSU_4core3fmtReNtB6_7Display3fmtCseSqpdtHE20y_5bench:
	.cfi_startproc
	movq	%rsi, %rdx
	movq	(%rdi), %rax
	movq	8(%rdi), %rsi
	movq	%rax, %rdi
	jmpq	*_RNvXsi_NtCskADBYZwJmSU_4core3fmteNtB5_7Display3fmt@GOTPCREL(%rip)
.Lfunc_end17:
	.size	_RNvXs1i_NtCskADBYZwJmSU_4core3fmtReNtB6_7Display3fmtCseSqpdtHE20y_5bench, .Lfunc_end17-_RNvXs1i_NtCskADBYZwJmSU_4core3fmtReNtB6_7Display3fmtCseSqpdtHE20y_5bench
	.cfi_endproc

	.section	.text._RNvXsZ_NtNtCskADBYZwJmSU_4core3fmt3numjNtB7_5Debug3fmt,"ax",@progbits
	.prefalign	4, .Lfunc_end18, nop
	.type	_RNvXsZ_NtNtCskADBYZwJmSU_4core3fmt3numjNtB7_5Debug3fmt,@function
_RNvXsZ_NtNtCskADBYZwJmSU_4core3fmt3numjNtB7_5Debug3fmt:
	.cfi_startproc
	movl	16(%rsi), %eax
	testl	$33554432, %eax
	jne	.LBB18_3
	testl	$67108864, %eax
	jne	.LBB18_2
	jmpq	*_RNvXsi_NtNtNtCskADBYZwJmSU_4core3fmt3num3impjNtB9_7Display3fmt@GOTPCREL(%rip)
.LBB18_3:
	jmpq	*_RNvXs6_NtNtCskADBYZwJmSU_4core3fmt3numjNtB7_8LowerHex3fmt@GOTPCREL(%rip)
.LBB18_2:
	jmpq	*_RNvXs8_NtNtCskADBYZwJmSU_4core3fmt3numjNtB7_8UpperHex3fmt@GOTPCREL(%rip)
.Lfunc_end18:
	.size	_RNvXsZ_NtNtCskADBYZwJmSU_4core3fmt3numjNtB7_5Debug3fmt, .Lfunc_end18-_RNvXsZ_NtNtCskADBYZwJmSU_4core3fmt3numjNtB7_5Debug3fmt
	.cfi_endproc

	.section	.text.main,"ax",@progbits
	.globl	main
	.prefalign	4, .Lfunc_end19, nop
	.type	main,@function
main:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rsi, %rcx
	movslq	%edi, %rdx
	leaq	_RNvCseSqpdtHE20y_5bench4main(%rip), %rax
	movq	%rax, (%rsp)
	leaq	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.1(%rip), %rsi
	movq	%rsp, %rdi
	xorl	%r8d, %r8d
	callq	*_RNvNtCs8ZKwes1zzDd_3std2rt19lang_start_internal@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end19:
	.size	main, .Lfunc_end19-main
	.cfi_endproc

	.type	_RNvNtCseSqpdtHE20y_5bench9candidate11URL_INVERSE,@object
	.section	.rodata._RNvNtCseSqpdtHE20y_5bench9candidate11URL_INVERSE,"a",@progbits
_RNvNtCseSqpdtHE20y_5bench9candidate11URL_INVERSE:
	.ascii	"\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377>\377\377456789:;<=\377\377\377\377\377\377\377\000\001\002\003\004\005\006\007\b\t\n\013\f\r\016\017\020\021\022\023\024\025\026\027\030\031\377\377\377\377?\377\032\033\034\035\036\037 !\"#$%&'()*+,-./0123\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377"
	.size	_RNvNtCseSqpdtHE20y_5bench9candidate11URL_INVERSE, 256

	.type	_RNvNtCseSqpdtHE20y_5bench9candidate16STANDARD_INVERSE,@object
	.section	.rodata._RNvNtCseSqpdtHE20y_5bench9candidate16STANDARD_INVERSE,"a",@progbits
_RNvNtCseSqpdtHE20y_5bench9candidate16STANDARD_INVERSE:
	.ascii	"\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377>\377\377\377?456789:;<=\377\377\377\377\377\377\377\000\001\002\003\004\005\006\007\b\t\n\013\f\r\016\017\020\021\022\023\024\025\026\027\030\031\377\377\377\377\377\377\032\033\034\035\036\037 !\"#$%&'()*+,-./0123\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377\377"
	.size	_RNvNtCseSqpdtHE20y_5bench9candidate16STANDARD_INVERSE, 256

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.0,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.0,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.0:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRhNtB6_5Debug3fmtCseSqpdtHE20y_5bench
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.0, 32

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.1,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.1,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.1:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNSNvYNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0INtNtNtCskADBYZwJmSU_4core3ops8function6FnOnceuE9call_once6vtableCseSqpdtHE20y_5bench
	.quad	_RNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0CseSqpdtHE20y_5bench
	.quad	_RNCINvNtCs8ZKwes1zzDd_3std2rt10lang_startuE0CseSqpdtHE20y_5bench
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.1, 48

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.2,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.2,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.2:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtB8_6result6ResultuNtCseSqpdtHE20y_5bench5ErrorENtB6_5Debug3fmtBV_
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.2, 32

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.3,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.3,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.3:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRINtNtCsgFX3jaOk65H_5alloc3vec3VechENtB6_5Debug3fmtCseSqpdtHE20y_5bench
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.3, 32

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4:
	.asciz	"bench.rs"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4, 9

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.5,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.5,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.5:
	.ascii	"case,url,text_bytes,sample,iterations,baseline_ns,candidate_ns,speedup\n"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.5, 71

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.6,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.6,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.6:
	.ascii	"valid"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.6, 5

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.7,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.7,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.7:
	.ascii	"invalid_head"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.7, 12

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.8,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.8,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.8:
	.ascii	"invalid_middle"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.8, 14

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.9,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.9,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.9:
	.ascii	"invalid_tail"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.9, 12

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.10,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.10,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.10:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4
	.asciz	"\b\000\000\000\000\000\000\000L\000\000\000{\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.10, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.11,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.11,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.11:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4
	.asciz	"\b\000\000\000\000\000\000\000O\000\000\000\021\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.11, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.12,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.12,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.12:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4
	.asciz	"\b\000\000\000\000\000\000\000O\000\000\000L\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.12, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.13,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.13,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.13:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4
	.asciz	"\b\000\000\000\000\000\000\000S\000\000\000\025\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.13, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.14,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.14,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.14:
	.asciz	"\300\001,\300\001,\300\001,\300\001,\300\001,\305 \000\000p\003\000\001,\305 \000\000p\003\000\001,\305 \000\000p\003\000\001\n"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.14, 43

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.15,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.15,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.15:
	.ascii	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.15, 64

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.16,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.16,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.16:
	.ascii	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.16, 64

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.17,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.17,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.17:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4
	.asciz	"\b\000\000\000\000\000\000\0001\000\000\000\025\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.17, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.18,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.18:
	.asciz	"\004URL \300\007, byte \300\013, position \300\t, offset \300"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.18, 40

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.19,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.19,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.19:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4
	.asciz	"\b\000\000\000\000\000\000\0002\000\000\000\025\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.19, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.20,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.20,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.20:
	.ascii	"assertion failed: b[..start].iter().chain(&b[start + 48..]).all(|&v| v == 0xa5)"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.20, 79

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.21,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.21,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.21:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4
	.asciz	"\b\000\000\000\000\000\000\0003\000\000\000\025\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.21, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.22,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.22,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.22:
	.ascii	"assertion failed: b[start + position / 8 * 6..].iter().all(|&v| v == 0xa5)"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.22, 74

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.23,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.23,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.23:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4
	.asciz	"\b\000\000\000\000\000\000\0004\000\000\000,\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.23, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.24,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.24,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.24:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4
	.asciz	"\b\000\000\000\000\000\000\000#\000\000\000\021\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.24, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.25,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.25,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.25:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4
	.asciz	"\b\000\000\000\000\000\000\000$\000\000\000\021\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.25, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.26,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.26,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.26:
	.ascii	"assertion failed: b[..start].iter().chain(&b[start + written..]).all(|&v| v == 0xa5)"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.26, 84

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.27,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.27,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.27:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.4
	.asciz	"\b\000\000\000\000\000\000\000%\000\000\000\021\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.27, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28:
	.asciz	"baseline.rs"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28, 12

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.29,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.29,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.29:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000\210\000\000\000\027\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.29, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.30,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.30,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.30:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000\211\000\000\000\027\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.30, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.31,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.31,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.31:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000\212\000\000\000\027\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.31, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.32,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.32,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.32:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000\213\000\000\000\027\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.32, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.33,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.33,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.33:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000\217\000\000\000\017\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.33, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.34,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.34,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.34:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000q\000\000\000\023\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.34, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.35,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.35,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.35:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000r\000\000\000\023\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.35, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.36,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.36,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.36:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000s\000\000\000\023\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.36, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.37,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.37,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.37:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000t\000\000\000\023\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.37, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.38,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.38,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.38:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000u\000\000\000\023\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.38, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.39,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.39,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.39:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000v\000\000\000\023\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.39, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.40,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.40,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.40:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000w\000\000\000\023\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.40, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.41,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.41,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.41:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000x\000\000\000\023\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.41, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.42,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.42,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.42:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000\203\000\000\000\017\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.42, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.43,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.43,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.43:
	.ascii	"internal error: entered unreachable code: a set high bit identifies an invalid table entry"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.43, 90

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.44,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.44,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.44:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.28
	.asciz	"\013\000\000\000\000\000\000\000b\000\000\000\005\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.44, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.45,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.45:
	.asciz	"candidate.rs"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.45, 13

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.46,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.46,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.46:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.45
	.asciz	"\f\000\000\000\000\000\000\000\213\000\000\000\027\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.46, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.47,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.47,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.47:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.45
	.asciz	"\f\000\000\000\000\000\000\000\214\000\000\000\027\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.47, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.48,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.48,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.48:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.45
	.asciz	"\f\000\000\000\000\000\000\000\215\000\000\000\027\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.48, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.49,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.49,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.49:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.45
	.asciz	"\f\000\000\000\000\000\000\000\221\000\000\000\017\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.49, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.50,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.50,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.50:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.45
	.asciz	"\f\000\000\000\000\000\000\000\204\000\000\000\017\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.50, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.51,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.51,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.51:
	.quad	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.45
	.asciz	"\f\000\000\000\000\000\000\000b\000\000\000\005\000\000"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.51, 24

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.52,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.52,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.52:
	.ascii	"LengthOverflow"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.52, 14

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.53,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.53,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.53:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRjNtB6_5Debug3fmtCseSqpdtHE20y_5bench
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.53, 32

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.54,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.54,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.54:
	.ascii	"OutputTooSmall"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.54, 14

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.55,@object
	.section	.rodata.cst8,"aM",@progbits,8
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.55:
	.ascii	"required"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.55, 8

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.56,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.56,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.56:
	.ascii	"InvalidLength"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.56, 13

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.57,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.57,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.57:
	.ascii	"index"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.57, 5

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.58,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.58,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.58:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXsZ_NtNtCskADBYZwJmSU_4core3fmt3numjNtB7_5Debug3fmt
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.58, 32

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.59,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.59,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.59:
	.ascii	"InvalidByte"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.59, 11

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.60,@object
	.section	.rodata.cst4,"aM",@progbits,4
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.60:
	.ascii	"byte"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.60, 4

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.61,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.61,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.61:
	.ascii	"InvalidPadding"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.61, 14

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.62,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.62,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.62:
	.ascii	"NonCanonical"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.62, 12

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.63,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.63,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.63:
	.ascii	"()"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.63, 2

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.64,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.64,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.64:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRuNtB6_5Debug3fmtCseSqpdtHE20y_5bench
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.64, 32

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.65,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.65,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.65:
	.ascii	"Ok"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.65, 2

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.66,@object
	.section	.data.rel.ro..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.66,"aw",@progbits
	.p2align	3, 0x0
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.66:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCskADBYZwJmSU_4core3fmtRNtCseSqpdtHE20y_5bench5ErrorNtB6_5Debug3fmtBy_
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.66, 32

	.type	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.67,@object
	.section	.rodata..Lanon.b953a2e8071bb4868dac6abc15fb0f5f.67,"a",@progbits
.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.67:
	.ascii	"Err"
	.size	.Lanon.b953a2e8071bb4868dac6abc15fb0f5f.67, 3

	.hidden	DW.ref.rust_eh_personality
	.weak	DW.ref.rust_eh_personality
	.section	.data.DW.ref.rust_eh_personality,"awG",@progbits,DW.ref.rust_eh_personality,comdat
	.p2align	3, 0x0
	.type	DW.ref.rust_eh_personality,@object
	.size	DW.ref.rust_eh_personality, 8
DW.ref.rust_eh_personality:
	.quad	rust_eh_personality
	.ident	"rustc version 1.99.1 (58cf8f9c3 2026-10-13)"
	.section	".note.GNU-stack","",@progbits
