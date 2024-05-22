using System.Web;
using System.Web.Optimization;

namespace BrgyIS
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/jquery-ui-{version}.js",
                        "~/Scripts/knockout-{version}.js",
                        "~/Scripts/knockout.mapping-latest.js",
                        "~/Scripts/knockout.validation.js",
                        "~/Scripts/jquery.unobtrusive-ajax.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new StyleBundle("~/Content/dataTable").Include(
                      "~/Content/DataTables/css/dataTables.css"
                      ));

            bundles.Add(new ScriptBundle("~/bundles/dataTable").Include(
                      "~/Scripts/DataTables/dataTables.js"
                ));

            bundles.Add(new ScriptBundle("~/bundles/echart").Include(
                     "~/Scripts/echarts/echarts.js"
                     ));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.bundle.js",
                      "~/Scripts/jquery.mask.js",
                      "~/Scripts/select2.js",
                      "~/Scripts/respond.js",
                      "~/Scripts/tinymce/tinymce.js",
                      "~/Scripts/fontawesome/fontawesome.js",
                      "~/Scripts/index.global.js",
                      "~/Scripts/main.js",
                      "~/Scripts/toastr.js",
                      "~/Scripts/googlemap.js",
                      "~/Scripts/moment.js",
                      "~/Scripts/jquery.signaturepad.js",
                      "~/Content/SignaturePad/json2.min.js",
                      "~/Scripts/scripts.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/css/select2.css",
                      "~/Content/css/select2-bootstrap-5-theme.min.css",
                      "~/Content/all.css",
                      "~/Content/toastr.css",
                      "~/Content/SignaturePad/jquery.signaturepad.css",
                      "~/Content/themes/base/jquery-ui.css",
                      "~/Content/variables.css",
                      "~/Content/bootstrap-icons/bootstrap-icons.css",
                      "~/Content/Style.css",
                      "~/Content/site.css"));
        }
    }
}
