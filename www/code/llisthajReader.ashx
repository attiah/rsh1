<%@ WebHandler Language="C#" Class="llisthajReader" %>

using System;
using System.Web;
using System.Data;
public class llisthajReader : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context)
    {
        DBCnn db=new DBCnn ();
        context.Response.ContentType = "text/plain";
        string id = (context.Request["id"] != null) ? context.Request["id"] : "";
        string yearno = "7";

        string sql = "Select * From Hyear where cy=1";
        DataRow row = db.GetRow(sql);
        if (row != null)
        {
            yearno = row["YearNo"].ToString();
        }
        sql = "SELECT  *  FROM      tafdata WHERE    (YearNo = " + yearno + ") and HajNo=" + id;
        
        string data = "";
        DataTable tb = db.GetTable(sql);
        for (int x = 0; x < tb.Rows.Count; x++)
        {
            data = data + tb.Rows[x]["OpDate"].ToString() + ";";
            data = data + tb.Rows[x]["TafName"].ToString() + ";";
            data = data + tb.Rows[x]["EmpName"].ToString() + ";";
            data = data + tb.Rows[x]["Jawal"].ToString() + "//";
          
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