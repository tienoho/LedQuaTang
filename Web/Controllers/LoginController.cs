using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web;
using Web.Models;
using Web.DAO;
using Web.Core;
using Web.Commons;
using Web.Model;
using System.Web.Script.Serialization;

namespace Web.Controllers
{
    public class LoginController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        //public ActionResult Login(Login lg)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        var dao = new login();
        //        var result = dao.Login(lg.Username, HelperEncryptor.Md5Hash(lg.Password));
        //        if (result == 1)
        //        {
        //            var user = dao.GetById(lg.Username);
        //            var userSession = new UserLogin();
        //            Session["name"] = user.UserName;
        //            Session["id"] = user.ID;
        //            userSession.Username = user.UserName;
        //            userSession.UserID = user.ID;
        //            Session.Add(CommonConstant.USER_SESSION, userSession);
        //            return RedirectToAction("Index", "Home");
        //        }
        //        else if (result == 0)
        //        {
        //            ModelState.AddModelError("", "Tài khoản không đúng");
        //        }
        //        else if (result == -1)
        //        {
        //            ModelState.AddModelError("", "Tài khoản đang bị khóa");
        //        }
        //        else if (result == -2)
        //        {
        //            ModelState.AddModelError("", "Mật khẩu không đúng");
        //        }
        //        else
        //        {
        //            ModelState.AddModelError("", "Đăng nhập không thành công");
        //        }
        //    }
        //    return View("Index");
        //}
        public ActionResult LogOut()
        {
            Session.Abandon();
            return RedirectToAction("Index", "Home");
        }
        public JsonResult Register(string id)
        {
            LedQuaTangEntities db = new LedQuaTangEntities();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            User u = serializer.Deserialize<User>(id);
            u.CreatedDate = DateTime.Now;
            db.Users.Add(u);
            return Json(new
            {

            }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Logins(string id, string user, string pass)
        {
            LedQuaTangEntities db = new LedQuaTangEntities();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            User u = serializer.Deserialize<User>(id);
            Session["id"] = "";
            var dao = new login();
            var result = dao.Login(user, HelperEncryptor.Md5Hash(pass));
            var userr = dao.GetById(user, HelperEncryptor.Md5Hash(pass));
            if (userr != null)
            {
                
                Session["name"] = userr.UserName;
                Session["id"] = userr.ID;
                var userSession = new UserLogin();
                userSession.Username = userr.UserName;
                userSession.UserID = userr.ID;
                Session.Add(CommonConstant.USER_SESSION, userSession);
            }

            return Json(new
            {
                data = result
            }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult CheckAlready(string userrg)
        {
            LedQuaTangEntities db = new LedQuaTangEntities();
            var check = db.Users.FirstOrDefault(x => x.UserName == userrg);
            if (check != null)
            {
                return Json(false, JsonRequestBehavior.AllowGet);
            }
            return Json(true, JsonRequestBehavior.AllowGet);
        }

    }
}

