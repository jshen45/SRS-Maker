﻿#pragma checksum "..\..\..\View\OS_CORE.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "A387008783C1B721F0C3BE876BB84327"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.34209
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

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
    /// OS_CORE
    /// </summary>
    public partial class OS_CORE : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector {
        
        
        #line 25 "..\..\..\View\OS_CORE.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.DataGrid DataGrid_Task;
        
        #line default
        #line hidden
        
        
        #line 39 "..\..\..\View\OS_CORE.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.CheckBox CpuLoad;
        
        #line default
        #line hidden
        
        
        #line 40 "..\..\..\View\OS_CORE.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.CheckBox ItLoad;
        
        #line default
        #line hidden
        
        
        #line 41 "..\..\..\View\OS_CORE.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.CheckBox StackDepth;
        
        #line default
        #line hidden
        
        
        #line 42 "..\..\..\View\OS_CORE.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.CheckBox TaskMonitoring;
        
        #line default
        #line hidden
        
        
        #line 47 "..\..\..\View\OS_CORE.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.CheckBox CheckBox_InternalWatchDog;
        
        #line default
        #line hidden
        
        
        #line 49 "..\..\..\View\OS_CORE.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox TextBox_InternalWatchDogTimeOut;
        
        #line default
        #line hidden
        
        
        #line 50 "..\..\..\View\OS_CORE.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.CheckBox CheckBox_ExternalWatchDog;
        
        #line default
        #line hidden
        
        
        #line 53 "..\..\..\View\OS_CORE.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox TextBox_ExternalWatchDogTimeOut;
        
        #line default
        #line hidden
        
        
        #line 54 "..\..\..\View\OS_CORE.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox ExternalWatchdogTogglePin;
        
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
            System.Uri resourceLocater = new System.Uri("/SRS Maker;component/view/os_core.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\View\OS_CORE.xaml"
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
            this.DataGrid_Task = ((System.Windows.Controls.DataGrid)(target));
            return;
            case 2:
            this.CpuLoad = ((System.Windows.Controls.CheckBox)(target));
            return;
            case 3:
            this.ItLoad = ((System.Windows.Controls.CheckBox)(target));
            return;
            case 4:
            this.StackDepth = ((System.Windows.Controls.CheckBox)(target));
            return;
            case 5:
            this.TaskMonitoring = ((System.Windows.Controls.CheckBox)(target));
            return;
            case 6:
            this.CheckBox_InternalWatchDog = ((System.Windows.Controls.CheckBox)(target));
            
            #line 47 "..\..\..\View\OS_CORE.xaml"
            this.CheckBox_InternalWatchDog.Checked += new System.Windows.RoutedEventHandler(this.CheckBox_InternalWatchDog_Checked);
            
            #line default
            #line hidden
            
            #line 47 "..\..\..\View\OS_CORE.xaml"
            this.CheckBox_InternalWatchDog.Unchecked += new System.Windows.RoutedEventHandler(this.CheckBox_InternalWatchDog_Unchecked);
            
            #line default
            #line hidden
            return;
            case 7:
            this.TextBox_InternalWatchDogTimeOut = ((System.Windows.Controls.TextBox)(target));
            return;
            case 8:
            this.CheckBox_ExternalWatchDog = ((System.Windows.Controls.CheckBox)(target));
            
            #line 50 "..\..\..\View\OS_CORE.xaml"
            this.CheckBox_ExternalWatchDog.Checked += new System.Windows.RoutedEventHandler(this.CheckBox_ExternalWatchDog_Checked);
            
            #line default
            #line hidden
            
            #line 50 "..\..\..\View\OS_CORE.xaml"
            this.CheckBox_ExternalWatchDog.Unchecked += new System.Windows.RoutedEventHandler(this.CheckBox_ExternalWatchDog_Unchecked);
            
            #line default
            #line hidden
            return;
            case 9:
            this.TextBox_ExternalWatchDogTimeOut = ((System.Windows.Controls.TextBox)(target));
            return;
            case 10:
            this.ExternalWatchdogTogglePin = ((System.Windows.Controls.ComboBox)(target));
            
            #line 54 "..\..\..\View\OS_CORE.xaml"
            this.ExternalWatchdogTogglePin.DropDownOpened += new System.EventHandler(this.ComboBox_DropDownOpened);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

