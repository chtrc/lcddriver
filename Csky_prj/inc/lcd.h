/*
 * Description: ck5a6.h - Define the system configuration, memory & IO base
 * address, flash size & address, interrupt resource for ck5a6 soc.
 *
 * Copyright (C) : Hangzhou C-SKY Microsystems Co.,LTD.
 * Author(s): Liu Bing (bing_liu@c-sky.com)
 * Contributors: Liu Bing
 * Date:  2011-06-26
 */

#ifndef __INCLUDE_CSKY_H
#define __INCLUDE_CSKY_H

/**********************************************
 * Config MGU
 *********************************************/
/* 0 - rw; 1 - rwc; 2 - rwc; 3 - rw */
#define CONFIG_CKCPU_MGU_BLOCKS         0xff06

/* 0 - baseaddr: 0x0; size: 4G */
#define CONFIG_CKCPU_MGU_REGION1        0x3f
/* 1- Disable */
#undef CONFIG_CKCPU_MGU_REGION2
/* 2- Disable */
#undef CONFIG_CKCPU_MGU_REGION3
/* 3- Disable */
#undef CONFIG_CKCPU_MGU_REGION4

/*******************************
 * Config CPU cache
 ******************************/
#define CONFIG_CKCPU_ICACHE             0
#define CONFIG_CKCPU_DCACHE             0


#endif /* __INCLUDE_CSKY_H */
