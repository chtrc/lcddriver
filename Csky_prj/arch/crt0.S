/*
 * crt0.S -- startup codes for CK-CPU.
 *
 * Define a exception vector table
 *
 * Initial PSR register.
 * Initial VBR register, relocate exception vector table.
 * Initial sp(stack pointer) register.
 * Initial MGU (for ckcpu having MGU)
 * Initial Cache.
 * Initial BSS section to "0"
 * Then goto "main".
 *
 * Copyright (C) 2008~2011  Hangzhou C-SKY Microsystems Co., Ltd
 */

#include "helloworld.h"

.file "crt0.S"

/*
 *         MGU & CACHE macro from "ck803.h"
 *
 * CONFIG_CKCPU_MGU_BLOCKS	---- MGU block priority setting value
 * CONFIG_CKCPU_MGU_REGION(1-4)
 *                          ---- MGU (1-4) block base address and size.
 * CONFIG_CKCPU_ICACHE		---- Instruction cache enable
 * CONFIG_CKCPU_DCACHE		---- Data cache enable
 *
 */

/*
 * For importing variable or functions from script file "ckcpu.ld".
 */
.import __stack		/* The stack pointer from linking script file */
.import __fstack	/* The stack pointer for fast interrupt from 
                     linking script file */
.import	__sbss		/* The end of bss from linking script file */
.import __ebss		/* The end of bss from linking script file */

/*
 * For importing variable or functions from other c or assemble files.
 */
.import main				/* The c codes entry */

/*
 * For importing variable or functions from entry.S.
 */
.import default_exception_handler /* default exception service routine */

/* For exporting varialbe or functions */
.export	ckcpu_vsr_table	/* Vector table base address. */
.export __start				/* The system entry. */


.section .exp_table
/* Vector table space. */
.align 10
ckcpu_vsr_table:
.rept 128
.long default_exception_handler
.endr

/* The ckcpu startup codes. */
.text
	/*
	 *	
	 * This is the codes first entry point. This is where it all
	 * begins...
	 */

__start:
	/*
	 * Init psr value, enable exception, disable interrupt and fast interrupt.
	 * psr = 0x80000100
	 */
	bgeni	r7, 31
	bseti	r7, 8
	mtcr	r7, psr
	
	/*
	 * Setup initial vector base table for interrupts and exceptions
	 */
	lrw		r6, ckcpu_vsr_table
	mtcr	r6, vbr
	
	/* Initialize the normal stack pointer from the linker definition. */
	lrw		r7, __stack
	mov		sp, r7

#ifdef FAST_INTERRUPT_ENABLE
	/* Initialize the fast interrupt stack pointer . */
	psrset	af
	lrw		r6, __fstack
	mov		sp, r6
	psrclr	af
#endif

	/*
	 * Initial CKCPU MGU & Cache or MMU & Cache
	 */
#if CONFIG_CKCPU_MMU

	/*** Initial CKCPU MMU & Cache ***/

	/*
	 *  Step 1: Disable MMU & Cache.
	 */
	mfcr	r7, cr18
	bclri	r7, 0       /* bit 0 ~ 1, mmu/mgu enable */
	bclri	r7, 1       /* */
	bclri	r7, 2       /* inst cache */
	bclri	r7, 3       /* data cache */
	bclri	r7, 6       /* jumping predict */
	mtcr	r7, cr18

	/*
	 * Step 2: Setup the initial page tables.
 	 */
__create_page_table:
	/*
	 * invalid the jTLB
 	 */
#if defined(__ck610__)
	cpseti	cp15
	bgeni	r3, 27
	cpwcr	r3, cpcr8
#else
	movi	r3,	0
	bseti	r3,	26
	mtcr	r3,	cr<8,15>
#endif

	/*
 	 * Setup the initial page tables.
	 * r2 = page size,16M
 	 * r5, r6 = physical address of start of RAM
 	 * r7 = Virtual address
 	 */
	lrw     r8, __origin
	bmaski  r2, 12
	lsli    r2, 13
	movi    r5, 0x1e		/* C = 011, D = 1, V = 1, G = 0, pfn = 0x0 */
	movi    r6, 0x0			/* this page is invalid */
	movi	r7, 0x0

	or      r7, r8
#if defined(__ck610__)
	lsri    r8, 6
#endif
	or      r5, r8
	and     r6, r8

	bgeni	r3, 28

