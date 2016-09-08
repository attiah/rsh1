<%@ WebHandler Language="C#" Class="alllogin" %>

using System;
using System.Web;
using System.Data;
public class alllogin : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
        
        
        string id = (context.Request["id"] != null) ? context.Request["id"] : "";
        string job = (context.Request["job"] != null) ? context.Request["job"] : "";
        string empid = (context.Request["empid"] != null) ? context.Request["empid"] : "";
        sql = "SELECT  *  FROM      tafdata WHERE    (YearNo = " + yearno + ") and TafID=" + id;
        if (job == "0") sql += " and EmpNo='" + empid + "'";
        sql+="  order by OpID desc";

               string data = "";
               DataTable tb = db.GetTable(sql);
               for (int x = 0; x < tb.Rows.Count; x++)
               {
                   data = data + tb.Rows[x]["HajNo"].ToString() + ";";
                   data = data + tb.Rows[x]["OpDate"].ToString() + ";";
                   data = data + tb.Rows[x]["TafName"].ToString() + ";";
                   data = data + tb.Rows[x]["HName"].ToString() + ";";
                   data = data + tb.Rows[x]["HouseName"].ToString() + ";";
                   data = data + tb.Rows[x]["CompanyName"].ToString() + ";";
                   data += tb.Rows[x]["OpID"].ToString() + ";";
                   data += tb.Rows[x]["PublicNo"].ToString() + ";";
                   data += tb.Rows[x]["BedNo"].ToString() + "//";
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