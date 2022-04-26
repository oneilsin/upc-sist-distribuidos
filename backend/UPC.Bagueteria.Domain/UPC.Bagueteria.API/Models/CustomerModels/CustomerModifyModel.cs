using System;

namespace UPC.Bagueteria.API.Models.CustomerModels
{
    public class CustomerModifyModel
    {
        public string CustomerName { get; set; }
        public string LastName { get; set; }
        public string CardID { get; set; }
        public DateTime Bithday { get; set; }
        public bool Gender { get; set; }
        public string Password { get; set; }
        public string Address { get; set; }
        public string Referece { get; set; }
        public int CustomerID { get; set; }
    }
}
