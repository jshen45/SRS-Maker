using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRS_Maker.Model
{
    public class Can : INotifyPropertyChanged
    {
        public int Driver { get; set; }
		public int Phy { get; set; }
		public string Usage { get; set; }
		public string IC { get; set; }
		public string Tx { get; set; }
		public string Rx { get; set; }
		public string Control { get; set; }
		public string EN { get; set; }
		public string STN { get; set; }
		public string Err { get; set; }
		public string Buadrate { get; set; }


        public event PropertyChangedEventHandler PropertyChanged;

        protected void OnPropertyChanged(string name)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(name));
            }
        }
    }
}
