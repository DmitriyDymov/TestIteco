using System;

namespace TestIteco.Functions
{
    public static class DateTimeToStr
    {
        public static string Convert(DateTime dateTime)
        {
            return $"{dateTime.Year}{dateTime.Month:00}{dateTime.Day:00}{dateTime.Hour:00}{dateTime.Minute:00}{dateTime.Second:00}";
        }
    }
}