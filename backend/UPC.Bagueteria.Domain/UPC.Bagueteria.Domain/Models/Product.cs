using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace UPC.Bagueteria.Domain.Models
{
    public  class Product : BaseModels
    {
        [Key]
        public int ProductID { get; set; }
        public string Name { get; set; }
        public int CategoryID { get; set; }
        public int StockMin { get; set; }
    }
}
