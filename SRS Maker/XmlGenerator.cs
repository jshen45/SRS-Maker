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

            WordGen();

            XmlGen();
            
        }

        private void WordGen()
        {
            
            Word._Application WordApplication;
            WordApplication = new Word.Application();
            WordApplication.Visible = true;

            Word._Document Doc;
            Doc = WordApplication.Documents.Add();

            string EndOfDocFlag = "\\endofdoc";

            Word.Range AtEndOfDoc = Doc.Bookmarks.get_Item(EndOfDocFlag).Range; ;

            /* 1 Page */

            // Source
            List<string> McuTableParameters = new List<string>(new string[] { "Model", "PinPackage", "Quartz Clock", "Core Clock", "Periperal 1 Clock", "Periperal 2 Clock", "Periperal 3 Clock" });
            List<string> McuTableValues = new List<string>(new string[] { general_tab.ComboBox_McuModel.Text, general_tab.ComboBox_PinPackage.Text, general_tab.TextBox_Clock_Quartz.Text, general_tab.TextBox_Clock_Core.Text, general_tab.TextBox_Clock_Peripheral1.Text, general_tab.TextBox_Clock_Peripheral2.Text, general_tab.TextBox_Clock_Peripheral3.Text });
            List<string> ClockOutputParameters;
            List<string> ClockOutputValues;
            if (general_tab.CheckBox_ClockOutput.IsChecked == true)
            {
                ClockOutputParameters = new List<string>(new string[] { "Usage", "Source Clock", "Divider" });
                ClockOutputValues = new List<string>(new string[] { "USE", "", general_tab.ComboBox_ClockOutput_Divider.Text });

                if (general_tab.RadioButton_ClockOutput_FIRC.IsChecked == true)
                {
                    ClockOutputValues[1] = "FIRC";
                }
                else
                    if (general_tab.RadioButton_ClockOutput_FMPLL.IsChecked == true)
                {
                    ClockOutputValues[1] = "FMPLL";
                }
                else
                        if (general_tab.RadioButton_ClockOutput_FXOSC.IsChecked == true)
                {
                    ClockOutputValues[1] = "FXOSC";
                }
            }
            else
            {
                ClockOutputParameters = new List<string>(new string[] { "Usage" });
                ClockOutputValues = new List<string>(new string[] { "NOT USE" });
            }

            H1(ref Doc, "MCU");
            MakeVTable(ref Doc, "MCU General", McuTableParameters, McuTableValues);
            MakeVTable(ref Doc, "Clock Output", ClockOutputParameters, ClockOutputValues);
            BreakPage(ref Doc);
            H1(ref Doc, "OS");
            List<string> StackTableParameters = new List<string>(new string[] { "FG1 Task", "FG2 Task (Include Low Power Task)", "Event", "Background Task" });
            List<string> StackTableValues = new List<string>(new string[] { os_tab.TextBox_Stack_FG1.Text, os_tab.TextBox_Stack_FG2.Text, os_tab.TextBox_Stack_Event.Text, os_tab.TextBox_Stack_BG.Text });
            MakeVTable(ref Doc, "Stack", StackTableParameters, StackTableValues);

            List<string> TaskTableParameters = new List<string>(new string[] { "Name\n(Task_)", "Priority", "Auto\nStart", "Preemtive", "Offset\n(Periodic)", "Cycle\n(Periodic)" });
            List<string> TaskNameTableValues = new List<string>();
            List<string> TaskPriorityTableValues = new List<string>();
            List<string> TaskAutoStartTableValues = new List<string>();
            List<string> TaskPreemtiveTableValues = new List<string>();
            List<string> TaskOffsetTableValues = new List<string>();
            List<string> TaskCycleTableValues = new List<string>();
            foreach (Model.PlatformTask task in os_tab.DataGrid_Task.ItemsSource as IEnumerable)
            {
                TaskNameTableValues.Add(task.Name.Remove(0, 5));
                TaskPriorityTableValues.Add(task.Priority.ToString());
                TaskAutoStartTableValues.Add(task.Preemptive.ToString());
                TaskPreemtiveTableValues.Add(task.AutoStart.ToString());
                if (task.AlarmOffset == null)
                {
                    TaskOffsetTableValues.Add("-");
                }
                else
                {
                    TaskOffsetTableValues.Add(task.AlarmOffset.ToString());
                }
                if (task.AlarmCycle == null)
                {
                    TaskCycleTableValues.Add("-");
                }
                else
                {
                    TaskCycleTableValues.Add(task.AlarmCycle.ToString());
                }
            }
            MakeHTable(ref Doc, "Task", TaskTableParameters, TaskNameTableValues, TaskPriorityTableValues, TaskAutoStartTableValues, TaskPreemtiveTableValues, TaskOffsetTableValues, TaskCycleTableValues);

            List<string> DebugFuncTableParameters = new List<string>(new string[] { "CPU Load", "Interrupt Load", "Stack Depth", "Task Monitoring" });
            List<string> DebugFuncTableValues = new List<string>(new string[] { os_tab.CpuLoad.IsChecked.ToString(), os_tab.ItLoad.IsChecked.ToString(), os_tab.StackDepth.IsChecked.ToString(), os_tab.TaskMonitoring.IsChecked.ToString() });
            MakeVTable(ref Doc, "Debug Function", DebugFuncTableParameters, DebugFuncTableValues);

            BreakPage(ref Doc);

            /* 2 Page */

            object szPath = "test.docx";
            Doc.SaveAs(ref szPath);
        }

        private void XmlGen()
        {
            if (EmptyValueCheck())
            {
                XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();
                xmlWriterSettings.NewLineOnAttributes = true;
                xmlWriterSettings.Indent = true;

                XmlWriter writer = XmlWriter.Create("SRS.xml", xmlWriterSettings);
                writer.WriteStartDocument(); 
                {
                    writer.WriteStartElement("Config");
                    {
                        McuPage(ref writer);
                        OsPage(ref writer);
                    } writer.WriteEndElement(); //Config
                } writer.WriteEndDocument();
            }
        }

        private bool EmptyValueCheck()
        {
            return true;
        }

        private void McuPage(ref XmlWriter writer)
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
                            }
                            else
                            if (general_tab.RadioButton_ClockOutput_FMPLL.IsChecked == true)
                            {
                                writer.WriteAttributeString("Source", "FMPLLRC");
                            }
                            else
                            if (general_tab.RadioButton_ClockOutput_FXOSC.IsChecked == true)
                            {
                                writer.WriteAttributeString("Source", "FXOSC");
                            }
                            writer.WriteAttributeString("Divider", general_tab.ComboBox_ClockOutput_Divider.Text);
                        }
                    }
                    writer.WriteEndElement(); // ClockOutput
                }
                writer.WriteEndElement(); // Clock

                writer.WriteStartElement("FBL");
                {
                    writer.WriteElementString("STmin", "5");
                }
                writer.WriteEndElement(); // FBL
            }
            writer.WriteEndElement(); // Mcu

        }
        private void OsPage(ref XmlWriter writer)
        {
            writer.WriteStartElement("OS");
            {
                writer.WriteStartElement("Task");
                {
                    var tasks = os_tab.DataGrid_Task.ItemsSource as IEnumerable;
                    foreach (Model.PlatformTask task in tasks)
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
                        }
                        writer.WriteEndElement(); // task.Name
                    }
                }
                writer.WriteEndElement(); // Task

                writer.WriteStartElement("Debugging");
                {
                    writer.WriteAttributeString("CpuLoad", os_tab.CpuLoad.IsChecked.ToString());
                    writer.WriteAttributeString("ItLoad", os_tab.ItLoad.IsChecked.ToString());
                    writer.WriteAttributeString("StackDepth", os_tab.StackDepth.IsChecked.ToString());
                    writer.WriteAttributeString("TaskMonitoring", os_tab.TaskMonitoring.IsChecked.ToString());
                }
                writer.WriteEndElement(); // Debugging
            }
            writer.WriteEndElement(); // OS

        }
        
  
        private void MakeVTable(ref Word._Document Doc, string TableName, List<string> Header, List<string> Value)
        {
            try
            {
                string EndOfDocFlag = "\\endofdoc";

                Word.Paragraph McuParagraph;
                Word.Range AtEndOfDoc;
                AtEndOfDoc = Doc.Bookmarks.get_Item(EndOfDocFlag).Range;
                McuParagraph = Doc.Content.Paragraphs.Add(AtEndOfDoc);
                McuParagraph.Range.Font.Size = 20;
                McuParagraph.Range.Text = TableName;

                Word.Table McuTable;
                AtEndOfDoc = Doc.Bookmarks.get_Item(EndOfDocFlag).Range;
                McuTable = Doc.Tables.Add(AtEndOfDoc, Header.Count, 2);
                McuTable.Borders.InsideLineStyle = Word.WdLineStyle.wdLineStyleSingle;
                McuTable.Borders.OutsideLineStyle = Word.WdLineStyle.wdLineStyleSingle;

                foreach (var x in Header.Select((value, index) => new { value, index }))
                {
                    McuTable.Cell(x.index + 1, 1).Range.Text = x.value;
                    McuTable.Cell(x.index + 1, 1).Range.Shading.BackgroundPatternColor = Word.WdColor.wdColorGray10;
                    McuTable.Cell(x.index + 1, 1).Range.Font.Bold = 1;
                }
                McuTable.Columns[1].AutoFit();

                foreach (var x in Value.Select((value, index) => new { value, index }))
                {
                    McuTable.Cell(x.index + 1, 2).Range.Text = x.value;
                }
                McuTable.Columns[2].AutoFit();
            }
            catch
            {

            }
        }
        private void MakeHTable(ref Word._Document Doc, string TableName, List<string> Header, params List<string>[] ValueLists)
        {
            try
            {
                string EndOfDocFlag = "\\endofdoc";


                Word.Paragraph McuParagraph;
                Word.Range AtEndOfDoc;
                AtEndOfDoc = Doc.Bookmarks.get_Item(EndOfDocFlag).Range;
                McuParagraph = Doc.Content.Paragraphs.Add(AtEndOfDoc);
                McuParagraph.Range.Font.Size = 16;
                McuParagraph.Range.Text = TableName;
                McuParagraph.Range.InsertParagraphAfter();

                Word.Table McuTable;
                AtEndOfDoc = Doc.Bookmarks.get_Item(EndOfDocFlag).Range;
                McuTable = Doc.Tables.Add(AtEndOfDoc, ValueLists[0].Count + 1, Header.Count);
                McuTable.Borders.InsideLineStyle = Word.WdLineStyle.wdLineStyleSingle;
                McuTable.Borders.OutsideLineStyle = Word.WdLineStyle.wdLineStyleSingle;

                foreach (var row in Header.Select((value, index) => new { value, index }))
                {
                    McuTable.Cell(1, row.index + 1).Range.Text = row.value;
                    McuTable.Cell(1, row.index + 1).Range.Shading.BackgroundPatternColor = Word.WdColor.wdColorGray10;
                    McuTable.Cell(1, row.index + 1).Range.Font.Bold = 1;
                }

                foreach (var col in ValueLists.Select((value, index) => new { value, index }))
                {
                    foreach (var row in col.value.Select((value, index) => new { value, index }))
                    {
                        McuTable.Cell(row.index + 2, col.index + 1).Range.Text = row.value;
                    }
                    McuTable.Columns[col.index + 1].AutoFit();
                }
                McuTable.Columns[1].AutoFit();
            }
            catch
            {

            }
        }

        private void H1(ref Word._Document Doc, string str)
        {
            try
            {
                string EndOfDocFlag = "\\endofdoc";

                Word.Range AtEndOfDoc;
                AtEndOfDoc = Doc.Bookmarks.get_Item(EndOfDocFlag).Range;

                Word.Paragraph McuParagraph;
                McuParagraph = Doc.Content.Paragraphs.Add(AtEndOfDoc);

                McuParagraph.Range.Font.Size = 22;
                McuParagraph.Range.Font.Bold = 1;
                McuParagraph.Range.Text = str;
                McuParagraph.Range.InsertParagraphAfter();
            }
            catch
            {

            }
        }
        private void H2(ref Word._Document Doc, string str)
        {
            try
            {
                string EndOfDocFlag = "\\endofdoc";

                Word.Range AtEndOfDoc;
                AtEndOfDoc = Doc.Bookmarks.get_Item(EndOfDocFlag).Range;

                Word.Paragraph McuParagraph;
                McuParagraph = Doc.Content.Paragraphs.Add(AtEndOfDoc);

                McuParagraph.Range.Font.Size = 22;
                McuParagraph.Range.Font.Bold = 1;
                McuParagraph.Range.Text = str;
                McuParagraph.Range.InsertParagraphAfter();
            }
            catch
            {

            }
        }
        private void BreakPage(ref Word._Document Doc)
        {
            try
            {
                string EndOfDocFlag = "\\endofdoc";

                Word.Range AtEndOfDoc;
                AtEndOfDoc = Doc.Bookmarks.get_Item(EndOfDocFlag).Range;
                AtEndOfDoc.InsertBreak(Word.WdBreakType.wdPageBreak);
            }
            catch
            {

            }
        }

        
        
    }
}

