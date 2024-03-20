/* SPDX-License-Identifier: GPL-2.0-only */

    External (_SB_.AAC0, UnknownObj)
    External (_SB_.ACRT, UnknownObj)
    External (_SB_.APSV, UnknownObj)
    External (_SB_.DTSE, UnknownObj)
    External (_SB_.PCI0.LPCB.H_EC.PECH, FieldUnitObj)
    External (_SB_.PCI0.LPCB.H_EC.PECL, FieldUnitObj)
    External (_SB_.PCI0.LPCB.H_EC.PENV, FieldUnitObj)
    External (_SB_.PCI0.LPCB.H_EC.PLMX, FieldUnitObj)
    External (_SB_.PDTS, UnknownObj)
    External (_SB_.PKGA, UnknownObj)
    External (_SB_.PR00, UnknownObj)
    External (_SB_.PR01, UnknownObj)
    External (_SB_.PR02, UnknownObj)
    External (_SB_.PR03, UnknownObj)
    External (_SB_.PR04, UnknownObj)
    External (_SB_.PR05, UnknownObj)
    External (_SB_.PR06, UnknownObj)
    External (_SB_.PR07, UnknownObj)
    External (_SB_.PR08, UnknownObj)
    External (_SB_.PR09, UnknownObj)
    External (_SB_.PR10, UnknownObj)
    External (_SB_.PR11, UnknownObj)
    External (_SB_.PR12, UnknownObj)
    External (_SB_.PR13, UnknownObj)
    External (_SB_.PR14, UnknownObj)
    External (_SB_.PR15, UnknownObj)
    External (_SB_.PR16, UnknownObj)
    External (_SB_.PR17, UnknownObj)
    External (_SB_.PR18, UnknownObj)
    External (_SB_.PR19, UnknownObj)
    //External (ACT1, IntObj)
    //External (ACTT, IntObj)
    //External (CRTT, IntObj)
    //External (CTYP, IntObj)
    //External (DPTF, IntObj)
    //External (ECON, IntObj)
    //External (PSVT, IntObj)
    //External (TC1V, IntObj)
    //External (TC2V, IntObj)
    //External (TCNT, IntObj)
    //External (TSPV, IntObj)
    //External (VFN0, IntObj)
    //External (VFN1, IntObj)
    //External (VFN2, IntObj)
    //External (VFN3, IntObj)
    //External (VFN4, IntObj)
		
		Name (ACT1, 0x37)
		Name (ACTT, 0x50)
		Name (CRTT, 0x77) 
		Name (CTYP, One)
		Name (DPTF, One)
		Name (ECON, Zero)
		Name (PSVT, One)
    Name (VFN0, Zero)
    Name (VFN1, Zero)
    Name (VFN2, Zero)
    Name (VFN3, Zero)
    Name (VFN4, Zero)

    Scope (\_TZ)
    {
        Name (ETMD, One)
        Event (FCET)
        Name (FCRN, Zero)
        Mutex (FCMT, 0x00)
        Name (CVF0, Zero)
        Name (CVF1, Zero)
        Name (CVF2, Zero)
        Name (CVF3, Zero)
        Name (CVF4, Zero)
        Mutex (FMT0, 0x00)
        Mutex (FMT1, 0x00)
        Mutex (FMT2, 0x00)
        Mutex (FMT3, 0x00)
        Mutex (FMT4, 0x00)

        PowerResource (FN00, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Local1 = Zero
                Local0 = Acquire (FMT0, 0x03E8)
                If ((Local0 == Zero))
                {
                    Local1 = CVF0 /* \_TZ_.CVF0 */
                    Release (FMT0)
                }

                Return (Local1)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Local0 = Acquire (FMT0, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF0 = One
                    Release (FMT0)
                }

                FNCL ()
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Local0 = Acquire (FMT0, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF0 = Zero
                    Release (FMT0)
                }

                FNCL ()
            }
        }

        Device (FAN0)
        {
            Name (_HID, EisaId ("PNP0C0B") /* Fan (Thermal Solution) */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                FN00
            })
        }

        PowerResource (FN01, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Local1 = Zero
                Local0 = Acquire (FMT1, 0x03E8)
                If ((Local0 == Zero))
                {
                    Local1 = CVF1 /* \_TZ_.CVF1 */
                    Release (FMT1)
                }

                Return (Local1)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Local0 = Acquire (FMT1, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF1 = One
                    Release (FMT1)
                }

                FNCL ()
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Local0 = Acquire (FMT1, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF1 = Zero
                    Release (FMT1)
                }

                FNCL ()
            }
        }

        Device (FAN1)
        {
            Name (_HID, EisaId ("PNP0C0B") /* Fan (Thermal Solution) */)  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                FN01
            })
        }

        PowerResource (FN02, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Local1 = Zero
                Local0 = Acquire (FMT2, 0x03E8)
                If ((Local0 == Zero))
                {
                    Local1 = CVF2 /* \_TZ_.CVF2 */
                    Release (FMT2)
                }

                Return (Local1)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Local0 = Acquire (FMT2, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF2 = One
                    Release (FMT2)
                }

                FNCL ()
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Local0 = Acquire (FMT2, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF2 = Zero
                    Release (FMT2)
                }

                FNCL ()
            }
        }

        Device (FAN2)
        {
            Name (_HID, EisaId ("PNP0C0B") /* Fan (Thermal Solution) */)  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                FN02
            })
        }

        PowerResource (FN03, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Local1 = Zero
                Local0 = Acquire (FMT3, 0x03E8)
                If ((Local0 == Zero))
                {
                    Local1 = CVF3 /* \_TZ_.CVF3 */
                    Release (FMT3)
                }

                Return (Local1)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Local0 = Acquire (FMT3, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF3 = One
                    Release (FMT3)
                }

                FNCL ()
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Local0 = Acquire (FMT3, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF3 = Zero
                    Release (FMT3)
                }

                FNCL ()
            }
        }

        Device (FAN3)
        {
            Name (_HID, EisaId ("PNP0C0B") /* Fan (Thermal Solution) */)  // _HID: Hardware ID
            Name (_UID, 0x03)  // _UID: Unique ID
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                FN03
            })
        }

        PowerResource (FN04, 0x00, 0x0000)
        {
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                Local1 = Zero
                Local0 = Acquire (FMT4, 0x03E8)
                If ((Local0 == Zero))
                {
                    Local1 = CVF4 /* \_TZ_.CVF4 */
                    Release (FMT4)
                }

                Return (Local1)
            }

            Method (_ON, 0, Serialized)  // _ON_: Power On
            {
                Local0 = Acquire (FMT4, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF4 = One
                    Release (FMT4)
                }

                FNCL ()
            }

            Method (_OFF, 0, Serialized)  // _OFF: Power Off
            {
                Local0 = Acquire (FMT4, 0x03E8)
                If ((Local0 == Zero))
                {
                    CVF4 = Zero
                    Release (FMT4)
                }

                FNCL ()
            }
        }

        Device (FAN4)
        {
            Name (_HID, EisaId ("PNP0C0B") /* Fan (Thermal Solution) */)  // _HID: Hardware ID
            Name (_UID, 0x04)  // _UID: Unique ID
            Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
            {
                FN04
            })
        }

        Method (FNCL, 0, NotSerialized)
        {
            Local5 = Acquire (FCMT, 0x03E8)
            If ((Local5 == Zero))
            {
                Local6 = FCRN /* \_TZ_.FCRN */
                Release (FCMT)
            }

            If ((Local6 != Zero))
            {
                Signal (FCET)
            }
            Else
            {
                Local5 = Acquire (FCMT, 0x03E8)
                If ((Local5 == Zero))
                {
                    FCRN = One
                    Release (FCMT)
                }

                Local5 = Zero
                While ((Local5 < 0x04))
                {
                    If ((Wait (FCET, 0x05) != Zero))
                    {
                        Local5 = 0x04
                    }
                    Else
                    {
                        Local5++
                    }
                }

                Local5 = Acquire (FCMT, 0x03E8)
                If ((Local5 == Zero))
                {
                    FCRN = Zero
                    Release (FCMT)
                }
            }

            Local0 = Zero
            Local1 = Zero
            Local2 = Zero
            Local3 = Zero
            Local4 = Zero
            Local5 = Acquire (FMT0, 0x03E8)
            If ((Local5 == Zero))
            {
                Local0 = CVF0 /* \_TZ_.CVF0 */
                Release (FMT0)
            }

            Local5 = Acquire (FMT1, 0x03E8)
            If ((Local5 == Zero))
            {
                Local1 = CVF1 /* \_TZ_.CVF1 */
                Release (FMT1)
            }

            Local5 = Acquire (FMT2, 0x03E8)
            If ((Local5 == Zero))
            {
                Local2 = CVF2 /* \_TZ_.CVF2 */
                Release (FMT2)
            }

            Local5 = Acquire (FMT3, 0x03E8)
            If ((Local5 == Zero))
            {
                Local3 = CVF3 /* \_TZ_.CVF3 */
                Release (FMT3)
            }

            Local5 = Acquire (FMT4, 0x03E8)
            If ((Local5 == Zero))
            {
                Local4 = CVF4 /* \_TZ_.CVF4 */
                Release (FMT4)
            }

            \VFN0 = Local0
            \VFN1 = Local1
            \VFN2 = Local2
            \VFN3 = Local3
            \VFN4 = Local4
        }

        ThermalZone (TZ00)
        {
            Name (PTMP, 0x0BB8)
            Method (_SCP, 1, Serialized)  // _SCP: Set Cooling Policy
            {
                \CTYP = Arg0
            }

            Method (_CRT, 0, Serialized)  // _CRT: Critical Temperature
            {
                If (CondRefOf (\_SB.ACRT))
                {
                    If ((\_SB.ACRT != Zero))
                    {
                        Return ((0x0AAC + (\_SB.ACRT * 0x0A)))
                    }
                }

                If ((DPTF == Zero))
                {
                    Return ((0x0AAC + (\CRTT * 0x0A)))
                }
                Return ((0x0AAC + (\CRTT * 0x0A)))
            }

            Method (_AC0, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                If (CondRefOf (\_SB.AAC0))
                {
                    If ((\_SB.AAC0 != Zero))
                    {
                        Return ((0x0AAC + (\_SB.AAC0 * 0x0A)))
                    }
                }

                //Return ((0x0AAC + (\ACTT * 0x0A)))
								Return (0x0D72)
            }

            Method (_AC1, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                Return ((0x0AAC + (\ACT1 * 0x0A)))
            }

            Method (_AC2, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                Return (((0x0AAC + (\ACT1 * 0x0A)) - 0x32))
            }

            Method (_AC3, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                Return (((0x0AAC + (\ACT1 * 0x0A)) - 0x64))
            }

            Method (_AC4, 0, Serialized)  // _ACx: Active Cooling, x=0-9
            {
                Return (((0x0AAC + (\ACT1 * 0x0A)) - 0x96))
            }

            Name (_AL0, Package (0x01)  // _ALx: Active List, x=0-9
            {
                FAN0
            })
            Name (_AL1, Package (0x01)  // _ALx: Active List, x=0-9
            {
                FAN1
            })
            Name (_AL2, Package (0x01)  // _ALx: Active List, x=0-9
            {
                FAN2
            })
            Name (_AL3, Package (0x01)  // _ALx: Active List, x=0-9
            {
                FAN3
            })
            Name (_AL4, Package (0x01)  // _ALx: Active List, x=0-9
            {
                FAN4
            })
            Method (_TMP, 0, Serialized)  // _TMP: Temperature
            {
                If (!ETMD)
                {
                    Return (0x0BB8)
                }

                If (CondRefOf (\_SB.DTSE))
                {
                    If ((\_SB.DTSE == 0x03))
                    {
                        Return ((0x0B10 + (\CRTT * 0x0A)))
                    }
                }

                If (CondRefOf (\_SB.DTSE))
                {
                    If ((\_SB.DTSE == One))
                    {
                        Return ((0x0AAC + (\_SB.PDTS * 0x0A)))
                    }
                }

                If (\ECON){}
                //Return (0x0DCC)
								//((Return ((0x0B10 + (\CRTT * 0x0A)))
                Return (0x0DCC)
            }

            Method (XPSV, 0, Serialized)
            {
                If (CondRefOf (\_SB.APSV))
                {
                    If ((\_SB.APSV != Zero))
                    {
                        Return ((0x0AAC + (\_SB.APSV * 0x0A)))
                    }
                }

                Return ((0x0AAC + (\PSVT * 0x0A)))
            }

        }
    }




