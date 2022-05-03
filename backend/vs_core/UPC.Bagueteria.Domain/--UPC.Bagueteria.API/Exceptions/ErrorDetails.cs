using Newtonsoft.Json;
namespace UPC.Bagueteria.API.Exceptions
{
    public class CustomErrorException
    {
        /// <summary>
        /// Status de la llamada
        /// </summary>
        public int StatusCode { get; set; }

        /// <summary>
        /// Mensaje de error
        /// </summary>
        public string Message { get; set; }

        /// <summary>
        ///  Detalles
        /// </summary>
        public Detail Details { get; set; }

        /// <summary>
        ///  Tipo de Error
        /// </summary>
        public string Type { get; set; }

        /// <summary>
        ///  Instancia
        /// </summary>
        public string Instance { get; set; }

        /// <summary>
        /// Override para serializar la clase
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {
            return JsonConvert.SerializeObject(this);
        }
    }

    /// <summary>
    /// Detalle Técnico de Error
    /// </summary>
    public class Detail
    {
        /// <summary>
        ///  Tipo de Stack
        /// </summary>
        public string Stack { get; set; }

        /// <summary>
        ///  Tipo de Code
        /// </summary>
        public string Code { get; set; }

        /// <summary>
        ///  Tipo de Object
        /// </summary>
        public string Object { get; set; }


    }
}
