<%@ WebHandler Language="C#" Class="record" %>

using System;
using System.Web;
using System.Data;
public class record : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        DBCnn db = new DBCnn();
        string sql = "";


        string hajno = (context.Request["hajno"] != null) ? context.Request["hajno"] : "";
        string tid = (context.Request["tid"] != null) ? context.Request["tid"] : "";
        string id = (context.Request["id"] != null) ? context.Request["id"] : "";
        string yearno = "7";
        
        sql = "Select * From Hyear where cy=1";
        DataRow row = db.GetRow(sql);
        if (row != null)
        {
           yearno = row["YearNo"].ToString();
        }

        sql = "Insert into Hoperation (HajNo,YearNo,EmpNo,TafID) ";
        sql += " Values ('" + hajno.Trim() + "','" + yearno + "','" + id + "','" + tid + "')";
        string[,] data=new string[2,2];
        data[0, 0] = "message";
        data[1, 0] = "op";
        if (db.Execute(sql))
        {
           
            data[0, 1] = "تم التسجيل";
            data[1, 1] = "1";
        }
        else
        {
            data[0, 1] = "فشلت عملية التسجيل ";
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