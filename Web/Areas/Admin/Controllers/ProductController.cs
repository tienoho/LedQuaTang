using CMS.IRepository;
using CMS.Reporitory;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Xml.Linq;
using Web.BaseSecurity;
using Web.Model;
using Web.Repository;
using Web.Repository.Entity;

namespace Web.Areas.Admin.Controllers
{ 
    public class ProductController : BaseController
    {
        IProductRepository productRepository = new ProductRepository();
        private IHomeMenuRepository menuHomeRepository = new HomeMenuRepository();

        // GET: Product
        [Authorize(Roles = "Index")]
        public ActionResult Index()
        {
            return View();
        }
        [Authorize(Roles = "Index")]
        public ActionResult ListData(int satatus, string keyWord, int pageIndex)
        {
            Session["PAGEINDEX"] = (pageIndex - 1) * 10;
            if (!string.IsNullOrEmpty(keyWord))
            {
                Session["PAGEINDEX"] = 0;
                keyWord = keyWord.Trim();
            }
            var model = productRepository.ListAll(satatus, keyWord).ToList();
            var totalAdv = model.Count();
            model = model.Skip((pageIndex - 1) * 10).Take(10).ToList();
            return Json(new
            {
                totalModel = totalAdv,
                viewContent = RenderViewToString("~/Areas/Admin/Views/Product/ListData.cshtml", model),
                totalPages = Math.Ceiling(((double)totalAdv / 10)),
            }, JsonRequestBehavior.AllowGet);
        }
        [Authorize(Roles = "Add")]
        public ActionResult AddImg(int id)
        {
            ViewBag.ID = id;
            return Json(RenderViewToString("~/Areas/Admin/Views/Product/AddImg.cshtml"), JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult SaveImages(string images,int id)
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                var lstImages = serializer.Deserialize<List<string>>(images);
                XElement xElement = new XElement("Images");
                foreach (var item in lstImages)
                {
                    var arr = item.Split('/');
                    xElement.Add(new XElement("Image", item));
                }
                productRepository.UpdateImages(id, xElement.ToString());
                return Json(new
                {
                    result = true
                });
            }
            catch (Exception)
            {
                return Json(new
                {
                    result = false
                });
            }
           
        }
        public JsonResult LoadImages(int id)
        {
            var product = productRepository.Find(id);
            var imageMore = product.ImageMore;
            XElement xImageMore = XElement.Parse(imageMore);
            List<string> lstImageMore = new List<string>();
            foreach (var item in xImageMore.Elements())
            {
                lstImageMore.Add(item.Value);
            }
            return Json(new
            {
                data = lstImageMore
            },JsonRequestBehavior.AllowGet);
        }
        [Authorize(Roles = "Add")]
        [HttpGet]
        public ActionResult Add()
        {
            TempData["Category"] = menuHomeRepository.GetAll().Where(x=>x.ParentId != 0).ToList();
            TempData["Danhmuc"] = menuHomeRepository.GetAll().Where(x=>x.ParentId == 0 && x.Product == true).ToList();
            return View();
        }
        [Authorize(Roles = "Add")]
        [ValidateInput(false)]
        [HttpPost]
        public ActionResult Add(Product product, string isContinue)
        {
            try
            {
                if (string.IsNullOrEmpty(product.Description))
                {
                    return Json(new
                    {
                        IsSuccess = false,
                        Messenger = "Vui lòng nhập mô tả sản phẩm"
                    }, JsonRequestBehavior.AllowGet);
                }
                if (string.IsNullOrEmpty(product.Images))
                {
                    return Json(new
                    {
                        IsSuccess = false,
                        Messenger = "Vui lòng thêm ảnh sản phẩm"
                    }, JsonRequestBehavior.AllowGet);
                }
                var obj = productRepository.GetAll().FirstOrDefault(x=>x.Name == product.Name);
                if (obj != null)
                {
                    return Json(new
                    {
                        IsSuccess = false,
                        Messenger = "Tên sản phẩm đã tồn tại"
                    }, JsonRequestBehavior.AllowGet);
                }
                product.CreatedDate = DateTime.Now;
                productRepository.Add(product);
                return Json(new
                {
                    IsContinue = isContinue,
                    IsSuccess = true,
                    Messenger = "Thêm mới thành công"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new
                {
                    IsSuccess = false,
                    Messenger = "Thêm mới thất bại"
                }, JsonRequestBehavior.AllowGet);
            }
        }
        [Authorize(Roles = "Edit")]
        [HttpGet]
        public ActionResult Edit(int id)
        {
            TempData["Category"] = menuHomeRepository.GetAll().Where(x => x.ParentId != 0).ToList();
            TempData["Danhmuc"] = menuHomeRepository.GetAll().Where(x => x.ParentId == 0 && x.Product == true).ToList();
            var obj = productRepository.Find(id);
            return View(obj);
        }
        [Authorize(Roles = "Edit")]
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(Product product)
        {
            try
            {
                if (string.IsNullOrEmpty(product.Description))
                {
                    return Json(new
                    {
                        IsSuccess = false,
                        Messenger = "Vui lòng nhập mô tả sản phẩm"
                    }, JsonRequestBehavior.AllowGet);
                }
                var obj = productRepository.GetAll().FirstOrDefault(x => x.Name == product.Name && x.ID != product.ID);
                if (obj != null)
                {
                    return Json(new
                    {
                        IsSuccess = false,
                        Messenger = "Tên sản phẩm đã tồn tại"
                    }, JsonRequestBehavior.AllowGet);
                }
                productRepository.Edit(product);
                return Json(new
                {
                    IsSuccess = true,
                    Messenger = "Cập nhật thành công"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new
                {
                    IsSuccess = false,
                    Messenger = "Cập nhật thất bại"
                }, JsonRequestBehavior.AllowGet);
            }
        }
        [Authorize(Roles = "Delete")]
        public ActionResult Delete(int id)
        {
            try
            {
                productRepository.Delete(id);
                return Json(new { IsSuccess = true, Messenger = "Xóa thành công" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new { IsSuccess = false, Messenger = "Xóa thất bại" }, JsonRequestBehavior.AllowGet);
            }
        }
        [HttpGet]
        public void DeleteImg(string fileImg)
        {
            System.IO.File.Delete(Path.Combine(Server.MapPath("~/Uploads/Images/"), fileImg));
        }
        [HttpGet]
        public ActionResult CheckProductCode(string code)
        {
            var product = productRepository.CheckProductCode(code);
            if (product != null)
            {
                return Json(new { IsSuccess = false, Messenger = "Mã sản phẩm đã tồn tại" }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { IsSuccess = true, Messenger = "" }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Detail(int id)
        {
            var product = productRepository.Find(id);
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
            return Json(RenderViewToString("~/Areas/Admin/Views/Product/Detail.cshtml", product), JsonRequestBehavior.AllowGet);
        }
    }
}
