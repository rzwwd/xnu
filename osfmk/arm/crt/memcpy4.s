/*
 * Copyright (c) 2008 - 2009, Apple Inc. All rights reserved.<BR>
 *
 * This program and the accompanying materials
 * are licensed and made available under the terms and conditions of the BSD License
 * which accompanies this distribution.  The full text of the license may be found at
 * http://opensource.org/licenses/bsd-license.php
 *
 * THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
 * WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
 */

#include <arm/asm_help.h>

EnterARM(memcpy4)
EnterARM(_aeabi_memcpy4)
    stmdb   sp!, {r4, lr}
    subs    r2, r2, #32     /* 0x20 */
    bcc     memcpy4_label2
memcpy4_label1:
    ldmiacs r1!, {r3, r4, ip, lr}
    stmiacs r0!, {r3, r4, ip, lr}
    ldmiacs r1!, {r3, r4, ip, lr}
    stmiacs r0!, {r3, r4, ip, lr}
    subscs  r2, r2, #32     /* 0x20 */
    bcs     memcpy4_label1
memcpy4_label2:
    movs    ip, r2, lsl #28
    ldmiacs r1!, {r3, r4, ip, lr}
    stmiacs r0!, {r3, r4, ip, lr}
    ldmiami r1!, {r3, r4}
    stmiami r0!, {r3, r4}
    ldmia   sp!, {r4, lr}
    movs    ip, r2, lsl #30
    ldrcs   r3, [r1], #4
    strcs   r3, [r0], #4
    bxeq    lr
_memcpy4_lastbytes_aligned:
    movs    r2, r2, lsl #31
    ldrhcs  r3, [r1], #2
    ldrbmi  r2, [r1], #1
    strhcs  r3, [r0], #2
    strbmi  r2, [r0], #1
    bx      lr
