using BrgyIS.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BrgyIS.Controllers
{
    public class LogsController : Controller
    {
        tbl_User_Log mod = new tbl_User_Log();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult List() {
            return new JsonNetResult { Data = mod.List() };
        }
    }
}