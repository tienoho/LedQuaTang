
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
    public class InstructionController : Controller
    {
        IInstructionRepository instructionRepository = new InstructionRepository();
        // GET: News
        public ActionResult Index()
        {
            var obj = instructionRepository.GetAll().FirstOrDefault();
            return View(obj);
        }
    }
}