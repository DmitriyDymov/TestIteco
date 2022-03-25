using System;
using System.Linq;
using DevExpress.Utils.Design;
using DevExpress.Web;
using TestIteco.Functions;
using TestIteco.Models.Contacts;
using Convert = System.Convert;

namespace TestIteco.Forms.Contacts
{
    public partial class ContactEditUserControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            CompanyNameComboBox.Items.Clear();
            CompanyNameComboBox.Items.AddRange((from IGrouping<string, Contact> gr in
                    (from Contact contact in Contact.GetContacts() group contact by contact.CompanyName into groups select groups)
                orderby gr.Key
                select new ListEditItem(gr.Key)).ToList());

            GroupNameComboBox.Items.Clear();
            GroupNameComboBox.Items.AddRange((from IGrouping<string, Contact> gr in 
                    (from Contact contact in Contact.GetContacts() group contact by contact.GroupName into groups select groups)
                    orderby gr.Key    
                    select new ListEditItem(gr.Key)).ToList());

            ContactPositionComboBox.Items.Clear();
            ContactPositionComboBox.Items.AddRange((from IGrouping<string, Contact> gr in
                    (from Contact contact in Contact.GetContacts() group contact by contact.ContactPosition into groups select groups)
                orderby gr.Key
                select new ListEditItem(gr.Key)).ToList());


        }

        protected void ContactEditCallbackPanel_OnCallback(object sender, CallbackEventArgsBase e)
        {
            var contactID = Convert.ToInt32(e.Parameter);

            ContactNameTextBox.Text = "";
            ContactAddressTextBox.Text = "";
            ContactDateOfBirth.Date = DateTime.Now.AddYears(-30);
            GroupNameComboBox.Text = "";
            CompanyNameComboBox.Text = "";
            ContactPositionComboBox.Text = "";
            ContactEmailTextBox.Text = "";
            ContactPhoneTextBox.Text = "";

            if (contactID == 0) return;

            var contact = new Contact(contactID);

            ContactNameTextBox.Text = contact.ContactName;
            ContactAddressTextBox.Text = contact.ContactAddress;
            ContactDateOfBirth.Date = contact.ContactDateOfBirth;
            GroupNameComboBox.Text = contact.GroupName;
            CompanyNameComboBox.Text = contact.CompanyName;
            ContactPositionComboBox.Text = contact.ContactPosition;
            ContactEmailTextBox.Text = contact.ContactEmail;
            ContactPhoneTextBox.Text = PhoneToStr.Convert(contact.ContactPhone);
        }

        protected void ValidationContactSaveCallback_OnCallback(object source, CallbackEventArgs e)
        {
            var p = e.Parameter.Split('|');

            var contactID = Convert.ToInt32(p[0]);
            var contactName = p[1];
            var contactEmail = p[2].ToLower();
            var contactPhone = p[3];

            var validationName = Validations.IsValidName(contactName) ? 1 : 2;
            var validationEmail = Validations.IsValidEmail(contactEmail) ? (Contact.GetContacts().Any(r => r.ContactEmail == contactEmail && r.ContactID != contactID) ? 3 : 1) : 2;

            var validationPhoneResult = Validations.IsValidPhone(contactPhone);
            var validationPhone = validationPhoneResult.IsValid ? (Contact.GetContacts().Any(r => r.ContactPhone == validationPhoneResult.PhoneNumber && r.ContactID != contactID) ? 3 : 1) : 2;

            e.Result = $"{validationName}|{validationEmail}|{validationPhone}";
        }

        protected void ContactSaveCallback_OnCallback(object source, CallbackEventArgs e)
        {
            var p = e.Parameter.Split('|');

            var contactID = Convert.ToInt32(p[0]);
            var contactName = p[1];
            var contactAddress = p[2];
            var contactDateOfBirth = Functions.StrToDate.Convert(p[3]);
            var groupName = p[4];
            var companyName = p[5];
            var contactPosition = p[6];
            var contactEmail = p[7].ToLower();
            var contactPhone = p[8];

            if (!Validations.IsValidName(contactName)) return;

            if (!Validations.IsValidEmail(contactEmail)) return;

            if (contactID != 0)
            {
                if (Contact.GetContacts().Any(r => r.ContactEmail == contactEmail && r.ContactID != contactID)) return;
            }
            

            var validationPhoneResult = Validations.IsValidPhone(contactPhone);
            if (!validationPhoneResult.IsValid) return;

            var contact = contactID == 0 ? new Contact() : new Contact(contactID);

            contact.ContactName = contactName;
            contact.ContactAddress = contactAddress;
            contact.ContactDateOfBirth = contactDateOfBirth;
            contact.GroupName = groupName;
            contact.CompanyName = companyName;
            contact.ContactPosition = contactPosition;
            contact.ContactEmail = contactEmail;
            contact.ContactPhone = validationPhoneResult.PhoneNumber;

            contact.Save();

            e.Result = "1";
        }
    }
}