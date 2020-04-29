/*
 * Si5345 Rev B Configuration Register Export Header File
 *
 * This file represents a series of Silicon Labs Si5345 Rev B 
 * register writes that can be performed to load a single configuration 
 * on a device. It was created by a Silicon Labs ClockBuilder Pro
 * export tool.
 *
 * Part:		                                       Si5345 Rev B
 * Design ID:                                          0808-02A
 * Includes Pre/Post Download Control Register Writes: Yes
 * Created By:                                         ClockBuilder Pro v2.5 [2016-02-23]
 * Timestamp:                                          2016-08-06 21:04:09 GMT+02:00
 *
 * A complete design report corresponding to this export is included at the end 
 * of this header file.
 *
 */

#ifndef SI5345_REVB_REG_CONFIG_HEADER
#define SI5345_REVB_REG_CONFIG_HEADER

#define SI5345_REVB_REG_CONFIG_NUM_REGS				375

typedef struct
{
	unsigned int address; /* 16-bit register address */
	unsigned char value; /* 8-bit register data */

} si5345_revb_register_t;

si5345_revb_register_t const si5345_revb_registers[SI5345_REVB_REG_CONFIG_NUM_REGS] =
{
	{ 0x0B24, 0xD8 },
	{ 0x0B25, 0x00 },
	{ 0x000B, 0x68 },
	{ 0x0016, 0x02 },
	{ 0x0017, 0x1C },
	{ 0x0018, 0xEE },
	{ 0x0019, 0xDD },
	{ 0x001A, 0xDF },
	{ 0x002B, 0x02 },
	{ 0x002C, 0x01 },
	{ 0x002D, 0x01 },
	{ 0x002E, 0x3B },
	{ 0x002F, 0x00 },
	{ 0x0030, 0x00 },
	{ 0x0031, 0x00 },
	{ 0x0032, 0x00 },
	{ 0x0033, 0x00 },
	{ 0x0034, 0x00 },
	{ 0x0035, 0x00 },
	{ 0x0036, 0x3B },
	{ 0x0037, 0x00 },
	{ 0x0038, 0x00 },
	{ 0x0039, 0x00 },
	{ 0x003A, 0x00 },
	{ 0x003B, 0x00 },
	{ 0x003C, 0x00 },
	{ 0x003D, 0x00 },
	{ 0x003F, 0x01 },
	{ 0x0040, 0x04 },
	{ 0x0041, 0x0B },
	{ 0x0042, 0x00 },
	{ 0x0043, 0x00 },
	{ 0x0044, 0x00 },
	{ 0x0045, 0x0C },
	{ 0x0046, 0x4B },
	{ 0x0047, 0x00 },
	{ 0x0048, 0x00 },
	{ 0x0049, 0x00 },
	{ 0x004A, 0x4B },
	{ 0x004B, 0x00 },
	{ 0x004C, 0x00 },
	{ 0x004D, 0x00 },
	{ 0x004E, 0x05 },
	{ 0x004F, 0x00 },
	{ 0x0051, 0x03 },
	{ 0x0052, 0x00 },
	{ 0x0053, 0x00 },
	{ 0x0054, 0x00 },
	{ 0x0055, 0x03 },
	{ 0x0056, 0x00 },
	{ 0x0057, 0x00 },
	{ 0x0058, 0x00 },
	{ 0x0059, 0x03 },
	{ 0x005A, 0x00 },
	{ 0x005B, 0x00 },
	{ 0x005C, 0x00 },
	{ 0x005D, 0x01 },
	{ 0x005E, 0x00 },
	{ 0x005F, 0x00 },
	{ 0x0060, 0x00 },
	{ 0x0061, 0x00 },
	{ 0x0062, 0x00 },
	{ 0x0063, 0x00 },
	{ 0x0064, 0x00 },
	{ 0x0065, 0x00 },
	{ 0x0066, 0x00 },
	{ 0x0067, 0x00 },
	{ 0x0068, 0x00 },
	{ 0x0069, 0x00 },
	{ 0x0092, 0x00 },
	{ 0x0093, 0x00 },
	{ 0x0095, 0x00 },
	{ 0x0096, 0x00 },
	{ 0x0098, 0x00 },
	{ 0x009A, 0x02 },
	{ 0x009B, 0x30 },
	{ 0x009D, 0x00 },
	{ 0x009E, 0x20 },
	{ 0x00A0, 0x00 },
	{ 0x00A2, 0x02 },
	{ 0x00A8, 0x43 },
	{ 0x00A9, 0x88 },
	{ 0x00AA, 0x08 },
	{ 0x00AB, 0x00 },
	{ 0x00AC, 0x00 },
	{ 0x0102, 0x01 },
	{ 0x0108, 0x02 },
	{ 0x0109, 0x09 },
	{ 0x010A, 0x3D },
	{ 0x010B, 0x00 },
	{ 0x010D, 0x02 },
	{ 0x010E, 0x09 },
	{ 0x010F, 0x3D },
	{ 0x0110, 0x00 },
	{ 0x0112, 0x02 },
	{ 0x0113, 0x09 },
	{ 0x0114, 0x3D },
	{ 0x0115, 0x00 },
	{ 0x0117, 0x01 },
	{ 0x0118, 0x09 },
	{ 0x0119, 0x3B },
	{ 0x011A, 0x00 },
	{ 0x011C, 0x02 },
	{ 0x011D, 0x09 },
	{ 0x011E, 0x3D },
	{ 0x011F, 0x00 },
	{ 0x0121, 0x02 },
	{ 0x0122, 0x09 },
	{ 0x0123, 0x3D },
	{ 0x0124, 0x02 },
	{ 0x0126, 0x06 },
	{ 0x0127, 0x09 },
	{ 0x0128, 0x3D },
	{ 0x0129, 0x03 },
	{ 0x012B, 0x06 },
	{ 0x012C, 0x09 },
	{ 0x012D, 0x3D },
	{ 0x012E, 0x01 },
	{ 0x0130, 0x02 },
	{ 0x0131, 0x09 },
	{ 0x0132, 0x3D },
	{ 0x0133, 0x00 },
	{ 0x013A, 0x01 },
	{ 0x013B, 0x09 },
	{ 0x013C, 0x3B },
	{ 0x013D, 0x00 },
	{ 0x013F, 0x00 },
	{ 0x0140, 0x00 },
	{ 0x0141, 0x40 },
	{ 0x0142, 0xFF },
	{ 0x0202, 0x00 },
	{ 0x0203, 0x00 },
	{ 0x0204, 0x00 },
	{ 0x0205, 0x00 },
	{ 0x0206, 0x00 },
	{ 0x0208, 0x0D },
	{ 0x0209, 0x00 },
	{ 0x020A, 0x00 },
	{ 0x020B, 0x00 },
	{ 0x020C, 0x00 },
	{ 0x020D, 0x00 },
	{ 0x020E, 0x01 },
	{ 0x020F, 0x00 },
	{ 0x0210, 0x00 },
	{ 0x0211, 0x00 },
	{ 0x0212, 0x00 },
	{ 0x0213, 0x00 },
	{ 0x0214, 0x00 },
	{ 0x0215, 0x00 },
	{ 0x0216, 0x00 },
	{ 0x0217, 0x00 },
	{ 0x0218, 0x00 },
	{ 0x0219, 0x00 },
	{ 0x021A, 0x00 },
	{ 0x021B, 0x00 },
	{ 0x021C, 0x00 },
	{ 0x021D, 0x00 },
	{ 0x021E, 0x00 },
	{ 0x021F, 0x00 },
	{ 0x0220, 0x00 },
	{ 0x0221, 0x00 },
	{ 0x0222, 0x00 },
	{ 0x0223, 0x00 },
	{ 0x0224, 0x00 },
	{ 0x0225, 0x00 },
	{ 0x0226, 0x00 },
	{ 0x0227, 0x00 },
	{ 0x0228, 0x00 },
	{ 0x0229, 0x00 },
	{ 0x022A, 0x00 },
	{ 0x022B, 0x00 },
	{ 0x022C, 0x00 },
	{ 0x022D, 0x00 },
	{ 0x022E, 0x00 },
	{ 0x022F, 0x00 },
	{ 0x0231, 0x01 },
	{ 0x0232, 0x01 },
	{ 0x0233, 0x01 },
	{ 0x0234, 0x01 },
	{ 0x0235, 0x00 },
	{ 0x0236, 0x00 },
	{ 0x0237, 0x00 },
	{ 0x0238, 0x00 },
	{ 0x0239, 0x8C },
	{ 0x023A, 0x00 },
	{ 0x023B, 0x00 },
	{ 0x023C, 0x00 },
	{ 0x023D, 0x00 },
	{ 0x023E, 0x80 },
	{ 0x024A, 0x04 },
	{ 0x024B, 0x00 },
	{ 0x024C, 0x00 },
	{ 0x024D, 0x03 },
	{ 0x024E, 0x00 },
	{ 0x024F, 0x00 },
	{ 0x0250, 0x04 },
	{ 0x0251, 0x00 },
	{ 0x0252, 0x00 },
	{ 0x0253, 0x00 },
	{ 0x0254, 0x00 },
	{ 0x0255, 0x00 },
	{ 0x0256, 0x04 },
	{ 0x0257, 0x00 },
	{ 0x0258, 0x00 },
	{ 0x0259, 0x01 },
	{ 0x025A, 0x00 },
	{ 0x025B, 0x00 },
	{ 0x025C, 0x00 },
	{ 0x025D, 0x00 },
	{ 0x025E, 0x00 },
	{ 0x025F, 0x00 },
	{ 0x0260, 0x00 },
	{ 0x0261, 0x00 },
	{ 0x0262, 0x13 },
	{ 0x0263, 0x00 },
	{ 0x0264, 0x00 },
	{ 0x0268, 0x00 },
	{ 0x0269, 0x00 },
	{ 0x026A, 0x00 },
	{ 0x026B, 0x30 },
	{ 0x026C, 0x38 },
	{ 0x026D, 0x30 },
	{ 0x026E, 0x38 },
	{ 0x026F, 0x2D },
	{ 0x0270, 0x30 },
	{ 0x0271, 0x32 },
	{ 0x0272, 0x41 },
	{ 0x0302, 0x00 },
	{ 0x0303, 0x00 },
	{ 0x0304, 0x00 },
	{ 0x0305, 0x00 },
	{ 0x0306, 0x07 },
	{ 0x0307, 0x00 },
	{ 0x0308, 0x00 },
	{ 0x0309, 0x00 },
	{ 0x030A, 0x00 },
	{ 0x030B, 0x80 },
	{ 0x030D, 0x00 },
	{ 0x030E, 0x00 },
	{ 0x030F, 0x00 },
	{ 0x0310, 0x00 },
	{ 0x0311, 0x1C },
	{ 0x0312, 0x00 },
	{ 0x0313, 0x00 },
	{ 0x0314, 0x00 },
	{ 0x0315, 0x00 },
	{ 0x0316, 0xA0 },
	{ 0x0318, 0x00 },
	{ 0x0319, 0x00 },
	{ 0x031A, 0x00 },
	{ 0x031B, 0x60 },
	{ 0x031C, 0x6D },
	{ 0x031D, 0x00 },
	{ 0x031E, 0x00 },
	{ 0x031F, 0x00 },
	{ 0x0320, 0x00 },
	{ 0x0321, 0xD8 },
	{ 0x0323, 0x00 },
	{ 0x0324, 0x00 },
	{ 0x0325, 0x00 },
	{ 0x0326, 0x5C },
	{ 0x0327, 0x44 },
	{ 0x0328, 0x00 },
	{ 0x0329, 0x00 },
	{ 0x032A, 0x00 },
	{ 0x032B, 0x00 },
	{ 0x032C, 0xC5 },
	{ 0x032E, 0x00 },
	{ 0x032F, 0x00 },
	{ 0x0330, 0x00 },
	{ 0x0331, 0x00 },
	{ 0x0332, 0x00 },
	{ 0x0333, 0x00 },
	{ 0x0334, 0x00 },
	{ 0x0335, 0x00 },
	{ 0x0336, 0x00 },
	{ 0x0337, 0x00 },
	{ 0x0339, 0x1F },
	{ 0x033B, 0x00 },
	{ 0x033C, 0x00 },
	{ 0x033D, 0x00 },
	{ 0x033E, 0x00 },
	{ 0x033F, 0x00 },
	{ 0x0340, 0x00 },
	{ 0x0341, 0x00 },
	{ 0x0342, 0x00 },
	{ 0x0343, 0x00 },
	{ 0x0344, 0x00 },
	{ 0x0345, 0x00 },
	{ 0x0346, 0x00 },
	{ 0x0347, 0x00 },
	{ 0x0348, 0x00 },
	{ 0x0349, 0x00 },
	{ 0x034A, 0x00 },
	{ 0x034B, 0x00 },
	{ 0x034C, 0x00 },
	{ 0x034D, 0x00 },
	{ 0x034E, 0x00 },
	{ 0x034F, 0x00 },
	{ 0x0350, 0x00 },
	{ 0x0351, 0x00 },
	{ 0x0352, 0x00 },
	{ 0x0353, 0x00 },
	{ 0x0354, 0x00 },
	{ 0x0355, 0x00 },
	{ 0x0356, 0x00 },
	{ 0x0357, 0x00 },
	{ 0x0358, 0x00 },
	{ 0x0359, 0x00 },
	{ 0x035A, 0x00 },
	{ 0x035B, 0x00 },
	{ 0x035C, 0x00 },
	{ 0x035D, 0x00 },
	{ 0x035E, 0x00 },
	{ 0x035F, 0x00 },
	{ 0x0360, 0x00 },
	{ 0x0361, 0x00 },
	{ 0x0362, 0x00 },
	{ 0x0487, 0x00 },
	{ 0x0502, 0x01 },
	{ 0x0508, 0x14 },
	{ 0x0509, 0x23 },
	{ 0x050A, 0x0C },
	{ 0x050B, 0x0B },
	{ 0x050C, 0x03 },
	{ 0x050D, 0x3F },
	{ 0x050E, 0x17 },
	{ 0x050F, 0x2B },
	{ 0x0510, 0x09 },
	{ 0x0511, 0x08 },
	{ 0x0512, 0x03 },
	{ 0x0513, 0x3F },
	{ 0x0515, 0x00 },
	{ 0x0516, 0x00 },
	{ 0x0517, 0x00 },
	{ 0x0518, 0x00 },
	{ 0x0519, 0xD8 },
	{ 0x051A, 0x02 },
	{ 0x051B, 0x00 },
	{ 0x051C, 0x00 },
	{ 0x051D, 0x00 },
	{ 0x051E, 0x00 },
	{ 0x051F, 0x80 },
	{ 0x0521, 0x21 },
	{ 0x052A, 0x01 },
	{ 0x052B, 0x01 },
	{ 0x052C, 0x0F },
	{ 0x052D, 0x03 },
	{ 0x052E, 0x19 },
	{ 0x052F, 0x19 },
	{ 0x0531, 0x00 },
	{ 0x0532, 0x63 },
	{ 0x0533, 0x03 },
	{ 0x0534, 0x00 },
	{ 0x0536, 0x0C },
	{ 0x0537, 0x00 },
	{ 0x0538, 0x00 },
	{ 0x0539, 0x00 },
	{ 0x090E, 0x02 },
	{ 0x0943, 0x00 },
	{ 0x0949, 0x01 },
	{ 0x094A, 0x01 },
	{ 0x0A02, 0x00 },
	{ 0x0A03, 0x0F },
	{ 0x0A04, 0x01 },
	{ 0x0A05, 0x0F },
	{ 0x0B44, 0x2F },
	{ 0x0B46, 0x00 },
	{ 0x0B47, 0x00 },
	{ 0x0B48, 0x0E },
	{ 0x0B4A, 0x10 },
	{ 0x0514, 0x01 },
	{ 0x001C, 0x01 },
	{ 0x0B24, 0xDB },
	{ 0x0B25, 0x02 },

};

