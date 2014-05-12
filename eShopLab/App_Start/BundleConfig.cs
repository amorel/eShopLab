using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

namespace eShopLab.App_Start
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/script").Include(
                "~/Scripts/jquery-{version}.js",
                "~/Scripts/bootstrap.js"));

            bundles.Add(new ScriptBundle("~/bundles/css").Include(
                "~/Content/style.css",
                "~/Content/font-awesome.min.css",
                "~/Content/bootstrap.css"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                "~/Content/jquery.validate.js"));
        }
    }
}