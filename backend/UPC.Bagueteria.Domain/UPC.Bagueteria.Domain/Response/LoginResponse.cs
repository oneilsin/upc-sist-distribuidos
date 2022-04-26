using System;
using System.Collections.Generic;
using System.Text;

namespace UPC.Bagueteria.Domain.Response
{
    public class LoginResponse
    {
        public string IdUsuario { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string Documento { get; set; }
        public string Email { get; set; }
        public string Role { get; set; }
        public string Address { get; set; }
    }
}