/*
 * Design Report
 *
 * Overview
 * ========
 * Part:         Si5345 Rev B
 * Project File: B:\SVN\cores\2016.2\design\TE0808\TEBF0808\misc\Si5345-RevB-0808-02A-Project.slabtimeproj
 * Design ID:    0808-02A
 * Created By:   ClockBuilder Pro v2.5 [2016-02-23]
 * Timestamp:    2016-08-06 21:04:09 GMT+02:00
 * 
 * Design Rule Check
 * =================
 * Errors:
 * - No errors
 * 
 * Warnings:
 * - OUT5 [27 MHz] and OUT4 [100 MHz] may have harmonic crosstalk [1]
 * - OUT5 [27 MHz] and OUT6 [78.8 MHz] may have harmonic crosstalk [1]
 * - OUT6 [78.8 MHz] and OUT7 [156.25 MHz] may have harmonic crosstalk [1]
 * 
 * Notes:
 * [1] To avoid crosstalk in outputs, Silicon Labs recommends the following:
 * - Avoid adjacent frequency values that are close. CBPro uses an output's integration bandwidth (IBW) to determine whether two adjacent frequencies are too close. An IBW of 20 MHz is used for frequencies 80 MHz and larger. Lower frequencies will use IBW of Freq/4.
 * - Note that harmonics of the fundamental clock output frequencies also contribute to crosstalk, but to a lesser degree than the fundamental.
 * - Adjacent frequency values that are integer multiples of one another are okay and these outputs should be grouped accordingly. For example, a 155.52 MHz and 622.08 MHz (155.52 x 4) can be adjacent.
 * - Unused outputs can be used to separate clock outputs that might otherwise interfere with one another.
 * - Silicon Labs recommends you validate your design's jitter performance using an Evaluation Board.
 * 
 * Device Grade
 * ============
 * Maximum Output Frequency: 156.25 MHz
 * Frequency Synthesis Mode: Fractional
 * Frequency Plan Grade:     B
 * Minimum Base OPN:         Si5345B*
 * 
 * Base       Output Clock         Supported Frequency Synthesis Modes
 * OPN Grade  Frequency Range      (Typical Jitter)
 * ---------  -------------------  --------------------------------------------
 * Si5345A    100 Hz to 712.5 MHz  Integer (< 100 fs) and fractional (< 150 fs)
 * Si5345B*   100 Hz to 350 MHz    "
 * Si5345C    100 Hz to 712.5 MHz  Integer only (< 100 fs)
 * Si5345D    100 Hz to 350 MHz    "
 * 
 * * Based on your calculated frequency plan, a Si5345B grade device is
 * sufficient for your design. For more in-system configuration flexibility
 * (higher frequencies and/or to enable fractional synthesis), consider
 * selecting device grade Si5345A when specifying an ordering part number (OPN)
 * for your application. See the datasheet Ordering Guide for more information.
 * 
 * Design
 * ======
 * Host Interface:
 *    I/O Power Supply: VDD (Core)
 *    SPI Mode: 4-Wire
 *    I2C Address Range: 104d to 107d / 0x68 to 0x6B (selected via A0/A1 pins)
 * 
 * XA/XB:
 *    50 MHz (XTAL - Crystal)
 * 
 * Inputs:
 *     IN0: 25 MHz
 *          Standard
 *     IN1: Unused
 *     IN2: Unused
 *     IN3: Unused
 * 
 * Outputs:
 *    OUT0: 100 MHz
 *          Enabled, LVDS 1.8 V
 *    OUT1: 125 MHz
 *          Enabled, LVDS 1.8 V
 *    OUT2: 100 MHz
 *          Enabled, LVDS 1.8 V
 *    OUT3: Unused
 *    OUT4: 100 MHz
 *          Enabled, LVDS 1.8 V
 *    OUT5: 27 MHz
 *          Enabled, LVDS 1.8 V
 *    OUT6: 78.8 MHz [ 78 + 4/5 MHz ]
 *          Enabled, LVDS 1.8 V
 *    OUT7: 156.25 MHz [ 156 + 1/4 MHz ]
 *          Enabled, LVDS 1.8 V
 *    OUT8: 25 MHz
 *          Enabled, LVDS 1.8 V
 *    OUT9: Unused
 * 
 * Frequency Plan
 * ==============
 * Fvco = 14 GHz
 * Fpfd = 1.9230769230769230... MHz [ 1 + 12/13 MHz ]
 * Fms0 = 1 GHz
 * Fms1 = 312.5 MHz [ 312 + 1/2 MHz ]
 * Fms2 = 108 MHz
 * Fms3 = 157.6 MHz [ 157 + 3/5 MHz ]
 * 
 * P dividers:
 *    P0  = 13
 *    P1  = Unused
 *    P2  = Unused
 *    P3  = Unused
 *    Pxaxb = 1
 * 
 * MXAXB = 280
 * M = 1456
 * N dividers:
 *    N0:
 *       Value: 14
 *       Skew:  0.000 s
 *       OUT0: 100 MHz
 *       OUT1: 125 MHz
 *       OUT2: 100 MHz
 *       OUT4: 100 MHz
 *       OUT8: 25 MHz
 *    N1:
 *       Value: 44.8 [ 44 + 4/5 ]
 *       Skew:  0.000 s
 *       OUT7: 156.25 MHz [ 156 + 1/4 MHz ]
 *    N2:
 *       Value: 129.6296296296296296... [ 129 + 17/27 ]
 *       Skew:  0.000 s
 *       OUT5: 27 MHz
 *    N3:
 *       Value: 88.8324873096446700... [ 88 + 164/197 ]
 *       Skew:  0.000 s
 *       OUT6: 78.8 MHz [ 78 + 4/5 MHz ]
 *    N4:
 *       Unused
 * 
 * R dividers:
 *    R0 = 10
 *    R1 = 8
 *    R2 = 10
 *    R3 = Unused
 *    R4 = 10
 *    R5 = 4
 *    R6 = 2
 *    R7 = 2
 *    R8 = 40
 *    R9 = Unused
 * 
 * Nominal Bandwidth:
 *   Desired: 100.000 Hz
 *   Actual:  84.493 Hz
 *   Coefficients:
 *      BW0:  20
 *      BW1:  35
 *      BW2:  12
 *      BW3:  11
 *      BW4:  3
 *      BW5:  63
 * Fastlock Bandwidth:
 *   Desired: 1.000 kHz
 *   Actual:  676.620 Hz
 *   Coefficients:
 *      BW0:  23
 *      BW1:  43
 *      BW2:  9
 *      BW3:  8
 *      BW4:  3
 *      BW5:  63
 * 
 * Dividers listed above show effective values. These values are translated to register settings by ClockBuilder Pro. For the actual register values, see below. Refer to the Family Reference Manual for information on registers related to frequency plan.
 * 
 * Digitally Controlled Oscillator (DCO)
 * =====================================
 * Mode: Register Direct Write
 * 
 * N0: DCO Disabled
 * 
 * N1: DCO Disabled
 * 
 * N2: DCO Disabled
 * 
 * N3: DCO Disabled
 * 
 * N4: DCO Disabled
 * 
 * Revision B Frequency Offset Errata Report
 * =========================================
 * 
 * Output  Frequency   Offset(Max,ppt)
 * ------  ----------  ---------------
 * OUT0    100 MHz     0.000000       
 * OUT1    125 MHz     0.000000       
 * OUT2    100 MHz     0.000000       
 * OUT3    Unused                     
 * OUT4    100 MHz     0.000000       
 * OUT5    27 MHz      0.000000       
 * OUT6    78.8 MHz    0.000000       
 * OUT7    156.25 MHz  0.000000       
 * OUT8    25 MHz      0.000000       
 * OUT9    Unused                     
 * 
 * Offset is reported in parts-per-trillion (1e12).
 * 
 * Estimated Power & Junction Temperature
 * ======================================
 * Assumptions:
 * 
 * Revision: B
 * VDD:      1.8 V
 * Ta:       70 °C
 * Airflow:  None
 * 
 * Total Power: 917 mW, On Chip Power: 869 mW, Tj: 89 °C
 * 
 *          Frequency  Format   Voltage   Current     Power
 *         ----------  ------  --------  --------  --------
 * VDD                            1.8 V  172.0 mA    310 mW
 * VDDA                           3.3 V  116.4 mA    384 mW
 * VDDO0      100 MHz  LVDS       1.8 V   15.6 mA     28 mW
 * VDDO1      125 MHz  LVDS       1.8 V   15.7 mA     28 mW
 * VDDO2      100 MHz  LVDS       1.8 V   15.6 mA     28 mW
 * VDDO3       Unused                                      
 * VDDO4      100 MHz  LVDS       1.8 V   15.6 mA     28 mW
 * VDDO5       27 MHz  LVDS       1.8 V   15.1 mA     27 mW
 * VDDO6     78.8 MHz  LVDS       1.8 V   15.4 mA     28 mW
 * VDDO7   156.25 MHz  LVDS       1.8 V   15.9 mA     29 mW
 * VDDO8       25 MHz  LVDS       1.8 V   15.1 mA     27 mW
 * VDDO9       Unused                                      
 *                                       --------  --------
 *                                Total  412.3 mA    917 mW
 * 
 * Note:
 * 
 * -Total power includes on- and off-chip power. This is a typical value and estimate only.
 * -Use an EVB for a more exact power measurement
 * -On-chip power excludes power dissipated in external terminations.
 * -Tj is junction temperature. When using a crystal (XTAL) reference, Tj must be less than 125 °C (on Si5345 Revision B) for device to comply with datasheet specifications.
 * 
 * Settings
 * ========
 * 
 * Location      Setting Name          Decimal Value  Hex Value       
 * ------------  --------------------  -------------  ----------------
 * 0x000B[0:6]   I2C_ADDR              104            0x68            
 * 0x0016[1]     LOL_ON_HOLD           1              0x1             
 * 0x0017[0]     SYSINCAL_INTR_MSK     0              0x0             
 * 0x0017[1]     LOSXAXB_INTR_MSK      0              0x0             
 * 0x0017[5]     SMB_TMOUT_INTR_MSK    0              0x0             
 * 0x0018[0:3]   LOS_INTR_MSK          14             0xE             
 * 0x0018[4:7]   OOF_INTR_MSK          14             0xE             
 * 0x0019[1]     LOL_INTR_MSK          0              0x0             
 * 0x0019[5]     HOLD_INTR_MSK         0              0x0             
 * 0x001A[5]     CAL_INTR_MSK          0              0x0             
 * 0x002B[3]     SPI_3WIRE             0              0x0             
 * 0x002B[5]     AUTO_NDIV_UPDATE      0              0x0             
 * 0x002C[0:3]   LOS_EN                1              0x1             
 * 0x002C[4]     LOSXAXB_DIS           0              0x0             
 * 0x002D[0:1]   LOS0_VAL_TIME         1              0x1             
 * 0x002D[2:3]   LOS1_VAL_TIME         0              0x0             
 * 0x002D[4:5]   LOS2_VAL_TIME         0              0x0             
 * 0x002D[6:7]   LOS3_VAL_TIME         0              0x0             
 * 0x002E[0:15]  LOS0_TRG_THR          59             0x003B          
 * 0x0030[0:15]  LOS1_TRG_THR          0              0x0000          
 * 0x0032[0:15]  LOS2_TRG_THR          0              0x0000          
 * 0x0034[0:15]  LOS3_TRG_THR          0              0x0000          
 * 0x0036[0:15]  LOS0_CLR_THR          59             0x003B          
 * 0x0038[0:15]  LOS1_CLR_THR          0              0x0000          
 * 0x003A[0:15]  LOS2_CLR_THR          0              0x0000          
 * 0x003C[0:15]  LOS3_CLR_THR          0              0x0000          
 * 0x003F[0:3]   OOF_EN                1              0x1             
 * 0x003F[4:7]   FAST_OOF_EN           0              0x0             
 * 0x0040[0:2]   OOF_REF_SEL           4              0x4             
 * 0x0041[0:4]   OOF0_DIV_SEL          11             0x0B            
 * 0x0042[0:4]   OOF1_DIV_SEL          0              0x00            
 * 0x0043[0:4]   OOF2_DIV_SEL          0              0x00            
 * 0x0044[0:4]   OOF3_DIV_SEL          0              0x00            
 * 0x0045[0:4]   OOFXO_DIV_SEL         12             0x0C            
 * 0x0046[0:7]   OOF0_SET_THR          75             0x4B            
 * 0x0047[0:7]   OOF1_SET_THR          0              0x00            
 * 0x0048[0:7]   OOF2_SET_THR          0              0x00            
 * 0x0049[0:7]   OOF3_SET_THR          0              0x00            
 * 0x004A[0:7]   OOF0_CLR_THR          75             0x4B            
 * 0x004B[0:7]   OOF1_CLR_THR          0              0x00            
 * 0x004C[0:7]   OOF2_CLR_THR          0              0x00            
 * 0x004D[0:7]   OOF3_CLR_THR          0              0x00            
 * 0x004E[0:2]   OOF0_DETWIN_SEL       5              0x5             
 * 0x004E[4:6]   OOF1_DETWIN_SEL       0              0x0             
 * 0x004F[0:2]   OOF2_DETWIN_SEL       0              0x0             
 * 0x004F[4:6]   OOF3_DETWIN_SEL       0              0x0             
 * 0x0051[0:3]   FAST_OOF0_SET_THR     3              0x3             
 * 0x0052[0:3]   FAST_OOF1_SET_THR     0              0x0             
 * 0x0053[0:3]   FAST_OOF2_SET_THR     0              0x0             
 * 0x0054[0:3]   FAST_OOF3_SET_THR     0              0x0             
 * 0x0055[0:3]   FAST_OOF0_CLR_THR     3              0x3             
 * 0x0056[0:3]   FAST_OOF1_CLR_THR     0              0x0             
 * 0x0057[0:3]   FAST_OOF2_CLR_THR     0              0x0             
 * 0x0058[0:3]   FAST_OOF3_CLR_THR     0              0x0             
 * 0x0059[0:1]   FAST_OOF0_DETWIN_SEL  3              0x3             
 * 0x0059[2:3]   FAST_OOF1_DETWIN_SEL  0              0x0             
 * 0x0059[4:5]   FAST_OOF2_DETWIN_SEL  0              0x0             
 * 0x0059[6:7]   FAST_OOF3_DETWIN_SEL  0              0x0             
 * 0x005A[0:25]  OOF0_RATIO_REF        16777216       0x1000000       
 * 0x005E[0:25]  OOF1_RATIO_REF        0              0x0000000       
 * 0x0062[0:25]  OOF2_RATIO_REF        0              0x0000000       
 * 0x0066[0:25]  OOF3_RATIO_REF        0              0x0000000       
 * 0x0092[1]     LOL_FST_EN            0              0x0             
 * 0x0093[4:7]   LOL_FST_DETWIN_SEL    0              0x0             
 * 0x0095[2:3]   LOL_FST_VALWIN_SEL    0              0x0             
 * 0x0096[4:7]   LOL_FST_SET_THR_SEL   0              0x0             
 * 0x0098[4:7]   LOL_FST_CLR_THR_SEL   0              0x0             
 * 0x009A[1]     LOL_SLOW_EN_PLL       1              0x1             
 * 0x009B[4:7]   LOL_SLW_DETWIN_SEL    3              0x3             
 * 0x009D[2:3]   LOL_SLW_VALWIN_SEL    0              0x0             
 * 0x009E[4:7]   LOL_SLW_SET_THR       2              0x2             
 * 0x00A0[4:7]   LOL_SLW_CLR_THR       0              0x0             
 * 0x00A2[1]     LOL_TIMER_EN          1              0x1             
 * 0x00A8[0:34]  LOL_CLR_DELAY         559171         0x000088843     
 * 0x0102[0]     OUTALL_DISABLE_LOW    1              0x1             
 * 0x0108[0]     OUT0_PDN              0              0x0             
 * 0x0108[1]     OUT0_OE               1              0x1             
 * 0x0108[2]     OUT0_RDIV_FORCE2      0              0x0             
 * 0x0109[0:2]   OUT0_FORMAT           1              0x1             
 * 0x0109[3]     OUT0_SYNC_EN          1              0x1             
 * 0x0109[4:5]   OUT0_DIS_STATE        0              0x0             
 * 0x0109[6:7]   OUT0_CMOS_DRV         0              0x0             
 * 0x010A[0:3]   OUT0_CM               13             0xD             
 * 0x010A[4:6]   OUT0_AMPL             3              0x3             
 * 0x010B[0:2]   OUT0_MUX_SEL          0              0x0             
 * 0x010B[6:7]   OUT0_INV              0              0x0             
 * 0x010D[0]     OUT1_PDN              0              0x0             
 * 0x010D[1]     OUT1_OE               1              0x1             
 * 0x010D[2]     OUT1_RDIV_FORCE2      0              0x0             
 * 0x010E[0:2]   OUT1_FORMAT           1              0x1             
 * 0x010E[3]     OUT1_SYNC_EN          1              0x1             
 * 0x010E[4:5]   OUT1_DIS_STATE        0              0x0             
 * 0x010E[6:7]   OUT1_CMOS_DRV         0              0x0             
 * 0x010F[0:3]   OUT1_CM               13             0xD             
 * 0x010F[4:6]   OUT1_AMPL             3              0x3             
 * 0x0110[0:2]   OUT1_MUX_SEL          0              0x0             
 * 0x0110[6:7]   OUT1_INV              0              0x0             
 * 0x0112[0]     OUT2_PDN              0              0x0             
 * 0x0112[1]     OUT2_OE               1              0x1             
 * 0x0112[2]     OUT2_RDIV_FORCE2      0              0x0             
 * 0x0113[0:2]   OUT2_FORMAT           1              0x1             
 * 0x0113[3]     OUT2_SYNC_EN          1              0x1             
 * 0x0113[4:5]   OUT2_DIS_STATE        0              0x0             
 * 0x0113[6:7]   OUT2_CMOS_DRV         0              0x0             
 * 0x0114[0:3]   OUT2_CM               13             0xD             
 * 0x0114[4:6]   OUT2_AMPL             3              0x3             
 * 0x0115[0:2]   OUT2_MUX_SEL          0              0x0             
 * 0x0115[6:7]   OUT2_INV              0              0x0             
 * 0x0117[0]     OUT3_PDN              1              0x1             
 * 0x0117[1]     OUT3_OE               0              0x0             
 * 0x0117[2]     OUT3_RDIV_FORCE2      0              0x0             
 * 0x0118[0:2]   OUT3_FORMAT           1              0x1             
 * 0x0118[3]     OUT3_SYNC_EN          1              0x1             
 * 0x0118[4:5]   OUT3_DIS_STATE        0              0x0             
 * 0x0118[6:7]   OUT3_CMOS_DRV         0              0x0             
 * 0x0119[0:3]   OUT3_CM               11             0xB             
 * 0x0119[4:6]   OUT3_AMPL             3              0x3             
 * 0x011A[0:2]   OUT3_MUX_SEL          0              0x0             
 * 0x011A[6:7]   OUT3_INV              0              0x0             
 * 0x011C[0]     OUT4_PDN              0              0x0             
 * 0x011C[1]     OUT4_OE               1              0x1             
 * 0x011C[2]     OUT4_RDIV_FORCE2      0              0x0             
 * 0x011D[0:2]   OUT4_FORMAT           1              0x1             
 * 0x011D[3]     OUT4_SYNC_EN          1              0x1             
 * 0x011D[4:5]   OUT4_DIS_STATE        0              0x0             
 * 0x011D[6:7]   OUT4_CMOS_DRV         0              0x0             
 * 0x011E[0:3]   OUT4_CM               13             0xD             
 * 0x011E[4:6]   OUT4_AMPL             3              0x3             
 * 0x011F[0:2]   OUT4_MUX_SEL          0              0x0             
 * 0x011F[6:7]   OUT4_INV              0              0x0             
 * 0x0121[0]     OUT5_PDN              0              0x0             
 * 0x0121[1]     OUT5_OE               1              0x1             
 * 0x0121[2]     OUT5_RDIV_FORCE2      0              0x0             
 * 0x0122[0:2]   OUT5_FORMAT           1              0x1             
 * 0x0122[3]     OUT5_SYNC_EN          1              0x1             
 * 0x0122[4:5]   OUT5_DIS_STATE        0              0x0             
 * 0x0122[6:7]   OUT5_CMOS_DRV         0              0x0             
 * 0x0123[0:3]   OUT5_CM               13             0xD             
 * 0x0123[4:6]   OUT5_AMPL             3              0x3             
 * 0x0124[0:2]   OUT5_MUX_SEL          2              0x2             
 * 0x0124[6:7]   OUT5_INV              0              0x0             
 * 0x0126[0]     OUT6_PDN              0              0x0             
 * 0x0126[1]     OUT6_OE               1              0x1             
 * 0x0126[2]     OUT6_RDIV_FORCE2      1              0x1             
 * 0x0127[0:2]   OUT6_FORMAT           1              0x1             
 * 0x0127[3]     OUT6_SYNC_EN          1              0x1             
 * 0x0127[4:5]   OUT6_DIS_STATE        0              0x0             
 * 0x0127[6:7]   OUT6_CMOS_DRV         0              0x0             
 * 0x0128[0:3]   OUT6_CM               13             0xD             
 * 0x0128[4:6]   OUT6_AMPL             3              0x3             
 * 0x0129[0:2]   OUT6_MUX_SEL          3              0x3             
 * 0x0129[6:7]   OUT6_INV              0              0x0             
 * 0x012B[0]     OUT7_PDN              0              0x0             
 * 0x012B[1]     OUT7_OE               1              0x1             
 * 0x012B[2]     OUT7_RDIV_FORCE2      1              0x1             
 * 0x012C[0:2]   OUT7_FORMAT           1              0x1             
 * 0x012C[3]     OUT7_SYNC_EN          1              0x1             
 * 0x012C[4:5]   OUT7_DIS_STATE        0              0x0             
 * 0x012C[6:7]   OUT7_CMOS_DRV         0              0x0             
 * 0x012D[0:3]   OUT7_CM               13             0xD             
 * 0x012D[4:6]   OUT7_AMPL             3              0x3             
 * 0x012E[0:2]   OUT7_MUX_SEL          1              0x1             
 * 0x012E[6:7]   OUT7_INV              0              0x0             
 * 0x0130[0]     OUT8_PDN              0              0x0             
 * 0x0130[1]     OUT8_OE               1              0x1             
 * 0x0130[2]     OUT8_RDIV_FORCE2      0              0x0             
 * 0x0131[0:2]   OUT8_FORMAT           1              0x1             
 * 0x0131[3]     OUT8_SYNC_EN          1              0x1             
 * 0x0131[4:5]   OUT8_DIS_STATE        0              0x0             
 * 0x0131[6:7]   OUT8_CMOS_DRV         0              0x0             
 * 0x0132[0:3]   OUT8_CM               13             0xD             
 * 0x0132[4:6]   OUT8_AMPL             3              0x3             
 * 0x0133[0:2]   OUT8_MUX_SEL          0              0x0             
 * 0x0133[6:7]   OUT8_INV              0              0x0             
 * 0x013A[0]     OUT9_PDN              1              0x1             
 * 0x013A[1]     OUT9_OE               0              0x0             
 * 0x013A[2]     OUT9_RDIV_FORCE2      0              0x0             
 * 0x013B[0:2]   OUT9_FORMAT           1              0x1             
 * 0x013B[3]     OUT9_SYNC_EN          1              0x1             
 * 0x013B[4:5]   OUT9_DIS_STATE        0              0x0             
 * 0x013B[6:7]   OUT9_CMOS_DRV         0              0x0             
 * 0x013C[0:3]   OUT9_CM               11             0xB             
 * 0x013C[4:6]   OUT9_AMPL             3              0x3             
 * 0x013D[0:2]   OUT9_MUX_SEL          0              0x0             
 * 0x013D[6:7]   OUT9_INV              0              0x0             
 * 0x013F[0:11]  OUTX_ALWAYS_ON        0              0x000           
 * 0x0141[1]     OUT_DIS_MSK           0              0x0             
 * 0x0141[5]     OUT_DIS_LOL_MSK       0              0x0             
 * 0x0141[6]     OUT_DIS_LOSXAXB_MSK   1              0x1             
 * 0x0141[7]     OUT_DIS_MSK_LOS_PFD   0              0x0             
 * 0x0142[1]     OUT_DIS_MSK_LOL       1              0x1             
 * 0x0142[5]     OUT_DIS_MSK_HOLD      1              0x1             
 * 0x0202[0:31]  XAXB_FREQ_OFFSET      0              0x00000000      
 * 0x0206[0:1]   PXAXB                 0              0x0             
 * 0x0208[0:47]  P0_NUM                13             0x00000000000D  
 * 0x020E[0:31]  P0_DEN                1              0x00000001      
 * 0x0212[0:47]  P1_NUM                0              0x000000000000  
 * 0x0218[0:31]  P1_DEN                0              0x00000000      
 * 0x021C[0:47]  P2_NUM                0              0x000000000000  
 * 0x0222[0:31]  P2_DEN                0              0x00000000      
 * 0x0226[0:47]  P3_NUM                0              0x000000000000  
 * 0x022C[0:31]  P3_DEN                0              0x00000000      
 * 0x0231[0:3]   P0_FRACN_MODE         1              0x1             
 * 0x0231[4]     P0_FRACN_EN           0              0x0             
 * 0x0232[0:3]   P1_FRACN_MODE         1              0x1             
 * 0x0232[4]     P1_FRACN_EN           0              0x0             
 * 0x0233[0:3]   P2_FRACN_MODE         1              0x1             
 * 0x0233[4]     P2_FRACN_EN           0              0x0             
 * 0x0234[0:3]   P3_FRACN_MODE         1              0x1             
 * 0x0234[4]     P3_FRACN_EN           0              0x0             
 * 0x0235[0:43]  MXAXB_NUM             601295421440   0x08C00000000   
 * 0x023B[0:31]  MXAXB_DEN             2147483648     0x80000000      
 * 0x024A[0:23]  R0_REG                4              0x000004        
 * 0x024D[0:23]  R1_REG                3              0x000003        
 * 0x0250[0:23]  R2_REG                4              0x000004        
 * 0x0253[0:23]  R3_REG                0              0x000000        
 * 0x0256[0:23]  R4_REG                4              0x000004        
 * 0x0259[0:23]  R5_REG                1              0x000001        
 * 0x025C[0:23]  R6_REG                0              0x000000        
 * 0x025F[0:23]  R7_REG                0              0x000000        
 * 0x0262[0:23]  R8_REG                19             0x000013        
 * 0x0268[0:23]  R9_REG                0              0x000000        
 * 0x026B[0:7]   DESIGN_ID0            48             0x30            
 * 0x026C[0:7]   DESIGN_ID1            56             0x38            
 * 0x026D[0:7]   DESIGN_ID2            48             0x30            
 * 0x026E[0:7]   DESIGN_ID3            56             0x38            
 * 0x026F[0:7]   DESIGN_ID4            45             0x2D            
 * 0x0270[0:7]   DESIGN_ID5            48             0x30            
 * 0x0271[0:7]   DESIGN_ID6            50             0x32            
 * 0x0272[0:7]   DESIGN_ID7            65             0x41            
 * 0x0302[0:43]  N0_NUM                30064771072    0x00700000000   
 * 0x0308[0:31]  N0_DEN                2147483648     0x80000000      
 * 0x030D[0:43]  N1_NUM                120259084288   0x01C00000000   
 * 0x0313[0:31]  N1_DEN                2684354560     0xA0000000      
 * 0x0318[0:43]  N2_NUM                469762048000   0x06D60000000   
 * 0x031E[0:31]  N2_DEN                3623878656     0xD8000000      
 * 0x0323[0:43]  N3_NUM                293601280000   0x0445C000000   
 * 0x0329[0:31]  N3_DEN                3305111552     0xC5000000      
 * 0x032E[0:43]  N4_NUM                0              0x00000000000   
 * 0x0334[0:31]  N4_DEN                0              0x00000000      
 * 0x0339[0:4]   N_FSTEP_MSK           31             0x1F            
 * 0x033B[0:43]  N0_FSTEPW             0              0x00000000000   
 * 0x0341[0:43]  N1_FSTEPW             0              0x00000000000   
 * 0x0347[0:43]  N2_FSTEPW             0              0x00000000000   
 * 0x034D[0:43]  N3_FSTEPW             0              0x00000000000   
 * 0x0353[0:43]  N4_FSTEPW             0              0x00000000000   
 * 0x0359[0:15]  N0_DELAY              0              0x0000          
 * 0x035B[0:15]  N1_DELAY              0              0x0000          
 * 0x035D[0:15]  N2_DELAY              0              0x0000          
 * 0x035F[0:15]  N3_DELAY              0              0x0000          
 * 0x0361[0:15]  N4_DELAY              0              0x0000          
 * 0x0487[0]     ZDM_EN                0              0x0             
 * 0x0487[1:2]   ZDM_IN_SEL            0              0x0             
 * 0x0502[4]     ADD_DIV256            0              0x0             
 * 0x0508[0:5]   BW0_PLL               20             0x14            
 * 0x0509[0:5]   BW1_PLL               35             0x23            
 * 0x050A[0:5]   BW2_PLL               12             0x0C            
 * 0x050B[0:5]   BW3_PLL               11             0x0B            
 * 0x050C[0:5]   BW4_PLL               3              0x03            
 * 0x050D[0:5]   BW5_PLL               63             0x3F            
 * 0x050E[0:5]   FAST_BW0_PLL          23             0x17            
 * 0x050F[0:5]   FAST_BW1_PLL          43             0x2B            
 * 0x0510[0:5]   FAST_BW2_PLL          9              0x09            
 * 0x0511[0:5]   FAST_BW_PLL           8              0x08            
 * 0x0512[0:5]   FAST_BW4_PLL          3              0x03            
 * 0x0513[0:5]   FAST_BW5_PLL          63             0x3F            
 * 0x0515[0:55]  M_NUM                 3126736191488  0x0002D800000000
 * 0x051C[0:31]  M_DEN                 2147483648     0x80000000      
 * 0x0521[0:3]   M_FRAC_MODE           1              0x1             
 * 0x0521[4]     M_FRAC_EN             0              0x0             
 * 0x0521[5]     PLL_OUT_RATE_SEL      1              0x1             
 * 0x052A[0]     IN_SEL_REGCTRL        1              0x1             
 * 0x052A[1:3]   IN_SEL                0              0x0             
 * 0x052B[0]     FASTLOCK_AUTO_EN      1              0x1             
 * 0x052B[1]     FASTLOCK_MAN          0              0x0             
 * 0x052C[0]     HOLD_EN               1              0x1             
 * 0x052C[3]     HOLD_RAMP_BYP         1              0x1             
 * 0x052C[5:7]   HOLD_RAMP_RATE        0              0x0             
 * 0x052D[1]     HOLD_RAMPBYP_NOHIST   1              0x1             
 * 0x052E[0:4]   HOLD_HIST_LEN         25             0x19            
 * 0x052F[0:4]   HOLD_HIST_DELAY       25             0x19            
 * 0x0531[0:4]   HOLD_REF_COUNT_FRC    0              0x00            
 * 0x0532[0:23]  HOLD_15M_CYC_COUNT    867            0x000363        
 * 0x0536[0:1]   CLK_SWITCH_MODE       0              0x0             
 * 0x0536[2]     HSW_EN                1              0x1             
 * 0x0536[3]     HSW_RAMP_BYP          1              0x1             
 * 0x0537[0:3]   IN_LOS_MSK            0              0x0             
 * 0x0537[4:7]   IN_OOF_MSK            0              0x0             
 * 0x0538[0:2]   IN0_PRIORITY          0              0x0             
 * 0x0538[4:6]   IN1_PRIORITY          0              0x0             
 * 0x0539[0:2]   IN2_PRIORITY          0              0x0             
 * 0x0539[4:6]   IN3_PRIORITY          0              0x0             
 * 0x090E[0]     XAXB_EXTCLK_EN        0              0x0             
 * 0x0943[0]     IO_VDD_SEL            0              0x0             
 * 0x0949[0:3]   IN_EN                 1              0x1             
 * 0x0949[4:7]   IN_PULSED_CMOS_EN     0              0x0             
 * 0x094A[0:3]   INX_TO_PFD_EN         1              0x1             
 * 0x0A02[0:4]   N_ADD_0P5             0              0x00            
 * 0x0A03[0:4]   N_CLK_TO_OUTX_EN      15             0x0F            
 * 0x0A04[0:4]   N_PIBYP               1              0x01            
 * 0x0A05[0:4]   N_PDNB                15             0x0F            
 * 0x0B44[0:3]   PDIV_FRACN_CLK_DIS    15             0xF             
 * 0x0B44[5]     FRACN_CLK_DIS_PLL     1              0x1             
 * 0x0B46[0:3]   LOS_CLK_DIS           0              0x0             
 * 0x0B47[0:4]   OOF_CLK_DIS           0              0x00            
 * 0x0B48[0:4]   OOF_DIV_CLK_DIS       14             0x0E            
 * 0x0B4A[0:4]   N_CLK_DIS             16             0x10
 * 
 *
 */

#endif