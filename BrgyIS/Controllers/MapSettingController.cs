using BrgyIS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BrgyIS.Controllers
{
    public class MapSettingController : Controller
    {
        tbl_MapSetting mod = new tbl_MapSetting();

        // GET: MapSetting
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Get()
        {
            return new JsonNetResult { Data = mod.Get() };
        }

        public ActionResult Update(tbl_MapSetting m)
        {
            mod.Update(m);
            return new JsonNetResult { Data = "" };
        }
    }
}