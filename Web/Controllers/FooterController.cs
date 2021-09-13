using CMS.IRepository;
using CMS.Reporitory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web.Repository;
using Web.Repository.Entity;

namespace Web.Controllers
{
    public class FooterController : Controller
    {
        IFooterRepository footerRepository = new FooterRepository();
        ILogoRepository logoRepository = new LogoRepository();
        IHomeMenuRepository menuHomeRepository = new HomeMenuRepository();
        // GET: Footer
        public ActionResult LoadFooter()
        {
            var logo = logoRepository.GetAll().FirstOrDefault(x => x.Status == true && x.Type == 2);
            string urlLog = string.Empty;
            if (logo != null)
            {
                urlLog = logo.Image;
                ViewBag.LogoFooter = urlLog;
            }
           
            var footer = footerRepository.GetAll().FirstOrDefault();
            ViewBag.Footer = footer.Contents;
            var menu = menuHomeRepository.GetAll().ToList();
            return PartialView(menu);
        }
       
    }
}