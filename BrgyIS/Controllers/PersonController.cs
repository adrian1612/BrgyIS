using BrgyIS.Models;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BrgyIS.Models
{
    public class PersonController : Controller
    {
        tbl_Person mod = new tbl_Person();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult List()
        {
            var list = mod.List();
            return new JsonNetResult() { Data = new { data = list } };
        }

        public ActionResult Action(string Type, int? ID = null)
        {
            switch (Type)
            {
                case "Add":
                    return RedirectToAction("Create");
                case "Edit":
                    return RedirectToAction("Edit", new { ID = ID });
            }
            return View();
        }

        public ActionResult Create()
        {
            return PartialView();
        }

        [HttpPost]
        public ActionResult Create(tbl_Person m)
        {
            string Message = string.Empty; bool isSuccess = true;
            var errors = ModelState.Values.SelectMany(f => f.Errors.Select(e => e.ErrorMessage));
            errors.ToList().ForEach(r => Message += $"{r}\n");
            isSuccess = errors.ToList().Count <= 0;
            if (ModelState.IsValid)
            {
                mod.Create(m);
                Message = "New record successfully submitted";
            }
            var result = new { Data = "", Status = isSuccess, Message = Message };
            return new JsonNetResult { Data = result };
        }

        public ActionResult Edit(int ID)
        {
            var item = mod.Find(ID);
            return PartialView(item);
        }

        [HttpPost]
        public ActionResult Edit(tbl_Person m)
        {
            string Message = string.Empty; bool isSuccess = true;
            var errors = ModelState.Values.SelectMany(f => f.Errors.Select(e => e.ErrorMessage));
            errors.ToList().ForEach(r => Message += $"{r}\n");
            isSuccess = errors.ToList().Count <= 0;
            if (ModelState.IsValid)
            {
                mod.Update(m);
                Message = "Record successfully updated";
            }
            var result = new { Data = "", Status = isSuccess, Message = Message };
            return new JsonNetResult { Data = result };
        }

        public ActionResult Detail(int ID)
        {
            var item = mod.Find(ID);
            return View(item);
        }

        public ActionResult Delete(int ID)
        {
            var item = mod.Find(ID);
            return View(item);
        }

        [HttpPost]
        public ActionResult Delete(tbl_Person m)
        {
            m.Delete(m);
            return RedirectToAction("Index");
        }

        //---------------------REPORT-----------------------------------------------------------

        [HttpPost]
        public ActionResult GenerateForms(int ID, FormType Type)
        {
            var ReportsAndFilename = Enum.GetName(typeof(FormType), Type);
            var Item = mod.List(ID);
            Tool.ReportWrapper($"~/Reports/Forms/{ReportsAndFilename}.rdlc", ReportsAndFilename, ReportFormat.PDF, (d, p) =>
            {
                d.Add(new ReportDataSource("data", Item));
            });
            return View();
        }
    }
}