Scope (\_SB.PCI0.LPCB)
{
	Device (AC)
	{
		Name (_HID, "ACPI0003")
		Name (_PCL, Package () { LPCB })
		Name (ACFG, 1)

		Method (_PSR, 0, NotSerialized)
		{
			Return (ACFG)
		}
	}


OperationRegion (SMIO, SystemIO, 0xB2, One)
Field (SMIO, ByteAcc, NoLock, Preserve)
{
    SSMI,   8
}

OperationRegion (GTV, SystemMemory, 0xFED15994, One)
Field (GTV, ByteAcc, NoLock, Preserve)
{
    GTS,    8
}

Mutex (MUTX, 0x00)
Device (H_EC)
{
	Name (_HID, EisaId ("PNP0C09"))

	Name (_GPE, 0x50)

	Name (_CRS, ResourceTemplate () {
		IO (Decode16, 0x62, 0x62, 0, 1)
		IO (Decode16, 0x66, 0x66, 0, 1)
	})

	//Name (ECON, Zero)
	Name (ECST, Zero)

	Method (_REG, 2, NotSerialized)  // _REG: Region Availability
	{
		If (((Arg0 == 0x03) && (Arg1 == One)))
		{
			\ECON = One
			Acquire (MUTX, 0xFFFF)
			ECN0 = One
			Release (MUTX)
		}
	}

	OperationRegion (ERAM, EmbeddedControl, Zero, 0xFF)
	Field (ERAM, ByteAcc, NoLock, Preserve)
	{
		Offset (0xB0),
		BIF0,   16,
		BIF1,   16,
		BIF2,   16,
		BIF3,   16,
		BIF4,   16,
		BIF5,   16,
		BIF6,   16,
		BIF7,   16,
		BIF8,   16,
		BST0,   16,
		BST1,   16,
		BST2,   16,
		BST3,   16,
		PSTA,   8,
		ECN0,   8,
		DT1,    8,
		DT2,    8,
		CTMP,   8,
		LCDL,   8,
		OSSI,   8,
		IBT1,   8,
		IBT2,   8,
		WTMS,   8,
		AWT0,   8,
		AWT1,   8,
		AWT2,   8,
		LSTE,   8,
		WKRS,   8
	}

	OperationRegion (CMD0, SystemIO, 0x68, One)
	Field (CMD0, ByteAcc, NoLock, Preserve)
	{
		CMDR,   8
	}

	Method (ECMD, 1, Serialized)
	{
		If (ECON)
		{
			While (CMDR)
			{
				Stall (0x14)
			}

			CMDR = Arg0
		}
	}
}




}

