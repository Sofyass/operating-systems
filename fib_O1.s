	.file	"fib.c"
	.text

	# ����������� ������� printf
	.def	printf;	.scl	3;	.type	32;	.endef
	.seh_proc	printf
printf:
	pushq	%rsi		# ���������� �������� rsi
	.seh_pushreg	%rsi
	pushq	%rbx		# ���������� �������� rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp	# ��������� ����� �� �����
	.seh_stackalloc	56
	.seh_endprologue
	movq	%rcx, %rbx	# ���������� ������� ��������� � rbx
	movq	%rdx, 88(%rsp)	# ���������� ������� ��������� �� �����
	movq	%r8, 96(%rsp)	# ���������� �������� ��������� �� �����
	movq	%r9, 104(%rsp)	# ���������� ���������� ��������� �� �����
	leaq	88(%rsp), %rsi	# �������� ������ ���������� �� ����� � rsi
	movq	%rsi, 40(%rsp)	# ���������� ������ ���������� �� �����
	movl	$1, %ecx	# �������� ������� ��������� ��� __acrt_iob_func
	call	*__imp___acrt_iob_func(%rip) # ����� __acrt_iob_func
	movq	%rax, %rcx	# ���������� ���������� � rcx
	movq	%rsi, %r8	# �������� ������ ���������� � r8
	movq	%rbx, %rdx	# �������� ������� ��������� � rdx
	call	__mingw_vfprintf # ����� __mingw_vfprintf
	addq	$56, %rsp	# ������������ ����� �� �����
	popq	%rbx		# �������������� �������� rbx
	popq	%rsi		# �������������� �������� rsi
	ret			# ������� �� �������

	# ����������� ������� fib
	.globl	fib
	.def	fib;	.scl	2;	.type	32;	.endef
	.seh_proc	fib
fib:
	pushq	%rsi		# ���������� �������� rsi
	.seh_pushreg	%rsi
	pushq	%rbx		# ���������� �������� rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp	# ��������� ����� �� �����
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %ebx	# ���������� ��������� � ebx
	movl	%ecx, %eax	# ����������� ��������� � eax
	cmpl	$1, %ecx	# ��������� ��������� � 1
	jle	.L2		# �������, ���� �������� ������ ��� ����� 1
	leal	-1(%rcx), %ecx	# ���������� ��������� ��� ������������ ������
	call	fib		# ����������� ����� fib
	movl	%eax, %esi	# ���������� ���������� � esi
	leal	-2(%rbx), %ecx	# ���������� ��������� ��� ������� ������������ ������
	call	fib		# ������ ����������� ����� fib
	addl	%esi, %eax	# �������� ����������� ���� ����������� �������
.L2:
	addq	$40, %rsp	# ������������ ����� �� �����
	popq	%rbx		# �������������� �������� rbx
	popq	%rsi		# �������������� �������� rsi
	ret			# ������� �� �������

	# ����������� ������� main
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Fibonacci number %d is %d\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp	# ��������� ����� �� �����
	.seh_stackalloc	40
	.seh_endprologue
	call	__main		# ����� __main
	movl	$30, %ecx	# �������� ��������� 30 � ecx
	call	fib		# ����� ������� fib
	movl	%eax, %r8d	# ���������� ���������� � r8d
	movl	$30, %edx	# �������� ��������� 30 � edx
	leaq	.LC0(%rip), %rcx # �������� ������ ������ ������� � rcx
	call	printf		# ����� ������� printf
	movl	$0, %eax	# �������� 0 � eax (��� ��������)
	addq	$40, %rsp	# ������������ ����� �� �����
	ret			# ������� �� ������� main
	.seh_endproc
	.ident	"GCC: (GNU) 13.2.0"
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef