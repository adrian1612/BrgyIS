using Microsoft.Reporting.WebForms;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BrgyIS.Classes
{
    public class dbcontrol : MasterControl
    {
        public dbcontrol() : base("BrgyIS")
        {
            QueryException += Dbcontrol_QueryException;
        }

        private void Dbcontrol_QueryException(Exception e)
        {
            throw e;
        }
    }
}

public class JsonNetResult : JsonResult
{
    public new object Data { get; set; }

    public JsonNetResult()
    {
    }
    public override void ExecuteResult(ControllerContext context)
    {
        HttpResponseBase response = context.HttpContext.Response;
        response.ContentType = "application/json";
        if (ContentEncoding != null)
            response.ContentEncoding = ContentEncoding;
        if (Data != null)
        {
            JsonTextWriter writer = new JsonTextWriter(response.Output) { Formatting = Formatting.Indented };
            JsonSerializer serializer = JsonSerializer.Create(new JsonSerializerSettings());
            serializer.Serialize(writer, Data);
            writer.Flush();
        }
    }
}

public class Tool
{
    public static string GetUrl(string Action, string Controller, object RouteData)
    {
        var result = "";
        var request = HttpContext.Current.Request;
        var helper = new UrlHelper(request.RequestContext);
        result = helper.Action(Action, Controller, RouteData, request.Url.Scheme);
        return result;
    }

    public static byte[] ReportWrapper(string ReportPath, string Filename, ReportFormat format, Action<List<ReportDataSource>, List<ReportParameter>> _data)
    {
        byte[] result;
        ReportViewer rv = new ReportViewer();
        rv.LocalReport.ReportPath = HttpContext.Current.Server.MapPath(ReportPath);
        List<ReportDataSource> dataSource = new List<ReportDataSource>();
        List<ReportParameter> dataParameters = new List<ReportParameter>();
        _data(dataSource, dataParameters);
        dataSource.ForEach(r => rv.LocalReport.DataSources.Add(r));
        dataParameters.ForEach(r => rv.LocalReport.SetParameters(r));
        string Render = "", ContentType = "", Extension = "";
        switch (format)
        {
            case ReportFormat.PDF:
                Render = "PDF";
                ContentType = "application/pdf";
                Extension = "pdf";
                break;
            case ReportFormat.EXCEL:
                Render = "EXCELOPENXML";
                ContentType = "application/vnd.ms-excel";
                Extension = "xlsx";
                break;
            default:
                break;
        }
        result = rv.LocalReport.Render(Render);
        HttpContext.Current.Response.ContentType = ContentType;
        HttpContext.Current.Response.AddHeader("content-disposition", $"inline;filename={HttpUtility.HtmlEncode(Filename)}.{Extension}");
        HttpContext.Current.Response.Buffer = true;
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.BinaryWrite(result);
        HttpContext.Current.Response.End();
        return result;
    }
}

public enum ReportFormat
{
    PDF, EXCEL
}