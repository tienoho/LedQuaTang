using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web.BaseSecurity;
using Web.Model;
using Web.Repository;
using Web.Repository.Entity;

namespace Web.Areas.Admin.Controllers
{
    public class InstructionController : BaseController
    {
        //
        // GET: /Admin/Instruction/
        readonly IInstructionRepository _instructionRepository = new InstructionRepository();
        public ActionResult Index()
        {
            return View();
        }
        [Authorize(Roles = "Index")]
        [HttpPost]
        public ActionResult ListData()
        {
            var lstObj = _instructionRepository.GetAll().ToList();
            return Json(new
            {
                viewContent = RenderViewToString("~/Areas/Admin/Views/Instruction/_ListData.cshtml", lstObj),
            }, JsonRequestBehavior.AllowGet);
        }
        [Authorize(Roles = "Add")]
        public ActionResult Add()
        {
            return View();
        }

        [Authorize(Roles = "Add")]
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Add(Instruction obj)
        {
            try
            {
                obj.CreatedDate = DateTime.Now;
                _instructionRepository.Add(obj);
               
                return Json(new
                {
                    IsSuccess = true,
                    Messenger = "Thêm mới thành công",
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new
                {
                    IsSuccess = false,
                    Messenger = string.Format("Thêm mới thất bại")
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult Edit(int id)
        {
            var obj = _instructionRepository.Find(id);
            return View(obj);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(Instruction obj)
        {
            try
            {
               
                _instructionRepository.Edit(obj);
                return Json(new
                {
                    IsSuccess = true,
                    Messenger = "Cập nhật thành công",
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new
                {
                    IsSuccess = false,
                    Messenger = string.Format("Cập thất bại")
                }, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult Delete(int id)
        {
            try
            {
                _instructionRepository.Delete(id);
                return Json(new
                {
                    IsSuccess = true,
                    Messenger = "Xóa thành công",
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return Json(new
                {
                    IsSuccess = false,
                    Messenger = string.Format("Xóa thất bại")
                }, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult Detail(int id)
        {
            var obj = _instructionRepository.Find(id);
            return Json(RenderViewToString("~/Areas/Admin/Views/Instruction/Detail.cshtml", obj), JsonRequestBehavior.AllowGet);
        }
    }
}
