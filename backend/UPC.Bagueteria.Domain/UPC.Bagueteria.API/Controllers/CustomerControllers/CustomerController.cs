using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using UPC.Bagueteria.API.Models.CustomerModels;
using UPC.Bagueteria.Domain.Models;
using UPC.Bagueteria.Infra.Dao;

namespace UPC.Bagueteria.API.Controllers.CustomerControllers
{
    [Produces("application/json")]
    [Route("api/Customers")]
    [ApiController]
    public class CustomerController : Controller
    {
        [Produces("application/json")]
        [AllowAnonymous]
        [HttpPost]
        [Route("CreateCustomer")]
        public async Task<ActionResult> Create(CustomerCreateModel model)
        {
            using (var uow = new UnitOfWork())
            {
                var response = await uow.Customer.Create(new Customer()
                {
                    Name = model.Name,
                    Password = model.Password,
                    Email = model.Email,
                });

                return Json(response);
            }
        }

        [Produces("application/json")]
        [AllowAnonymous]
        [HttpPost]
        [Route("ModifyCustomer")]
        public async Task<ActionResult> Modify(CustomerModifyModel model)
        {
            using (var uow = new UnitOfWork())
            {
                var response = await uow.Customer.Modify(new Customer()
                {
                    Name = model.Name,
                    LastName = model.LastName,
                    CardID = model.CardID,
                    Bithday = model.Bithday,
                    Gender = model.Gender,
                    Password = model.Password,
                    CustomerID = model.CustomerID,
                });

                return Json(response);
            }
        }
    }
}
