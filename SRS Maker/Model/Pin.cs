using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace SRS_Maker.Model
{
    public class Pins
    {
        public string Name { get; set; }
        public List<int?> PinNumber { get; set; }
        public List<string> Usage { get; set; }

        public List<Pins> PinList { get; set; }

        public Pins()
        {

        }

        public Pins(string pinNumber)
        {
            PinList = new List<Pins>();
                
            /* Port A Group(0) ============================================================================== */
            PinList.Add(new Pins { Name = "PA0", PinNumber = new List<int?>  { 12, 16, 24 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PA1", PinNumber = new List<int?> { 7, 11, 19 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PA2", PinNumber = new List<int?> { 5, 9, 17 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PA3", PinNumber = new List<int?> { 68, 90, 114 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PA4", PinNumber = new List<int?> { 29, 43, 51 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PA5", PinNumber = new List<int?> { 79, 118, 146 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PA6", PinNumber = new List<int?> { 80, 119, 147 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PA7", PinNumber = new List<int?> { 71, 104, 128 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });

            PinList.Add(new Pins { Name = "PA8", PinNumber = new List<int?> { 72, 105, 129 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PA9", PinNumber = new List<int?> { 73, 106, 130 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PA10", PinNumber = new List<int?> { 74, 107, 131 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PA11", PinNumber = new List<int?> { 75, 108, 132 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PA12", PinNumber = new List<int?> { 31, 45, 53 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "SPI0 IN" } });
            PinList.Add(new Pins { Name = "PA13", PinNumber = new List<int?> { 30, 44, 52 }, Usage = new List<string> { "GPIO", "SPI0 OUT"} });
            PinList.Add(new Pins { Name = "PA14", PinNumber = new List<int?> { 28, 42, 50 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "SPI0 CLK" } });
            PinList.Add(new Pins { Name = "PA15", PinNumber = new List<int?> { 27, 40, 48 }, Usage = new List<string> { "GPIO", "SPI0 CLK" } });

            /* Port B Group(1) ============================================================================== */
            PinList.Add(new Pins { Name = "PB0", PinNumber = new List<int?> { 23, 31, 39 }, Usage = new List<string> { "GPIO", "CAN0 TX"} });
            PinList.Add(new Pins { Name = "PB1", PinNumber = new List<int?> { 24, 32, 40 }, Usage = new List<string> { "GPIO", "CAN0 RX", "WakeUpInterrupt" } });
            PinList.Add(new Pins { Name = "PB2", PinNumber = new List<int?> { 100, 144, 176 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "CAN RX" } });
            PinList.Add(new Pins { Name = "PB3", PinNumber = new List<int?> { 1, 1, 1 }, Usage = new List<string> { "GPIO", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PB4", PinNumber = new List<int?> { 50, 72, 88 }, Usage = new List<string> { "GPIO", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PB5", PinNumber = new List<int?> { 53, 75, 91 }, Usage = new List<string> { "GPIO", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PB6", PinNumber = new List<int?> { 54, 76, 92 }, Usage = new List<string> { "GPIO", "CAN TX" } });
            PinList.Add(new Pins { Name = "PB7", PinNumber = new List<int?> { 55, 77, 93 }, Usage = new List<string> { "GPIO" } });

            PinList.Add(new Pins { Name = "PB7", PinNumber = new List<int?> { 39, 53, 61 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PB8", PinNumber = new List<int?> { 38, 52, 60 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PB9", PinNumber = new List<int?> { 40, 54, 62 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PB10", PinNumber = new List<int?> { 97 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PB11", PinNumber = new List<int?> { 61, 83, 101 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PB12", PinNumber = new List<int?> { 63, 85, 103 }, Usage = new List<string> { "GPIO", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PB13", PinNumber = new List<int?> { 65, 87, 105 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PB14", PinNumber = new List<int?> { 67, 89, 107 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "CAN TX" } });

            /* Port C Group(2) ============================================================================== */
            PinList.Add(new Pins { Name = "PC0", PinNumber = new List<int?> { 87, 126, 154 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PC1", PinNumber = new List<int?> { 82, 121, 149 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PC2", PinNumber = new List<int?> { 78, 117, 145 }, Usage = new List<string> { "GPIO", "CAN4 TX", "SPI1 CLK" } });
            PinList.Add(new Pins { Name = "PC3", PinNumber = new List<int?> { 77, 116, 144 }, Usage = new List<string> { "GPIO", "CAN1 RX", "CAN4 RX" } });
            PinList.Add(new Pins { Name = "PC4", PinNumber = new List<int?> { 92, 131, 159 }, Usage = new List<string> { "GPIO", "CAN3 RX", "SPI1 IN" } });
            PinList.Add(new Pins { Name = "PC5", PinNumber = new List<int?> { 91, 130, 158 }, Usage = new List<string> { "GPIO", "CAN3 TX", "SPI1 OUT" } });
            PinList.Add(new Pins { Name = "PC6", PinNumber = new List<int?> { 25, 36, 44 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PC7", PinNumber = new List<int?> { 26, 37, 45 }, Usage = new List<string> { "GPIO" } });

            PinList.Add(new Pins { Name = "PC8", PinNumber = new List<int?> { 99, 143, 175 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PC9", PinNumber = new List<int?> { 2, 2, 2 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PC10", PinNumber = new List<int?> { 22, 28, 36 }, Usage = new List<string> { "GPIO", "CAN1 TX", "CAN4 RX" } });
            PinList.Add(new Pins { Name = "PC11", PinNumber = new List<int?> { 21, 27, 35 }, Usage = new List<string> { "GPIO", "CAN1 RX", "CAN4 RX", "WakeUpInterrupt" } });
            PinList.Add(new Pins { Name = "PC12", PinNumber = new List<int?> { 97, 141, 173 }, Usage = new List<string> { "GPIO", "PWM", "SPI2 IN" } });
            PinList.Add(new Pins { Name = "PC13", PinNumber = new List<int?> { 98, 142, 174 }, Usage = new List<string> { "GPIO", "PWM", "SPI2 OUT" } });
            PinList.Add(new Pins { Name = "PC14", PinNumber = new List<int?> { 3, 3, 3 }, Usage = new List<string> { "GPIO", "PWM", "SPI2 CLK" } });
            PinList.Add(new Pins { Name = "PC15", PinNumber = new List<int?> { 4, 4, 4 }, Usage = new List<string> { "GPIO", "PWM" } });

            /* Port D Group(3) ============================================================================== */
            PinList.Add(new Pins { Name = "PD0", PinNumber = new List<int?> { 41, 63, 77 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD1", PinNumber = new List<int?> { 42, 64, 78 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD2", PinNumber = new List<int?> { 43, 65, 79 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD3", PinNumber = new List<int?> { 44, 66, 80 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD4", PinNumber = new List<int?> { 45, 67, 81 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD5", PinNumber = new List<int?> { 46, 68, 82 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD6", PinNumber = new List<int?> { 47, 69, 83 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD7", PinNumber = new List<int?> { 48, 70, 87 }, Usage = new List<string> { "GPIO" } });

            PinList.Add(new Pins { Name = "PD8", PinNumber = new List<int?> { 49, 71, 87 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD9", PinNumber = new List<int?> { 56, 78, 94 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD10", PinNumber = new List<int?> { 57, 79, 95 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD11", PinNumber = new List<int?> { 58, 80, 96 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD12", PinNumber = new List<int?> { 100 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD13", PinNumber = new List<int?> { 62, 84, 102 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD14", PinNumber = new List<int?> { 64, 86, 104 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PD15", PinNumber = new List<int?> { 66, 88, 106 }, Usage = new List<string> { "GPIO" } });

            /* Port E Group(4) ============================================================================== */
            PinList.Add(new Pins { Name = "PE0", PinNumber = new List<int?> { 6, 10, 18 }, Usage = new List<string> { "GPIO", "PWM", "CAN5 RX", "WakeUpInterrupt" } });
            PinList.Add(new Pins { Name = "PE1", PinNumber = new List<int?> { 8, 12, 20 }, Usage = new List<string> { "GPIO", "PWM", "CAN5 TX" } });
            PinList.Add(new Pins { Name = "PE2", PinNumber = new List<int?> { 89, 128, 156 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "PWM", "SPI1 IN" } });
            PinList.Add(new Pins { Name = "PE3", PinNumber = new List<int?> { 90, 129, 157 }, Usage = new List<string> { "GPIO", "PWM", "SPI1 OUT" } });
            PinList.Add(new Pins { Name = "PE4", PinNumber = new List<int?> { 93, 132, 160 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "PWM", "SPI1 CLK" } });
            PinList.Add(new Pins { Name = "PE5", PinNumber = new List<int?> { 94, 133, 161 }, Usage = new List<string> { "GPIO", "PWM" } });
            PinList.Add(new Pins { Name = "PE6", PinNumber = new List<int?> { 95, 139, 167 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "PWM" } });
            PinList.Add(new Pins { Name = "PE7", PinNumber = new List<int?> { 96, 140, 168 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "PWM" } });

            PinList.Add(new Pins { Name = "PE8", PinNumber = new List<int?> { 9, 13, 21 }, Usage = new List<string> { "GPIO", "CAN2 TX", "CAN3 TX" } });
            PinList.Add(new Pins { Name = "PE9", PinNumber = new List<int?> { 10, 14, 22 }, Usage = new List<string> { "GPIO", "CAN2 RX", "CAN3 RX", "WakeUpInterrupt" } });
            PinList.Add(new Pins { Name = "PE10", PinNumber = new List<int?> { 11, 15, 23 }, Usage = new List<string> { "GPIO", "ExternalInterrup" } });
            PinList.Add(new Pins { Name = "PE11", PinNumber = new List<int?> { 13, 17, 25 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PE12", PinNumber = new List<int?> { 76, 109, 133 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "SPI2 IN" } });
            PinList.Add(new Pins { Name = "PE13", PinNumber = new List<int?> { 103, 127 }, Usage = new List<string> { "GPIO", "PWM", "SPI2 OUT" } });
            PinList.Add(new Pins { Name = "PE14", PinNumber = new List<int?> { 112, 136 }, Usage = new List<string> { "GPIO", "PWM", "ExternalInterrup", "SPI2 CLK" } });
            PinList.Add(new Pins { Name = "PE15", PinNumber = new List<int?> { 113, 137 }, Usage = new List<string> { "GPIO", "PWM" } });

            /* Port F Group(5) ============================================================================== */
            PinList.Add(new Pins { Name = "PF0", PinNumber = new List<int?> { 55, 63 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PF1", PinNumber = new List<int?> { 56, 64 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PF2", PinNumber = new List<int?> { 57, 65 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PF3", PinNumber = new List<int?> { 58, 66 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PF4", PinNumber = new List<int?> { 59, 67 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PF5", PinNumber = new List<int?> { 60, 68 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PF6", PinNumber = new List<int?> { 61, 69 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PF7", PinNumber = new List<int?> { 62, 70 }, Usage = new List<string> { "GPIO" } });

            PinList.Add(new Pins { Name = "PF8", PinNumber = new List<int?> { 34, 42 }, Usage = new List<string> { "GPIO", "CAN2 TX", "CAN3 TX" } });
            PinList.Add(new Pins { Name = "PF9", PinNumber = new List<int?> { 33, 41 }, Usage = new List<string> { "GPIO", "CAN2 RX", "CAN3 RX" } });
            PinList.Add(new Pins { Name = "PF10", PinNumber = new List<int?> { 38, 46 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PF11", PinNumber = new List<int?> { 39, 47 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PF12", PinNumber = new List<int?> { 35, 43 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PF13", PinNumber = new List<int?> { 41, 49 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PF14", PinNumber = new List<int?> { 102, 126 }, Usage = new List<string> { "GPIO", "CAN1 TX", "CAN4 TX" } });
            PinList.Add(new Pins { Name = "PF15", PinNumber = new List<int?> { 101, 125 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "CAN1 RX", "CAN1 RX" } });

            /* Port G Group(6) ============================================================================== */
            PinList.Add(new Pins { Name = "PG0", PinNumber = new List<int?> { 98, 122 }, Usage = new List<string> { "GPIO", "PWM", "CAN5 TX" } });
            PinList.Add(new Pins { Name = "PG1", PinNumber = new List<int?> { 97, 121 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "PWM", "CAN5 RX" } });
            PinList.Add(new Pins { Name = "PG2", PinNumber = new List<int?> { 8, 16 }, Usage = new List<string> { "GPIO", "PWM", "SPI3 OUT" } });
            PinList.Add(new Pins { Name = "PG3", PinNumber = new List<int?> { 7, 15 }, Usage = new List<string> { "GPIO", "PWM" } });
            PinList.Add(new Pins { Name = "PG4", PinNumber = new List<int?> { 6, 14 }, Usage = new List<string> { "GPIO", "PWM", "SPI3 CLK" } });
            PinList.Add(new Pins { Name = "PG5", PinNumber = new List<int?> { 5, 13 }, Usage = new List<string> { "GPIO", "PWM", "SPI3 IN" } });
            PinList.Add(new Pins { Name = "PG6", PinNumber = new List<int?> { 30, 38 }, Usage = new List<string> { "GPIO", "PWM" } });
            PinList.Add(new Pins { Name = "PG7", PinNumber = new List<int?> { 29, 37 }, Usage = new List<string> { "GPIO", "PWM" } });

            PinList.Add(new Pins { Name = "PG8", PinNumber = new List<int?> { 26, 34 }, Usage = new List<string> { "GPIO", "ExternalInterrup", "PWM" } });
            PinList.Add(new Pins { Name = "PG9", PinNumber = new List<int?> { 25, 33 }, Usage = new List<string> { "GPIO", "PWM", "SPI2 CLK" } });
            PinList.Add(new Pins { Name = "PG10", PinNumber = new List<int?> { 114, 138 }, Usage = new List<string> { "GPIO", "PWM", "SPI2 IN" } });
            PinList.Add(new Pins { Name = "PG11", PinNumber = new List<int?> { 115, 139 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PG12", PinNumber = new List<int?> { 92, 116 }, Usage = new List<string> { "GPIO", "SPI4 OUT" } });
            PinList.Add(new Pins { Name = "PG13", PinNumber = new List<int?> { 91, 115 }, Usage = new List<string> { "GPIO", "SPI4 CLK" } });
            PinList.Add(new Pins { Name = "PG14", PinNumber = new List<int?> { 110, 134 }, Usage = new List<string> { "GPIO", "PWM" } });
            PinList.Add(new Pins { Name = "PG15", PinNumber = new List<int?> { 111, 135 }, Usage = new List<string> { "GPIO", "PWM" } });

            /* Port H Group(7) ============================================================================== */
            PinList.Add(new Pins { Name = "PH0", PinNumber = new List<int?> { 93, 117 }, Usage = new List<string> { "GPIO", "PWM", "SPI1 IN" } });
            PinList.Add(new Pins { Name = "PH1", PinNumber = new List<int?> { 94, 118 }, Usage = new List<string> { "GPIO", "PWM", "SPI1 OUT" } });
            PinList.Add(new Pins { Name = "PH2", PinNumber = new List<int?> { 95, 119 }, Usage = new List<string> { "GPIO", "PWM", "SPI1 CLK" } });
            PinList.Add(new Pins { Name = "PH3", PinNumber = new List<int?> { 96, 120 }, Usage = new List<string> { "GPIO", "PWM" } });
            PinList.Add(new Pins { Name = "PH4", PinNumber = new List<int?> { 134, 162 }, Usage = new List<string> { "GPIO", "PWM" } });
            PinList.Add(new Pins { Name = "PH5", PinNumber = new List<int?> { 135, 163 }, Usage = new List<string> { "GPIO", "PWM" } });
            PinList.Add(new Pins { Name = "PH6", PinNumber = new List<int?> { 136, 164 }, Usage = new List<string> { "GPIO", "PWM" } });
            PinList.Add(new Pins { Name = "PH7", PinNumber = new List<int?> { 137, 165 }, Usage = new List<string> { "GPIO", "PWM" } });

            PinList.Add(new Pins { Name = "PH8", PinNumber = new List<int?> { 138, 166 }, Usage = new List<string> { "GPIO", "PWM" } });
            PinList.Add(new Pins { Name = "PH9", PinNumber = new List<int?> { 88, 127, 155 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PH10", PinNumber = new List<int?> { 81, 120, 148 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PH11", PinNumber = new List<int?> { 140 }, Usage = new List<string> { "GPIO", "SPI3 OUT" } });
            PinList.Add(new Pins { Name = "PH12", PinNumber = new List<int?> { 141 }, Usage = new List<string> { "GPIO", "SPI3 CLK" } });
            PinList.Add(new Pins { Name = "PH13", PinNumber = new List<int?> { 9 }, Usage = new List<string> { "GPIO", "SPI4 OUT" } });
            PinList.Add(new Pins { Name = "PH14", PinNumber = new List<int?> { 10 }, Usage = new List<string> { "GPIO", "SPI4 CLK" } });
            PinList.Add(new Pins { Name = "PH15", PinNumber = new List<int?> { 8 }, Usage = new List<string> { "GPIO", "SPI5 OUT" } });

            /* Port I Group(8) ============================================================================== */
            PinList.Add(new Pins { Name = "PI0", PinNumber = new List<int?> { 172 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI1", PinNumber = new List<int?> { 171 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI2", PinNumber = new List<int?> { 170 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI3", PinNumber = new List<int?> { 169 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI4", PinNumber = new List<int?> { 143 }, Usage = new List<string> { "GPIO", "SPI4 OUT" } });
            PinList.Add(new Pins { Name = "PI5", PinNumber = new List<int?> { 142 }, Usage = new List<string> { "GPIO", "SPI4 CLK" } });
            PinList.Add(new Pins { Name = "PI6", PinNumber = new List<int?> { 11 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI7", PinNumber = new List<int?> { 12 }, Usage = new List<string> { "GPIO" } });

            PinList.Add(new Pins { Name = "PI8", PinNumber = new List<int?> { 108 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI9", PinNumber = new List<int?> { 109 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI10", PinNumber = new List<int?> { 110 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI11", PinNumber = new List<int?> { 111 }, Usage = new List<string> { "GPIO", "SPI3 IN" } });
            PinList.Add(new Pins { Name = "PI12", PinNumber = new List<int?> { 112 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI13", PinNumber = new List<int?> { 113 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI14", PinNumber = new List<int?> { 76 }, Usage = new List<string> { "GPIO", "SPI4 IN" } });
            PinList.Add(new Pins { Name = "PI15", PinNumber = new List<int?> { 75 }, Usage = new List<string> { "GPIO" } });

            /* Port J Group(9) ============================================================================== */
            PinList.Add(new Pins { Name = "PI0", PinNumber = new List<int?> { 74 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI1", PinNumber = new List<int?> { 73 }, Usage = new List<string> { "GPIO", "SPI5 IN" } });
            PinList.Add(new Pins { Name = "PI2", PinNumber = new List<int?> { 72 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI3", PinNumber = new List<int?> { 71 }, Usage = new List<string> { "GPIO" } });
            PinList.Add(new Pins { Name = "PI4", PinNumber = new List<int?> { 5 }, Usage = new List<string> { "GPIO", "SPI5 CLK" } });

            int PinNum = 0;

            if (pinNumber == "100 Pin") PinNum = 3;
            else if (pinNumber == "144 Pin") PinNum = 2;
            else if (pinNumber == "176 Pin") PinNum = 1;

            PinList.RemoveAll((Pins p) => p.PinNumber.Count() < PinNum);
        }

        public List<string> PortNameList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Select((Pins pin) => pin.Name).ToList();
                return list;
            }
        }

        public List<string> Can0RxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pins Possible) => Possible.Usage.Contains("CAN0 RX")).Select((Pins RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can0TxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pins Possible) => Possible.Usage.Contains("CAN0 TX")).Select((Pins RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can1RxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pins Possible) => Possible.Usage.Contains("CAN1 RX")).Select((Pins RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can1TxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pins Possible) => Possible.Usage.Contains("CAN1 TX")).Select((Pins RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can2RxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pins Possible) => Possible.Usage.Contains("CAN2 RX")).Select((Pins RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can2TxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pins Possible) => Possible.Usage.Contains("CAN2 TX")).Select((Pins RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can3RxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pins Possible) => Possible.Usage.Contains("CAN3 RX")).Select((Pins RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can3TxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pins Possible) => Possible.Usage.Contains("CAN3 TX")).Select((Pins RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can4RxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pins Possible) => Possible.Usage.Contains("CAN4 RX")).Select((Pins RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can4TxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pins Possible) => Possible.Usage.Contains("CAN4 TX")).Select((Pins RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
    }
    
}
