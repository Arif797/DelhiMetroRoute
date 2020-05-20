using Android.App;
using Android.OS;
using Android.Support.V7.App;
using Android.Runtime;
using Android.Widget;
using Android.Support.V4.View;
using Android.Support.Design.Widget;
using V4Fragment = Android.Support.V4.App.Fragment;
using V4FragmentManager = Android.Support.V4.App.FragmentManager;
using System.Collections.Generic;
using V7Toolbar = Android.Support.V7.Widget.Toolbar;
using System;

namespace AndroidTrainingTask
{
    [Activity(Label = "@string/app_name", MainLauncher = true)]
    public class MainActivity : AppCompatActivity
    {
        ViewPager viewpager;

        protected override void OnCreate(Bundle bundle)
        {
            base.OnCreate(bundle);

            // Set our view from the "main" layout resource
            SetContentView(Resource.Layout.activity_main);

            // Get our button from the layout resource,
            // and attach an event to it
            viewpager = FindViewById<Android.Support.V4.View.ViewPager>(Resource.Id.viewpager);

            var toolbar = FindViewById<V7Toolbar>(Resource.Id.toolbar);

            SetSupportActionBar(toolbar);

            SupportActionBar.SetIcon(Resource.Drawable.whatsapp);

            SupportActionBar.SetDisplayHomeAsUpEnabled(false);
            SupportActionBar.SetDisplayShowTitleEnabled(false);
            SupportActionBar.SetHomeButtonEnabled(false);

            if (viewpager.Adapter == null)
            {
                setupViewPager(viewpager);


            }
            else
            {
                viewpager.Adapter.NotifyDataSetChanged();
            }

            var fab = FindViewById<FloatingActionButton>(Resource.Id.fab);
            fab.Click += (sender, e) => {
                // Show a snackbar
                Snackbar.Make(fab, "Sorry! Contacts can't be added.", Snackbar.LengthLong).SetAction("OK",
                    v => Console.WriteLine("Action handler")).Show();
            };

            var tabLayout = FindViewById<TabLayout>(Resource.Id.tabs);

            tabLayout.SetupWithViewPager(viewpager);
        }
        void setupViewPager(Android.Support.V4.View.ViewPager viewPager)
        {
            var adapter = new Adapter(SupportFragmentManager);
            adapter.AddFragment(new TabFragment1(), "STATUS");
            adapter.AddFragment(new TabFragment2(), "CHATS");
            adapter.AddFragment(new TabFragment3(), "CALLS");
            viewPager.Adapter = adapter;
            viewpager.Adapter.NotifyDataSetChanged();
            //viewpager.OffscreenPageLimit(4);


        }

    }
    class Adapter : Android.Support.V4.App.FragmentPagerAdapter
    {
        List<V4Fragment> fragments = new List<V4Fragment>();
        List<string> fragmentTitles = new List<string>();


        public Adapter(V4FragmentManager fm) : base(fm)
        {
        }

        public void AddFragment(V4Fragment fragment, String title)
        {
            fragments.Add(fragment);
            fragmentTitles.Add(title);


        }

        public override V4Fragment GetItem(int position)
        {
            return fragments[position];

        }

        public override int Count
        {
            get { return fragments.Count; }
        }

        public override Java.Lang.ICharSequence GetPageTitleFormatted(int position)
        {
            return new Java.Lang.String(fragmentTitles[position]);
        }


    }

}
