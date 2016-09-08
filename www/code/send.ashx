<%@ WebHandler Language="C#" Class="task" %>

using System;
using System.Web;
using System.Data;
public class task : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        DBCnn db = new DBCnn();
        string sql = "";


        string name = (context.Request["name"] != null) ? context.Request["name"] : "";
        string jawal = (context.Request["jawal"] != null) ? context.Request["jawal"] : "";
        string email = (context.Request["email"] != null) ? context.Request["email"] : "";
        string title = (context.Request["title"] != null) ? context.Request["title"] : "";
        string message = (context.Request["message"] != null) ? context.Request["message"] : "";
       
        sql = "insert into HMessage(fname,title,message,email,jawal) values('" + name + "','" + title + "','" + message + "','" + email + "','" + jawal + "')";
      
        string[,] data=new string[2,2];
        data[0, 0] = "message";
        data[1, 0] = "op";
        if( db.Execute(sql))
        {
            data[0, 1] = " تم ارسال البيانات بنجاح";
            data[1, 1] = "1";
        }
        else
        {
            data[0, 1] = (" فشلت عملية الارسال حاول مرة اخري");
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