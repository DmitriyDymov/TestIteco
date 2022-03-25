using System;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;

namespace TestIteco.Functions
{
    public static class Validations
    {
        public static bool IsValidName(string userName)
        {
            return userName.Trim(' ').Length > 5;
        }

        public static bool IsValidEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
                return false;

            try
            {
                email = Regex.Replace(email, @"(@)(.+)$", DomainMapper,
                                      RegexOptions.None, TimeSpan.FromMilliseconds(200));

                string DomainMapper(Match match)
                {
                    var idn = new IdnMapping();
                    var domainName = idn.GetAscii(match.Groups[2].Value);

                    return match.Groups[1].Value + domainName;
                }
            }
            catch (RegexMatchTimeoutException e)
            {
                return false;
            }
            catch (ArgumentException e)
            {
                return false;
            }

            try
            {
                return Regex.IsMatch(email,
                    @"^[^@\s]+@[^@\s]+\.[^@\s]+$",
                    RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(250));
            }
            catch (RegexMatchTimeoutException)
            {
                return false;
            }
        }

        public static PhoneValidation IsValidPhone(string phone)
        {
            var res = new PhoneValidation();

            if (string.IsNullOrWhiteSpace(phone))
                return res;

            long.TryParse(string.Join("", phone.Where(char.IsDigit)), out var intPhone);

            var phoneStr = Convert.ToString(intPhone);

            if (phoneStr.Length != 11) return res;
            
            res.IsValid = true;

            if (phoneStr[0] == '8')
            {
                phoneStr = "7" + phoneStr.Substring(1, phoneStr.Length - 1);
            }

            res.PhoneNumber = Convert.ToInt64(phoneStr);

            return res;
        }

        public class PhoneValidation
        {
            public bool IsValid { get; set; }
            public long PhoneNumber { get; set; }
        }
    }
}