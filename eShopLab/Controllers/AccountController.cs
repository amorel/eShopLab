using eShopLab.Models;
using eShopLab.Provider;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace eShopLab.Controllers
{
    public class AccountController : Controller
    {

        CustomMembershipProvider membershipProvider = new CustomMembershipProvider();

        //
        // GET: /Account/

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(User user)
        {
            if (membershipProvider.ValidateUser(user, out user))
            {
                FormsAuthentication.SetAuthCookie(user.UserUsername, true); 
            }
            return View();
        }

    }
}
