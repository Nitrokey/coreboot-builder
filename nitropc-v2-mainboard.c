/* SPDX-License-Identifier: GPL-2.0-only */

#include <device/device.h>
#include <ec/acpi/ec.h>

static void mainboard_final(void *chip_info)
{
	/* Start fan control */
	ec_set_ports(0x6c, 0x68);
	send_ec_command(0x06);
	send_ec_data(0x00);
}

struct chip_operations mainboard_ops = {
	.final = mainboard_final,
};
