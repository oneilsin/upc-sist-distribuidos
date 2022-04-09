using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using UPC.Bagueteria.Domain.Models;
using UPC.Bagueteria.Domain.Queries.ProductQuerieResult;

namespace UPC.Bagueteria.Domain.IRepositories.IStockRepositories
{
    public interface IStockRepository:IRepository<Stock>
    {
        Task<EntityResponse> GetStockByCategory(string idCategory);
    }
}
