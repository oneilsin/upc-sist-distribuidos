using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using UPC.Bagueteria.Domain.Models;

namespace UPC.Bagueteria.Domain.IRepositories.ISecurityRepositories
{
    public interface ILoginRepository : IRepository<LoginModel>
    {
        Task<EntityResponse> GetLogin(LoginModel login);
    }
}
