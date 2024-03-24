using BrgyIS.Models;
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
            return new JsonNetResult() { Data = list };
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
            return View();
        }

        [HttpPost]
        public ActionResult Create(tbl_Person m)
        {
            if (ModelState.IsValid)
            {
                mod.Create(m);
                return RedirectToAction("Index");
            }
            return View(m);
        }

        public ActionResult Edit(int ID)
        {
            var item = mod.Find(ID);
            return View(item);
        }

        [HttpPost]
        public ActionResult Edit(tbl_Person m)
        {
            if (ModelState.IsValid)
            {
                mod.Update(m);
                return RedirectToAction("Index");
            }
            return View(m);
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
    }
}