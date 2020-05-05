using ActivityLoader.Controls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using ActivityLoader.Models;

namespace ActivityLoader.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class ActivityLoaderPage : ContentPage
    {
        public ActivityLoaderPage()
        {
            InitializeComponent();
            BindingContext = new LoadingIndicatorModel();
        }

        private LoadingIndicatorModel ViewModel => BindingContext as LoadingIndicatorModel;

        protected override async void OnAppearing()
        {
            base.OnAppearing();

            await ViewModel.LoadData();
        }
    }
}