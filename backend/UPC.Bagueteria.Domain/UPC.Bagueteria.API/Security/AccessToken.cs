﻿namespace UPC.Bagueteria.API.Security
{
    /// <summary>
    /// 
    /// </summary>
    public class AccessToken
    {
        /// <summary>
        /// 
        /// </summary>
        public string access_token { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string token_type { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string scope { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public int expires_in { get; set; }
    }
}
