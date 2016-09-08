<%@ WebHandler Language="C#" Class="allHajjeReader" %>

using System;
using System.Web;
using System.Data;
public class allHajjeReader : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
       
          sql  =  " SELECT HajNo,  HName, HouseName, PublicNo, CompanyName, BedNo, optype FROM   tafdata ";
          sql += " WHERE    (YearNo = " + yearno + ") and optype=0 and TafID=" + id;
          sql += " GROUP BY HajNo, HName, HouseName, PublicNo, CompanyName, BedNo, optype";
      
       

               string data = "";
               DataTable tb = db.GetTable(sql);
               for (int x = 0; x < tb.Rows.Count; x++)
               {
                   data = data + tb.Rows[x]["HajNo"].ToString() + ";";
                   data = data + tb.Rows[x]["HName"].ToString() + ";";
                   data = data + tb.Rows[x]["HouseName"].ToString() + ";";
                   data = data + tb.Rows[x]["CompanyName"].ToString() + ";";
                   data += tb.Rows[x]["PublicNo"].ToString() + ";";
                   data += tb.Rows[x]["optype"].ToString() + ";";
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