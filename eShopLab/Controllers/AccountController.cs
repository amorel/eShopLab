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

        //
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                bool valid = true;
                if (membershipProvider.GetUser(model.UserName) != null)
                {
                    ModelState.AddModelError("", "The user name " + model.UserName + " exists !");
                    valid = false;
                }
                if (membershipProvider.GetEmail(model.Email) != null)
                {
                    ModelState.AddModelError("", "The email " + model.Email + " exists !");
                    valid = false;
                }

                if (valid)
                {
                    string salt = membershipProvider.GeneratePassword();
                    User user = new User()
                    {
                        UserUsername = model.UserName.Trim(),
                        UserPassword = Encryptor.MD5Hash(model.Password + salt),
                        UserEmail = model.Email,
                        UserRegisterDate = DateTime.Now,
                        UserLastLoginDate = DateTime.Now,
                        UserSalt = salt
                    };
                    var result = membershipProvider.CreateAccount(user);
                }
            }

            return View(model);
        }
    }
}
