using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using UPC.Bagueteria.API.Models.SalesModels;
using UPC.Bagueteria.Domain.Models;
using UPC.Bagueteria.Infra.Dao;

namespace UPC.Bagueteria.API.Controllers.SalesControllers
{
    [Produces("application/json")]
    [Route("api/Sales")]
    [ApiController]
    public class SalesController : Controller
    {
        [Produces("application/json")]
        [AllowAnonymous]
        [HttpPost]
        [Route("CreateSales")]
        public async Task<ActionResult> CreateSales(SaleCreateModel model)
        {
            using (var uow = new UnitOfWork())
            {
                var response = await uow.Sales.AddSale(new Sales()
                {
                    CustomerID = model.CustomerID,
                    Delivery = model.Delivery,
                    PaymentID = model.PaymentID,
                });

                return Json(response);
            }
        }

        [Produces("application/json")]
        [AllowAnonymous]
        [HttpPost]
        [Route("SetSaleDispatch")]
        public async Task<ActionResult> SetSaleDispatch(SaleDispatchModel model)
        {
            using (var uow = new UnitOfWork())
            {
                var response = await uow.Sales.UpdateSale(new Sales()
                {
                    EmployeeID = model.EmployeeID,
                    AttendedStatus = model.AttendedStatus,
                    SalesID = model.SalesID,
                });

                return Json(response);
            }
        }

        [Produces("application/json")]
        [AllowAnonymous]
        [HttpGet]
        [Route("GetPayment")]
        public async Task<ActionResult> GetPayment()
        {
            using (var uow = new UnitOfWork())
            {
                var response = await uow.Sales.GetPaymentList();
                return Json(response);
            }
        }

        [Produces("application/json")]
        [AllowAnonymous]
        [HttpGet]
        [Route("GetPendingSales")]
        public async Task<ActionResult> GetPendingSales()
        {
            using (var uow = new UnitOfWork())
            {
                var response = await uow.Sales.GetSalesPendingList();
                return Json(response);
            }
        }
    }
}
