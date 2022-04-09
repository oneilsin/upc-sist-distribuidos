using Autonomus.Library.AdoNet.Asyncs;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using UPC.Bagueteria.Domain;

namespace UPC.Bagueteria.Infra.Dao
{
    public class Repository<T> : IRepository<T> where T : class, new()
    {
        protected readonly AdoContext _adoContext;

        public Repository(AdoContext adoContext)
        {
            _adoContext = adoContext;
        }

        public async Task<T> GetById(string id)
        {
            return await _adoContext.SelectByKey<T>(id);
        }

        public async Task<IEnumerable<T>> GetList()
        {
            return await _adoContext.SelectAll<T>();
        }
    }
}
