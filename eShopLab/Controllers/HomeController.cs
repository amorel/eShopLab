

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using eShopLab.Models;
using System.IO;
using PagedList;
namespace eShopLab.Controllers
{
    public class HomeController : Controller
    {
        private eShopDBEntities db = new eShopDBEntities();

        //
        // GET: /Home/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Contact()
        {
            return View();
        }
    }
}
