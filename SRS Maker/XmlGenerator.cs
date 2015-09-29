using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SRS_Maker.View;
using System.Xml;

namespace SRS_Maker
{
    class XmlGenerator
    {
        private CAN_UDS_SPI_ASC com_tab;
        private MCU_FBL_OS_CORE_EEPROM general_tab;
        private IO io_tab;
      
        public XmlGenerator(MCU_FBL_OS_CORE_EEPROM general_tab, IO io_tab, CAN_UDS_SPI_ASC com_tab)
        {
            this.general_tab = general_tab;
            this.io_tab = io_tab;
            this.com_tab = com_tab;

            if ( emptyValueCheck() )
            {
                XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();
                xmlWriterSettings.NewLineOnAttributes = true;
                xmlWriterSettings.Indent = true;

                using (XmlWriter writer = XmlWriter.Create("employees.xml", xmlWriterSettings))
                {
                    writer.WriteStartDocument();
                    writer.WriteStartElement("Config");

                    {
                        writer.WriteStartElement("DefaultMcuConfig");
                        {
                            writer.WriteElementString("MCU", general_tab.ComboBox_MCU.SelectedValue.ToString());
                            writer.WriteElementString("PinPackage", general_tab.PinCombo.SelectedValue.ToString());
                        }
                        writer.WriteEndElement();

                        writer.WriteStartElement("Debugging");
                        {
                            writer.WriteElementString("CpuLoad", general_tab.CpuLoad.IsChecked.ToString());
                            writer.WriteElementString("ItLoad", general_tab.ItLoad.IsChecked.ToString());
                            writer.WriteElementString("StackDepth", general_tab.StackDepth.IsChecked.ToString());
                            writer.WriteElementString("TaskMonitoring", general_tab.TaskMonitoring.IsChecked.ToString());
                        }

                        writer.WriteStartElement("FblConfig");
                        {
                            writer.WriteElementString("STmin", "5");
                        }
                        writer.WriteEndElement();

                    }
                    writer.WriteEndElement();
                    writer.WriteEndDocument();
                }

            }
        }

        private bool emptyValueCheck()
        {
            return true;
        }
    }
}
