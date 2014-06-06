using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public static class Globals
{
    private static string applicationPath;

    static Globals()
    {
        Globals.applicationPath = System.Web.Hosting.HostingEnvironment.MapPath("~/");
    }

    public static string resolveVirtual(string physicalPath)
    {
        string url = physicalPath.Substring(Globals.applicationPath.Length).Replace('\\', '/').Insert(0, "~/");
        return (url);
    }
}