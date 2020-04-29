#include "si534x.h"
#include "Si5345-Registers.h"

//XIicPs I2cInstancePtr;

int si534x_i2c_init(void){
    XIicPs_Config *I2cCfgPtr;
	int Status = I2C_SUCCESS;

	xil_printf("Si534x Init Function\r\n");
   	I2cCfgPtr = XIicPs_LookupConfig(XPAR_XIICPS_0_DEVICE_ID);

    if (I2cCfgPtr == NULL){
		return I2C_INIT_ERR;
	}
	
    Status = XIicPs_CfgInitialize(&I2cInstancePtr, I2cCfgPtr, I2cCfgPtr->BaseAddress);
    if (Status != I2C_SUCCESS) {
        return Status;
    }
	
    XIicPs_SetSClk(&I2cInstancePtr, IIC_SCLK_RATE_SI534X);


	return Status;
}

int si534x_i2c_write(u8 chip_addr, u8 reg_addr, u8 reg_val){
    u8 WriteBuffer[10];
	int Status;

	WriteBuffer[0] = reg_addr;
	WriteBuffer[1] = reg_val;
    Status = XIicPs_MasterSendPolled(&I2cInstancePtr, WriteBuffer, 2, chip_addr);
    if (Status != I2C_SUCCESS) {
		return Status;
    }

    /* Wait until bus is idle to start another transfer */
    while (XIicPs_BusIsBusy(&I2cInstancePtr));

	return I2C_SUCCESS;
}

static int i2c_reg_write16(unsigned char dev_addr, unsigned short reg_addr, unsigned char reg_data)
{
    const unsigned char page = reg_addr >> 8;
    if (_last_page<0 || _last_page!=page) {
        const int r = si534x_i2c_write(dev_addr, 0x01, page);
        if (r != 0) {
            return r;
        }
        _last_page = page;
    }

    return si534x_i2c_write(dev_addr, reg_addr & 0xFFu, reg_data);
}


int si534x_init(unsigned char chip_addr){
	int i, Status;
	unsigned char val;
	unsigned short addr;

#ifdef SI5345_REVB_REG_CONFIG_NUM_REGS
    for (i=0; i<SI5345_REVB_REG_CONFIG_NUM_REGS; ++i) {
        val = si5345_revb_registers[i].value;
        addr = si5345_revb_registers[i].address;
        Status = i2c_reg_write16(chip_addr, addr, val);
        if(Status != 0) {
            xil_printf("Couldn't write value 0x%02X to address 0x%04X.\n", val, addr);
            xil_printf("There were %d succesful I2C writes so far.\n", i);
            return Status;
        }
    }
#endif

#ifdef SI5345_REVD_REG_CONFIG_NUM_REGS
	for (i=0; i<SI5345_REVD_REG_CONFIG_NUM_REGS; ++i) {
		val = si5345_revd_registers[i].value;
		addr = si5345_revd_registers[i].address;
		Status = i2c_reg_write16(chip_addr, addr, val);
		if(Status != 0) {
			xil_printf("Couldn't write value 0x%02X to address 0x%04X.\n", val, addr);			
			xil_printf("There were %d succesful I2C writes so far.\n", i);
			return Status;
		}
	}
#endif
	
    xil_printf("Si534x Init Complete\r\n");
	return I2C_SUCCESS;
}

