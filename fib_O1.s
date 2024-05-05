	.file	"fib.c"
	.text

	# Определение функции printf
	.def	printf;	.scl	3;	.type	32;	.endef
	.seh_proc	printf
printf:
	pushq	%rsi		# Сохранение регистра rsi
	.seh_pushreg	%rsi
	pushq	%rbx		# Сохранение регистра rbx
	.seh_pushreg	%rbx
	subq	$56, %rsp	# Выделение места на стеке
	.seh_stackalloc	56
	.seh_endprologue
	movq	%rcx, %rbx	# Сохранение первого аргумента в rbx
	movq	%rdx, 88(%rsp)	# Сохранение второго аргумента на стеке
	movq	%r8, 96(%rsp)	# Сохранение третьего аргумента на стеке
	movq	%r9, 104(%rsp)	# Сохранение четвертого аргумента на стеке
	leaq	88(%rsp), %rsi	# Загрузка адреса аргументов на стеке в rsi
	movq	%rsi, 40(%rsp)	# Сохранение адреса аргументов на стеке
	movl	$1, %ecx	# Загрузка первого аргумента для __acrt_iob_func
	call	*__imp___acrt_iob_func(%rip) # Вызов __acrt_iob_func
	movq	%rax, %rcx	# Сохранение результата в rcx
	movq	%rsi, %r8	# Загрузка адреса аргументов в r8
	movq	%rbx, %rdx	# Загрузка первого аргумента в rdx
	call	__mingw_vfprintf # Вызов __mingw_vfprintf
	addq	$56, %rsp	# Освобождение места на стеке
	popq	%rbx		# Восстановление регистра rbx
	popq	%rsi		# Восстановление регистра rsi
	ret			# Возврат из функции

	# Определение функции fib
	.globl	fib
	.def	fib;	.scl	2;	.type	32;	.endef
	.seh_proc	fib
fib:
	pushq	%rsi		# Сохранение регистра rsi
	.seh_pushreg	%rsi
	pushq	%rbx		# Сохранение регистра rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp	# Выделение места на стеке
	.seh_stackalloc	40
	.seh_endprologue
	movl	%ecx, %ebx	# Сохранение аргумента в ebx
	movl	%ecx, %eax	# Копирование аргумента в eax
	cmpl	$1, %ecx	# Сравнение аргумента с 1
	jle	.L2		# Переход, если аргумент меньше или равен 1
	leal	-1(%rcx), %ecx	# Вычисление аргумента для рекурсивного вызова
	call	fib		# Рекурсивный вызов fib
	movl	%eax, %esi	# Сохранение результата в esi
	leal	-2(%rbx), %ecx	# Вычисление аргумента для второго рекурсивного вызова
	call	fib		# Второй рекурсивный вызов fib
	addl	%esi, %eax	# Сложение результатов двух рекурсивных вызовов
.L2:
	addq	$40, %rsp	# Освобождение места на стеке
	popq	%rbx		# Восстановление регистра rbx
	popq	%rsi		# Восстановление регистра rsi
	ret			# Возврат из функции

	# Определение функции main
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "Fibonacci number %d is %d\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	subq	$40, %rsp	# Выделение места на стеке
	.seh_stackalloc	40
	.seh_endprologue
	call	__main		# Вызов __main
	movl	$30, %ecx	# Загрузка аргумента 30 в ecx
	call	fib		# Вызов функции fib
	movl	%eax, %r8d	# Сохранение результата в r8d
	movl	$30, %edx	# Загрузка аргумента 30 в edx
	leaq	.LC0(%rip), %rcx # Загрузка адреса строки формата в rcx
	call	printf		# Вызов функции printf
	movl	$0, %eax	# Загрузка 0 в eax (код возврата)
	addq	$40, %rsp	# Освобождение места на стеке
	ret			# Возврат из функции main
	.seh_endproc
	.ident	"GCC: (GNU) 13.2.0"
	.def	__mingw_vfprintf;	.scl	2;	.type	32;	.endef