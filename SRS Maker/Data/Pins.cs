using SRS_Maker.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRS_Maker.Data
{
     
    public class Pins
    {
        public List<Pin> PinList { get; set; }

        public Pins(string pinNumber)
        {
            PinList = new List<Pin>();

            /* Port A Group(0) ============================================================================== */
            PinList.Add(new Pin { Name = "PA0", PinNumber = new List<int?> { 12, 16, 24 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PA1", PinNumber = new List<int?> { 7, 11, 19 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PA2", PinNumber = new List<int?> { 5, 9, 17 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PA3", PinNumber = new List<int?> { 68, 90, 114 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PA4", PinNumber = new List<int?> { 29, 43, 51 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PA5", PinNumber = new List<int?> { 79, 118, 146 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PA6", PinNumber = new List<int?> { 80, 119, 147 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PA7", PinNumber = new List<int?> { 71, 104, 128 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });

            PinList.Add(new Pin { Name = "PA8", PinNumber = new List<int?> { 72, 105, 129 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PA9", PinNumber = new List<int?> { 73, 106, 130 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PA10", PinNumber = new List<int?> { 74, 107, 131 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PA11", PinNumber = new List<int?> { 75, 108, 132 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PA12", PinNumber = new List<int?> { 31, 45, 53 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "SPI0 IN" } });
            PinList.Add(new Pin { Name = "PA13", PinNumber = new List<int?> { 30, 44, 52 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI0 OUT" } });
            PinList.Add(new Pin { Name = "PA14", PinNumber = new List<int?> { 28, 42, 50 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "SPI0 CLK" } });
            PinList.Add(new Pin { Name = "PA15", PinNumber = new List<int?> { 27, 40, 48 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI0 CLK" } });

            /* Port B Group(1) ============================================================================== */
            PinList.Add(new Pin { Name = "PB0", PinNumber = new List<int?> { 23, 31, 39 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN0 TX" } });
            PinList.Add(new Pin { Name = "PB1", PinNumber = new List<int?> { 24, 32, 40 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN0 RX", "WakeUpInterrupt" } });
            PinList.Add(new Pin { Name = "PB2", PinNumber = new List<int?> { 100, 144, 176 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "CAN RX" } });
            PinList.Add(new Pin { Name = "PB3", PinNumber = new List<int?> { 1, 1, 1 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PB4", PinNumber = new List<int?> { 50, 72, 88 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PB5", PinNumber = new List<int?> { 53, 75, 91 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PB6", PinNumber = new List<int?> { 54, 76, 92 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN TX" } });
            PinList.Add(new Pin { Name = "PB7", PinNumber = new List<int?> { 55, 77, 93 }, PossibleUsage = new List<string> { "General Input", "General Output" } });

            PinList.Add(new Pin { Name = "PB7", PinNumber = new List<int?> { 39, 53, 61 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PB8", PinNumber = new List<int?> { 38, 52, 60 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PB9", PinNumber = new List<int?> { 40, 54, 62 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PB10", PinNumber = new List<int?> { 97 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PB11", PinNumber = new List<int?> { 61, 83, 101 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PB12", PinNumber = new List<int?> { 63, 85, 103 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PB13", PinNumber = new List<int?> { 65, 87, 105 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PB14", PinNumber = new List<int?> { 67, 89, 107 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "CAN TX" } });

            /* Port C Group(2) ============================================================================== */
            PinList.Add(new Pin { Name = "PC0", PinNumber = new List<int?> { 87, 126, 154 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PC1", PinNumber = new List<int?> { 82, 121, 149 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PC2", PinNumber = new List<int?> { 78, 117, 145 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN4 TX", "SPI1 CLK" } });
            PinList.Add(new Pin { Name = "PC3", PinNumber = new List<int?> { 77, 116, 144 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN1 RX", "CAN4 RX" } });
            PinList.Add(new Pin { Name = "PC4", PinNumber = new List<int?> { 92, 131, 159 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN3 RX", "SPI1 IN" } });
            PinList.Add(new Pin { Name = "PC5", PinNumber = new List<int?> { 91, 130, 158 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN3 TX", "SPI1 OUT" } });
            PinList.Add(new Pin { Name = "PC6", PinNumber = new List<int?> { 25, 36, 44 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PC7", PinNumber = new List<int?> { 26, 37, 45 }, PossibleUsage = new List<string> { "General Input", "General Output" } });

            PinList.Add(new Pin { Name = "PC8", PinNumber = new List<int?> { 99, 143, 175 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PC9", PinNumber = new List<int?> { 2, 2, 2 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PC10", PinNumber = new List<int?> { 22, 28, 36 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN1 TX", "CAN4 RX" } });
            PinList.Add(new Pin { Name = "PC11", PinNumber = new List<int?> { 21, 27, 35 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN1 RX", "CAN4 RX", "WakeUpInterrupt" } });
            PinList.Add(new Pin { Name = "PC12", PinNumber = new List<int?> { 97, 141, 173 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI2 IN" } });
            PinList.Add(new Pin { Name = "PC13", PinNumber = new List<int?> { 98, 142, 174 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI2 OUT" } });
            PinList.Add(new Pin { Name = "PC14", PinNumber = new List<int?> { 3, 3, 3 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI2 CLK" } });
            PinList.Add(new Pin { Name = "PC15", PinNumber = new List<int?> { 4, 4, 4 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });

            /* Port D Group(3) ============================================================================== */
            PinList.Add(new Pin { Name = "PD0", PinNumber = new List<int?> { 41, 63, 77 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD1", PinNumber = new List<int?> { 42, 64, 78 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD2", PinNumber = new List<int?> { 43, 65, 79 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD3", PinNumber = new List<int?> { 44, 66, 80 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD4", PinNumber = new List<int?> { 45, 67, 81 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD5", PinNumber = new List<int?> { 46, 68, 82 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD6", PinNumber = new List<int?> { 47, 69, 83 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD7", PinNumber = new List<int?> { 48, 70, 87 }, PossibleUsage = new List<string> { "General Input", "General Output" } });

            PinList.Add(new Pin { Name = "PD8", PinNumber = new List<int?> { 49, 71, 87 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD9", PinNumber = new List<int?> { 56, 78, 94 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD10", PinNumber = new List<int?> { 57, 79, 95 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD11", PinNumber = new List<int?> { 58, 80, 96 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD12", PinNumber = new List<int?> { 100 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD13", PinNumber = new List<int?> { 62, 84, 102 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD14", PinNumber = new List<int?> { 64, 86, 104 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PD15", PinNumber = new List<int?> { 66, 88, 106 }, PossibleUsage = new List<string> { "General Input", "General Output" } });

            /* Port E Group(4) ============================================================================== */
            PinList.Add(new Pin { Name = "PE0", PinNumber = new List<int?> { 6, 10, 18 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "CAN5 RX", "WakeUpInterrupt" } });
            PinList.Add(new Pin { Name = "PE1", PinNumber = new List<int?> { 8, 12, 20 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "CAN5 TX" } });
            PinList.Add(new Pin { Name = "PE2", PinNumber = new List<int?> { 89, 128, 156 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "PWM", "SPI1 IN" } });
            PinList.Add(new Pin { Name = "PE3", PinNumber = new List<int?> { 90, 129, 157 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI1 OUT" } });
            PinList.Add(new Pin { Name = "PE4", PinNumber = new List<int?> { 93, 132, 160 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "PWM", "SPI1 CLK" } });
            PinList.Add(new Pin { Name = "PE5", PinNumber = new List<int?> { 94, 133, 161 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });
            PinList.Add(new Pin { Name = "PE6", PinNumber = new List<int?> { 95, 139, 167 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "PWM" } });
            PinList.Add(new Pin { Name = "PE7", PinNumber = new List<int?> { 96, 140, 168 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "PWM" } });

            PinList.Add(new Pin { Name = "PE8", PinNumber = new List<int?> { 9, 13, 21 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN2 TX", "CAN3 TX" } });
            PinList.Add(new Pin { Name = "PE9", PinNumber = new List<int?> { 10, 14, 22 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN2 RX", "CAN3 RX", "WakeUpInterrupt" } });
            PinList.Add(new Pin { Name = "PE10", PinNumber = new List<int?> { 11, 15, 23 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup" } });
            PinList.Add(new Pin { Name = "PE11", PinNumber = new List<int?> { 13, 17, 25 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PE12", PinNumber = new List<int?> { 76, 109, 133 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "SPI2 IN" } });
            PinList.Add(new Pin { Name = "PE13", PinNumber = new List<int?> { 103, 127 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI2 OUT" } });
            PinList.Add(new Pin { Name = "PE14", PinNumber = new List<int?> { 112, 136 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "ExternalInterrup", "SPI2 CLK" } });
            PinList.Add(new Pin { Name = "PE15", PinNumber = new List<int?> { 113, 137 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });

            /* Port F Group(5) ============================================================================== */
            PinList.Add(new Pin { Name = "PF0", PinNumber = new List<int?> { 55, 63 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PF1", PinNumber = new List<int?> { 56, 64 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PF2", PinNumber = new List<int?> { 57, 65 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PF3", PinNumber = new List<int?> { 58, 66 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PF4", PinNumber = new List<int?> { 59, 67 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PF5", PinNumber = new List<int?> { 60, 68 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PF6", PinNumber = new List<int?> { 61, 69 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PF7", PinNumber = new List<int?> { 62, 70 }, PossibleUsage = new List<string> { "General Input", "General Output" } });

            PinList.Add(new Pin { Name = "PF8", PinNumber = new List<int?> { 34, 42 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN2 TX", "CAN3 TX" } });
            PinList.Add(new Pin { Name = "PF9", PinNumber = new List<int?> { 33, 41 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN2 RX", "CAN3 RX" } });
            PinList.Add(new Pin { Name = "PF10", PinNumber = new List<int?> { 38, 46 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PF11", PinNumber = new List<int?> { 39, 47 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PF12", PinNumber = new List<int?> { 35, 43 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PF13", PinNumber = new List<int?> { 41, 49 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PF14", PinNumber = new List<int?> { 102, 126 }, PossibleUsage = new List<string> { "General Input", "General Output", "CAN1 TX", "CAN4 TX" } });
            PinList.Add(new Pin { Name = "PF15", PinNumber = new List<int?> { 101, 125 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "CAN1 RX", "CAN1 RX" } });

            /* Port G Group(6) ============================================================================== */
            PinList.Add(new Pin { Name = "PG0", PinNumber = new List<int?> { 98, 122 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "CAN5 TX" } });
            PinList.Add(new Pin { Name = "PG1", PinNumber = new List<int?> { 97, 121 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "PWM", "CAN5 RX" } });
            PinList.Add(new Pin { Name = "PG2", PinNumber = new List<int?> { 8, 16 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI3 OUT" } });
            PinList.Add(new Pin { Name = "PG3", PinNumber = new List<int?> { 7, 15 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });
            PinList.Add(new Pin { Name = "PG4", PinNumber = new List<int?> { 6, 14 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI3 CLK" } });
            PinList.Add(new Pin { Name = "PG5", PinNumber = new List<int?> { 5, 13 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI3 IN" } });
            PinList.Add(new Pin { Name = "PG6", PinNumber = new List<int?> { 30, 38 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });
            PinList.Add(new Pin { Name = "PG7", PinNumber = new List<int?> { 29, 37 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });

            PinList.Add(new Pin { Name = "PG8", PinNumber = new List<int?> { 26, 34 }, PossibleUsage = new List<string> { "General Input", "General Output", "ExternalInterrup", "PWM" } });
            PinList.Add(new Pin { Name = "PG9", PinNumber = new List<int?> { 25, 33 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI2 CLK" } });
            PinList.Add(new Pin { Name = "PG10", PinNumber = new List<int?> { 114, 138 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI2 IN" } });
            PinList.Add(new Pin { Name = "PG11", PinNumber = new List<int?> { 115, 139 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PG12", PinNumber = new List<int?> { 92, 116 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI4 OUT" } });
            PinList.Add(new Pin { Name = "PG13", PinNumber = new List<int?> { 91, 115 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI4 CLK" } });
            PinList.Add(new Pin { Name = "PG14", PinNumber = new List<int?> { 110, 134 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });
            PinList.Add(new Pin { Name = "PG15", PinNumber = new List<int?> { 111, 135 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });

            /* Port H Group(7) ============================================================================== */
            PinList.Add(new Pin { Name = "PH0", PinNumber = new List<int?> { 93, 117 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI1 IN" } });
            PinList.Add(new Pin { Name = "PH1", PinNumber = new List<int?> { 94, 118 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI1 OUT" } });
            PinList.Add(new Pin { Name = "PH2", PinNumber = new List<int?> { 95, 119 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM", "SPI1 CLK" } });
            PinList.Add(new Pin { Name = "PH3", PinNumber = new List<int?> { 96, 120 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });
            PinList.Add(new Pin { Name = "PH4", PinNumber = new List<int?> { 134, 162 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });
            PinList.Add(new Pin { Name = "PH5", PinNumber = new List<int?> { 135, 163 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });
            PinList.Add(new Pin { Name = "PH6", PinNumber = new List<int?> { 136, 164 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });
            PinList.Add(new Pin { Name = "PH7", PinNumber = new List<int?> { 137, 165 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });

            PinList.Add(new Pin { Name = "PH8", PinNumber = new List<int?> { 138, 166 }, PossibleUsage = new List<string> { "General Input", "General Output", "PWM" } });
            PinList.Add(new Pin { Name = "PH9", PinNumber = new List<int?> { 88, 127, 155 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PH10", PinNumber = new List<int?> { 81, 120, 148 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PH11", PinNumber = new List<int?> { 140 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI3 OUT" } });
            PinList.Add(new Pin { Name = "PH12", PinNumber = new List<int?> { 141 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI3 CLK" } });
            PinList.Add(new Pin { Name = "PH13", PinNumber = new List<int?> { 9 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI4 OUT" } });
            PinList.Add(new Pin { Name = "PH14", PinNumber = new List<int?> { 10 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI4 CLK" } });
            PinList.Add(new Pin { Name = "PH15", PinNumber = new List<int?> { 8 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI5 OUT" } });

            /* Port I Group(8) ============================================================================== */
            PinList.Add(new Pin { Name = "PI0", PinNumber = new List<int?> { 172 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI1", PinNumber = new List<int?> { 171 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI2", PinNumber = new List<int?> { 170 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI3", PinNumber = new List<int?> { 169 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI4", PinNumber = new List<int?> { 143 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI4 OUT" } });
            PinList.Add(new Pin { Name = "PI5", PinNumber = new List<int?> { 142 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI4 CLK" } });
            PinList.Add(new Pin { Name = "PI6", PinNumber = new List<int?> { 11 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI7", PinNumber = new List<int?> { 12 }, PossibleUsage = new List<string> { "General Input", "General Output" } });

            PinList.Add(new Pin { Name = "PI8", PinNumber = new List<int?> { 108 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI9", PinNumber = new List<int?> { 109 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI10", PinNumber = new List<int?> { 110 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI11", PinNumber = new List<int?> { 111 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI3 IN" } });
            PinList.Add(new Pin { Name = "PI12", PinNumber = new List<int?> { 112 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI13", PinNumber = new List<int?> { 113 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI14", PinNumber = new List<int?> { 76 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI4 IN" } });
            PinList.Add(new Pin { Name = "PI15", PinNumber = new List<int?> { 75 }, PossibleUsage = new List<string> { "General Input", "General Output" } });

            /* Port J Group(9) ============================================================================== */
            PinList.Add(new Pin { Name = "PI0", PinNumber = new List<int?> { 74 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI1", PinNumber = new List<int?> { 73 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI5 IN" } });
            PinList.Add(new Pin { Name = "PI2", PinNumber = new List<int?> { 72 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI3", PinNumber = new List<int?> { 71 }, PossibleUsage = new List<string> { "General Input", "General Output" } });
            PinList.Add(new Pin { Name = "PI4", PinNumber = new List<int?> { 5 }, PossibleUsage = new List<string> { "General Input", "General Output", "SPI5 CLK" } });

            int PinNum = 0;

            if (pinNumber == "100 Pin") PinNum = 3;
            else if (pinNumber == "144 Pin") PinNum = 2;
            else if (pinNumber == "176 Pin") PinNum = 1;

            PinList.RemoveAll((Pin p) => p.PinNumber.Count() < PinNum);
        }

        public List<string> PortNameList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pin pin) => pin.SelectedUsage == "").Select((Pin pin) => pin.Name).ToList();
                return list;
            }
        }

        public List<string> Can0RxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pin Possible) => Possible.PossibleUsage.Contains("CAN0 RX")).Select((Pin RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can0TxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pin Possible) => Possible.PossibleUsage.Contains("CAN0 TX")).Select((Pin RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can1RxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pin Possible) => Possible.PossibleUsage.Contains("CAN1 RX")).Select((Pin RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can1TxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pin Possible) => Possible.PossibleUsage.Contains("CAN1 TX")).Select((Pin RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can2RxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pin Possible) => Possible.PossibleUsage.Contains("CAN2 RX")).Select((Pin RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can2TxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pin Possible) => Possible.PossibleUsage.Contains("CAN2 TX")).Select((Pin RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can3RxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pin Possible) => Possible.PossibleUsage.Contains("CAN3 RX")).Select((Pin RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can3TxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pin Possible) => Possible.PossibleUsage.Contains("CAN3 TX")).Select((Pin RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can4RxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pin Possible) => Possible.PossibleUsage.Contains("CAN4 RX")).Select((Pin RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
        public List<string> Can4TxPinList
        {
            get
            {
                if (PinList == null)
                    return null;
                var list = PinList.Where((Pin Possible) => Possible.PossibleUsage.Contains("CAN4 TX")).Select((Pin RxPin) => RxPin.Name).ToList();
                return list;
            }
        }
    }
}
