#ifndef SI534X_H
#define SI534X_H

#include "xiicps.h"
#include "xil_printf.h"
XIicPs I2cInstancePtr;


#define	I2C_SUCCESS		0
#define I2C_INIT_ERR	1

#define IIC_SCLK_RATE_SI534X	400000

int si534x_i2c_init(void);
int si534x_i2c_write(u8 chip_addr, u8 reg_addr, u8 reg_val);
int si534x_init(unsigned char chip_addr);

static int _last_page = -1;

#endif
