using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SRS_Maker.View;
using System.Xml;
using System.Collections;
using SRS_Maker.Model;
using System.Collections.ObjectModel;
using System.Data;
using Word = Microsoft.Office.Interop.Word;

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
            this.os_tab = os_tab;

            object objMiss = System.Reflection.Missing.Value;
            object objEndOfDocFlag = "\\endofdoc"; /* \endofdoc is a predefined bookmark */
            
            //Start Word and create a new document.
            Word._Application objApp;
            objApp = new Word.Application();
            objApp.Visible = true;
            
            Word._Document objDoc;
            objDoc = objApp.Documents.Add(ref objMiss, ref objMiss, ref objMiss, ref objMiss);
            object oRng = objDoc.Bookmarks.get_Item(ref objEndOfDocFlag).Range;
            //Insert a paragraph at the end of the document.

            Word.Paragraph McuParagraph;
            McuParagraph = objDoc.Content.Paragraphs.Add(ref oRng); //add paragraph at end of document
            McuParagraph.Format.SpaceAfter = 100; //define some style
            McuParagraph.Range.Font.Size = 20;
            McuParagraph.Range.Text = "MCU"; //add some text in paragraph
            McuParagraph.Range.InsertParagraphAfter(); //insert paragraph

            Word.Table objTab1; //create table object
            Word.Range objWordRng = objDoc.Bookmarks.get_Item(ref objEndOfDocFlag).Range; //go to end of document
            objTab1 = objDoc.Tables.Add(objWordRng, 7, 2, ref objMiss, ref objMiss); //add table object in word document
            objTab1.Borders.InsideLineStyle = Word.WdLineStyle.wdLineStyleSingle;
            objTab1.Borders.OutsideLineStyle = Word.WdLineStyle.wdLineStyleSingle;
            
            List<string> McuTableStrings = new List<string>(new string[] {"Model","PinPackage","Quartz Clock","Core Clock","Periperal 1 Clock","Periperal 2 Clock","Periperal 3 Clock"});
            foreach (var x in McuTableStrings.Select((value, index) => new { value, index }))
            {
                objTab1.Cell(x.index + 1, 1).Range.Text = x.value;
                objTab1.Cell(x.index + 1, 1).Range.Shading.BackgroundPatternColor = Word.WdColor.wdColorGray10;
                objTab1.Cell(x.index + 1, 1).Range.Font.Bold = 1;
            }
            objTab1.Columns[1].AutoFit();
            
            //Add some text after table
            objWordRng = objDoc.Bookmarks.get_Item(ref objEndOfDocFlag).Range;
            objWordRng.InsertParagraphAfter(); //put enter in document
            
            
            
            
            
            
            
            
            
            
            
            object szPath = "test.docx";
            objDoc.SaveAs(ref szPath);


            if ( emptyValueCheck() )
            {
                XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();
                xmlWriterSettings.NewLineOnAttributes = true;
                xmlWriterSettings.Indent = true;

                using (XmlWriter writer = XmlWriter.Create("SRS.xml", xmlWriterSettings))
                {
                    writer.WriteStartDocument();
                    writer.WriteStartElement("Config");
                    {
                        writer.WriteStartElement("Mcu");
                        {
                            writer.WriteAttributeString("Model", general_tab.ComboBox_McuModel.Text);
                            writer.WriteAttributeString("PinPackage", general_tab.ComboBox_PinPackage.Text);
                            writer.WriteStartElement("Clock");
                            {
                                writer.WriteAttributeString("Quartz", general_tab.TextBox_Clock_Quartz.Text);
                                writer.WriteAttributeString("Core", general_tab.TextBox_Clock_Core.Text);
                                writer.WriteAttributeString("Peripheral1", general_tab.TextBox_Clock_Peripheral1.Text);
                                writer.WriteAttributeString("Peripheral2", general_tab.TextBox_Clock_Peripheral2.Text);
                                writer.WriteAttributeString("Peripheral3", general_tab.TextBox_Clock_Peripheral3.Text);
                                writer.WriteStartElement("ClockOutput");
                                {
                                    writer.WriteAttributeString("Use", general_tab.CheckBox_ClockOutput.IsChecked.ToString());
                                    
                                    if (general_tab.CheckBox_ClockOutput.IsChecked == true)
                                    {
                                        if (general_tab.RadioButton_ClockOutput_FIRC.IsChecked == true)
                                        {
                                            writer.WriteAttributeString("Source", "FIRC");
                                        } else
                                        if (general_tab.RadioButton_ClockOutput_FMPLL.IsChecked == true)
                                        {
                                            writer.WriteAttributeString("Source", "FMPLLRC");
                                        } else
                                        if (general_tab.RadioButton_ClockOutput_FXOSC.IsChecked == true)
                                        {
                                            writer.WriteAttributeString("Source", "FXOSC");
                                        }
                                        writer.WriteAttributeString("Divider", general_tab.ComboBox_ClockOutput_Divider.Text);
                                    }
                                } writer.WriteEndElement(); // ClockOutput
                            } writer.WriteEndElement(); // Clock
                        } writer.WriteEndElement(); // Mcu

                        writer.WriteStartElement("OS");
                        {
                            writer.WriteStartElement("Task");
                            {
                                var tasks = os_tab.DataGrid_Task.ItemsSource as IEnumerable;
                                foreach (SwpTask task in tasks)
                                {
                                    writer.WriteStartElement(task.Name);
                                    {
                                        writer.WriteAttributeString("Priority", task.Priority.ToString());
                                        writer.WriteAttributeString("Preemptive", task.Preemptive.ToString());
                                        writer.WriteAttributeString("AutoStart", task.AutoStart.ToString());
                                        if (task.AlarmOffset != null && task.AlarmCycle != null)
                                        {
                                            writer.WriteAttributeString("AlarmOffset", task.AlarmOffset.ToString());
                                            writer.WriteAttributeString("AlarmCycle", task.AlarmCycle.ToString());
                                        }
                                    } writer.WriteEndElement(); // task.Name
                                }
                            } writer.WriteEndElement(); // Task

                            writer.WriteStartElement("Debugging");
                            {
                                writer.WriteAttributeString("CpuLoad", os_tab.CpuLoad.IsChecked.ToString());
                                writer.WriteAttributeString("ItLoad", os_tab.ItLoad.IsChecked.ToString());
                                writer.WriteAttributeString("StackDepth", os_tab.StackDepth.IsChecked.ToString());
                                writer.WriteAttributeString("TaskMonitoring", os_tab.TaskMonitoring.IsChecked.ToString());
                            } writer.WriteEndElement(); // Debugging
                        }
                        writer.WriteStartElement("FBL");
                        {
                            writer.WriteElementString("STmin", "5");
                        } writer.WriteEndElement(); // F

                    } writer.WriteEndElement();
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

