namespace TestIteco.Functions
{
    public static class AppVersion
    {
        public static string Get()
        {
            return System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
        }
    }
}