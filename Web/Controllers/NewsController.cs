
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web.BaseSecurity;
using Web.Model;
using Web.Repository;
using Web.Repository.Entity;

namespace Web.Controllers
{
    public class NewsController : BaseController
    {
        readonly  INewsRepository newsRepository = new NewsRepository();
        // GET: News
        public ActionResult Index()
        {
            var lstNewsTop = newsRepository.GetAll().Skip(1).ToList();
            ViewBag.NewsTop = lstNewsTop;
            var lstNewsButtom = newsRepository.GetAll().Where(x => x.Status == 2).Skip(3).Take(4).ToList();
            ViewBag.NewsButtom = lstNewsButtom;
            var obj = newsRepository.GetAll().Where(x => x.Status == 2).FirstOrDefault();
            if (obj != null)
                return View(obj);
            else
                return RedirectToAction("", "News");
        }
        public ActionResult ShowNews()
        {
            return View();
        }
        public ActionResult Detail(int id)
        {
            var news =  newsRepository.Detail(id);
            var leftRelated = new List<News>();
            ViewBag.LeftRelated = leftRelated;
            return View(news);
        }
        public ActionResult NewsList(string linkseo)
        {
            ViewBag.LinkSeo = linkseo;
            return View();
        }
        
    }
}