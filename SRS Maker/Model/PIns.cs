using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace SRS_Maker.Model
{
    public class Pin
    {
        public string Name { get; set; }
        public List<int?> PinNumber { get; set; }  // List's first element is 80 pin package's pin number, second element is 100 pin package...
        public List<string> Usage { get; set; }      // GPIO, ADC, CAN Tx, CAN Rx, SPI Tx, SPI Rx, SPI Clk, ASC Tx, ASC Rx, External Interrup, Input Capture, Output Compare, PWM 
    }

    public class Pins
    {
        public List<Pin> PinList { get; set; }

        public List<string> CanRxPinList
        {
            get
            {
                if(PinList == null)
                {
                    return null;
                }
                else
                {
                    var list = PinList.Where((Pin Possible) => Possible.Usage.Contains("CAN RX")).Select((Pin RxPin) => RxPin.Name).ToList();
                    return list;
                }
            }
        }

        public Pins()
        {
            try
            {
                PinList = new List<Pin>();
                
#if true
                /* Port A Group(0) ============================================================================== */
                PinList.Add(new Pin { Name = "PA0", PinNumber = new List<int?>  { 12, 16, 24 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
                PinList.Add(new Pin() { Name = "PA1", PinNumber = new List<int?> { 7, 11, 19 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
                PinList.Add(new Pin() { Name = "PA2", PinNumber = new List<int?> { 5, 9, 17 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
                PinList.Add(new Pin() { Name = "PA3", PinNumber = new List<int?> { 68, 90, 114 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
                PinList.Add(new Pin() { Name = "PA4", PinNumber = new List<int?> { 29, 43, 51 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
                PinList.Add(new Pin() { Name = "PA5", PinNumber = new List<int?> { 79, 118, 146 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
                PinList.Add(new Pin() { Name = "PA6", PinNumber = new List<int?> { 80, 119, 147 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
                PinList.Add(new Pin() { Name = "PA7", PinNumber = new List<int?> { 71, 104, 128 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });

                PinList.Add(new Pin() { Name = "PA8", PinNumber = new List<int?> { 72, 105, 129 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
                PinList.Add(new Pin() { Name = "PA9", PinNumber = new List<int?> { 73, 106, 130 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
                PinList.Add(new Pin() { Name = "PA10", PinNumber = new List<int?> { 74, 107, 131 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
                PinList.Add(new Pin() { Name = "PA11", PinNumber = new List<int?> { 75, 108, 132 }, Usage = new List<string> { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
                PinList.Add(new Pin() { Name = "PA12", PinNumber = new List<int?> { 31, 45, 53 }, Usage = new List<string> { "GPIO", "CAN RX" } });
                PinList.Add(new Pin() { Name = "PA13", PinNumber = new List<int?> { 30, 44, 52 }, Usage = new List<string> { "GPIO", "CAN RX" } });
                PinList.Add(new Pin() { Name = "PA14", PinNumber = new List<int?> { 28, 42, 50 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PA15", PinNumber = new List<int?> { 27, 40, 48 }, Usage = new List<string> { "GPIO" } });

                /* Port B Group(1) ============================================================================== */
                PinList.Add(new Pin() { Name = "PB0", PinNumber = new List<int?> { 23, 31, 39 }, Usage = new List<string> { "GPIO", "CAN RX" } });
                PinList.Add(new Pin() { Name = "PB1", PinNumber = new List<int?> { 24, 32, 40 }, Usage = new List<string> { "GPIO", "CAN TX" } });
                PinList.Add(new Pin() { Name = "PB2", PinNumber = new List<int?> { 100, 144, 176 }, Usage = new List<string> { "GPIO", "CAN RX" } });
                PinList.Add(new Pin() { Name = "PB3", PinNumber = new List<int?> { 1, 1, 1 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PB4", PinNumber = new List<int?> { 50, 72, 88 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PB5", PinNumber = new List<int?> { 53, 75, 91 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PB6", PinNumber = new List<int?> { 54, 76, 92 }, Usage = new List<string> { "GPIO", "CAN TX" } });
                PinList.Add(new Pin() { Name = "PB7", PinNumber = new List<int?> { 55, 77, 93 }, Usage = new List<string> { "GPIO" } });

                PinList.Add(new Pin() { Name = "PB7", PinNumber = new List<int?> { 39, 53, 61 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PB8", PinNumber = new List<int?> { 38, 52, 60 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PB9", PinNumber = new List<int?> { 40, 54, 62 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PB10", PinNumber = new List<int?> { 97 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PB11", PinNumber = new List<int?> { 61, 83, 101 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PB12", PinNumber = new List<int?> { 63, 85, 103 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PB13", PinNumber = new List<int?> { 65, 87, 105 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PB14", PinNumber = new List<int?> { 67, 89, 107 }, Usage = new List<string> { "GPIO", "CAN TX" } });

                /* Port C Group(2) ============================================================================== */
                PinList.Add(new Pin() { Name = "PC0", PinNumber = new List<int?> { 87, 126, 154 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PC1", PinNumber = new List<int?> { 82, 121, 149 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PC2", PinNumber = new List<int?> { 78, 117, 145 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PC3", PinNumber = new List<int?> { 77, 116, 144 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PC4", PinNumber = new List<int?> { 92, 131, 159 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PC5", PinNumber = new List<int?> { 91, 130, 158 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PC6", PinNumber = new List<int?> { 25, 36, 44 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PC7", PinNumber = new List<int?> { 26, 37, 45 }, Usage = new List<string> { "GPIO" } });

                PinList.Add(new Pin() { Name = "PC8", PinNumber = new List<int?> { 99, 143, 175 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PC9", PinNumber = new List<int?> { 2, 2, 2 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PC10", PinNumber = new List<int?> { 22, 28, 36 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PC11", PinNumber = new List<int?> { 21, 27, 35 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PC12", PinNumber = new List<int?> { 97, 141, 173 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PC13", PinNumber = new List<int?> { 98, 142, 174 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PC14", PinNumber = new List<int?> { 3, 3, 3 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PC15", PinNumber = new List<int?> { 4, 4, 4 }, Usage = new List<string> { "GPIO", "PWM" } });

                /* Port D Group(3) ============================================================================== */
                PinList.Add(new Pin() { Name = "PD0", PinNumber = new List<int?> { 41, 63, 77 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD1", PinNumber = new List<int?> { 42, 64, 78 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD2", PinNumber = new List<int?> { 43, 65, 79 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD3", PinNumber = new List<int?> { 44, 66, 80 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD4", PinNumber = new List<int?> { 45, 67, 81 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD5", PinNumber = new List<int?> { 46, 68, 82 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD6", PinNumber = new List<int?> { 47, 69, 83 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD7", PinNumber = new List<int?> { 48, 70, 87 }, Usage = new List<string> { "GPIO" } });

                PinList.Add(new Pin() { Name = "PD8", PinNumber = new List<int?> { 49, 71, 87 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD9", PinNumber = new List<int?> { 56, 78, 94 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD10", PinNumber = new List<int?> { 57, 79, 95 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD11", PinNumber = new List<int?> { 58, 80, 96 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD12", PinNumber = new List<int?> { 100 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD13", PinNumber = new List<int?> { 62, 84, 102 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD14", PinNumber = new List<int?> { 64, 86, 104 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PD15", PinNumber = new List<int?> { 66, 88, 106 }, Usage = new List<string> { "GPIO" } });

                /* Port E Group(4) ============================================================================== */
                PinList.Add(new Pin() { Name = "PE0", PinNumber = new List<int?> { 6, 10, 18 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PE1", PinNumber = new List<int?> { 8, 12, 20 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PE2", PinNumber = new List<int?> { 89, 128, 156 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PE3", PinNumber = new List<int?> { 90, 129, 157 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PE4", PinNumber = new List<int?> { 93, 132, 160 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PE5", PinNumber = new List<int?> { 94, 133, 161 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PE6", PinNumber = new List<int?> { 95, 139, 167 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PE7", PinNumber = new List<int?> { 96, 140, 168 }, Usage = new List<string> { "GPIO", "PWM" } });

                PinList.Add(new Pin() { Name = "PE8", PinNumber = new List<int?> { 9, 13, 21 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PE9", PinNumber = new List<int?> { 10, 14, 22 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PE10", PinNumber = new List<int?> { 11, 15, 23 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PE11", PinNumber = new List<int?> { 13, 17, 25 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PE12", PinNumber = new List<int?> { 76, 109, 133 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PE13", PinNumber = new List<int?> { 103, 127 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PE14", PinNumber = new List<int?> { 112, 136 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PE15", PinNumber = new List<int?> { 113, 137 }, Usage = new List<string> { "GPIO", "PWM" } });

                /* Port F Group(5) ============================================================================== */
                PinList.Add(new Pin() { Name = "PF0", PinNumber = new List<int?> { 55, 63 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF1", PinNumber = new List<int?> { 56, 64 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF2", PinNumber = new List<int?> { 57, 65 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF3", PinNumber = new List<int?> { 58, 66 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF4", PinNumber = new List<int?> { 59, 67 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF5", PinNumber = new List<int?> { 60, 68 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF6", PinNumber = new List<int?> { 61, 69 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF7", PinNumber = new List<int?> { 62, 70 }, Usage = new List<string> { "GPIO" } });

                PinList.Add(new Pin() { Name = "PF8", PinNumber = new List<int?> { 34, 42 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF9", PinNumber = new List<int?> { 33, 41 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF10", PinNumber = new List<int?> { 38, 46 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF11", PinNumber = new List<int?> { 39, 47 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF12", PinNumber = new List<int?> { 35, 43 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF13", PinNumber = new List<int?> { 41, 49 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF14", PinNumber = new List<int?> { 102, 126 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PF15", PinNumber = new List<int?> { 101, 125 }, Usage = new List<string> { "GPIO" } });

                /* Port G Group(6) ============================================================================== */
                PinList.Add(new Pin() { Name = "PG0", PinNumber = new List<int?> { 98, 122 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PG1", PinNumber = new List<int?> { 97, 121 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PG2", PinNumber = new List<int?> { 8, 16 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PG3", PinNumber = new List<int?> { 7, 15 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PG4", PinNumber = new List<int?> { 6, 14 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PG5", PinNumber = new List<int?> { 5, 13 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PG6", PinNumber = new List<int?> { 30, 38 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PG7", PinNumber = new List<int?> { 29, 37 }, Usage = new List<string> { "GPIO", "PWM" } });

                PinList.Add(new Pin() { Name = "PG8", PinNumber = new List<int?> { 26, 34 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PG9", PinNumber = new List<int?> { 25, 33 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PG10", PinNumber = new List<int?> { 114, 138 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PG11", PinNumber = new List<int?> { 115, 139 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PG12", PinNumber = new List<int?> { 92, 116 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PG13", PinNumber = new List<int?> { 91, 115 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PG14", PinNumber = new List<int?> { 110, 134 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PG15", PinNumber = new List<int?> { 111, 135 }, Usage = new List<string> { "GPIO", "PWM" } });

                /* Port H Group(7) ============================================================================== */
                PinList.Add(new Pin() { Name = "PH0", PinNumber = new List<int?> { 93, 117 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PH1", PinNumber = new List<int?> { 94, 118 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PH2", PinNumber = new List<int?> { 95, 119 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PH3", PinNumber = new List<int?> { 96, 120 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PH4", PinNumber = new List<int?> { 134, 162 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PH5", PinNumber = new List<int?> { 135, 163 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PH6", PinNumber = new List<int?> { 136, 164 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PH7", PinNumber = new List<int?> { 137, 165 }, Usage = new List<string> { "GPIO", "PWM" } });

                PinList.Add(new Pin() { Name = "PH8", PinNumber = new List<int?> { 138, 166 }, Usage = new List<string> { "GPIO", "PWM" } });
                PinList.Add(new Pin() { Name = "PH9", PinNumber = new List<int?> { 88, 127, 155 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PH10", PinNumber = new List<int?> { 81, 120, 148 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PH11", PinNumber = new List<int?> { 140 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PH12", PinNumber = new List<int?> { 141 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PH13", PinNumber = new List<int?> { 9 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PH14", PinNumber = new List<int?> { 10 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PH15", PinNumber = new List<int?> { 8 }, Usage = new List<string> { "GPIO" } });

                /* Port I Group(8) ============================================================================== */
                PinList.Add(new Pin() { Name = "PI0", PinNumber = new List<int?> { 172 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI1", PinNumber = new List<int?> { 171 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI2", PinNumber = new List<int?> { 170 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI3", PinNumber = new List<int?> { 169 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI4", PinNumber = new List<int?> { 143 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI5", PinNumber = new List<int?> { 142 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI6", PinNumber = new List<int?> { 11 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI7", PinNumber = new List<int?> { 12 }, Usage = new List<string> { "GPIO" } });

                PinList.Add(new Pin() { Name = "PI8", PinNumber = new List<int?> { 108 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI9", PinNumber = new List<int?> { 109 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI10", PinNumber = new List<int?> { 110 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI11", PinNumber = new List<int?> { 111 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI12", PinNumber = new List<int?> { 112 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI13", PinNumber = new List<int?> { 113 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI14", PinNumber = new List<int?> { 76 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI15", PinNumber = new List<int?> { 75 }, Usage = new List<string> { "GPIO" } });

                /* Port J Group(9) ============================================================================== */
                PinList.Add(new Pin() { Name = "PI0", PinNumber = new List<int?> { 74 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI1", PinNumber = new List<int?> { 73 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI2", PinNumber = new List<int?> { 72 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI3", PinNumber = new List<int?> { 71 }, Usage = new List<string> { "GPIO" } });
                PinList.Add(new Pin() { Name = "PI4", PinNumber = new List<int?> { 5 }, Usage = new List<string> { "GPIO" } });
#endif
            }
        catch
            {
                MessageBox.Show("오류 발생 !!");
            }


        }
    }
    
}