#if defined(__ck610__)
	cpwcr	r2, cpcr6		/* MPR */

	cpwcr	r5, cpcr2		/* MEL0 */
	cpwcr	r6, cpcr3		/* MEL1 */
	cpwcr	r7, cpcr4		/* MEH */
	cpwcr	r3, cpcr8		/* MCIR */
#else
	mtcr	r2,	cr<6,15>	/* MPR */

	mtcr	r5,	cr<2,15>	/* MEL0 */
	mtcr	r6,	cr<3,15>	/* MEL1 */
	mtcr	r7,	cr<4,15>	/* MEH */
	mtcr	r3,	cr<8,15>	/* MCIR */
#endif

#else /* CONFIG_CKCPU_MMU */

	/*** Initial CKCPU MGU & Cache ***/

	/*
	 * Step 1: Disable MGU & Cache.
	 */
	movi	r7, 0
	mtcr	r7, cr18

	/*
	 * Initial CKCPU MGU & Cache
	 * Step 2: priority setting, ff -- read and write
	 */
	lrw		r6, CONFIG_CKCPU_MGU_BLOCKS
	mtcr	r6, cr19

	/*
	 * Initial CKCPU MGU & Cache
	 * Step 3: set MGU block
	 */

   	/* The first block */
	movi	r5, 0
	mtcr	r5, cr21
#ifdef CONFIG_CKCPU_MGU_REGION1
	lrw		r7, CONFIG_CKCPU_MGU_REGION1
	mtcr	r7, cr20
#else
	mtcr	r5, cr20
#endif

	/* The second block */
	movi	r4, 1
	mtcr	r4, cr21
#ifdef 	CONFIG_CKCPU_MGU_REGION2
	lrw		r7, CONFIG_CKCPU_MGU_REGION2
	mtcr	r7, cr20
#else
	mtcr	r5, cr20
#endif

	/* The third block */
	movi	r4, 2
	mtcr	r4, cr21
#ifdef CONFIG_CKCPU_MGU_REGION3
	lrw		r7, CONFIG_CKCPU_MGU_REGION3
	mtcr	r7, cr20
#else
	mtcr	r5, cr20
#endif
	/* The forth block */
	movi	r4, 3
	mtcr	r4, cr21
#ifdef CONFIG_CKCPU_MGU_REGION4
	lrw		r7, CONFIG_CKCPU_MGU_REGION4
	mtcr	r7, cr20
#else
	mtcr	r5, cr20
#endif

#endif /* #ifndef CONFIG_CKCPU_MMU */

	/*
	 * Step 4: enable MGU or MMU
	 */
	/* Enable MGU or MMU */
	mfcr	r7, cr18
	bseti	r7, 0       /* bit 0 ~ 1, mmu/mgu enable */
	bclri	r7, 1       /*  */
	bseti	r7,	4       /* write back */
	bseti	r7,	5       /* return stack */
	bseti	r7,	6		/* jumping predict */
	//mtcr	r7,	cr18

	/*
	 * Step 5: enable instruction & data cache
	 */
#if CONFIG_CKCPU_ICACHE
	/* Invalid Instruction cache content */
	movi	r7, 0x11
	mtcr	r7, cr17

	/* Enable instruction cache */
	mfcr	r6, cr18
	bseti	r6, 2
	mtcr	r6, cr18
#endif /* #ifdef CONFIG_CKCPU_ICACHE */

#if CONFIG_CKCPU_DCACHE
	/* Invalid Data cache content */
	movi	r7, 0x12
	mtcr	r7, cr17

	/* Enable Data cache */
	mfcr	r7, cr18
	bseti	r7, 3
	mtcr	r7, cr18
#endif /* #ifdef CONFIG_CKCPU_DCACHE */

	/*
	 * Zero out the bss region.
	 * NOTE: __sbss must align 4
	 */
	lrw		r7, __sbss	/* Get start of bss from linking script file */
	lrw		r6, __ebss	/* Get end of bss from linking script file */
	subu	r6, r7		/* Calculate size of bss */
	lsri	r6, 2		/* Size of whole words */
	cmpnei	r6, 0
	bf		__goto_c
	movi	r5, 0		/* Set zero value to write */
2:
	stw		r5, (r7)	/* Zero next word */
	addi	r7, 4		/* Increase bss pointer */
	decne	r6			/* Decrease counter */
	bt		2b			/* Repeat for all bss */

	
	/*
	 * Assember start up done, C codes start here.
	 */
__goto_c:
	jbsr	main
	
	/* Should never get here. */
__exit:
	bkpt
	
default_exception_handler:
	br	default_exception_handler
	rte

