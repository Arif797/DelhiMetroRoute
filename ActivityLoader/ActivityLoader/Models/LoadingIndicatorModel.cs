using ActivityLoader.Views;
using MvvmHelpers;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace ActivityLoader.Models
{
    class LoadingIndicatorModel : BaseViewModel
    {
        private bool isLoadingData;

        public bool IsLoadingData
        {
            get => isLoadingData;
            set => SetProperty(ref isLoadingData, value);
        }
        public async Task LoadData()
        {
            IsLoadingData = true;
            await Task.Delay(9000);      
            IsLoadingData = false;
        }

    }
}
