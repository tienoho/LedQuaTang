using CMS.IRepository;
using CMS.Reporitory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PagedList;
using System.Web.Mvc;
using Web.BaseSecurity;
using System.Xml.Linq;
using Web.Repository;
using Web.Repository.Entity;
using System.Web.Script.Serialization;
using Web.Model;
using System.Data.Entity;

namespace Web.Controllers
{
    public class ProductController : BaseController
    {
        private IProductRepository productRepository = new ProductRepository();
        private IHomeMenuRepository menuHomeRepository = new HomeMenuRepository();
        private ICartRepository cartRepository = new CartRepository();
        private const string CartSession = "CartSession";

        // GET: Product
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult ThuBongHoatHinhProduct(int pageIndex)
        {
            var model = productRepository.GetAll().Where(x => x.Status == 3).ToList();
            var totalAdv = model.Count();
            model = model.Skip((pageIndex - 1) * 8).Take(8).ToList();
            return Json(new
            {
                viewContent = RenderViewToString("~/Views/Product/ThuBongHoatHinhProduct.cshtml", model),
                totalPages = Math.Ceiling(((double)totalAdv / 8)),
            }, JsonRequestBehavior.AllowGet);
        }
        //public ActionResult ThuBongHoatHinhProduct(string keyWord,string code, int pageIndex)
        //{
        //    var model = productRepository.ListAll(0,keyWord).ToList();
        //    var totalAdv = model.Count();
        //    model = model.Skip((pageIndex - 1) * 18).Take(18).ToList();
        //    return Json(new
        //    {
        //        viewContent = RenderViewToString("~/Views/Product/ThuBongHoatHinhProduct.cshtml", model),
        //        totalPages = Math.Ceiling(((double)totalAdv / 18)),
        //    }, JsonRequestBehavior.AllowGet);
        //}
        public PartialViewResult HotProduct()
        {
            var lst = productRepository.GetAll().Where(x => x.Status == 1).Take(5).ToList();
            return PartialView(lst);
        }
        public PartialViewResult RepresentProduct()
        {
            var lst = productRepository.GetAll().Where(x => x.Status == 1).Take(8).ToList();
            //var lst = productRepository.GetAll().Where(x => x.Status == 2).Take(15).ToList();
            return PartialView(lst);
        }
        public PartialViewResult SaleProduct()
        {
            var lst = productRepository.GetAll().Where(x => x.Status == 1).Take(4).ToList();
            //var lst = productRepository.GetAll().Where(x => x.Status == 2).Take(4).ToList();
            return PartialView(lst);
        }
        public PartialViewResult MenuHome1()
        {
            var menu = menuHomeRepository.GetAll().Where(x => x.Product == true || x.ParentId != 0).ToList();
            return PartialView(menu);

        }
        public PartialViewResult DatHangNhanh(string customerOrder, string orderDetail)
        {
            var order = new JavaScriptSerializer().Deserialize<tbl_Order>(customerOrder);
            var details = new JavaScriptSerializer().Deserialize<List<OrderDetail>>(orderDetail);
            order.Status = 1;
            order.CreatedDate = DateTime.Now;
            int id = cartRepository.AddOrder(order);
            foreach (var item in details)
            {
                item.OrderID = id;
                cartRepository.AddOrderDetail(item);
            }
            Session.Clear();

            return PartialView();


        }
        public ActionResult GoiOm()
        {
            return View();
        }
        public ActionResult ThuBongHoatHinh()
        {
            return View();
        }
        public ActionResult GoiOmProduct(int pageIndex)
        {
            var model = productRepository.GetAll().Where(x => x.Status == 2).ToList();
            var totalAdv = model.Count();
            model = model.Skip((pageIndex - 1) * 8).Take(8).ToList();
            return Json(new
            {
                viewContent = RenderViewToString("~/Views/Product/GoiOmProduct.cshtml", model),
                totalPages = Math.Ceiling(((double)totalAdv / 8)),
            }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult GauTeddyProduct(int pageIndex)
        {
            var model = productRepository.GetAll().Where(x => x.Status == 1).ToList();
            var totalAdv = model.Count();
            model = model.Skip((pageIndex - 1) * 8).Take(8).ToList();
            return Json(new
            {
                viewContent = RenderViewToString("~/Views/Product/GauTeddyProduct.cshtml", model),
                totalPages = Math.Ceiling(((double)totalAdv / 8)),
            }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Detail(int id)
        {
            var product = productRepository.Find(id);
            var lstProduct = productRepository.GetAll().Where(x => x.CategoryId == product.CategoryId && x.ID != product.ID).ToList();
            ViewBag.RelatedProduct = lstProduct;
            //Load nhiều ảnh hơn
            if (product.ImageMore != null)
            {
                var imageMore = product.ImageMore;
                XElement xImageMore = XElement.Parse(imageMore);
                List<string> lstImageMore = new List<string>();
                foreach (var item in xImageMore.Elements())
                {
                    lstImageMore.Add(item.Value);
                }
                ViewBag.ImageMore = lstImageMore;
            }
            return View(product);
        }
        public ActionResult Product(string keyword)
        {
            var record = productRepository.ListAll(keyword).ToList();
            ViewBag.keyword = keyword;
            return View(record);
        }
        public ActionResult All()
        {
            return View();
        }
        public JsonResult ProductAll(int pageIndex)
        {
            var model = productRepository.GetAll().ToList();
            var totalAdv = model.Count();
            model = model.Skip((pageIndex - 1) * 8).Take(8).ToList();
            return Json(new
            {
                viewContent = RenderViewToString("~/Views/Product/ProductAll.cshtml", model),
                totalPages = Math.Ceiling(((double)totalAdv / 8)),
            }, JsonRequestBehavior.AllowGet);
        }

    }
}