using BrgyIS.Models;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BrgyIS.Controllers
{
    public class HomeController : Controller
    {
        tbl_User mod = new tbl_User();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult RestrictedAccess()
        {
            return View();
        }

        [AllowAnonymous]
        public ActionResult Login(string cb = null)
        {
            if (!string.IsNullOrEmpty(cb))
            {
                ViewBag.Message = cb;
            }
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult Login(string username, string password)
        {
            if (ModelState.IsValid)
            {
                var credential = mod.Login(username, password);
                if (credential != null)
                {
                    Session["User"] = credential;
                    return RedirectToAction("Index");
                }
                ModelState.AddModelError("", "Username or Password not Found!");
            }
            return View();
        }

        [AllowAnonymous]
        public ActionResult Registration()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult Registration(tbl_User m)
        {
            if (ModelState.IsValid)
            {
                if (mod.Create(m))
                {
                    return RedirectToAction("Login", new { cb = "You are now successfully registered" });
                }
                ModelState.AddModelError("", "Username already exist.");
            }
            return View(m);
        }

        public ActionResult Logout()
        {
            Session.Clear();
            return Redirect("/");
        }
    }
}