using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace UPC.Bagueteria.Domain.Models
{
    public class Customer: BaseModels
    {
        [Key]
        public int CustomerID { get; set; }
        public string Name { get; set; }
        public string LastName { get; set; }
        public string CardID { get; set; }
        public DateTime Bithday { get; set; }
        public char Gender { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string Referece { get; set; }
        public string Password { get; set; }
        public string Role { get; set; }
    }
}
