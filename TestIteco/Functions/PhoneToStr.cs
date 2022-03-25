namespace TestIteco.Functions
{
    public static class PhoneToStr
    {
        public static string Convert(long phone)
        {
            var strPhone = System.Convert.ToString(phone);

            if (strPhone.Length != 11)
                return strPhone;

            return
                $"+{strPhone[0]} ({strPhone.Substring(1, 3)}) {strPhone.Substring(4, 3)}-{strPhone.Substring(7, 2)}-{strPhone.Substring(9, 2)}";
        }
    }
}