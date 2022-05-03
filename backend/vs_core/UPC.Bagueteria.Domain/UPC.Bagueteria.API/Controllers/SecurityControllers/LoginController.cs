using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Threading.Tasks;
using UPC.Bagueteria.API.Security;
using UPC.Bagueteria.Domain.Models;
using UPC.Bagueteria.Domain.Response;
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
                if (response.Data != null)
                {
                    var objLogin = response.Data as LoginResponse;
                   /* var id = objLogin.IdUsuario.ToString();
                    var doc = objLogin.Documento.ToString();

                    var token = JsonConvert
                        .DeserializeObject<AccessToken>(
                            await new Authentication().GenerateToken(doc, id)
                        ).access_token;

                    objLogin.Token = token;*/
                    response.Data = objLogin;
                }
                return Json(response);
            }
        }
    }
}
