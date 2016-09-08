<%@ WebHandler Language="C#" Class="taf" %>

using System;
using System.Web;
using System.Data;
public class taf : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context)
    {
        DBCnn db=new DBCnn ();
        context.Response.ContentType = "text/plain";
        string yearno = "7";

        string sql = "Select * From Hyear where cy=1";
        DataRow row = db.GetRow(sql);
        if (row != null)
        {
            yearno = row["YearNo"].ToString();
        }
        
         sql = "SELECT  *  FROM      HTafwej WHERE    (YearNo = "+yearno+") and CompanyNo='100' ";

               string data = "";
               DataTable tb = db.GetTable(sql);
               for (int x = 0; x < tb.Rows.Count; x++)
               {
                   data = data + tb.Rows[x]["TafID"].ToString() + ";";
                   data += tb.Rows[x]["TafName"].ToString() + "//";
               }

        context.Response.Write(data);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    //======================

}