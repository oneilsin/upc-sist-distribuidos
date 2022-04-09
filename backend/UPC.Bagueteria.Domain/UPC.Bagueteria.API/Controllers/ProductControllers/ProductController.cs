using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UPC.Bagueteria.API.Models;
using UPC.Bagueteria.Domain.Queries.ProductQuerieResult;
using UPC.Bagueteria.Infra.Dao;

namespace UPC.Bagueteria.API.Controllers.ProductControllers
{
    [Produces("application/json")]
    [Route("api/Products")]
    [ApiController]
    public class ProductController : Controller
    {
        [Produces("application/json")]
        [AllowAnonymous]
        [HttpGet]
        [Route("GetStockByCategory")]
        public async Task<ActionResult> GetStockByCategory(string idCategory)
        {
            using (var uow = new UnitOfWork())
            {
                var response = await uow.Stock.GetStockByCategory(idCategory);
                if (response.Data != null)
                {
                    var objStock = response.Data as List<StockQuery>;
                    response.Data = objStock.Select(o => new StockCategoryViewModel
                    {
                        ProductID = o.ProductID,
                        Producto=o.Producto,
                        Precio=o.Precio,
                        Stock=o.Stock,
                    });
                }
                return Json(response);
            }
        }
    }
}
