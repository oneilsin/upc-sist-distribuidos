using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UPC.Bagueteria.Domain.Models;

namespace UPC.Bagueteria.API.Configs
{
    public class Settings
    {
        public EntityResponse Response(bool success, string errCde, string errMsg, Object data)
        {
            return new EntityResponse()
            {
                IsSuccess=success,
                ErrorCode=errCde,
                ErrorMessage=errMsg,
                Data=data
            };
        }
    }
}
