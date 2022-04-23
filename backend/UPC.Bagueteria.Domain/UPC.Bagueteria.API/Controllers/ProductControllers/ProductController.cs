using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UPC.Bagueteria.API.Models;
using UPC.Bagueteria.API.Models.ProductModels;
using UPC.Bagueteria.Domain.Models;
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
                        Producto = o.Producto,
                        Precio = o.Precio,
                        Stock = o.Stock,
                    });
                }
                return Json(response);
            }
        }

        [Produces("application/json")]
        [AllowAnonymous]
        [HttpPost]
        [Route("AddToCart")]
        public async Task<ActionResult> AddToCart(ProductAddCartModel model)
        {
            using (var uow = new UnitOfWork())
            {
                var response = await uow.Stock.AddCart(new Stock()
                {
                    ProductID=model.ProductID,Quantity=model.Quantity,
                }, new Orders 
                {
                    CustomerID =model.CustomerID
                });                
                
                return Json(response);
            }
        }

        [Produces("application/json")]
        [AllowAnonymous]
        [HttpPost]
        [Route("EditToCart")]
        public async Task<ActionResult> EditToCart(ProductEditCartModel model)
        {
            using (var uow = new UnitOfWork())
            {
                var response = await uow.Stock.EditCart(new Stock()
                {
                    Quantity = model.Quantity,
                    StockID = model.StockID,
                }, new Orders
                {
                    OrderID = model.OrderID
                });

                return Json(response);
            }
        }

        [Produces("application/json")]
        [AllowAnonymous]
        [HttpGet]
        [Route("GetCartByCustomer")]
        public async Task<ActionResult> GetCartByCustomer(string idCustomer)
        {
            using (var uow = new UnitOfWork())
            {
                var response = await uow.Stock.GetCartByCustomer(idCustomer);
                return Json(response);
            }
        }
    }
}
