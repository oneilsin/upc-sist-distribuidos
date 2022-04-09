using System;
using System.Collections.Generic;
using System.Text;

namespace UPC.Bagueteria.Domain.Models
{
    public  class BaseSales
    {
        public string Year { get; set; }
        public string Mont { get; set; }
        public string Day { get; set; }
        public bool Deleted { get; set; }
    }
}
