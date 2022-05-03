using System;
using System.Collections.Generic;
using System.Text;

namespace UPC.Bagueteria.Domain.Models
{
    public class EntityResponse
    {
        public EntityResponse()
        {
            _isSuccess = false;
            _errorCode = "0000";
            _errorMessage = "";
            _data = null;
        }
        private Boolean _isSuccess;
        private String _errorCode;
        private String _errorMessage;
        private Object _data;

        public bool IsSuccess { get => _isSuccess; set => _isSuccess = value; }
        public string ErrorCode { get => _errorCode; set => _errorCode = value; }
        public string ErrorMessage { get => _errorMessage; set => _errorMessage = value; }
        public object Data { get => _data; set => _data = value; }
    }
}
