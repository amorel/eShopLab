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
                "~/Content/font-awesome.min.css",
                "~/Content/bootstrap.css",
                "~/Content/jquery-ui-1.8.23.custom.css",
                "~/Content/jquery.selectBoxIt.css",
                "~/Content/smoothproducts.css",
                "~/Content/jquery.bxslider.css",
                "~/Content/toastr.css",
                "~/Content/style.css"
                ));

            bundles.Add(new ScriptBundle("~/bundles/script").Include(
                "~/Scripts/jquery-{version}.js",
                "~/Scripts/jquery.validate.js",
                "~/Scripts/jquery.validate.unobtrusive.js",
                "~/Scripts/jquery-ui-1.10.4.js",
                "~/Scripts/jquery.selectBoxIt.js",
                "~/Scripts/modernizr-2.7.2.js",
                "~/Scripts/bootstrap.js",
                "~/Scripts/angular.js",
                "~/Scripts/eshop.js",
                "~/Scripts/jquery.bxslider.min.js",
                "~/Scripts/jquery.blImageCenter.js",
                "~/Scripts/smoothproducts.js",
                "~/Scripts/bootstrap.touchspin.js",
                "~/Scripts/toastr.js"
                ));

            bundles.Add(new ScriptBundle("~/bundles/cssadmin").Include(
                "~/Content/font-awesome.min.css",
                "~/Scripts/dropzone/css/basic.css",
                "~/Scripts/dropzone/css/dropzone.css",
                "~/Content/bootstrap.css",
                "~/Content/animate.css",
                "~/Scripts/wysiwyg/bootstrap-wysihtml5.css",
                "~/Scripts/wysiwyg/bootstrap3-wysiwyg5-color.css",
                "~/Content/jquery-ui-1.8.23.custom.css",
                "~/Content/jquery.selectBoxIt.css",
                "~/Content/admin.css"
                ));

            bundles.Add(new ScriptBundle("~/bundles/scriptadmin").Include(
                    "~/Scripts/jquery-{version}.js",
                    "~/Scripts/dropzone/dropzone.js",
                    "~/Scripts/jquery.validate.js",
                    "~/Scripts/jquery.validate.unobtrusive.js",
                    "~/Scripts/mask/jquery.mask.js",
                    "~/Scripts/jquery-ui-1.10.4.js",
                    "~/Scripts/jquery.selectBoxIt.js",
                    "~/Scripts/modernizr-2.7.2.js",
                    "~/Scripts/bootstrap.js",
                    "~/Scripts/wysiwyg/wysihtml5-0.3.0.js",
                    "~/Scripts/wysiwyg/bootstrap3-wysihtml5.js",
                    "~/Scripts/angular.js",
                    "~/Scripts/admin.js"
                    ));
        }
    }
}