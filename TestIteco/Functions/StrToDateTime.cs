using System;
using System.Globalization;

namespace TestIteco.Functions
{
    public static class StrToDateTime
    {
        public static DateTime Convert(string source)
        {
            return DateTime.ParseExact(source, "yyyyMMddHHmm", CultureInfo.InvariantCulture);
        }
    }
}