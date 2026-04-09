/**
  ******************************************************************************
  * @file    startup_MDR32FG16S1QI.S
  * @author  Milandr Application Team
  * @version V2.0
  * @date    22/07/2024
  * @brief   CMSIS core device startup file for MDR32FG16S1QI (GCC)
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

.equ  Stack_Size, 0x00000400
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
    .word NonMaskableInt_Handler             /* NMI Handler */
    .word HardFault_Handler                  /* Hard Fault Handler */
    .word MemoryManagement_Handler           /* MPU Fault Handler */
    .word BusFault_Handler                   /* Bus Fault Handler */
    .word UsageFault_Handler                 /* Usage Fault Handler */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word SVCall_Handler                     /* SVCall Handler */
    .word 0                                  /* Reserved */
    .word 0                                  /* Reserved */
    .word PendSV_Handler                     /* PendSV Handler */
    .word SysTick_Handler                    /* SysTick Handler */

    /* External Interrupts */
    .word SSP3_IRQHandler                    /* 0: SSP3 Handler */
    .word SSP4_IRQHandler                    /* 1: SSP4 Handler */
    .word USB_IRQHandler                     /* 2: USB Host Handler */
    .word MCBSP1_IRQHandler                  /* 3: McBSP1 Handler */
    .word MCBSP2_IRQHandler                  /* 4: McBSP2 Handler */
    .word DMA_IRQHandler                     /* 5: DMA Handler */
    .word UART1_IRQHandler                   /* 6: UART1 Handler */
    .word UART2_IRQHandler                   /* 7: UART2 Handler */
    .word SSP1_IRQHandler                    /* 8: SSP1 Handler */
    .word MCBSP3_IRQHandler                  /* 9: MxBSP3 Handler */
    .word I2C_IRQHandler                     /* 10: I2C Handler */
    .word POWER_IRQHandler                   /* 11: POWER Detector Handler */
    .word WWDG_IRQHandler                    /* 12: WWDG Handler */
    .word DMA_DSP_IRQHandler                 /* 13: DMA DSP Handler */
    .word TIMER1_IRQHandler                  /* 14: Timer1 Handler */
    .word TIMER2_IRQHandler                  /* 15: Timer2 Handler */
    .word TIMER3_IRQHandler                  /* 16: Timer3 Handler */
    .word ADC_IRQHandler                     /* 17: ADC Handler */
    .word SDIO_IRQHandler                    /* 18: SDIO Handler */
    .word COMPARATOR_IRQHandler              /* 19: COMPARATOR Handler */
    .word SSP2_IRQHandler                    /* 20: SSP2 Handler */
    .word AUDIO_IP_IRQHandler                /* 21: Audio IP Handler */
    .word DSP_CRPT_IRQHandler                /* 22: DSP CRPT Handler */
    .word DSP_TIMER_IRQHandler               /* 23: DSP TIMER Handler */
    .word DSP_CORE_IRQHandler                /* 24: DSP CORE Handler */
    .word DSP_STATE_IRQHandler               /* 25: DSP STATE Handler */
    .word UART3_IRQHandler                   /* 26: UART3 Handler */
    .word BACKUP_IRQHandler                  /* 27: BACKUP Handler */
    .word EXT_INT1_IRQHandler                /* 28: EXT_INT1 Handler */
    .word EXT_INT2_IRQHandler                /* 29: EXT_INT2 Handler */
    .word EXT_INT3_IRQHandler                /* 30: EXT_INT3 Handler */
    .word EXT_INT4_IRQHandler                /* 31: EXT_INT4 Handler */

/* Алиас для совместимости с system_MDR32FG16S1QI.c */
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
DEFINE_IRQ_HANDLER NonMaskableInt_Handler
DEFINE_IRQ_HANDLER HardFault_Handler
DEFINE_IRQ_HANDLER MemoryManagement_Handler
DEFINE_IRQ_HANDLER BusFault_Handler
DEFINE_IRQ_HANDLER UsageFault_Handler
DEFINE_IRQ_HANDLER SVCall_Handler
DEFINE_IRQ_HANDLER PendSV_Handler
DEFINE_IRQ_HANDLER SysTick_Handler
DEFINE_IRQ_HANDLER SSP3_IRQHandler
DEFINE_IRQ_HANDLER SSP4_IRQHandler
DEFINE_IRQ_HANDLER USB_IRQHandler
DEFINE_IRQ_HANDLER MCBSP1_IRQHandler
DEFINE_IRQ_HANDLER MCBSP2_IRQHandler
DEFINE_IRQ_HANDLER DMA_IRQHandler
DEFINE_IRQ_HANDLER UART1_IRQHandler
DEFINE_IRQ_HANDLER UART2_IRQHandler
DEFINE_IRQ_HANDLER SSP1_IRQHandler
DEFINE_IRQ_HANDLER MCBSP3_IRQHandler
DEFINE_IRQ_HANDLER I2C_IRQHandler
DEFINE_IRQ_HANDLER POWER_IRQHandler
DEFINE_IRQ_HANDLER WWDG_IRQHandler
DEFINE_IRQ_HANDLER DMA_DSP_IRQHandler
DEFINE_IRQ_HANDLER TIMER1_IRQHandler
DEFINE_IRQ_HANDLER TIMER2_IRQHandler
DEFINE_IRQ_HANDLER TIMER3_IRQHandler
DEFINE_IRQ_HANDLER ADC_IRQHandler
DEFINE_IRQ_HANDLER SDIO_IRQHandler
DEFINE_IRQ_HANDLER COMPARATOR_IRQHandler
DEFINE_IRQ_HANDLER SSP2_IRQHandler
DEFINE_IRQ_HANDLER AUDIO_IP_IRQHandler
DEFINE_IRQ_HANDLER DSP_CRPT_IRQHandler
DEFINE_IRQ_HANDLER DSP_TIMER_IRQHandler
DEFINE_IRQ_HANDLER DSP_CORE_IRQHandler
DEFINE_IRQ_HANDLER DSP_STATE_IRQHandler
DEFINE_IRQ_HANDLER UART3_IRQHandler
DEFINE_IRQ_HANDLER BACKUP_IRQHandler
DEFINE_IRQ_HANDLER EXT_INT1_IRQHandler
DEFINE_IRQ_HANDLER EXT_INT2_IRQHandler
DEFINE_IRQ_HANDLER EXT_INT3_IRQHandler
DEFINE_IRQ_HANDLER EXT_INT4_IRQHandler

/* End of file */