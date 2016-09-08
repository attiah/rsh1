<%@ WebHandler Language="C#" Class="task" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
public class task : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        DBCnn db = new DBCnn();
        string sql = "";
        string[,] data = new string[3, 2];
        data[0, 0] = "message";
        data[1, 0] = "op";
        data[2, 0] = "job";


        data[2, 1] = "0";
        string yearno = "7";
        
        sql = "Select * From Hyear where cy=1";
        DataRow row = db.GetRow(sql);
        if (row != null)
        {
           yearno = row["YearNo"].ToString();
        }
        
        string id = (context.Request["id"] != null) ? context.Request["id"] : "";
        string pass = (context.Request["pass"] != null) ? context.Request["pass"] : "";
        
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "HUserSelectLogin";
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@UserNo", id);
        cmd.Parameters.AddWithValue("@password", pass);
        row = db.GetRow(cmd);
        if (row != null)
        {
            context.Session["UserNo"] = id;
            context.Session["password"] = pass;
            context.Session["UserName"] = row["UserName"].ToString();
            data[0, 1] = row["UserName"].ToString();
            data[1, 1] = "1";
            if (row["Job"].ToString() == "1") data[2, 1] = "1"; else data[2, 1] = "2";
        }
        else
        {
            sql = "Select EmpNo,EmpName from HEmployee where EmpNo='" + id + "' and Jawal='" + pass + "' and YearNo='" + yearno + "'";
            row = db.GetRow(sql);
            if (row != null)
            {
                context.Session["UserNo"] = id;
                context.Session["password"] = pass;
                context.Session["UserName"] = row["EmpName"].ToString();
                data[0, 1] = row["EmpName"].ToString();
                data[1, 1] = "1";
            }
            else
            {
                data[0, 1] = "رقم المستخدم او كلمة المرور غير مسجلة";
                data[1, 1] = "0";
            }
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