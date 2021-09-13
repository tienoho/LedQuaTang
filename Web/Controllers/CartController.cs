
using CMS.IRepository;
using CMS.Reporitory;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using Web.Model;
using Web.Model.CustomModel;
using Web.Repository;
using Web.Repository.Entity;
using System.Linq;

namespace Web.Controllers
{
    public class CartController : Controller
    {
        private const string CartSession = "CartSession";
        private IProductRepository productRepository = new ProductRepository();
        private ICartRepository cartRepository = new CartRepository();
        // GET: Cart
        public ActionResult Index()
        {
            var cart = Session[CartSession];
            var lst = new List<CartItem>();
            if (cart != null)
            {
                lst = (List<CartItem>)Session[CartSession];
                Session["CoutCart"]= lst.Count;
            }else
            {
                Session["CoutCart"] = 0;
            }
            return View(lst);
        }
        public ActionResult AddProduct(int id,int quantity)
        {
            var product = productRepository.Find(id);
            var cart = Session[CartSession];
            if(cart != null)
            {
                var lst = (List<CartItem>)Session[CartSession];
                if(lst.Exists(x=>x.Product.ID == id))
                {
                    foreach (var item in lst)
                    {
                        if (item.Product == product)
                        {
                            item.Quantity += quantity;
                        }
                    }
                }else
                {
                    var item = new CartItem();
                    item.Product = product;
                    item.Quantity = quantity;
                    lst.Add(item);
                }
               
            }
            else
            {
                var item = new CartItem();
                item.Product = product;
                item.Quantity = quantity;
                var lst =new  List<CartItem>();
                lst.Add(item);
                Session[CartSession]= lst;
            }
            return RedirectToAction("Index");
        }
        public void EditProduct(string Products)
        {
            var lst = new JavaScriptSerializer().Deserialize<List<ProductCustom>>(Products);
            var lstCartItem = new List<CartItem>();
            foreach (var item in lst)
            {
                var product = new Product
                {
                    Images = item.Images,
                    Name = item.Name,
                    Price = item.Price
                };
                var quantity = item.Quantity;
                var cartItem = new CartItem
                {
                    Product = product,
                    Quantity = quantity
                };
                lstCartItem.Add(cartItem);
            }
            Session[CartSession] = lstCartItem;
        }
        public void DeleteSession()
        {
            Session.Remove(CartSession);
        }
        public ActionResult Order()
        {

            var cart = Session[CartSession];
            var lst = new List<CartItem>();
            if (cart != null)
            {
                lst = (List<CartItem>)Session[CartSession];
                Session["CoutCart"] = lst.Count;
            }
            else
            {
                Session["CoutCart"] = 0;
            }
            return View(lst);
        }
        [HttpPost]
        public ActionResult Order(string customerOrder, string orderDetail)
        {
            var order = new JavaScriptSerializer().Deserialize<tbl_Order>(customerOrder);
            //var details = new JavaScriptSerializer().Deserialize<List<OrderDetail>>(orderDetail);
            
            try
            {
                
                order.Status = 1;
                order.CreatedDate = DateTime.Now;
               int id = cartRepository.AddOrder(order);
                var details = (List<CartItem>)Session[CartSession];
                foreach (var item in details)
                {
                    var o = new OrderDetail();
                    o.OrderID = id;
                    o.ProductID = item.Product.ID;
                    o.Quantity = item.Quantity;
                    cartRepository.AddOrderDetail(o);
                }
                Session.Clear();
                return Json(new
                {
                    Success = true
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new
                {
                    Success = false
                }, JsonRequestBehavior.AllowGet);
            }
           
        }
        public ActionResult CancelOrder()
        {
            Session.Clear();
            return Json(new
            {
                Success = true
            }, JsonRequestBehavior.AllowGet);
        }
        class ProductCustom:Product
        {
            public int Quantity { get; set; }
        }
        public JsonResult Update(string cart)
        {
            var cartList = new JavaScriptSerializer().Deserialize<List<CartItem>>(cart);
            var listCart = (List<CartItem>)Session[CartSession];
            foreach(var item in listCart)
            {
                var Item = cartList.SingleOrDefault(x => x.Product.ID == item.Product.ID);
                if(Item != null)
                {
                    item.Quantity = Item.Quantity;
                }
                
            }
            return Json(new
            {
                status = true
            }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Update1(string cart)
        {
            var cartList = new JavaScriptSerializer().Deserialize<List<CartItem>>(cart);
            var Cartlist = (List<CartItem>)Session[CartSession];
            if (Cartlist != null && Cartlist.Count !=0)
            {
                
                foreach (var item in Cartlist)
                {
                    var Item = cartList.SingleOrDefault(x => x.Product.ID == item.Product.ID);
                    if (Item != null)
                    {
                        item.Quantity = Item.Quantity;
                    }

                }
            }
            else
            {
                var Item = new CartItem();
                foreach (var item in cartList)
                {
                    Item.Product = item.Product;
                    Item.Quantity = item.Quantity;
                }
            }
            
            
            return Json(new
            {
                status = true
            }, JsonRequestBehavior.AllowGet);
        }
        public PartialViewResult ViewCart(CartItem c)
        {
            var menu = productRepository.GetAll().ToList();
            return PartialView(menu);

        }
    }
}