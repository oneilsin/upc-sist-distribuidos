using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace UPC.Bagueteria.Domain.Models
{
    public class Category : BaseModels
    {
        [Key]
        public int CategoryID { get; set; }
        public string Name { get; set; }
    }
}
