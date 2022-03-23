using System.IO;
using System.Web;
using TestIteco.Files;

namespace TestIteco
{

    public class Content : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            var name = context.Request.Params["Name"];

            var fullFileName = Path.Combine(context.Server.MapPath($"~/Content/{name}"));

            if (File.Exists(fullFileName))
            {
                var fInfo = new FileInfo(fullFileName);
                var newFileName =
                    $"{fInfo.Name.Replace(fInfo.Extension, "")}{fInfo.LastWriteTime.Year}{fInfo.LastWriteTime.Month}{fInfo.LastWriteTime.Day}{fInfo.LastWriteTime.Hour}{fInfo.LastWriteTime.Minute}{fInfo.LastWriteTime.Second}{fInfo.LastWriteTime.Millisecond}{fInfo.Extension}";
                context.Response.Clear();
                context.Response.ContentType = MimeType.GetMimeType(Path.GetExtension(fullFileName)).ApplicationType;
                context.Response.AppendHeader("Content-Disposition", $"attachment; filename={newFileName}");
                context.Response.TransmitFile(fullFileName);
            }
            else
            {
                context.Response.ContentType = "text/plain";
                context.Response.Write("");
            }
        }

        public bool IsReusable => false;
    }
}