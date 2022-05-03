namespace UPC.Bagueteria.API.Configs
{
    public static class AppSettingsProvider
    {
        public static Infra.Dao.Context.ConfigSettings config { get; set; }
    }

    public class ConfigSettings
    {
        /// <summary>
        /// 
        /// </summary>
        public string ApplicationName { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string ApplicationType { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string OrganizationName { get; set; }


        /// <summary>
        /// 
        /// </summary>
        public string Version { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public CircuitBreak CircuitBreak { get; set; }
    }

    /// <summary>
    /// CircuitBreaker
    /// </summary>
    public class CircuitBreak
    {
        /// <summary>
        /// 
        /// </summary>
        public string HandledEventsAllowed { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string DurationOfBreakCircuit { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string RetryCount { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string SleepDuration { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string HandlerLifetime { get; set; }

    }
}
