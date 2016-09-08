<%@ WebHandler Language="C#" Class="allhajj" %>

using System;
using System.Web;
using System.Data;
public class allhajj : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context)
    {
        DBCnn db=new DBCnn ();
        context.Response.ContentType = "text/plain";
        //string id = (context.Request["id"] != null) ? context.Request["id"] : "";
        string yearno = "7";

        string sql = "Select * From Hyear where cy=1";
        DataRow row = db.GetRow(sql);
        if (row != null)
        {
            yearno = row["YearNo"].ToString();
        }
         sql = "SELECT  HName, HouseName, marName, MarJawal, HajNo, PublicNo, IDno, Jawal, NatName, CompanyName, BedNo ";
               sql+= " FROM      HHajData WHERE   (DeleteOK = 0) AND (YearNo = '"+yearno+"') AND (CompanyNo = 100 OR  CompanyNo = 101)";

               string data = "";
               DataTable tb = db.GetTable(sql);
               for (int x = 0; x < tb.Rows.Count; x++)
               {
                   data = data + tb.Rows[x]["HName"].ToString() + ";";
                   data = data + tb.Rows[x]["HouseName"].ToString() + ";";
                   data = data + tb.Rows[x]["marName"].ToString() + ";";
                   data = data + tb.Rows[x]["MarJawal"].ToString() + ";";
                   data = data + tb.Rows[x]["HajNo"].ToString() + ";";
                   data = data + tb.Rows[x]["PublicNo"].ToString() + ";";
                   data = data + tb.Rows[x]["IDno"].ToString() + ";";
                   data = data + tb.Rows[x]["Jawal"].ToString() + ";";
                   data = data + tb.Rows[x]["NatName"].ToString() + ";";
                   data = data + tb.Rows[x]["CompanyName"].ToString() + ";";
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