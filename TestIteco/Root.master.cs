using System;
using System.Web.UI;
using DevExpress.Utils;
using DevExpress.Web;
using TestIteco.Models.Users;

namespace TestIteco
{
    public partial class Root : MasterPage
    {

        public bool LeftAreaMenuVisible
        {
            get => LeftPanel.ClientVisible;
            set
            {
                foreach (MenuItem item in LeftAreaMenu.Items)
                {
                    if (item.Name != "ToggleLeftPanel") continue;
                    item.ClientVisible = value;
                }

                LeftPanel.ClientVisible = value;
            }
        }

        public bool EnableBackButton { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (Request["__EVENTTARGET"] == "_Page" &&
                    Request["__EVENTARGUMENT"] == "UserLogout")
                {
                    AuthHelper.SignOut();
                    Response.Redirect("/logon", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }
            }

            if (!string.IsNullOrEmpty(Page.Header.Title))
                Page.Header.Title += " - ";

            Page.Header.Title = Page.Header.Title + " S1";

            Page.Header.DataBind();
            UpdateUserMenuItemsVisible();
            HideUnusedContent();

            CreateMenuItems();
            CreateAdminNavBarItems();
            CreateHelpNavBarItems();

            CompanyLabel.InnerText = $"{DateTime.Now.Year} Created by D.Dymov - Russian professional developer";

            UpdateUserInfo();
        }

        private void UserLogout()
        {
            AuthHelper.SignOut();

            if (IsPostBack)
            {
                Response.RedirectLocation = "/logon";
                Context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                Response.Redirect("/logon", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected void CreateMenuItems()
        {
            ApplicationMenu.Items.Clear();

            ApplicationMenu.Items.Add(new MenuItem("Контакты", "ContactsRegistry", "", "/ContactsRegistry"));
            ApplicationMenu.Items.Add(new MenuItem("Вызовы", "ContactsRegistry", "", "/CallRegistry"));
            ApplicationMenu.Items.Add(new MenuItem("Конференции", "ConferencesRegistry", "", "/ConferencesRegistry"));

            //    ApplicationMenu.Items.Add(new MenuItem("Выбор компании", "SelectCompany", "", "/SelectCompany"));
            //if (Session["CompanyID"] == null)
            //{
            //    ApplicationMenu.Items.Add(new MenuItem("Мои компании", "MyCompanies", "", "/MyCompanies"));
            //    ApplicationMenu.Items.Add(new MenuItem("Выбор компании", "SelectCompany", "", "/SelectCompany"));
            //}
            //else
            //{
            //    var userCompany = new UserCompany(Convert.ToString(Session["UserID"]), Convert.ToString(Session["CompanyID"]));

            //    if (userCompany.IsAdmin || userCompany.IsSubAdmin)
            //    {
            //        ApplicationMenu.Items.Add(new MenuItem("Мои задачи", "MyTasks", "", "/MyTasks"));
            //        ApplicationMenu.Items.Add(new MenuItem("Все задачи", "TasksItem", "", "/TasksRegistry"));
            //        ApplicationMenu.Items.Add(new MenuItem("Шаблоны", "ScriptsItem", "", "/ScriptsRegistry"));
            //    }
            //    else
            //    {
            //        ApplicationMenu.Items.Add(new MenuItem("Мои задачи", "MyTasks", "", "/MyTasks"));
            //    }
            //}
        }

        protected void CreateAdminNavBarItems()
        {
            AdminNavBar.Groups.Clear();

            //var user = Users.User.CurrentUser;

            //if (!(user.IsAdmin || user.IsSubAdmin))
            //    return;

            //var navBarGroup = new NavBarGroup("Администрирование", "AdminGroup")
            //{
            //    ShowExpandButton = DefaultBoolean.True
            //};

            //if (user.IsAdmin)
            //{
            //    navBarGroup.Items.Add(new NavBarItem() { Text = "Компании", NavigateUrl = "/CompaniesRegistry" });
            //}

            //if (user.IsAdmin || user.IsSubAdmin)
            //{
            //    navBarGroup.Items.Add(new NavBarItem() { Text = "Пользователи", NavigateUrl = "/UsersRegistry" });
            //}

            //AdminNavBar.Groups.Add(navBarGroup);
        }

        protected void CreateHelpNavBarItems()
        {
            //AdminNavBar.Groups.Clear();

            //var user = Users.User.CurrentUser;

            //if (!(user.IsAdmin || user.IsSubAdmin))
            //    return;

            var navBarGroup = new NavBarGroup("Помощь", "HelpGroup")
            {
                ShowExpandButton = DefaultBoolean.True
            };

            navBarGroup.Items.Add(new NavBarItem() { Text = "Инструкция", NavigateUrl = "/" });

            navBarGroup.Items.Add(new NavBarItem() { Text = "Обратиться в тех. поддержку", NavigateUrl = "/" });

            AdminNavBar.Groups.Add(navBarGroup);
        }

        protected void HideUnusedContent()
        {
            LeftAreaMenu.Items[1].Visible = EnableBackButton;

            bool hasLeftPanelContent = HasContent(LeftPanelContent);
            LeftAreaMenu.Items.FindByName("ToggleLeftPanel").Visible = hasLeftPanelContent;
            LeftPanel.Visible = hasLeftPanelContent;

            bool hasRightPanelContent = HasContent(RightPanelContent);
            RightAreaMenu.Items.FindByName("ToggleRightPanel").Visible = hasRightPanelContent;
            RightPanel.Visible = hasRightPanelContent;

            bool hasPageToolbar = HasContent(PageToolbar);
            PageToolbarPanel.Visible = hasPageToolbar;
        }

        protected bool HasContent(Control contentPlaceHolder)
        {
            if (contentPlaceHolder == null) return false;

            ControlCollection childControls = contentPlaceHolder.Controls;
            if (childControls.Count == 0) return false;

            return true;
        }

        // SignIn/Register

        protected void UpdateUserMenuItemsVisible()
        {
            //var isAuthenticated = AuthHelper.IsAuthenticated();
            //RightAreaMenu.Items.FindByName("SignInItem").Visible = !isAuthenticated;
            //RightAreaMenu.Items.FindByName("RegisterItem").Visible = !isAuthenticated;
            //RightAreaMenu.Items.FindByName("MyAccountItem").Visible = isAuthenticated;
            //RightAreaMenu.Items.FindByName("SignOutItem").Visible = isAuthenticated;
        }

        protected void UpdateUserInfo()
        {

            var myAccountItem = RightAreaMenu.Items.FindByName("MyAccountItem");
            var userName = (ASPxLabel)myAccountItem.FindControl("UserNameLabel");
            var email = (ASPxLabel)myAccountItem.FindControl("EmailLabel");
        
            userName.Text = $"Александра";
            email.Text = "global@it.com";

        }

        protected void RightAreaMenu_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e)
        {
            if (e.Item.Name == "SignOutItem")
            {
                AuthHelper.SignOut();
                Response.Redirect("~/Logon", false);
                Context.ApplicationInstance.CompleteRequest();
            }

            if (e.Item.Name == "ExitFromCompanyItem")
            {
                Session["CompanyID"] = null;
                Response.Redirect("~/SelectCompany", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected void ApplicationMenu_ItemDataBound(object source, MenuItemEventArgs e)
        {
            e.Item.Image.Url = $"Content/Images/{e.Item.Text}.svg";
            e.Item.Image.UrlSelected = $"Content/Images/{e.Item.Text}-white.svg";
        }

    }
}