	.file	"syscalls.c"
	.option nopic
	.text
	.align	2
	.type	printArray, @function
printArray:
	add	sp,sp,-32
	sw	s0,28(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	sw	a2,-28(s0)
	nop
	lw	s0,28(sp)
	add	sp,sp,32
	jr	ra
	.size	printArray, .-printArray
	.align	2
	.type	printDoubleArray, @function
printDoubleArray:
	add	sp,sp,-32
	sw	s0,28(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	sw	a2,-28(s0)
	nop
	lw	s0,28(sp)
	add	sp,sp,32
	jr	ra
	.size	printDoubleArray, .-printDoubleArray
	.align	2
	.type	verify, @function
verify:
	add	sp,sp,-64
	sw	s0,60(sp)
	add	s0,sp,64
	sw	a0,-52(s0)
	sw	a1,-56(s0)
	sw	a2,-60(s0)
	sw	zero,-20(s0)
	j	.L4
.L8:
	lw	a5,-20(s0)
	sll	a5,a5,2
	lw	a4,-56(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-24(s0)
	lw	a5,-20(s0)
	add	a5,a5,1
	sll	a5,a5,2
	lw	a4,-56(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	sll	a5,a5,2
	lw	a4,-60(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-32(s0)
	lw	a5,-20(s0)
	add	a5,a5,1
	sll	a5,a5,2
	lw	a4,-60(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-36(s0)
	lw	a4,-24(s0)
	lw	a5,-32(s0)
	beq	a4,a5,.L5
	lw	a5,-20(s0)
	add	a5,a5,1
	j	.L6
.L5:
	lw	a4,-28(s0)
	lw	a5,-36(s0)
	beq	a4,a5,.L7
	lw	a5,-20(s0)
	add	a5,a5,2
	j	.L6
.L7:
	lw	a5,-20(s0)
	add	a5,a5,2
	sw	a5,-20(s0)
.L4:
	lw	a5,-52(s0)
	srl	a4,a5,31
	add	a5,a4,a5
	sra	a5,a5,1
	sll	a4,a5,1
	lw	a5,-20(s0)
	bgt	a4,a5,.L8
	lw	a5,-52(s0)
	and	a5,a5,1
	beqz	a5,.L9
	lw	a4,-52(s0)
	li	a5,1073741824
	add	a5,a5,-1
	add	a5,a4,a5
	sll	a5,a5,2
	lw	a4,-56(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a3,-52(s0)
	li	a5,1073741824
	add	a5,a5,-1
	add	a5,a3,a5
	sll	a5,a5,2
	lw	a3,-60(s0)
	add	a5,a3,a5
	lw	a5,0(a5)
	beq	a4,a5,.L9
	lw	a5,-52(s0)
	j	.L6
.L9:
	li	a5,0
.L6:
	mv	a0,a5
	lw	s0,60(sp)
	add	sp,sp,64
	jr	ra
	.size	verify, .-verify
	.globl	__eqdf2
	.globl	__nedf2
	.align	2
	.type	verifyDouble, @function
verifyDouble:
	add	sp,sp,-80
	sw	ra,76(sp)
	sw	s0,72(sp)
	sw	s1,68(sp)
	add	s0,sp,80
	sw	a0,-68(s0)
	sw	a1,-72(s0)
	sw	a2,-76(s0)
	sw	zero,-20(s0)
	j	.L11
.L16:
	lw	a5,-20(s0)
	sll	a5,a5,3
	lw	a4,-72(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,4(a5)
	sw	a4,-32(s0)
	sw	a5,-28(s0)
	lw	a5,-20(s0)
	add	a5,a5,1
	sll	a5,a5,3
	lw	a4,-72(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,4(a5)
	sw	a4,-40(s0)
	sw	a5,-36(s0)
	lw	a5,-20(s0)
	sll	a5,a5,3
	lw	a4,-76(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,4(a5)
	sw	a4,-48(s0)
	sw	a5,-44(s0)
	lw	a5,-20(s0)
	add	a5,a5,1
	sll	a5,a5,3
	lw	a4,-76(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,4(a5)
	sw	a4,-56(s0)
	sw	a5,-52(s0)
	li	s1,1
	lw	a2,-48(s0)
	lw	a3,-44(s0)
	lw	a0,-32(s0)
	lw	a1,-28(s0)
	call	__eqdf2
	mv	a5,a0
	beqz	a5,.L12
	li	s1,0
.L12:
	and	a5,s1,0xff
	sw	a5,-60(s0)
	li	s1,1
	lw	a2,-56(s0)
	lw	a3,-52(s0)
	lw	a0,-40(s0)
	lw	a1,-36(s0)
	call	__eqdf2
	mv	a5,a0
	beqz	a5,.L13
	li	s1,0
.L13:
	and	a5,s1,0xff
	sw	a5,-64(s0)
	lw	a4,-60(s0)
	lw	a5,-64(s0)
	and	a5,a4,a5
	bnez	a5,.L14
	lw	a5,-20(s0)
	add	a4,a5,1
	lw	a5,-60(s0)
	add	a5,a4,a5
	j	.L15
.L14:
	lw	a5,-20(s0)
	add	a5,a5,2
	sw	a5,-20(s0)
.L11:
	lw	a5,-68(s0)
	srl	a4,a5,31
	add	a5,a4,a5
	sra	a5,a5,1
	sll	a4,a5,1
	lw	a5,-20(s0)
	bgt	a4,a5,.L16
	lw	a5,-68(s0)
	and	a5,a5,1
	beqz	a5,.L17
	lw	a4,-68(s0)
	li	a5,536870912
	add	a5,a5,-1
	add	a5,a4,a5
	sll	a5,a5,3
	lw	a4,-72(s0)
	add	a5,a4,a5
	lw	a0,0(a5)
	lw	a1,4(a5)
	lw	a4,-68(s0)
	li	a5,536870912
	add	a5,a5,-1
	add	a5,a4,a5
	sll	a5,a5,3
	lw	a4,-76(s0)
	add	a5,a4,a5
	lw	a4,0(a5)
	lw	a5,4(a5)
	mv	a2,a4
	mv	a3,a5
	call	__nedf2
	mv	a5,a0
	beqz	a5,.L17
	lw	a5,-68(s0)
	j	.L15
.L17:
	li	a5,0
.L15:
	mv	a0,a5
	lw	ra,76(sp)
	lw	s0,72(sp)
	lw	s1,68(sp)
	add	sp,sp,80
	jr	ra
	.size	verifyDouble, .-verifyDouble
	.section	.tbss,"awT",@nobits
	.align	2
	.type	threadsense.2573, @object
	.size	threadsense.2573, 4
threadsense.2573:
	.zero	4
	.text
	.align	2
	.type	barrier, @function
barrier:
	add	sp,sp,-32
	sw	s0,28(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	fence rw,rw
	lui	a5,%tprel_hi(threadsense.2573)
	add	a5,a5,tp,%tprel_add(threadsense.2573)
	lw	a5,%tprel_lo(threadsense.2573)(a5)
	seqz	a5,a5
	and	a5,a5,0xff
	mv	a4,a5
	lui	a5,%tprel_hi(threadsense.2573)
	add	a5,a5,tp,%tprel_add(threadsense.2573)
	sw	a4,%tprel_lo(threadsense.2573)(a5)
	lui	a5,%hi(count.2572)
	li	a4,1
	add	a5,a5,%lo(count.2572)
	fence rw,w; amoadd.w.aq a3,a4,0(a5)
	mv	a4,a3
	lw	a5,-20(s0)
	add	a5,a5,-1
	bne	a4,a5,.L24
	lui	a5,%hi(count.2572)
	sw	zero,%lo(count.2572)(a5)
	lui	a5,%tprel_hi(threadsense.2573)
	add	a5,a5,tp,%tprel_add(threadsense.2573)
	lw	a4,%tprel_lo(threadsense.2573)(a5)
	lui	a5,%hi(sense.2571)
	sw	a4,%lo(sense.2571)(a5)
	j	.L22
.L24:
	nop
.L23:
	lui	a5,%hi(sense.2571)
	lw	a4,%lo(sense.2571)(a5)
	lui	a5,%tprel_hi(threadsense.2573)
	add	a5,a5,tp,%tprel_add(threadsense.2573)
	lw	a5,%tprel_lo(threadsense.2573)(a5)
	bne	a4,a5,.L23
.L22:
	fence rw,rw
	nop
	lw	s0,28(sp)
	add	sp,sp,32
	jr	ra
	.size	barrier, .-barrier
	.align	2
	.type	lfsr, @function
lfsr:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-40(s0)
	sw	a1,-36(s0)
	lw	a5,-36(s0)
	sll	a5,a5,31
	lw	a4,-40(s0)
	srl	t5,a4,1
	or	t5,a5,t5
	lw	a5,-36(s0)
	srl	t6,a5,1
	lw	a5,-40(s0)
	xor	t3,a5,t5
	lw	a5,-36(s0)
	xor	t4,a5,t6
	and	a5,t3,1
	sw	a5,-24(s0)
	and	a5,t4,0
	sw	a5,-20(s0)
	lw	a5,-36(s0)
	sll	a5,a5,31
	lw	a4,-40(s0)
	srl	t1,a4,1
	or	t1,a5,t1
	lw	a5,-36(s0)
	srl	t2,a5,1
	lw	a5,-24(s0)
	sll	a7,a5,30
	li	a6,0
	or	a2,t1,a6
	or	a3,t2,a7
	mv	a4,a2
	mv	a5,a3
	mv	a0,a4
	mv	a1,a5
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	lfsr, .-lfsr
	.align	2
	.type	handle_frontend_syscall, @function
handle_frontend_syscall:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-20(s0)
	sw	a2,-32(s0)
	sw	a3,-28(s0)
	sw	a4,-40(s0)
	sw	a5,-36(s0)
	sw	a6,-48(s0)
	sw	a7,-44(s0)
	add	sp,sp,-128
	mv	a5,sp
	add	a5,a5,63
	srl	a5,a5,6
	sll	a5,a5,6
	lw	a4,-20(s0)
	mv	t3,a4
	li	t4,0
	sw	t3,0(a5)
	sw	t4,4(a5)
	lw	a2,-32(s0)
	lw	a3,-28(s0)
	sw	a2,8(a5)
	sw	a3,12(a5)
	lw	a2,-40(s0)
	lw	a3,-36(s0)
	sw	a2,16(a5)
	sw	a3,20(a5)
	lw	a2,-48(s0)
	lw	a3,-44(s0)
	sw	a2,24(a5)
	sw	a3,28(a5)
	fence rw,rw
	mv	a4,a5
	mv	t1,a4
	li	t2,0
	lui	a4,%hi(tohost)
	sw	t1,%lo(tohost)(a4)
	sw	t2,%lo(tohost+4)(a4)
	nop
.L28:
	lui	a4,%hi(fromhost)
	lw	a2,%lo(fromhost)(a4)
	lw	a3,%lo(fromhost+4)(a4)
	mv	a4,a2
	or	a4,a4,a3
	beqz	a4,.L28
	lui	a4,%hi(fromhost)
	li	a2,0
	li	a3,0
	sw	a2,%lo(fromhost)(a4)
	sw	a3,%lo(fromhost+4)(a4)
	fence rw,rw
	lw	a4,0(a5)
	lw	a5,4(a5)
	mv	a5,a4
	mv	a0,a5
	add	sp,s0,-48
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	handle_frontend_syscall, .-handle_frontend_syscall
	.local	counters
	.comm	counters,8,4
	.local	counter_names
	.comm	counter_names,8,4
	.section	.rodata
	.align	2
.LC0:
	.string	"mcycle"
	.align	2
.LC1:
	.string	"minstret"
	.text
	.align	2
	.type	handle_stats, @function
handle_stats:
	add	sp,sp,-64
	sw	s0,60(sp)
	add	s0,sp,64
	sw	a0,-52(s0)
	sw	zero,-28(s0)
.L32:
	lw	a4,-28(s0)
	li	a5,1
	bgt	a4,a5,.L32
 #APP
# 49 "bare/syscalls.c" 1
	csrr a5, mcycle
# 0 "" 2
 #NO_APP
	sw	a5,-32(s0)
	lw	a5,-32(s0)
	sw	a5,-20(s0)
	lw	a5,-52(s0)
	bnez	a5,.L33
	lui	a5,%hi(counters)
	lw	a4,-28(s0)
	sll	a4,a4,2
	add	a5,a5,%lo(counters)
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a4,-20(s0)
	sub	a5,a4,a5
	sw	a5,-20(s0)
	lui	a5,%hi(counter_names)
	lw	a4,-28(s0)
	sll	a4,a4,2
	add	a5,a5,%lo(counter_names)
	add	a5,a4,a5
	lui	a4,%hi(.LC0)
	add	a4,a4,%lo(.LC0)
	sw	a4,0(a5)
.L33:
	lw	a5,-28(s0)
	add	a4,a5,1
	sw	a4,-28(s0)
	lui	a3,%hi(counters)
	sll	a4,a5,2
	add	a5,a3,%lo(counters)
	add	a5,a4,a5
	lw	a4,-20(s0)
	sw	a4,0(a5)
.L34:
	lw	a4,-28(s0)
	li	a5,1
	bgt	a4,a5,.L34
 #APP
# 50 "bare/syscalls.c" 1
	csrr a5, minstret
# 0 "" 2
 #NO_APP
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	sw	a5,-24(s0)
	lw	a5,-52(s0)
	bnez	a5,.L35
	lui	a5,%hi(counters)
	lw	a4,-28(s0)
	sll	a4,a4,2
	add	a5,a5,%lo(counters)
	add	a5,a4,a5
	lw	a5,0(a5)
	lw	a4,-24(s0)
	sub	a5,a4,a5
	sw	a5,-24(s0)
	lui	a5,%hi(counter_names)
	lw	a4,-28(s0)
	sll	a4,a4,2
	add	a5,a5,%lo(counter_names)
	add	a5,a4,a5
	lui	a4,%hi(.LC1)
	add	a4,a4,%lo(.LC1)
	sw	a4,0(a5)
.L35:
	lw	a5,-28(s0)
	add	a4,a5,1
	sw	a4,-28(s0)
	lui	a3,%hi(counters)
	sll	a4,a5,2
	add	a5,a3,%lo(counters)
	add	a5,a4,a5
	lw	a4,-24(s0)
	sw	a4,0(a5)
	li	a5,0
	mv	a0,a5
	lw	s0,60(sp)
	add	sp,sp,64
	jr	ra
	.size	handle_stats, .-handle_stats
	.align	2
	.globl	tohost_exit
	.type	tohost_exit, @function
tohost_exit:
	add	sp,sp,-32
	sw	s0,28(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	sll	a5,a5,1
	or	a5,a5,1
	mv	a2,a5
	li	a3,0
	lui	a5,%hi(tohost)
	sw	a2,%lo(tohost)(a5)
	sw	a3,%lo(tohost+4)(a5)
.L38:
	j	.L38
	.size	tohost_exit, .-tohost_exit
	.align	2
	.globl	handle_trap
	.type	handle_trap, @function
handle_trap:
	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	sw	a2,-28(s0)
	lw	a4,-20(s0)
	li	a5,11
	beq	a4,a5,.L40
	li	a0,1337
	call	tohost_exit
.L40:
	lw	a5,-28(s0)
	add	a5,a5,68
	lw	a4,0(a5)
	li	a5,93
	bne	a4,a5,.L41
	lw	a5,-28(s0)
	add	a5,a5,40
	lw	a5,0(a5)
	mv	a0,a5
	call	tohost_exit
.L41:
	lw	a5,-28(s0)
	add	a5,a5,68
	lw	a4,0(a5)
	li	a5,1234
	bne	a4,a5,.L42
	lw	a5,-28(s0)
	add	s1,a5,40
	lw	a5,-28(s0)
	add	a5,a5,40
	lw	a5,0(a5)
	mv	a0,a5
	call	handle_stats
	mv	a5,a0
	sw	a5,0(s1)
	j	.L43
.L42:
	lw	a5,-28(s0)
	add	s1,a5,40
	lw	a5,-28(s0)
	add	a5,a5,68
	lw	a1,0(a5)
	lw	a5,-28(s0)
	add	a5,a5,40
	lw	a5,0(a5)
	mv	t1,a5
	li	t2,0
	lw	a5,-28(s0)
	add	a5,a5,44
	lw	a5,0(a5)
	mv	t3,a5
	li	t4,0
	lw	a5,-28(s0)
	add	a5,a5,48
	lw	a5,0(a5)
	mv	a6,a5
	li	a7,0
	mv	a4,t3
	mv	a5,t4
	mv	a2,t1
	mv	a3,t2
	mv	a0,a1
	call	handle_frontend_syscall
	mv	a5,a0
	sw	a5,0(s1)
.L43:
	lw	a5,-24(s0)
	lhu	a5,0(a5)
	and	a4,a5,3
	li	a5,3
	bne	a4,a5,.L44
	li	a5,4
	j	.L45
.L44:
	li	a5,2
.L45:
	lw	a4,-24(s0)
	add	a5,a5,a4
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	add	sp,sp,32
	jr	ra
	.size	handle_trap, .-handle_trap
	.align	2
	.type	syscall, @function
syscall:
	add	sp,sp,-32
	sw	s0,28(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	sw	a2,-28(s0)
	sw	a3,-32(s0)
	lw	a7,-20(s0)
	lw	a0,-24(s0)
	lw	a1,-28(s0)
	lw	a2,-32(s0)
 #APP
# 82 "bare/syscalls.c" 1
	scall
# 0 "" 2
 #NO_APP
	mv	a5,a0
	mv	a0,a5
	lw	s0,28(sp)
	add	sp,sp,32
	jr	ra
	.size	syscall, .-syscall
	.align	2
	.globl	exit
	.type	exit, @function
exit:
	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	li	a3,0
	li	a2,0
	mv	a1,a5
	li	a0,93
	call	syscall
.L50:
	j	.L50
	.size	exit, .-exit
	.align	2
	.globl	setStats
	.type	setStats, @function
setStats:
	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	li	a3,0
	li	a2,0
	mv	a1,a5
	li	a0,1234
	call	syscall
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	add	sp,sp,32
	jr	ra
	.size	setStats, .-setStats
	.align	2
	.globl	printstr
	.type	printstr, @function
printstr:
	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s1,20(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	lw	s1,-20(s0)
	lw	a0,-20(s0)
	call	sc_strlen
	mv	a5,a0
	mv	a3,a5
	mv	a2,s1
	li	a1,1
	li	a0,64
	call	syscall
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	add	sp,sp,32
	jr	ra
	.size	printstr, .-printstr
	.align	2
	.weak	thread_entry
	.type	thread_entry, @function
thread_entry:
	add	sp,sp,-32
	sw	s0,28(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
.L54:
	lw	a5,-20(s0)
	bnez	a5,.L54
	nop
	lw	s0,28(sp)
	add	sp,sp,32
	jr	ra
	.size	thread_entry, .-thread_entry
	.section	.rodata
	.align	2
.LC2:
	.string	"Implement main(), foo!\n"
	.text
	.align	2
	.weak	main
	.type	main, @function
main:
	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	lui	a5,%hi(.LC2)
	add	a0,a5,%lo(.LC2)
	call	printstr
	li	a5,-1
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	add	sp,sp,32
	jr	ra
	.size	main, .-main
	.align	2
	.type	init_tls, @function
init_tls:
	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	add	s0,sp,32
	lui	a5,%tprel_hi(_tdata_end)
	add	a5,a5,tp,%tprel_add(_tdata_end)
	add	a4,a5,%tprel_lo(_tdata_end)
	lui	a5,%tprel_hi(_tdata_begin)
	add	a5,a5,tp,%tprel_add(_tdata_begin)
	add	a5,a5,%tprel_lo(_tdata_begin)
	sub	a5,a4,a5
	sw	a5,-20(s0)
	mv	a4,tp
	lw	a2,-20(s0)
	lui	a5,%hi(_tls_data)
	add	a1,a5,%lo(_tls_data)
	mv	a0,a4
	call	sc_memcpy
	lui	a5,%tprel_hi(_tbss_end)
	add	a5,a5,tp,%tprel_add(_tbss_end)
	add	a4,a5,%tprel_lo(_tbss_end)
	lui	a5,%tprel_hi(_tdata_end)
	add	a5,a5,tp,%tprel_add(_tdata_end)
	add	a5,a5,%tprel_lo(_tdata_end)
	sub	a5,a4,a5
	sw	a5,-24(s0)
	mv	a4,tp
	lw	a5,-20(s0)
	add	a5,a4,a5
	lw	a2,-24(s0)
	li	a1,0
	mv	a0,a5
	call	memset
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	add	sp,sp,32
	jr	ra
	.size	init_tls, .-init_tls
	.section	.rodata
	.align	2
.LC3:
	.string	"%s = %d\n"
	.text
	.align	2
	.globl	_init
	.type	_init, @function
_init:
	add	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	s1,36(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	add	sp,sp,-128
	mv	a5,sp
	add	a5,a5,63
	srl	a5,a5,6
	sll	s1,a5,6
	call	init_tls
	lw	a1,-40(s0)
	lw	a0,-36(s0)
	call	thread_entry
	li	a1,0
	li	a0,0
	call	main
	sw	a0,-28(s0)
	sw	s1,-20(s0)
	sw	zero,-24(s0)
	j	.L59
.L61:
	lui	a5,%hi(counters)
	lw	a4,-24(s0)
	sll	a4,a4,2
	add	a5,a5,%lo(counters)
	add	a5,a4,a5
	lw	a5,0(a5)
	beqz	a5,.L60
	lui	a5,%hi(counter_names)
	lw	a4,-24(s0)
	sll	a4,a4,2
	add	a5,a5,%lo(counter_names)
	add	a5,a4,a5
	lw	a2,0(a5)
	lui	a5,%hi(counters)
	lw	a4,-24(s0)
	sll	a4,a4,2
	add	a5,a5,%lo(counters)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a3,a5
	lui	a5,%hi(.LC3)
	add	a1,a5,%lo(.LC3)
	lw	a0,-20(s0)
	call	sprintf
	mv	a5,a0
	mv	a4,a5
	lw	a5,-20(s0)
	add	a5,a5,a4
	sw	a5,-20(s0)
.L60:
	lw	a5,-24(s0)
	add	a5,a5,1
	sw	a5,-24(s0)
.L59:
	lw	a4,-24(s0)
	li	a5,1
	ble	a4,a5,.L61
	lw	a5,-20(s0)
	beq	s1,a5,.L62
	mv	a0,s1
	call	printstr
.L62:
	lw	a0,-28(s0)
	call	exit
	.size	_init, .-_init
	.section	.tbss
	.align	6
	.type	buf.2678, @object
	.size	buf.2678, 64
buf.2678:
	.zero	64
	.align	2
	.type	buflen.2679, @object
	.size	buflen.2679, 4
buflen.2679:
	.zero	4
	.text
	.align	2
	.globl	putchar
	.type	putchar, @function
putchar:
	add	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	lui	a5,%tprel_hi(buflen.2679)
	add	a5,a5,tp,%tprel_add(buflen.2679)
	lw	a5,%tprel_lo(buflen.2679)(a5)
	add	a3,a5,1
	lui	a4,%tprel_hi(buflen.2679)
	add	a4,a4,tp,%tprel_add(buflen.2679)
	sw	a3,%tprel_lo(buflen.2679)(a4)
	lw	a4,-20(s0)
	and	a4,a4,0xff
	lui	a3,%tprel_hi(buf.2678)
	add	a3,a3,tp,%tprel_add(buf.2678)
	add	a3,a3,%tprel_lo(buf.2678)
	add	a5,a5,a3
	sb	a4,0(a5)
	lw	a4,-20(s0)
	li	a5,10
	beq	a4,a5,.L64
	lui	a5,%tprel_hi(buflen.2679)
	add	a5,a5,tp,%tprel_add(buflen.2679)
	lw	a4,%tprel_lo(buflen.2679)(a5)
	li	a5,64
	bne	a4,a5,.L65
.L64:
	lui	a5,%tprel_hi(buf.2678)
	add	a5,a5,tp,%tprel_add(buf.2678)
	add	a4,a5,%tprel_lo(buf.2678)
	lui	a5,%tprel_hi(buflen.2679)
	add	a5,a5,tp,%tprel_add(buflen.2679)
	lw	a5,%tprel_lo(buflen.2679)(a5)
	mv	a3,a5
	mv	a2,a4
	li	a1,1
	li	a0,64
	call	syscall
	lui	a5,%tprel_hi(buflen.2679)
	add	a5,a5,tp,%tprel_add(buflen.2679)
	sw	zero,%tprel_lo(buflen.2679)(a5)
.L65:
	li	a5,0
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	add	sp,sp,32
	jr	ra
	.size	putchar, .-putchar
	.align	2
	.globl	printhex
	.type	printhex, @function
printhex:
	add	sp,sp,-64
	sw	ra,60(sp)
	sw	s0,56(sp)
	add	s0,sp,64
	sw	a0,-56(s0)
	sw	a1,-52(s0)
	sw	zero,-20(s0)
	j	.L68
.L72:
	li	a4,15
	lw	a5,-20(s0)
	sub	a3,a4,a5
	lbu	a5,-56(s0)
	and	a5,a5,15
	and	a4,a5,0xff
	lw	a5,-56(s0)
	and	a6,a5,15
	lw	a5,-52(s0)
	and	a7,a5,0
	bnez	a7,.L69
	bnez	a7,.L73
	li	a5,9
	bgtu	a6,a5,.L69
.L73:
	li	a5,48
	j	.L71
.L69:
	li	a5,87
.L71:
	add	a5,a4,a5
	and	a4,a5,0xff
	add	a5,s0,-16
	add	a5,a5,a3
	sb	a4,-24(a5)
	lw	a5,-52(s0)
	sll	a5,a5,28
	lw	a4,-56(s0)
	srl	a4,a4,4
	or	a5,a4,a5
	sw	a5,-56(s0)
	lw	a5,-52(s0)
	srl	a5,a5,4
	sw	a5,-52(s0)
	lw	a5,-20(s0)
	add	a5,a5,1
	sw	a5,-20(s0)
.L68:
	lw	a4,-20(s0)
	li	a5,15
	ble	a4,a5,.L72
	sb	zero,-24(s0)
	add	a5,s0,-40
	mv	a0,a5
	call	printstr
	nop
	lw	ra,60(sp)
	lw	s0,56(sp)
	add	sp,sp,64
	jr	ra
	.size	printhex, .-printhex
	.globl	__umoddi3
	.globl	__udivdi3
	.align	2
	.type	printnum, @function
printnum:
	add	sp,sp,-352
	sw	ra,348(sp)
	sw	s0,344(sp)
	sw	s1,340(sp)
	sw	s2,336(sp)
	sw	s3,332(sp)
	sw	s4,328(sp)
	sw	s5,324(sp)
	sw	s6,320(sp)
	sw	s7,316(sp)
	add	s0,sp,352
	sw	a0,-324(s0)
	sw	a1,-328(s0)
	sw	a2,-336(s0)
	sw	a3,-332(s0)
	sw	a4,-340(s0)
	sw	a5,-344(s0)
	sw	a6,-348(s0)
	sw	zero,-52(s0)
.L78:
	lw	s1,-52(s0)
	add	a5,s1,1
	sw	a5,-52(s0)
	lw	a5,-340(s0)
	mv	s4,a5
	li	s5,0
	lw	a4,-336(s0)
	lw	a5,-332(s0)
	mv	a2,s4
	mv	a3,s5
	mv	a0,a4
	mv	a1,a5
	call	__umoddi3
	mv	a4,a0
	mv	a5,a1
	sll	a5,s1,2
	add	a3,s0,-48
	add	a5,a3,a5
	sw	a4,-260(a5)
	lw	a5,-340(s0)
	mv	s6,a5
	li	s7,0
	lw	a5,-332(s0)
	mv	a4,s7
	bltu	a5,a4,.L85
	lw	a5,-332(s0)
	mv	a4,s7
	bne	a5,a4,.L75
	lw	a5,-336(s0)
	mv	a4,s6
	bltu	a5,a4,.L85
.L75:
	lw	a5,-340(s0)
	mv	s2,a5
	li	s3,0
	mv	a2,s2
	mv	a3,s3
	lw	a0,-336(s0)
	lw	a1,-332(s0)
	call	__udivdi3
	mv	a4,a0
	mv	a5,a1
	sw	a4,-336(s0)
	sw	a5,-332(s0)
	j	.L78
.L85:
	nop
	j	.L79
.L80:
	lw	a5,-324(s0)
	lw	a1,-328(s0)
	lw	a0,-348(s0)
	jalr	a5
.L79:
	lw	a5,-344(s0)
	add	a4,a5,-1
	sw	a4,-344(s0)
	lw	a4,-52(s0)
	bgt	a5,a4,.L80
	j	.L81
.L84:
	lw	a5,-52(s0)
	sll	a5,a5,2
	add	a4,s0,-48
	add	a5,a4,a5
	lw	a4,-260(a5)
	lw	a5,-52(s0)
	sll	a5,a5,2
	add	a3,s0,-48
	add	a5,a3,a5
	lw	a3,-260(a5)
	li	a5,9
	bleu	a3,a5,.L82
	li	a5,87
	j	.L83
.L82:
	li	a5,48
.L83:
	add	a5,a4,a5
	lw	a4,-324(s0)
	lw	a1,-328(s0)
	mv	a0,a5
	jalr	a4
.L81:
	lw	a5,-52(s0)
	add	a4,a5,-1
	sw	a4,-52(s0)
	bgtz	a5,.L84
	nop
	lw	ra,348(sp)
	lw	s0,344(sp)
	lw	s1,340(sp)
	lw	s2,336(sp)
	lw	s3,332(sp)
	lw	s4,328(sp)
	lw	s5,324(sp)
	lw	s6,320(sp)
	lw	s7,316(sp)
	add	sp,sp,352
	jr	ra
	.size	printnum, .-printnum
	.align	2
	.type	getuint, @function
getuint:
	add	sp,sp,-32
	sw	s0,28(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	lw	a4,-24(s0)
	li	a5,1
	ble	a4,a5,.L87
	lw	a5,-20(s0)
	lw	a5,0(a5)
	add	a5,a5,7
	and	a5,a5,-8
	add	a3,a5,8
	lw	a4,-20(s0)
	sw	a3,0(a4)
	lw	a6,0(a5)
	lw	a7,4(a5)
	j	.L88
.L87:
	lw	a5,-24(s0)
	beqz	a5,.L89
	lw	a5,-20(s0)
	lw	a5,0(a5)
	add	a3,a5,4
	lw	a4,-20(s0)
	sw	a3,0(a4)
	lw	a5,0(a5)
	mv	a6,a5
	li	a7,0
	j	.L88
.L89:
	lw	a5,-20(s0)
	lw	a5,0(a5)
	add	a3,a5,4
	lw	a4,-20(s0)
	sw	a3,0(a4)
	lw	a5,0(a5)
	mv	a6,a5
	li	a7,0
.L88:
	mv	a4,a6
	mv	a5,a7
	mv	a0,a4
	mv	a1,a5
	lw	s0,28(sp)
	add	sp,sp,32
	jr	ra
	.size	getuint, .-getuint
	.align	2
	.type	getint, @function
getint:
	add	sp,sp,-32
	sw	s0,28(sp)
	add	s0,sp,32
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	lw	a4,-24(s0)
	li	a5,1
	ble	a4,a5,.L91
	lw	a5,-20(s0)
	lw	a5,0(a5)
	add	a5,a5,7
	and	a5,a5,-8
	add	a3,a5,8
	lw	a4,-20(s0)
	sw	a3,0(a4)
	lw	a6,0(a5)
	lw	a7,4(a5)
	j	.L92
.L91:
	lw	a5,-24(s0)
	beqz	a5,.L93
	lw	a5,-20(s0)
	lw	a5,0(a5)
	add	a3,a5,4
	lw	a4,-20(s0)
	sw	a3,0(a4)
	lw	a5,0(a5)
	mv	a6,a5
	sra	a5,a5,31
	mv	a7,a5
	j	.L92
.L93:
	lw	a5,-20(s0)
	lw	a5,0(a5)
	add	a3,a5,4
	lw	a4,-20(s0)
	sw	a3,0(a4)
	lw	a5,0(a5)
	mv	a6,a5
	sra	a5,a5,31
	mv	a7,a5
.L92:
	mv	a4,a6
	mv	a5,a7
	mv	a0,a4
	mv	a1,a5
	lw	s0,28(sp)
	add	sp,sp,32
	jr	ra
	.size	getint, .-getint
	.section	.rodata
	.align	2
.LC4:
	.string	"(null)"
	.text
	.align	2
	.type	vprintfmt, @function
vprintfmt:
	add	sp,sp,-80
	sw	ra,76(sp)
	sw	s0,72(sp)
	sw	s1,68(sp)
	sw	s2,64(sp)
	add	s0,sp,80
	sw	a0,-68(s0)
	sw	a1,-72(s0)
	sw	a2,-76(s0)
	sw	a3,-80(s0)
	j	.L95
.L98:
	beqz	s1,.L138
	lw	a5,-76(s0)
	add	a5,a5,1
	sw	a5,-76(s0)
	lw	a5,-68(s0)
	lw	a1,-72(s0)
	mv	a0,s1
	jalr	a5
.L95:
	lw	a5,-76(s0)
	lbu	a5,0(a5)
	mv	s1,a5
	li	a5,37
	bne	s1,a5,.L98
	lw	a5,-76(s0)
	add	a5,a5,1
	sw	a5,-76(s0)
	lw	a5,-76(s0)
	sw	a5,-48(s0)
	li	a5,32
	sb	a5,-41(s0)
	li	a5,-1
	sw	a5,-36(s0)
	li	a5,-1
	sw	a5,-40(s0)
	sw	zero,-32(s0)
	sw	zero,-52(s0)
.L99:
	lw	a5,-76(s0)
	add	a4,a5,1
	sw	a4,-76(s0)
	lbu	a5,0(a5)
	mv	s1,a5
	add	a5,s1,-35
	li	a4,85
	bgtu	a5,a4,.L100
	sll	a4,a5,2
	lui	a5,%hi(.L102)
	add	a5,a5,%lo(.L102)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L102:
	.word	.L101
	.word	.L100
	.word	.L103
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L104
	.word	.L100
	.word	.L100
	.word	.L105
	.word	.L106
	.word	.L100
	.word	.L107
	.word	.L108
	.word	.L108
	.word	.L108
	.word	.L108
	.word	.L108
	.word	.L108
	.word	.L108
	.word	.L108
	.word	.L108
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L109
	.word	.L110
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L100
	.word	.L111
	.word	.L100
	.word	.L100
	.word	.L112
	.word	.L113
	.word	.L100
	.word	.L100
	.word	.L114
	.word	.L100
	.word	.L115
	.word	.L100
	.word	.L100
	.word	.L116
	.text
.L105:
	li	a5,45
	sb	a5,-41(s0)
	j	.L99
.L107:
	li	a5,48
	sb	a5,-41(s0)
	j	.L99
.L108:
	sw	zero,-40(s0)
.L118:
	lw	a4,-40(s0)
	mv	a5,a4
	sll	a5,a5,2
	add	a5,a5,a4
	sll	a5,a5,1
	add	a5,a5,s1
	add	a5,a5,-48
	sw	a5,-40(s0)
	lw	a5,-76(s0)
	lbu	a5,0(a5)
	mv	s1,a5
	li	a5,47
	ble	s1,a5,.L139
	li	a5,57
	bgt	s1,a5,.L139
	lw	a5,-76(s0)
	add	a5,a5,1
	sw	a5,-76(s0)
	j	.L118
.L104:
	lw	a5,-80(s0)
	add	a4,a5,4
	sw	a4,-80(s0)
	lw	a5,0(a5)
	sw	a5,-40(s0)
	j	.L119
.L106:
	lw	a5,-36(s0)
	bgez	a5,.L99
	sw	zero,-36(s0)
	j	.L99
.L101:
	li	a5,1
	sw	a5,-52(s0)
	j	.L99
.L139:
	nop
.L119:
	lw	a5,-36(s0)
	bgez	a5,.L99
	lw	a5,-40(s0)
	sw	a5,-36(s0)
	li	a5,-1
	sw	a5,-40(s0)
	j	.L99
.L111:
	lw	a5,-32(s0)
	add	a5,a5,1
	sw	a5,-32(s0)
	j	.L99
.L109:
	lw	a5,-80(s0)
	add	a4,a5,4
	sw	a4,-80(s0)
	lw	a5,0(a5)
	lw	a4,-68(s0)
	lw	a1,-72(s0)
	mv	a0,a5
	jalr	a4
	j	.L122
.L114:
	lw	a5,-80(s0)
	add	a4,a5,4
	sw	a4,-80(s0)
	lw	s2,0(a5)
	bnez	s2,.L123
	lui	a5,%hi(.LC4)
	add	s2,a5,%lo(.LC4)
.L123:
	lw	a5,-36(s0)
	blez	a5,.L127
	lbu	a4,-41(s0)
	li	a5,45
	beq	a4,a5,.L127
	lw	a5,-40(s0)
	mv	a1,a5
	mv	a0,s2
	call	strnlen
	mv	a4,a0
	lw	a5,-36(s0)
	sub	a5,a5,a4
	sw	a5,-36(s0)
	j	.L125
.L126:
	lbu	a5,-41(s0)
	lw	a4,-68(s0)
	lw	a1,-72(s0)
	mv	a0,a5
	jalr	a4
	lw	a5,-36(s0)
	add	a5,a5,-1
	sw	a5,-36(s0)
.L125:
	lw	a5,-36(s0)
	bgtz	a5,.L126
	j	.L127
.L129:
	lw	a5,-68(s0)
	lw	a1,-72(s0)
	mv	a0,s1
	jalr	a5
	add	s2,s2,1
	lw	a5,-36(s0)
	add	a5,a5,-1
	sw	a5,-36(s0)
.L127:
	lbu	a5,0(s2)
	mv	s1,a5
	beqz	s1,.L130
	lw	a5,-40(s0)
	bltz	a5,.L129
	lw	a5,-40(s0)
	add	a5,a5,-1
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	bgez	a5,.L129
	j	.L130
.L131:
	lw	a5,-68(s0)
	lw	a1,-72(s0)
	li	a0,32
	jalr	a5
	lw	a5,-36(s0)
	add	a5,a5,-1
	sw	a5,-36(s0)
.L130:
	lw	a5,-36(s0)
	bgtz	a5,.L131
	j	.L122
.L110:
	add	a5,s0,-80
	lw	a1,-32(s0)
	mv	a0,a5
	call	getint
	mv	a4,a0
	mv	a5,a1
	sw	a4,-24(s0)
	sw	a5,-20(s0)
	lw	a4,-24(s0)
	lw	a5,-20(s0)
	bgez	a5,.L132
	lw	a5,-68(s0)
	lw	a1,-72(s0)
	li	a0,45
	jalr	a5
	lw	a0,-24(s0)
	lw	a1,-20(s0)
	li	a6,0
	li	a7,0
	sub	a2,a6,a0
	sltu	a5,a6,a2
	sub	a3,a7,a1
	sub	a5,a3,a5
	mv	a3,a5
	mv	a4,a2
	mv	a5,a3
	sw	a4,-24(s0)
	sw	a5,-20(s0)
.L132:
	li	a5,10
	sw	a5,-28(s0)
	j	.L134
.L115:
	li	a5,10
	sw	a5,-28(s0)
	j	.L135
.L112:
	li	a5,8
	sw	a5,-28(s0)
	j	.L135
.L113:
	li	a5,1
	sw	a5,-32(s0)
	lw	a5,-68(s0)
	lw	a1,-72(s0)
	li	a0,48
	jalr	a5
	lw	a5,-68(s0)
	lw	a1,-72(s0)
	li	a0,120
	jalr	a5
.L116:
	li	a5,16
	sw	a5,-28(s0)
.L135:
	add	a5,s0,-80
	lw	a1,-32(s0)
	mv	a0,a5
	call	getuint
	sw	a0,-24(s0)
	sw	a1,-20(s0)
.L134:
	lw	a4,-28(s0)
	lbu	a5,-41(s0)
	mv	a6,a5
	lw	a5,-36(s0)
	lw	a2,-24(s0)
	lw	a3,-20(s0)
	lw	a1,-72(s0)
	lw	a0,-68(s0)
	call	printnum
	j	.L122
.L103:
	lw	a5,-68(s0)
	lw	a1,-72(s0)
	mv	a0,s1
	jalr	a5
	j	.L122
.L100:
	lw	a5,-68(s0)
	lw	a1,-72(s0)
	li	a0,37
	jalr	a5
	lw	a5,-48(s0)
	sw	a5,-76(s0)
	nop
.L122:
	j	.L95
.L138:
	nop
	lw	ra,76(sp)
	lw	s0,72(sp)
	lw	s1,68(sp)
	lw	s2,64(sp)
	add	sp,sp,80
	jr	ra
	.size	vprintfmt, .-vprintfmt
	.align	2
	.globl	printf
	.type	printf, @function
printf:
	add	sp,sp,-80
	sw	ra,44(sp)
	sw	s0,40(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,4(s0)
	sw	a2,8(s0)
	sw	a3,12(s0)
	sw	a4,16(s0)
	sw	a5,20(s0)
	sw	a6,24(s0)
	sw	a7,28(s0)
	add	a5,s0,32
	add	a5,a5,-28
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a3,a5
	lw	a2,-36(s0)
	li	a1,0
	lui	a5,%hi(putchar)
	add	a0,a5,%lo(putchar)
	call	vprintfmt
	li	a5,0
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	add	sp,sp,80
	jr	ra
	.size	printf, .-printf
	.align	2
	.type	sprintf_putch.2793, @function
sprintf_putch.2793:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	t0,-44(s0)
	lw	a5,-40(s0)
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	lw	a5,0(a5)
	lw	a4,-36(s0)
	and	a4,a4,0xff
	sb	a4,0(a5)
	lw	a5,-20(s0)
	lw	a5,0(a5)
	add	a4,a5,1
	lw	a5,-20(s0)
	sw	a4,0(a5)
	nop
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	sprintf_putch.2793, .-sprintf_putch.2793
	.align	2
	.globl	sprintf
	.type	sprintf, @function
sprintf:
	add	sp,sp,-160
	sw	ra,124(sp)
	sw	s0,120(sp)
	add	s0,sp,128
	sw	a0,-116(s0)
	sw	a1,-120(s0)
	sw	a2,8(s0)
	sw	a3,12(s0)
	sw	a4,16(s0)
	sw	a5,20(s0)
	sw	a6,24(s0)
	sw	a7,28(s0)
	add	a5,s0,32
	sw	a5,-28(s0)
	add	a5,s0,-108
	add	a4,s0,-108
	li	a3,663
	sw	a3,0(a5)
	li	a3,21143552
	add	a3,a3,771
	sw	a3,4(a5)
	li	a3,16949248
	add	a3,a3,643
	sw	a3,8(a5)
	li	a3,196608
	add	a3,a3,103
	sw	a3,12(a5)
	sw	a4,16(a5)
	lui	a4,%hi(sprintf_putch.2793)
	add	a4,a4,%lo(sprintf_putch.2793)
	sw	a4,20(a5)
	fence.i
	lw	a5,-116(s0)
	sw	a5,-20(s0)
	add	a5,s0,32
	add	a5,a5,-24
	sw	a5,-24(s0)
	lw	a4,-24(s0)
	add	a5,s0,-108
	mv	a0,a5
	add	a5,s0,-116
	mv	a3,a4
	lw	a2,-120(s0)
	mv	a1,a5
	call	vprintfmt
	lw	a5,-116(s0)
	sb	zero,0(a5)
	lw	a5,-116(s0)
	mv	a4,a5
	lw	a5,-20(s0)
	sub	a5,a4,a5
	mv	a0,a5
	lw	ra,124(sp)
	lw	s0,120(sp)
	add	sp,sp,160
	jr	ra
	.size	sprintf, .-sprintf
	.align	2
	.globl	sc_memcpy
	.type	sc_memcpy, @function
sc_memcpy:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	a2,-44(s0)
	lw	a4,-36(s0)
	lw	a5,-40(s0)
	or	a4,a4,a5
	lw	a5,-44(s0)
	or	a5,a4,a5
	and	a5,a5,3
	bnez	a5,.L146
	lw	a5,-40(s0)
	sw	a5,-20(s0)
	lw	a5,-36(s0)
	sw	a5,-24(s0)
	j	.L147
.L148:
	lw	a5,-24(s0)
	add	a4,a5,4
	sw	a4,-24(s0)
	lw	a4,-20(s0)
	add	a3,a4,4
	sw	a3,-20(s0)
	lw	a4,0(a4)
	sw	a4,0(a5)
.L147:
	lw	a4,-36(s0)
	lw	a5,-44(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	bgtu	a4,a5,.L148
	j	.L149
.L146:
	lw	a5,-40(s0)
	sw	a5,-28(s0)
	lw	a5,-36(s0)
	sw	a5,-32(s0)
	j	.L150
.L151:
	lw	a5,-32(s0)
	add	a4,a5,1
	sw	a4,-32(s0)
	lw	a4,-28(s0)
	add	a3,a4,1
	sw	a3,-28(s0)
	lbu	a4,0(a4)
	sb	a4,0(a5)
.L150:
	lw	a4,-36(s0)
	lw	a5,-44(s0)
	add	a4,a4,a5
	lw	a5,-32(s0)
	bgtu	a4,a5,.L151
.L149:
	lw	a5,-36(s0)
	mv	a0,a5
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	sc_memcpy, .-sc_memcpy
	.align	2
	.globl	memset
	.type	memset, @function
memset:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	sw	a2,-44(s0)
	lw	a4,-36(s0)
	lw	a5,-44(s0)
	or	a5,a4,a5
	and	a5,a5,3
	bnez	a5,.L154
	lw	a5,-40(s0)
	and	a5,a5,255
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sll	a5,a5,8
	lw	a4,-28(s0)
	or	a5,a4,a5
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sll	a5,a5,16
	lw	a4,-28(s0)
	or	a5,a4,a5
	sw	a5,-28(s0)
	lw	a5,-36(s0)
	sw	a5,-20(s0)
	j	.L155
.L156:
	lw	a5,-20(s0)
	add	a4,a5,4
	sw	a4,-20(s0)
	lw	a4,-28(s0)
	sw	a4,0(a5)
.L155:
	lw	a4,-36(s0)
	lw	a5,-44(s0)
	add	a4,a4,a5
	lw	a5,-20(s0)
	bgtu	a4,a5,.L156
	j	.L157
.L154:
	lw	a5,-36(s0)
	sw	a5,-24(s0)
	j	.L158
.L159:
	lw	a5,-24(s0)
	add	a4,a5,1
	sw	a4,-24(s0)
	lw	a4,-40(s0)
	and	a4,a4,0xff
	sb	a4,0(a5)
.L158:
	lw	a4,-36(s0)
	lw	a5,-44(s0)
	add	a4,a4,a5
	lw	a5,-24(s0)
	bgtu	a4,a5,.L159
.L157:
	lw	a5,-36(s0)
	mv	a0,a5
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	memset, .-memset
	.align	2
	.globl	sc_strlen
	.type	sc_strlen, @function
sc_strlen:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	lw	a5,-36(s0)
	sw	a5,-20(s0)
	j	.L162
.L163:
	lw	a5,-20(s0)
	add	a5,a5,1
	sw	a5,-20(s0)
.L162:
	lw	a5,-20(s0)
	lbu	a5,0(a5)
	bnez	a5,.L163
	lw	a4,-20(s0)
	lw	a5,-36(s0)
	sub	a5,a4,a5
	mv	a0,a5
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	sc_strlen, .-sc_strlen
	.align	2
	.globl	strnlen
	.type	strnlen, @function
strnlen:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lw	a5,-36(s0)
	sw	a5,-20(s0)
	j	.L166
.L168:
	lw	a5,-20(s0)
	add	a5,a5,1
	sw	a5,-20(s0)
.L166:
	lw	a5,-40(s0)
	add	a4,a5,-1
	sw	a4,-40(s0)
	beqz	a5,.L167
	lw	a5,-20(s0)
	lbu	a5,0(a5)
	bnez	a5,.L168
.L167:
	lw	a4,-20(s0)
	lw	a5,-36(s0)
	sub	a5,a4,a5
	mv	a0,a5
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	strnlen, .-strnlen
	.align	2
	.globl	strcmp
	.type	strcmp, @function
strcmp:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
.L172:
	lw	a5,-36(s0)
	add	a4,a5,1
	sw	a4,-36(s0)
	lbu	a5,0(a5)
	sb	a5,-17(s0)
	lw	a5,-40(s0)
	add	a4,a5,1
	sw	a4,-40(s0)
	lbu	a5,0(a5)
	sb	a5,-18(s0)
	lbu	a5,-17(s0)
	beqz	a5,.L171
	lbu	a4,-17(s0)
	lbu	a5,-18(s0)
	beq	a4,a5,.L172
.L171:
	lbu	a4,-17(s0)
	lbu	a5,-18(s0)
	sub	a5,a4,a5
	mv	a0,a5
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	strcmp, .-strcmp
	.align	2
	.globl	sc_strcpy
	.type	sc_strcpy, @function
sc_strcpy:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	sw	a1,-40(s0)
	lw	a5,-36(s0)
	sw	a5,-20(s0)
	nop
.L175:
	lw	a5,-20(s0)
	add	a4,a5,1
	sw	a4,-20(s0)
	lw	a4,-40(s0)
	add	a3,a4,1
	sw	a3,-40(s0)
	lbu	a4,0(a4)
	sb	a4,0(a5)
	lbu	a5,0(a5)
	bnez	a5,.L175
	lw	a5,-36(s0)
	mv	a0,a5
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	sc_strcpy, .-sc_strcpy
	.align	2
	.globl	atol
	.type	atol, @function
atol:
	add	sp,sp,-48
	sw	s0,44(sp)
	add	s0,sp,48
	sw	a0,-36(s0)
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L178
.L179:
	lw	a5,-36(s0)
	add	a5,a5,1
	sw	a5,-36(s0)
.L178:
	lw	a5,-36(s0)
	lbu	a4,0(a5)
	li	a5,32
	beq	a4,a5,.L179
	lw	a5,-36(s0)
	lbu	a4,0(a5)
	li	a5,45
	beq	a4,a5,.L180
	lw	a5,-36(s0)
	lbu	a4,0(a5)
	li	a5,43
	bne	a4,a5,.L182
.L180:
	lw	a5,-36(s0)
	lbu	a5,0(a5)
	add	a5,a5,-45
	seqz	a5,a5
	and	a5,a5,0xff
	sw	a5,-24(s0)
	lw	a5,-36(s0)
	add	a5,a5,1
	sw	a5,-36(s0)
	j	.L182
.L183:
	lw	a4,-20(s0)
	mv	a5,a4
	sll	a5,a5,2
	add	a5,a5,a4
	sll	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-36(s0)
	add	a4,a5,1
	sw	a4,-36(s0)
	lbu	a5,0(a5)
	add	a5,a5,-48
	lw	a4,-20(s0)
	add	a5,a4,a5
	sw	a5,-20(s0)
.L182:
	lw	a5,-36(s0)
	lbu	a5,0(a5)
	bnez	a5,.L183
	lw	a5,-24(s0)
	beqz	a5,.L184
	lw	a5,-20(s0)
	sub	a5,zero,a5
	j	.L186
.L184:
	lw	a5,-20(s0)
.L186:
	mv	a0,a5
	lw	s0,44(sp)
	add	sp,sp,48
	jr	ra
	.size	atol, .-atol
	.local	count.2572
	.comm	count.2572,4,4
	.local	sense.2571
	.comm	sense.2571,4,4
	.ident	"GCC: (GNU) 6.1.0"
