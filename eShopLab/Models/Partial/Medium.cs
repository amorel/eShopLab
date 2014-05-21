using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace eShopLab.Models
{
    /// <summary>
    /// Delete Media file from the host server
    /// <param name="MapPath">Adding Server.MapPath methode</param>
    /// </summary>
    public partial class Medium
    {
        public void DeleteFile(string MapPath) {
            string serverPath = MapPath + Path.GetFileName(MediaUrl);

            if (System.IO.File.Exists(serverPath))
            {
                System.IO.File.Delete(serverPath);
            }
        }
    }
}