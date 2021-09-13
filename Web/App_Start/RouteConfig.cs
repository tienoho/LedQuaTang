using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Web
{
    public class RouteConfig
    {
        
        public static void RegisterRoutes(RouteCollection routes)
        {
            //routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapRoute("sanpham", "san-pham.html", new { controller = "Product", action = "All" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("gioithieu", "gioi-thieu.html", new { controller = "About", action = "Index" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("lienhe", "lien-he.html", new { controller = "Contact", action = "Index" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("AddCart", "dat-mua-hang", new { controller = "Cart", action = "AddProduct" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("Giohang", "gio-hang.html", new { controller = "Cart", action = "Index" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("Tintuc", "tin-tuc.html", new { controller = "News", action = "Index" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("home", "trang-chu.html", new { controller = "Home", action = "Index" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("video", "video-san-pham.html", new { controller = "Video", action = "Index" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("productsale", "san-pham/khuyen-mai.html", new { controller = "Product", action = "Sale" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("producthot", "san-pham/san-pham-ban-chay.html", new { controller = "Product", action = "Hot" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("InfoDetail", "thong-tin-huu-ich/{id}/{metatitle}.html", new { controller = "Footer", action = "Detail", id = UrlParameter.Optional }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("NewDetail", "chi-tiet-tin-tuc/{id}/{metatitle}.html", new { controller = "News", action = "Detail", id = UrlParameter.Optional }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("ProductDetail", "chi-tiet-san-pham/{id}/{name}.html", new { controller = "Product", action = "Detail", id = UrlParameter.Optional }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("ProductCategory", "danh-muc-san-pham/{linkseo}.html", new { controller = "Category", action = "ProductList", linkseo = UrlParameter.Optional }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("NewsCategory", "danh-muc-tin-tuc/{linkseo}.html", new { controller = "News", action = "NewsList", linkseo = UrlParameter.Optional }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("phananh_kiennghi", "pages/phan-anh-kien-nghi.html", new { controller = "TiepNhanPAHome", action = "Index", id = UrlParameter.Optional, zoneid = "" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("huong-dan", "huong-dan-mua-hang.html", new { controller = "Instruction", action = "Index" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("video_detail", "pages/video/{id}/{title}.html", new { controller = "video", action = "Index", id = UrlParameter.Optional }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("dangnhap", "dang-nhap.html", new { controller = "Login", action = "Index", id = UrlParameter.Optional }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("thoat", "thoat.html", new { controller = "Login", action = "LogOut", id = UrlParameter.Optional }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("trangcanhan", "trang-ca-nhan.html", new { controller = "User", action = "Profiled"}, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("dangky", "dang-ky.html", new { controller = "User", action = "Register"}, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("goiom", "goi-om.html", new { controller = "Product", action = "GoiOm" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("thubonghoathinh", "thu-bong-hoat-hinh.html", new { controller = "Product", action = "ThuBongHoatHinh" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("LinkSeoProduct", "danh-muc/{linkseo}.html", new { controller = "Home", action = "LinkSeo" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("Instruction", "chuyen-cua-gau.html", new { controller = "Instruction", action = "Index" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("thanhtoan", "thanh-toan.html", new { controller = "Cart", action = "Order" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute("gauteddy", "gau-bong-teddy.html", new { controller = "Product", action = "Index" }, namespaces: new[] { "Web.Controllers" });
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                namespaces: new[] { "Web.Controllers" }
            );
        }
    }
}