using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRS_Maker.Model
{
    class Pin
    {
        public string Name;
        public List<string> PinNumber;  // List's first element is 80 pin package's pin number, second element is 100 pin package...
        public List<string> Usage;      // GPIO, ADC, CAN Tx, CAN Rx, SPI Tx, SPI Rx, SPI Clk, ASC Tx, ASC Rx
        public bool InputOuput;         // Input:0, Output:1
        public string PullUpDown;       // No Use, Pull-Up, Pull-Down 
    }
}