Scope (\_SB)
{
	Device (LEDS)
	{
		Name (_HID, "PRP0001")
		Name (_DDN, "GPIO LEDs device")
		Name (_STA, 0xb)

		Name (_CRS, ResourceTemplate () {
			GpioIo (
				Exclusive,			// Not shared
				PullNone,			// No need for pulls
				0,				// Debounce timeout
				0,				// Drive strength
				IoRestrictionOutputOnly,	// Only used as output
				"\\_SB.PCI0.GPIO",		// GPIO controller
				0)				// Must be 0
			{
				296,				// GPP_E8 - STATUSLED#
			}
		})

		Name (_DSD, Package () {
			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
			Package () {
				Package () { "compatible", Package() { "gpio-leds" } },
			},
			ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
			Package () {
				Package () {"led-0", "LED0"},
			}
		})

		/*
		 * For more information about these bindings see:
		 * Documentation/devicetree/bindings/leds/common.yaml,
		 * Documentation/devicetree/bindings/leds/leds-gpio.yaml and
		 * Documentation/firmware-guide/acpi/gpio-properties.rst.
		 */
		Name (LED0, Package () {
			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
			Package () {
				Package () {"label", "blue:status"},
				Package () {"default-state", "keep"},
				Package () {"linux,default-trigger", "disk-activity"},
				Package () {"gpios", Package () {^LEDS, 0, 0, 1}},
				Package () {"retain-state-suspended", 1},
			}
		})
	}
}
