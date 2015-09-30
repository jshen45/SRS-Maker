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
        private MCU_FBL_MEM general_tab;
        private OS_CORE os_tab;
        private IO io_tab;
        private CAN_UDS_SPI_ASC com_tab;

        public XmlGenerator(MCU_FBL_MEM general_tab, OS_CORE os_tab, IO io_tab, CAN_UDS_SPI_ASC com_tab)
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
                            writer.WriteElementString("CpuLoad", os_tab.CpuLoad.IsChecked.ToString());
                            writer.WriteElementString("ItLoad", os_tab.ItLoad.IsChecked.ToString());
                            writer.WriteElementString("StackDepth", os_tab.StackDepth.IsChecked.ToString());
                            writer.WriteElementString("TaskMonitoring", os_tab.TaskMonitoring.IsChecked.ToString());
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
