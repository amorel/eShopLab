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
            
            bundles.Add(new ScriptBundle("~/bundles/css").Include(
                "~/Content/style.css",
                "~/Content/font-awesome.min.css",
                "~/Content/bootstrap.css" ,
                "~/Content/smoothproducts.css",
                "~/Content/jquery.bxslider.css"
                ));

            bundles.Add(new ScriptBundle("~/bundles/cssadmin").Include(
                "~/Content/font-awesome.min.css",
                "~/Scripts/dropzone/css/basic.css",
                "~/Scripts/dropzone/css/dropzone.css",
                "~/Content/bootstrap.css",
                "~/Content/animate.css",
                "~/Scripts/icheck/css/_all.css",
                "~/Content/admin.css"
                ));

            bundles.Add(new ScriptBundle("~/bundles/script").Include(
                "~/Scripts/jquery-{version}.js",
                "~/Scripts/dropzone/dropzone.js",
                "~/Scripts/jquery.validate.js",
                "~/Scripts/jquery.validate.unobtrusive.js",
                "~/Scripts/mask/jquery.mask.js",
                "~/Scripts/modernizr-2.7.2.js",
                "~/Scripts/bootstrap.js",
                "~/Scripts/icheck/js/icheck.min.js",
                "~/Scripts/angular.js",
                "~/Scripts/admin.js",
                 "~/Scripts/smoothproducts.min.js",
                 "~/Scripts/eshop.js",
                  "~/Scripts/Catalog.js",
                 "~/Scripts/jquery.bxslider.min.js",
                 "~/Scripts/jquery.blImageCenter.js",
                  "~/Scripts/knockout-2.1.0.js",
                 "~/Scripts/knockout.mapping-latest.js"
                ));
        }
    }
}