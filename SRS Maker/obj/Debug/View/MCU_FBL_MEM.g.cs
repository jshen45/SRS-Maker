﻿#pragma checksum "..\..\..\View\MCU_FBL_MEM.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "667B5E8429E9C991DE169469CAC8E0E8"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.34209
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using SRS_Maker.Model;
using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Shell;


namespace SRS_Maker.View {
    
    
    /// <summary>
    /// MCU_FBL_MEM
    /// </summary>
    public partial class MCU_FBL_MEM : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector {
        
        
        #line 32 "..\..\..\View\MCU_FBL_MEM.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox ComboBox_MCU;
        
        #line default
        #line hidden
        
        
        #line 34 "..\..\..\View\MCU_FBL_MEM.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox PinCombo;
        
        #line default
        #line hidden
        
        
        #line 59 "..\..\..\View\MCU_FBL_MEM.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.RadioButton RadioBtn_InternalEEPROM;
        
        #line default
        #line hidden
        
        
        #line 61 "..\..\..\View\MCU_FBL_MEM.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox Text_InternalE2PRomSize;
        
        #line default
        #line hidden
        
        
        #line 63 "..\..\..\View\MCU_FBL_MEM.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox Text_InternalE2PRomSize_Copy;
        
        #line default
        #line hidden
        
        
        #line 65 "..\..\..\View\MCU_FBL_MEM.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.RadioButton RadioBtn_ExternalE2PRom;
        
        #line default
        #line hidden
        
        
        #line 69 "..\..\..\View\MCU_FBL_MEM.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox externalEEPROM;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/SRS Maker;component/view/mcu_fbl_mem.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\View\MCU_FBL_MEM.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            this.ComboBox_MCU = ((System.Windows.Controls.ComboBox)(target));
            
            #line 32 "..\..\..\View\MCU_FBL_MEM.xaml"
            this.ComboBox_MCU.SelectionChanged += new System.Windows.Controls.SelectionChangedEventHandler(this.SelectedMcuUpdate);
            
            #line default
            #line hidden
            return;
            case 2:
            this.PinCombo = ((System.Windows.Controls.ComboBox)(target));
            return;
            case 3:
            this.RadioBtn_InternalEEPROM = ((System.Windows.Controls.RadioButton)(target));
            return;
            case 4:
            this.Text_InternalE2PRomSize = ((System.Windows.Controls.TextBox)(target));
            return;
            case 5:
            this.Text_InternalE2PRomSize_Copy = ((System.Windows.Controls.TextBox)(target));
            return;
            case 6:
            this.RadioBtn_ExternalE2PRom = ((System.Windows.Controls.RadioButton)(target));
            return;
            case 7:
            this.externalEEPROM = ((System.Windows.Controls.ComboBox)(target));
            return;
            }
            this._contentLoaded = true;
        }
    }
}
