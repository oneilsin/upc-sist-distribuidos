using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace UPC.Bagueteria.Domain.Models
{
    public  class Prices :BaseModels
    {
        [Key]
        public int PriceID { get; set; }
        public int ProductID { get; set; }
        public int Unity { get; set; }
        public decimal Price { get; set; }
    }
}
