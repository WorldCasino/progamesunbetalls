﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace admin.Report
{
    public partial class UnrecognizedWeb : PageBase
    {
        //----定义权限变量---------
        protected bool viewAc = true;
        protected bool qrAc = true;
        protected bool qxAc = true;

        protected void Page_Load(object sender, EventArgs e)
        {
            //-----------权限控制开始-----------
            //当前角色
            int Rid = CurrentManager.RoleId;

            BLL.Sys_role_rightManager rrService = new BLL.Sys_role_rightManager();

            //查看权限
            if (!rrService.IsPermission(Rid, 52))
            {
                viewAc = false;
                Response.Write("<script>alert('非法操作，请返回!');history.go(-1);</script>");
                Response.End();
            }
            //确认权限
            if (!rrService.IsPermission(Rid, 138))
            {
                qrAc = false;
            }
            //确认权限
            if (!rrService.IsPermission(Rid, 139))
            {
                qxAc = false;
            }
            //-----------权限控制结束-----------
        }
    }
}