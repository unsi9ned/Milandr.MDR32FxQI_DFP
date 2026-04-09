/**
  ******************************************************************************
  * @file    startup_K1986VE1xI.S
  * @author  Milandr Application Team
  * @version V2.0
  * @date    22/07/2024
  * @brief   CMSIS core device startup file for K1986VE1xI (GCC)
  ******************************************************************************
  */

.syntax unified
.thumb

.global g_pfnVectors
.global Default_Handler

/* Start address for the initialization values of the .data section */
.word _sidata
/* Start address for the .data section */
.word _sdata
/* End address for the .data section */
.word _edata
/* Start address for the .bss section */
.word _sbss
/* End address for the .bss section */
.word _ebss

.equ  Stack_Size, 0x00001000
.equ  Heap_Size,  0x00001000

.section .stack
.org 0
stack:
    .space Stack_Size
    .size stack, . - stack
__stack_limit = stack + Stack_Size
__initial_sp = stack + Stack_Size

.section .heap
heap:
    .space Heap_Size
    .size heap, . - heap
__heap_base = heap
__heap_limit = heap + Heap_Size

.section .isr_vector, "a"
.type g_pfnVectors, %object
.size g_pfnVectors, .-g_pfnVectors

g_pfnVectors:
    .word __initial_sp                       /* Top of Stack */
    .word Reset_Handler                      /* Reset Handler */
    .word NMI_Handler                        /* NMI Handler */
    .word HardFault_Handler                  /* Hard Fault Handler */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word SVC_Handler                        /* SVCall Handler */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word PendSV_Handler                     /* PendSV Handler */
    .word SysTick_Handler                    /* SysTick Handler */

    /* External Interrupts */
    .word MIL_STD_1553B2_IRQHandler          /* 0: MIL_STD_1553B2 Handler */
    .word MIL_STD_1553B1_IRQHandler          /* 1: MIL_STD_1553B1 Handler */
    .word USB_IRQHandler                     /* 2: USB Host Handler */
    .word CAN1_IRQHandler                    /* 3: CAN1 Handler */
    .word CAN2_IRQHandler                    /* 4: CAN2 Handler */
    .word DMA_IRQHandler                     /* 5: DMA Handler */
    .word UART1_IRQHandler                   /* 6: UART1 Handler */
    .word UART2_IRQHandler                   /* 7: UART2 Handler */
    .word SSP1_IRQHandler                    /* 8: SSP1 Handler */
    .word BUSY_IRQHandler                    /* 9: NAND Flash Handler */
    .word ARINC429R_IRQHandler               /* 10: ARINC429R1-ARINC429R8 Handler */
    .word POWER_IRQHandler                   /* 11: POWER Handler */
    .word WWDG_IRQHandler                    /* 12: WWDG Handler */
    .word TIMER4_IRQHandler                  /* 13: Timer4 Handler */
    .word TIMER1_IRQHandler                  /* 14: Timer1 Handler */
    .word TIMER2_IRQHandler                  /* 15: Timer2 Handler */
    .word TIMER3_IRQHandler                  /* 16: Timer3 Handler */
    .word ADC_IRQHandler                     /* 17: ADC Handler */
    .word ETHERNET_IRQHandler                /* 18: Ethernet Handler */
    .word SSP3_IRQHandler                    /* 19: SSP3 Handler */
    .word SSP2_IRQHandler                    /* 20: SSP2 Handler */
    .word ARINC429T1_IRQHandler              /* 21: ARINC429T1 Handler */
    .word ARINC429T2_IRQHandler              /* 22: ARINC429T2 Handler */
    .word ARINC429T3_IRQHandler              /* 23: ARINC429T3 Handler */
    .word ARINC429T4_IRQHandler              /* 24: ARINC429T4 Handler */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word BKP_IRQHandler                     /* 27: BKP Handler */
    .word EXT_INT1_IRQHandler                /* 28: EXT_INT1 Handler */
    .word EXT_INT2_IRQHandler                /* 29: EXT_INT2 Handler */
    .word EXT_INT3_IRQHandler                /* 30: EXT_INT3 Handler */
    .word EXT_INT4_IRQHandler                /* 31: EXT_INT4 Handler */

