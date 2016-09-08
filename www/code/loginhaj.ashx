<%@ WebHandler Language="C#" Class="loginhaj" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
public class loginhaj : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        DBCnn db = new DBCnn();
        string sql = "";
        string[,] data = new string[2, 2];
        data[0, 0] = "message";
        data[1, 0] = "op";
        
        string yearno = "7";
        
        sql = "Select * From Hyear where cy=1";
        DataRow row = db.GetRow(sql);
        if (row != null)
        {
           yearno = row["YearNo"].ToString();
        }
        
        string id = (context.Request["id"] != null) ? context.Request["id"] : "";
        string rev = (context.Request["rev"] != null) ? context.Request["rev"] : "";
        sql = "Select HName From HHajData where PublicNo='" + rev + "' and Jawal='" + id + "' and YearNo='" + yearno + "'";
        row = db.GetRow(sql);
        if (row != null)
        {

            data[0, 1] = "مرحبا بك " + row["HName"].ToString();
            data[1, 1] = "1";
           
        }
        else
        {
             data[0, 1] = "رقم الحجز او رقم المحمول غير مسجلة";
             data[1, 1] = "0";
        }
        context.Response.Write(Json.json(data,null));
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