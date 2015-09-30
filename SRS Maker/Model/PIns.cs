using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRS_Maker.Model
{
    class Pin
    {
        public string Name { get; set; }
        public List<int?> PinNumber { get; set; }  // List's first element is 80 pin package's pin number, second element is 100 pin package...
        public List<string> Usage { get; set; }      // GPIO, ADC, CAN Tx, CAN Rx, SPI Tx, SPI Rx, SPI Clk, ASC Tx, ASC Rx, External Interrup, Input Capture, Output Compare, PWM 
        public List<string> AssociatedEmios { get; set; }      // GPIO, ADC, CAN Tx, CAN Rx, SPI Tx, SPI Rx, SPI Clk, ASC Tx, ASC Rx, External Interrup, Input Capture, Output Compare, PWM, 
    }

    class Pins
    {
        public List<Pin> PinList { get; set; }

        public Pins()
        {
            /* Port A Group(0) ============================================================================== */
            PinList.Add(new Pin() { Name = "PA0",  PinNumber = { 12,  16,  24  }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin() { Name = "PA1",  PinNumber = { 7,   11,  19  }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin() { Name = "PA2",  PinNumber = { 5,   9,   17  }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin() { Name = "PA3",  PinNumber = { 68,  90,  114 }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin() { Name = "PA4",  PinNumber = { 29,  43,  51  }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin() { Name = "PA5",  PinNumber = { 79,  118, 146 }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin() { Name = "PA6",  PinNumber = { 80,  119, 147 }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin() { Name = "PA7",  PinNumber = { 71,  104, 128 }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });

            PinList.Add(new Pin() { Name = "PA8",  PinNumber = { 72,  105, 129 }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin() { Name = "PA9",  PinNumber = { 73,  106, 130 }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin() { Name = "PA10", PinNumber = { 74,  107, 131 }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin() { Name = "PA11", PinNumber = { 75,  108, 132 }, Usage = { "GPIO", "PWM", "InputCapture", "OutputCompare", "ExternalInterrup" } });
            PinList.Add(new Pin() { Name = "PA12", PinNumber = { 31,  45,  53  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PA13", PinNumber = { 30,  44,  52  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PA14", PinNumber = { 28,  42,  50  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PA15", PinNumber = { 27,  40,  48  }, Usage = { "GPIO" } });

            /* Port B Group(1) ============================================================================== */
            PinList.Add(new Pin() { Name = "PB0",  PinNumber = { 23,  31,  39  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB1",  PinNumber = { 24,  32,  40  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB2",  PinNumber = { 100, 144, 176 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB3",  PinNumber = { 1,   1,   1   }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB4",  PinNumber = { 50,  72,  88  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB5",  PinNumber = { 53,  75,  91  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB6",  PinNumber = { 54,  76,  92  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB7",  PinNumber = { 55,  77,  93  }, Usage = { "GPIO" } });

            PinList.Add(new Pin() { Name = "PB7",  PinNumber = { 39,  53,  61  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB8",  PinNumber = { 38,  52,  60  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB9",  PinNumber = { 40,  54,  62  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB10", PinNumber = {           97  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB11", PinNumber = { 61,  83,  101 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB12", PinNumber = { 63,  85,  103 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB13", PinNumber = { 65,  87,  105 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PB14", PinNumber = { 67,  89,  107 }, Usage = { "GPIO" } });

            /* Port C Group(2) ============================================================================== */
            PinList.Add(new Pin() { Name = "PC0",  PinNumber = { 87,  126, 154 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PC1",  PinNumber = { 82,  121, 149 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PC2",  PinNumber = { 78,  117, 145 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PC3",  PinNumber = { 77,  116, 144 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PC4",  PinNumber = { 92,  131, 159 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PC5",  PinNumber = { 91,  130, 158 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PC6",  PinNumber = { 25,  36,  44  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PC7",  PinNumber = { 26,  37,  45  }, Usage = { "GPIO" } });

            PinList.Add(new Pin() { Name = "PC8",  PinNumber = { 99,  143, 175 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PC9",  PinNumber = { 2,   2,   2   }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PC10", PinNumber = { 22,  28,  36  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PC11", PinNumber = { 21,  27,  35  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PC12", PinNumber = { 97,  141, 173 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PC13", PinNumber = { 98,  142, 174 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PC14", PinNumber = { 3,   3,   3   }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PC15", PinNumber = { 4,   4,   4   }, Usage = { "GPIO", "PWM" } });

            /* Port D Group(3) ============================================================================== */
            PinList.Add(new Pin() { Name = "PD0",  PinNumber = { 41,  63,  77  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD1",  PinNumber = { 42,  64,  78  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD2",  PinNumber = { 43,  65,  79  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD3",  PinNumber = { 44,  66,  80  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD4",  PinNumber = { 45,  67,  81  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD5",  PinNumber = { 46,  68,  82  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD6",  PinNumber = { 47,  69,  83  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD7",  PinNumber = { 48,  70,  87  }, Usage = { "GPIO" } });

            PinList.Add(new Pin() { Name = "PD8",  PinNumber = { 49,  71,  87  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD9",  PinNumber = { 56,  78,  94  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD10", PinNumber = { 57,  79,  95  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD11", PinNumber = { 58,  80,  96  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD12", PinNumber = {           100 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD13", PinNumber = { 62,  84,  102 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD14", PinNumber = { 64,  86,  104 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PD15", PinNumber = { 66,  88,  106 }, Usage = { "GPIO" } });

            /* Port E Group(4) ============================================================================== */
            PinList.Add(new Pin() { Name = "PE0",  PinNumber = { 6,   10,  18  }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PE1",  PinNumber = { 8,   12,  20  }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PE2",  PinNumber = { 89,  128, 156 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PE3",  PinNumber = { 90,  129, 157 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PE4",  PinNumber = { 93,  132, 160 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PE5",  PinNumber = { 94,  133, 161 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PE6",  PinNumber = { 95,  139, 167 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PE7",  PinNumber = { 96,  140, 168 }, Usage = { "GPIO", "PWM" } });

            PinList.Add(new Pin() { Name = "PE8",  PinNumber = { 9,   13,  21  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PE9",  PinNumber = { 10,  14,  22  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PE10", PinNumber = { 11,  15,  23  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PE11", PinNumber = { 13,  17,  25  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PE12", PinNumber = { 76,  109, 133 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PE13", PinNumber = {      103, 127 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PE14", PinNumber = {      112, 136 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PE15", PinNumber = {      113, 137 }, Usage = { "GPIO", "PWM" } });

            /* Port F Group(5) ============================================================================== */
            PinList.Add(new Pin() { Name = "PF0",  PinNumber = {      55,  63  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF1",  PinNumber = {      56,  64  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF2",  PinNumber = {      57,  65  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF3",  PinNumber = {      58,  66  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF4",  PinNumber = {      59,  67  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF5",  PinNumber = {      60,  68  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF6",  PinNumber = {      61,  69  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF7",  PinNumber = {      62,  70  }, Usage = { "GPIO" } });

            PinList.Add(new Pin() { Name = "PF8",  PinNumber = {      34,  42  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF9",  PinNumber = {      33,  41  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF10", PinNumber = {      38,  46  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF11", PinNumber = {      39,  47  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF12", PinNumber = {      35,  43  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF13", PinNumber = {      41,  49  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF14", PinNumber = {      102, 126 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PF15", PinNumber = {      101, 125 }, Usage = { "GPIO" } });

            /* Port G Group(6) ============================================================================== */
            PinList.Add(new Pin() { Name = "PG0",  PinNumber = {      98,  122 }, Usage = { "GPIO", "PWM"} });
            PinList.Add(new Pin() { Name = "PG1",  PinNumber = {      97,  121 }, Usage = { "GPIO", "PWM"} });
            PinList.Add(new Pin() { Name = "PG2",  PinNumber = {      8,   16  }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PG3",  PinNumber = {      7,   15  }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PG4",  PinNumber = {      6,   14  }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PG5",  PinNumber = {      5,   13  }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PG6",  PinNumber = {      30,  38  }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PG7",  PinNumber = {      29,  37  }, Usage = { "GPIO", "PWM" } });

            PinList.Add(new Pin() { Name = "PG8",  PinNumber = {      26,  34  }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PG9",  PinNumber = {      25,  33  }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PG10", PinNumber = {      114, 138 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PG11", PinNumber = {      115, 139 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PG12", PinNumber = {      92,  116 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PG13", PinNumber = {      91,  115 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PG14", PinNumber = {      110, 134 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PG15", PinNumber = {      111, 135 }, Usage = { "GPIO", "PWM" } });

            /* Port H Group(7) ============================================================================== */
            PinList.Add(new Pin() { Name = "PH0",  PinNumber = {      93,  117 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PH1",  PinNumber = {      94,  118 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PH2",  PinNumber = {      95,  119 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PH3",  PinNumber = {      96,  120 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PH4",  PinNumber = {      134, 162 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PH5",  PinNumber = {      135, 163 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PH6",  PinNumber = {      136, 164 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PH7",  PinNumber = {      137, 165 }, Usage = { "GPIO", "PWM" } });

            PinList.Add(new Pin() { Name = "PH8",  PinNumber = {      138, 166 }, Usage = { "GPIO", "PWM" } });
            PinList.Add(new Pin() { Name = "PH9",  PinNumber = { 88,  127, 155 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PH10", PinNumber = { 81,  120, 148 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PH11", PinNumber = {           140 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PH12", PinNumber = {           141 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PH13", PinNumber = {           9   }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PH14", PinNumber = {           10  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PH15", PinNumber = {           8   }, Usage = { "GPIO" } });

            /* Port I Group(8) ============================================================================== */
            PinList.Add(new Pin() { Name = "PI0",  PinNumber = {           172 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI1",  PinNumber = {           171 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI2",  PinNumber = {           170 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI3",  PinNumber = {           169 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI4",  PinNumber = {           143 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI5",  PinNumber = {           142 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI6",  PinNumber = {           11  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI7",  PinNumber = {           12  }, Usage = { "GPIO" } });

            PinList.Add(new Pin() { Name = "PI8",  PinNumber = {           108 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI9",  PinNumber = {           109 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI10", PinNumber = {           110 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI11", PinNumber = {           111 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI12", PinNumber = {           112 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI13", PinNumber = {           113 }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI14", PinNumber = {           76  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI15", PinNumber = {           75  }, Usage = { "GPIO" } });

            /* Port J Group(9) ============================================================================== */
            PinList.Add(new Pin() { Name = "PI0",  PinNumber = {           74  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI1",  PinNumber = {           73  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI2",  PinNumber = {           72  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI3",  PinNumber = {           71  }, Usage = { "GPIO" } });
            PinList.Add(new Pin() { Name = "PI4",  PinNumber = {           5   }, Usage = { "GPIO" } });
        }
    }
    
}
