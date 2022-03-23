using System;
using System.Globalization;

namespace TestIteco.Functions
{
    public static class StrToDate
    {
        public static DateTime Convert(string source)
        {
            return DateTime.ParseExact(source, "yyyyMMdd", CultureInfo.InvariantCulture);
        }

    }
}