/* Алиас для совместимости с system_K1986VE1xI.c */
.global __Vectors
__Vectors = g_pfnVectors

/* Reset handler */
.section .text.Reset_Handler, "ax"
.weak Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    ldr   r0, =_sidata
    ldr   r1, =_sdata
    ldr   r2, =_edata
    subs  r2, r2, r1
    bl    InitData

    ldr   r0, =_sbss
    ldr   r1, =_ebss
    subs  r1, r1, r0
    bl    InitZero

    ldr   r0, =SystemInit
    blx   r0
    ldr   r0, =main
    bx    r0

InitData:
    subs  r2, r2, #0
    beq   .L_InitData_Done
    movs  r3, #0
.L_InitData_Loop:
    ldr   r4, [r0, r3]
    str   r4, [r1, r3]
    adds  r3, r3, #4
    cmp   r3, r2
    blt   .L_InitData_Loop
.L_InitData_Done:
    bx    lr

InitZero:
    subs  r1, r1, #0
    beq   .L_InitZero_Done
    movs  r3, #0
    movs  r4, #0
.L_InitZero_Loop:
    str   r4, [r0, r3]
    adds  r3, r3, #4
    cmp   r3, r1
    blt   .L_InitZero_Loop
.L_InitZero_Done:
    bx    lr

.size Reset_Handler, .-Reset_Handler

/* Exception handlers */
.section .text.Default_Handler, "ax"
.weak Default_Handler
.type Default_Handler, %function
Default_Handler:
    b .
.size Default_Handler, .-Default_Handler

.macro DEFINE_IRQ_HANDLER name
    .weak \name
    .set \name, Default_Handler
.endm

/* Weak aliases for interrupt handlers */
DEFINE_IRQ_HANDLER NMI_Handler
DEFINE_IRQ_HANDLER HardFault_Handler
DEFINE_IRQ_HANDLER SVC_Handler
DEFINE_IRQ_HANDLER PendSV_Handler
DEFINE_IRQ_HANDLER SysTick_Handler
DEFINE_IRQ_HANDLER MIL_STD_1553B2_IRQHandler
DEFINE_IRQ_HANDLER MIL_STD_1553B1_IRQHandler
DEFINE_IRQ_HANDLER USB_IRQHandler
DEFINE_IRQ_HANDLER CAN1_IRQHandler
DEFINE_IRQ_HANDLER CAN2_IRQHandler
DEFINE_IRQ_HANDLER DMA_IRQHandler
DEFINE_IRQ_HANDLER UART1_IRQHandler
DEFINE_IRQ_HANDLER UART2_IRQHandler
DEFINE_IRQ_HANDLER SSP1_IRQHandler
DEFINE_IRQ_HANDLER BUSY_IRQHandler
DEFINE_IRQ_HANDLER ARINC429R_IRQHandler
DEFINE_IRQ_HANDLER POWER_IRQHandler
DEFINE_IRQ_HANDLER WWDG_IRQHandler
DEFINE_IRQ_HANDLER TIMER4_IRQHandler
DEFINE_IRQ_HANDLER TIMER1_IRQHandler
DEFINE_IRQ_HANDLER TIMER2_IRQHandler
DEFINE_IRQ_HANDLER TIMER3_IRQHandler
DEFINE_IRQ_HANDLER ADC_IRQHandler
DEFINE_IRQ_HANDLER ETHERNET_IRQHandler
DEFINE_IRQ_HANDLER SSP3_IRQHandler
DEFINE_IRQ_HANDLER SSP2_IRQHandler
DEFINE_IRQ_HANDLER ARINC429T1_IRQHandler
DEFINE_IRQ_HANDLER ARINC429T2_IRQHandler
DEFINE_IRQ_HANDLER ARINC429T3_IRQHandler
DEFINE_IRQ_HANDLER ARINC429T4_IRQHandler
DEFINE_IRQ_HANDLER BKP_IRQHandler
DEFINE_IRQ_HANDLER EXT_INT1_IRQHandler
DEFINE_IRQ_HANDLER EXT_INT2_IRQHandler
DEFINE_IRQ_HANDLER EXT_INT3_IRQHandler
DEFINE_IRQ_HANDLER EXT_INT4_IRQHandler

/* End of file */