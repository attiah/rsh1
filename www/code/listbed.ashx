<%@ WebHandler Language="C#" Class="listbed" %>

using System;
using System.Web;
using System.Data;
public class listbed : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
        string cid = (context.Request["cid"] != null) ? context.Request["cid"] : "";
        sql = " SELECT * from HHouseBed where CompanyNo='" + cid + "' and YearNo='" + yearno + "'";
        sql += " and HouseNo="+id;
       

               string data = "";
               DataTable tb = db.GetTable(sql);
               for (int x = 0; x < tb.Rows.Count; x++)
               {
                   data = data + tb.Rows[x]["HajNo"].ToString() + ";";
                   data = data + tb.Rows[x]["HName"].ToString() + ";";
                   data = data + tb.Rows[x]["PublicNo"].ToString() + ";";
                   data = data + tb.Rows[x]["Jawal"].ToString() + ";";
                   data = data + tb.Rows[x]["BedNo"].ToString() + ";";
                   data = data + tb.Rows[x]["NatName"].ToString() + "//";
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