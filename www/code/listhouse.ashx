<%@ WebHandler Language="C#" Class="listhouse" %>

using System;
using System.Web;
using System.Data;
public class listhouse : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
        sql = " SELECT HouseNo, HouseName ,[Size] ,MName,MJawal,HallName, Occup,[Size]-Occup  as free from HHouseFreeData where CompanyNo='" + id + "' and YearNo='" + yearno + "'";
        if (job == "0") sql += " and HouseNo=0";
       

               string data = "";
               DataTable tb = db.GetTable(sql);
               for (int x = 0; x < tb.Rows.Count; x++)
               {
                   data = data + tb.Rows[x]["HouseNo"].ToString() + ";";
                   data = data + tb.Rows[x]["HouseName"].ToString() + ";";
                   data = data + tb.Rows[x]["Size"].ToString() + ";";
                   data = data + tb.Rows[x]["Occup"].ToString() + ";";
                   data = data + tb.Rows[x]["MName"].ToString() + ";";
                   data = data + tb.Rows[x]["MJawal"].ToString() + ";";
                   data = data + tb.Rows[x]["HallName"].ToString() + ";";    
                   data += tb.Rows[x]["free"].ToString() + "//";
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