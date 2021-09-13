using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web.Model;
using Web.Repository;
using Web.Repository.Entity;

namespace Web.Controllers
{
    public class ContactController : Controller
    {
        readonly IContactReporitory _ContactReporitory = new ContactReporitory();
        // GET: Contact
        public ActionResult Index()
        {
            var contact = _ContactReporitory.GetAll().FirstOrDefault();
            if(contact!=null)
              ViewBag.Contact = contact.Contents;
            return View();
        }
       
       
        
    }
}