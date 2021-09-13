using CMS.IRepository;
using CMS.Reporitory;
using System;
using System.Dynamic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using Web.BaseSecurity;
using Web.Model;
using Web.Repository;
using Web.Repository.Entity;

namespace Web.Controllers
{
    public class HomeController : BaseController
    {
        ISlideIRepository slideRepository = new SlideRepository();
        IHomeMenuRepository menuHomeRepository = new HomeMenuRepository();
        INewsRepository newsRepository = new NewsRepository();
        ILogoRepository logoRepository = new LogoRepository();
        IProductRepository productRepository = new ProductRepository();
        public ActionResult Index()
        {
            return View();
        }
      
       
        public PartialViewResult Header()
        {
            return PartialView();
        }
        public PartialViewResult MenuHome()
        {
            var menu = menuHomeRepository.GetAll().ToList();
            return PartialView(menu);

        }
        
        public PartialViewResult Slider()
        {
            var slider = slideRepository.GetAll().ToList();
            return PartialView(slider);
        }
        public PartialViewResult NewsHome()
        {
            var lstNews = newsRepository.GetAll().Where(x=>x.Status==2).OrderBy(x=>x.CreatedDate).Take(3).ToList();
            return PartialView(lstNews);
        }
        public  PartialViewResult PathWay()
        {
            string  path= string.Empty;
            var linkSeo = HttpContext.Request.FilePath;
            var arrLink = linkSeo.Split('/');
            var link = arrLink[1];
            if(link== "danh-muc-san-pham")
            {
                path  = "Sản phẩm";
                ViewBag.LinkPath = "san-pham.html";
            }
            else if (link == "danh-muc-tin-tuc")
            {
                path = "Tin tức";
                ViewBag.LinkPath = "tin-tuc.html";
            }
            ViewBag.Path = path;
            return PartialView();
        }
        public PartialViewResult Logo()
        {
            var logo = logoRepository.GetAll().FirstOrDefault(x => x.Status == true && x.Type==1);
            return PartialView(logo);
        }
        public ActionResult LinkSeo(string linkseo)
        {
            ViewBag.LinkSeo = linkseo;
            return View();
        }
        public ActionResult LinkSeoProduct(string linkseo, int pageIndex)
        {
            string name = string.Empty;
            var category = menuHomeRepository.GetAll().FirstOrDefault(x => x.LinkSeo == linkseo);
            if (category != null)
            {
                name = category.Name;
            }
            var lstProduct = productRepository.ProductGetByCategory(linkseo);
            var totalAdv = lstProduct.Count();
            lstProduct = lstProduct.Skip((pageIndex - 1) * 8).Take(8).ToList();
            return Json(new
            {
                categoryName = name,
                viewContent = RenderViewToString("~/Views/Home/LinkSeoProduct.cshtml", lstProduct),
                totalPages = Math.Ceiling(((double)totalAdv / 8)),
            }, JsonRequestBehavior.AllowGet);
        }
    }
}