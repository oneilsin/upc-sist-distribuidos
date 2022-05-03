using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using UPC.Bagueteria.Domain.Models;
using UPC.Bagueteria.Infra.Dao;

namespace UPC.Bagueteria.API.Controllers.SecurityControllers
{
    [Produces("application/json")]
    [Route("api/Login")]
    [ApiController]
    public class LoginController : Controller
    {
        [Produces("application/json")]
        [AllowAnonymous]
        [HttpPost]
        [Route("login")]
        public async Task<ActionResult> Login(LoginModel model)
        {
            using (var uow = new UnitOfWork())
            {
                var response = await uow.Login.GetLogin(model);
                //if (response.Data != null) ;
                return Json(response);
            }
        }
    }
}
