using System;

namespace UPC.Bagueteria.API.Models.CustomerModels
{
    public class CustomerModifyModel
    {
        public string Name { get; set; }
        public string LastName { get; set; }
        public string CardID { get; set; }
        public DateTime Bithday { get; set; }
        public char Gender { get; set; }
        public string Password { get; set; }
        public int CustomerID { get; set; }
    }
}
