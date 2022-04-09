using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace UPC.Bagueteria.Domain
{
    public interface IRepository<T> where T : class, new()
    {
        Task<T> GetById(string id);
        Task<IEnumerable<T>> GetList();
    }
}
