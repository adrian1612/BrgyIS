using BrgyIS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BrgyIS.Models
{
    [Authorized]
    public class FormIssuanceController : Controller
    {
        tbl_FormIssuance mod = new tbl_FormIssuance();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult List(int id)
        {
            var list = mod.List(id);
            return new JsonNetResult() { Data = new { data = list } };
        }

        void Validator(out string _Message, out bool _isSuccess)
        {
            string Message = string.Empty; bool isSuccess = true;
            var errors = ModelState.Values.SelectMany(f => f.Errors.Select(e => e.ErrorMessage));
            errors.ToList().ForEach(r => Message += $"{r}\n");
            isSuccess = errors.ToList().Count <= 0;
            _Message = Message; _isSuccess = isSuccess;
        }

        public ActionResult Create()
        {
            return PartialView();
        }

        [HttpPost]
        public ActionResult Create(tbl_FormIssuance m)
        {
            string Message = string.Empty; bool isSuccess = true;
            Validator(out Message, out isSuccess);
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
        public ActionResult Edit(tbl_FormIssuance m)
        {
            string Message = string.Empty; bool isSuccess = true;
            Validator(out Message, out isSuccess);
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
        public ActionResult Delete(tbl_FormIssuance m)
        {
            m.Delete(m);
            return RedirectToAction("Index");
        }
    }
}