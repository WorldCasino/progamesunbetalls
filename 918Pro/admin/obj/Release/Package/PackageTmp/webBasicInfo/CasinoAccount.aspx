﻿<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeBehind="CasinoAccount.aspx.cs" Inherits="Admin.CasinoAccount" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
    <link href="/css/Default/globle.css" rel="stylesheet" type="text/css" />
    <link href="/css/Default/right_main.css" rel="stylesheet" type="text/css" />
    <link href="/css/Default/tab.css" rel="stylesheet" type="text/css" />
    <link href="/css/Default/style.css" rel="stylesheet" type="text/css" />
    <link href="/css/Default/cupertino/jquery.ui.all.css" rel="stylesheet" type="text/css" />
    <link href="/css/Default/cupertino/jquery.ui.datepicker.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="/js/jquery-ui.min.js" type="text/javascript"></script>
    <script src="/js/page/pageJs.js" type="text/javascript"></script>
    <script src="/js/jQueryCommon.js" type="text/javascript"></script>
    <script src="/js/jquery-ui-1.8.2.custom.min.js" type="text/javascript"></script>
    <link href="/css/Default/cupertino/jquery-ui-1.8.2.custom.css" rel="stylesheet"
        type="text/css" />
    <script src="/js/webBasicInfo/zh-CN.js" type="text/javascript"></script>
    <script type="text/javascript">
        var tr2 = $("#tr1").clone();
        var web;
        var data = "";
        var count = 0;
        var page = 0;
        <%=(fzAcS+
        addAcS+
        deleteAcS+
        mdfAcS) %>
        $(function () {
        SetGlobal("");

        });

        function SetGlobal(setLang){
        setLang = $.SetOrGetLanguage(setLang, function () {
                languages = language;

                            $("#delet").hide();
            $("#delet2").hide();
            web = new Array();
            $.AjaxCommon("/ServicesFile/webBasicInfo/WebInfoService.asmx/GetDate", "", true, false, function (json) {
                if (json.d != "none") {
                    $("#webWhereVal").html("");
                    var result = jQuery.parseJSON(json.d);
                    var a = "<option value=\"0\">全部</option>";
                    $.each(result, function (i) {
                        if (jQuery("#language").val() == "tw") {
                            web[result[i].id] = result[i].nametw;
                            a += "<option value=\"" + result[i].id + "\">" + result[i].nametw + "</option>";
                        }
                        else if (jQuery("#language").val() == "cn") {
                            web[result[i].id] = result[i].namecn;
                            a += "<option value=\"" + result[i].id + "\">" + result[i].namecn + "</option>";
                        }
                        else if (jQuery("#language").val() == "en") {
                            web[result[i].id] = result[i].nameen;
                            a += "<option value=\"" + result[i].id + "\">" + result[i].nameen + "</option>";
                        }
                        else if (jQuery("#language").val() == "th") {
                            web[result[i].id] = result[i].nameth;
                            a += "<option value=\"" + result[i].id + "\">" + result[i].nameth + "</option>";
                        }
                        else if (jQuery("#language").val() == "vn") {
                            web[result[i].id] = result[i].namevn;
                            a += "<option value=\"" + result[i].id + "\">" + result[i].namevn + "</option>";
                        }
                    });
                    $("#webWhereVal").html(a);
                }
            });
            jQuery("#delet1").hide();
            $("#AddInfoDiv").hide();
            $("#selectAndAddButtonDiv").show();
            $("#cookieDiv").hide();
            data = "casino:'0',group:'',time1:'',time2:'',enable:'-1'";
            jQuery.AjaxCommon("/ServicesFile/webBasicInfo/AccountService.asmx/getCount", data, false, false, function (json) {
                count = parseInt(json.d);
            });
            if (count % 20 == 0) {
                page = count / 20;
            }
            else {
                page = count / 20 + 1;
            }
            IsPage(parseInt(page), count, '20', 'IDex', 'IDexC');
            $("#closeButton").click(function () {
                jQuery("#delet2").dialog("close");
            });
            $("#time1WhereVal").datepicker();
            $("#time2WhereVal").datepicker();
            $("#escCook").click(function () {
                $("#cookieDiv").hide();
            });
            $("#AddInfo").click(function () {

                $("#AddInfoDiv").show();
                $("#selectAndAddButtonDiv").hide();
                GetWeb();
            });
            $("#esc").click(function () {
                $("#addID").val("");
                $("#addPassword").val("");
                $("#webList").val("");
                $("#addAddress").val("");
                $("#addAddress2").val("");
                $("#addGroup").val("");
                $("#AddCookie").val("");
                $("#selectAndAddButtonDiv").show();
                $("#AddInfoDiv").hide();
            });
            $("#sure").click(function () {
                var pd = 0;
                $.each($("#AddWebInfo").find(":text"), function (i) {
                    if(jQuery(this).attr("id")!=="addAddress" && jQuery(this).attr("id")!=="addAddress2" && jQuery(this).attr("id")!=="AddCookie"){
                        if ($("#AddWebInfo").find(":text:eq(" + i + ")").val() == "") {
                            alert("请确定数据的完整性");
                            pd = 1;
                            return false;
                        }
                    }
                });
                if (pd) {
                    return false;
                }
                var namePattern = /^(0|[1-9][0-9]*)$/;
                if (!namePattern.test($("#addGroup").val()) || $("#addGroup").val().length > 4) {
                    alert("分组必须是非0开头的数字且长度不能超过4位");
                    return false;
                }

                if ($("#addID").val().indexOf("'") != -1) {
                    alert("账号不允许存在特殊字符");
                    return false;
                }
                var zw = $("#addID").val();
                if (zw.replace(/[^\x00-\xff]/g, "aa").length != $("#addID").val().length) {
                    alert("账号不允许存在中文字符");
                    return false;
                }
                var cooke = $("#AddCookie").val();
                if (cooke.replace(/[^\x00-\xff]/g, "aa").length > 1000) {
                    alert("cookie的长度不能超过1000个字符");
                    return false;
                }
                var address1 = $("#addAddress").val();
                if (address1.replace(/[^\x00-\xff]/g, "aa").length > 50) {
                    alert("账号对应的网址长度不能超过50");
                    return false;
                }
                var address2 = $("#addAddress2").val();
                if (address2.replace(/[^\x00-\xff]/g, "aa").length > 100) {
                    alert("账号登录后的网址长度不能超过100");
                    return false;
                }
                data = "userid:'" + $("#addID").val() + "',password:'" + $("#addPassword").val() + "',casino:'" + $("#webList").val() + "',";
                data += "group:'" + $("#addGroup").val() + "',address:'" + $("#addAddress").val().replace("'", "Π") + "',address2:'" + $("#addAddress2").val().replace("'", "Π") + "',";
                data += "cookie:'" + $("#AddCookie").val().replace("'", "Π") + "',isquzhi:'" + ($("#addIsquzhi").attr("checked") == true ? 1 : 0) + "',";
                data += "enable:'" + ($("#addEnable").attr("checked") == true ? 1 : 0) + "',ip:'" + $("#IpAddress").val() + "'";
                $.AjaxCommon("/ServicesFile/webBasicInfo/AccountService.asmx/InsertInfo", data, false, false, function (json) {
                    if (json.d != "none") {
                        if (json.d == "-1") {
                            jQuery("#delet2").dialog({ model: true });
                            jQuery("#delet2>div:eq(0)>div:eq(0)").text("已存在的用户名!请重新输入");
                            return false;
                        }
                        data = "casino:'0',group:'',time1:'',time2:'',enable:'-1'";
                        jQuery.AjaxCommon("/ServicesFile/webBasicInfo/AccountService.asmx/getCount", data, true, false, function (json) {
                            count = parseInt(json.d);
                        });
                        if (count % 20 == 0) {
                            page = count / 20;
                        }
                        else {
                            page = count / 20 + 1;
                        }
                        IsPage(parseInt(page), count, '20', 'IDex', 'IDexC');
                    }
                });
                if ($("#IsContinuous").attr("checked")) {
                }
                else {
                    $("#addID").val("");
                    $("#addPassword").val("");
                    $("#webList").val("");
                    $("#addAddress").val("");
                    $("#addAddress2").val("");
                    $("#addGroup").val("");
                    $("#AddCookie").val("");
                    $("#selectAndAddButtonDiv").show();
                    $("#AddInfoDiv").hide();
                }

            });
            $("#selectByWhere").click(function () {
                data = "";
                data += "casino:'" + $("#webWhereVal").val() + "'";
                if ($("#groupWhereVal").val() != "") {
                    var namePattern = /^(0|[1-9][0-9]*)$/;
                    if (!namePattern.test($("#groupWhereVal").val()) || $("#groupWhereVal").val().length > 4) {
                        alert("分组必须是非0开头的数字且长度不能超过4位");
                        return false;
                    }
                }
                data += ",group:'" + $("#groupWhereVal").val() + "'";
                data += ",time1:'" + $("#time1WhereVal").val() + "',time2:'" + $("#time2WhereVal").val() + "'";
                data += ",enable:'" + $("#enableWhereVal").val() + "'";
                jQuery.AjaxCommon("/ServicesFile/webBasicInfo/AccountService.asmx/getCount", data, false, false, function (json) {
                    count = parseInt(json.d);
                });
                if (count % 20 == 0) {
                    page = count / 20;
                }
                else {
                    page = count / 20 + 1;
                }
                IsPage(parseInt(page), count, '20', 'IDex', 'IDexC');
            });

            jQuery("#Button1").click(function () {
                jQuery("#delet1").dialog("close");
            });

                jQuery("#wzss").text(languages["网站刷水账号"]);
                jQuery("#wz").text(languages["H1054"]);
                jQuery("#fz").text(languages["H1055"]);
                jQuery("#sj").text(languages["H1056"]);
                jQuery("#sf").text(languages["H1057"]);
                jQuery(".fa_saurch_in").text(languages["H1058"]);

                jQuery(".fa_add_in").text(languages["H1015"]);
                //jQuery("#headTitle").text(languages["H1059"]+"      "+languages["H1016"]);
                jQuery("#AddWebInfo>tr:eq(0)").find("td:eq(0)").text(languages["H1054"]);
                jQuery("#AddWebInfo>tr:eq(1)").find("td:eq(0)").text(languages["H1060"]);
                jQuery("#AddWebInfo>tr:eq(1)").find("td:eq(2)").text(languages["H1061"]);
                jQuery("#AddWebInfo>tr:eq(2)").find("td:eq(0)").text(languages["H1062"]);
                jQuery("#AddWebInfo>tr:eq(2)").find("td:eq(2)").text(languages["H1063"]);
                jQuery("#AddWebInfo>tr:eq(3)").find("td:eq(0)").text(languages["H1064"]);
                //jQuery("#AddWebInfo>tr:eq(3)").find("td:eq(2)").text();
                jQuery("#AddWebInfo>tr:eq(4)").find("td:eq(0)").text(languages["H1049"]);
                jQuery("#AddWebInfo>tr:eq(4)").find("td:eq(2)").text(languages["H1065"]);
                jQuery("#sure").val(languages["H1025"]);
                jQuery("#esc").val(languages["H1011"]);

//                jQuery("#tb2>thead>tr>th:eq(0)").text(languages["H1026"]);
//                jQuery("#tb2>thead>tr>th:eq(1)").text(languages["H1060"]);
//                jQuery("#tb2>thead>tr>th:eq(2)").text(languages["H1054"]);
//                jQuery("#tb2>thead>tr>th:eq(3)").text(languages["H1064"]);
//                jQuery("#tb2>thead>tr>th:eq(4)").text(languages["H1066"]);
//                jQuery("#tb2>thead>tr>th:eq(5)").text(languages["H1067"]);
//                //jQuery("#tb2>thead>tr>th:eq(6)").text();
//                jQuery("#tb2>thead>tr>th:eq(7)").text(languages["H1068"]);
//                jQuery("#tb2>thead>tr>th:eq(8)").text(languages["H1069"]);
//                jQuery("#tb2>thead>tr>th:eq(9)").text(languages["H1070"]);
//                jQuery("#tb2>thead>tr>th:eq(10)").text(languages["H1027"]);

                jQuery("#delet").attr("title", languages["H1035"]);
                jQuery("#delet").attr("title", languages["H1072"]);
                jQuery("#delet2").attr("title", languages["H1038"]);
                jQuery("#delet .wrnning").text(languages["H1071"]);
                jQuery("#delet1 .wrnning").text(languages["H1073"]);
                jQuery("#btnSure").val(languages["H1037"]);
                jQuery("#btnEsc").val(languages["H1011"]);
                jQuery("#Button1").val(languages["H1037"]);
                jQuery("#closeButton").val(languages["H1039"]);


                $("#sy").text(languages["H1031"]);
                $("#wy").text(languages["H1034"]);
                $("#syy").text(languages["H1032"]);
                $("#xyy").text(languages["H1033"]);
                $("#zg").text(languages["H1028"]);
                $("#tjl").text(languages["H1029"]);
                $("#g").text(languages["H1028"]);
                $("#y").text(languages["H1030"]);
            }, "/js/IndexGlobal/");
            
            }

        function GetWeb() {
            $.AjaxCommon("/ServicesFile/webBasicInfo/WebInfoService.asmx/GetDate", "", true, false, function (json) {
                if (json.d != "none") {
                    $("#webList").html("");
                    var result = jQuery.parseJSON(json.d);
                    var a = "";
                    $.each(result, function (i) {
                        a += "<option value=\"" + result[i].id + "\">" + result[i].namecn + "</option>";
                    });
                    $("#webList").html(a);
                }
            });
        }

        function setDate(data1) {
        var data2=data1+","+data;
            $.AjaxCommon("/ServicesFile/webBasicInfo/AccountService.asmx/GetDate", data2, true, false, function (json) {
                if (json.d != "none") {
                    $("#ShowWebInfo>tr").remove();
                    var result = jQuery.parseJSON(json.d);
                    var tr1 = $("#tr1").clone();
                    $.each(result, function (i) {
                        var tr = $("#tr1").clone();
                        tr.find("#IDNumber").text("" + (i + 1));
                        tr.find("#webID").text(result[i].userid);
                        tr.find("#pwd").text(result[i].password);
                        tr.find("#web").text(web[result[i].casino]);
                        tr.find("#webIDGroup").text(result[i].group1);
                        tr.find("#address").text((result[i].address).replace("Π", "'"));
                        tr.find("#address2").text((result[i].address2).replace("Π", "'"));
                            languages = language;
                            tr.find("#cook").html("<a style=\"color:#006c97\" id=\"cookieVal\">"+languages["H1048"]+"</a>");
                            tr.find("#cook").find("#cookieVal").click(function () {
                                jQuery("#cookieDiv").dialog({ modal: false });
                                $("#cookieDiv").text((result[i].cookie).replace("Π", "'"));
                            });
                            tr.find("#isManual").text("" + (result[i].isquzhi == 1 ? languages["H1007"] : languages["H1008"]));
                            tr.find("#isShow").text("" + (result[i].enable == 1 ? languages["H1049"] : languages["H1050"]));
                            tr.find("#updataInfo").html((addAc == 0?"<a id=\"ReAdd\"><img title=\""+languages["H1015"]+"\" src=\"/images/Icon/page_new.gif\" /></a>":"")+"&nbsp;&nbsp;&nbsp;&nbsp;"+(fzAc==0?"<a id=\"RepeatAdd\"><img title=\""+languages["H1051"]+"\" src=\"/images/Icon/note_new.gif\" /></a>":"")+"&nbsp;&nbsp;&nbsp;&nbsp;"+(mdfAc==0?"<a id=\"update\"><img title=\""+languages["H1009"]+"\" src=\"/images/Icon/page_edit.gif\" /></a>":"")+"&nbsp;&nbsp;&nbsp;&nbsp;"+(deleteAc==0?"<a id=\"delete\"><img title=\""+languages["H1052"]+"\" src=\"/images/Icon/note_delete.gif\" /></a>":""));
                        tr.find("#updateTime").text(result[i].time);
                        tr.find("#updataInfo").find("#ReAdd").click(function () {
                            $("#AddInfoDiv").show();
                            $("#selectAndAddButtonDiv").hide();
                            GetWeb();
                        });

                        tr.find("#updataInfo").find("#RepeatAdd").click(function () {

                            $("#addID").val(result[i].userid);
                            $("#addPassword").val(result[i].password);
                            $.AjaxCommon("/ServicesFile/webBasicInfo/WebInfoService.asmx/GetDate", "", true, false, function (json1) {
                                if (json1.d != "none") {
                                    $("#webList").html("");
                                    var result1 = jQuery.parseJSON(json1.d);
                                    var a = "";
                                    $.each(result1, function (j) {
                                        a += "<option value=\"" + result1[j].id + "\"";
                                        if (result1[j].id == result[i].casino) {
                                            a += " selected=\"selected\"";
                                        }
                                        a += ">" + result1[j].namecn + "</option>";
                                    });
                                    $("#webList").html(a);
                                }
                            });
                            $("#addAddress").val((result[i].address).replace("Π", "'"));
                            $("#addAddress2").val((result[i].address2).replace("Π", "'"));
                            $("#addGroup").val(result[i].group1);
                            $("#AddCookie").val((result[i].cookie).replace("Π", "'"));
                            if (result[i].enable == 1) {
                                $("#addEnable").css("checked", "checked");
                            }
                            else {
                                $("#addEnable").removeAttr("checked");
                            }
                            if (result[i].isquzhi == 1) {
                                $("#addIsquzhi").css("checked", "checked");
                            }
                            else {
                                $("#addIsquzhi").removeAttr("checked");
                            }
                            $("#AddInfoDiv").show();
                            $("#selectAndAddButtonDiv").hide();
                        });

                        tr.find("#updataInfo").find("#update").click(function () {
                            var div = $("#AddInfoDiv").clone();
                            var setLang = "";
                        setLang = $.SetOrGetLanguage(setLang, function () {
                            languages = language;
                            div.find("#headTitle").text(languages["H1053"]);
                        }, "/js/IndexGlobal/");
                            
                            div.find("#hideID").val(result[i].id);
                            div.find("#addID").val(result[i].userid);
                            div.find("#addPassword").val(result[i].password);
                            $.AjaxCommon("/ServicesFile/webBasicInfo/WebInfoService.asmx/GetDate", "", true, false, function (json1) {
                                if (json1.d != "none") {
                                    div.find("#webList").html("");
                                    var result1 = jQuery.parseJSON(json1.d);
                                    var a = "";
                                    $.each(result1, function (j) {
                                        a += "<option value=\"" + result1[j].id + "\"";
                                        if (result1[j].id == result[i].casino) {
                                            a += " selected=\"selected\"";
                                        }
                                        a += ">" + result1[j].namecn + "</option>";
                                    });
                                    div.find("#webList").html(a);
                                }
                            });
                            div.find("#addGroup").val(result[i].group1);
                            div.find("#addAddress").val((result[i].address).replace("Π", "'"));
                            div.find("#addAddress2").val((result[i].address2).replace("Π", "'"));
                            div.find("#AddCookie").val((result[i].cookie).replace("Π", "'"));
                            if (result[i].enable == 1) {
                                div.find("#addEnable").css("checked", "checked");
                            }
                            else {
                                div.find("#addEnable").removeAttr("checked");
                            }
                            if (result[i].isquzhi == 1) {
                                div.find("#addIsquzhi").css("checked", "checked");
                            }
                            else {
                                div.find("#addIsquzhi").removeAttr("checked");
                            }
                            var setLang = "";
                                languages = language;
                                div.find("#trEnd").html("<td align=\"center\" colspan=\"4\"><input type=\"button\" id=\"upda\" class=\"btn_02\" onmouseover=\"this.className='btn_02_h'\" onmouseout=\"this.className='btn_02'\"  value=\""+languages["H1009"]+"\" /><input type=\"button\"  id=\"upEsc\" class=\"btn_02\" onmouseover=\"this.className='btn_02_h'\" onmouseout=\"this.className='btn_02'\" onclick=\"close_list()\" value=\""+languages["H1011"]+"\" /></td></td>");
                            div.show();
                            div.find("#trEnd").find("#upEsc").click(function () {
                                tr1.remove();
                            });
                            div.find("#trEnd").find("#upda").click(function () {
                                var pd = 0;
                                $.each(div.find("#AddWebInfo").find(":text"), function (i) {                                
                                    if(jQuery(this).attr("id")!="addAddress" && jQuery(this).attr("id")!="addAddress2" && jQuery(this).attr("id")!="AddCookie"){
                                        if (div.find("#AddWebInfo").find(":text:eq(" + i + ")").val() == "") {
                                            var setLang = "";
                                            setLang = $.SetOrGetLanguage(setLang, function () {
                                                languages = language;
                                                alert(languages["H1004"]);
                                            }, "/js/IndexGlobal/");
                                            pd = 1;
                                            return false;
                                        }
                                    }
                                });
                                if (pd) {
                                    return false;
                                }
                                var namePattern = /^(0|[1-9][0-9]*)$/;
                                if (!namePattern.test(div.find("#addGroup").val()) || div.find("#addGroup").val().length > 4) {
                                    var setLang = "";
                                    setLang = $.SetOrGetLanguage(setLang, function () {
                                        languages = language;
                                        alert(languages["H1041"]);
                                    }, "/js/IndexGlobal/");
                                    return false;
                                }

                                if (div.find("#addID").val().indexOf("'") != -1) {
                                    var setLang = "";
                                    setLang = $.SetOrGetLanguage(setLang, function () {
                                        languages = language;
                                        alert(languages["H1042"]);
                                    }, "/js/IndexGlobal/");
                                    
                                    return false;
                                }
                                var zw = div.find("#addID").val();
                                if (zw.replace(/[^\x00-\xff]/g, "aa").length != div.find("#addID").val().length) {
                                    var setLang = "";
                                    setLang = $.SetOrGetLanguage(setLang, function () {
                                        languages = language;
                                        alert(languages["H1043"]);
                                    }, "/js/IndexGlobal/");
                                    
                                    return false;
                                }
                                var cooke = div.find("#AddCookie").val();
                                if (cooke.replace(/[^\x00-\xff]/g, "aa").length > 1000) {
                                    var setLang = "";
                                    setLang = $.SetOrGetLanguage(setLang, function () {
                                        languages = language;
                                        alert(languages["H1044"]);
                                    }, "/js/IndexGlobal/");
                                    
                                    return false;
                                }
                                var address1 = div.find("#addAddress").val();
                                if (address1.replace(/[^\x00-\xff]/g, "aa").length > 50) {
                                    var setLang = "";
                                    setLang = $.SetOrGetLanguage(setLang, function () {
                                        languages = language;
                                        alert(languages["H1045"]);
                                    }, "/js/IndexGlobal/");
                                    return false;
                                }
                                var address2 = div.find("#addAddress2").val();
                                if (address2.replace(/[^\x00-\xff]/g, "aa").length > 100) {
                                    var setLang = "";
                                    setLang = $.SetOrGetLanguage(setLang, function () {
                                        languages = language;
                                        alert(languages["H1046"]);
                                    }, "/js/IndexGlobal/");
                                    return false;
                                }

                                data = "id:'" + div.find("#hideID").val() + "',userid:'" + div.find("#addID").val() + "',password:'" + div.find("#addPassword").val() + "',casino:'" + div.find("#webList").val() + "',";
                                data += "group:'" + div.find("#addGroup").val() + "',address:'" + div.find("#addAddress").val().replace("'", "Π") + "',address2:'" + div.find("#addAddress2").val().replace("'", "Π") + "',";
                                data += "cookie:'" + div.find("#AddCookie").val().replace("'", "Π") + "',isquzhi:'" + (div.find("#addIsquzhi").attr("checked") == true ? 1 : 0) + "',";
                                data += "enable:'" + (div.find("#addEnable").attr("checked") == true ? 1 : 0) + "',ip:'" + $("#IpAddress").val() + "'";
                                $.AjaxCommon("/ServicesFile/webBasicInfo/AccountService.asmx/UpdateInfo", data, false, false, function (json) {
                                    if (json.d != "none") {
                                    }
                                });
                                data = "casino:'0',group:'',time1:'',time2:'',enable:'-1'";
                                jQuery.AjaxCommon("/ServicesFile/webBasicInfo/AccountService.asmx/getCount", data, true, false, function (json) {
                                    count = parseInt(json.d);
                                });
                                if (count % 20 == 0) {
                                    page = count / 20;
                                }
                                else {
                                    page = count / 20 + 1;
                                }
                                IsPage(parseInt(page), count, '20', 'IDex', 'IDexC');
                            });
                            tr1.find("td:gt(0)").remove();
                            tr1.find("td:eq(0)").attr("colspan", "11");
                            tr1.find("td:eq(0)").text("");
                            tr1.find("td:eq(0)").append(div);
                            tr.after(tr1);
                        });

                        tr.find("#updataInfo").find("#delete").click(function () {
                            jQuery("#delet").dialog({ modal: true });
                            jQuery("#btnSure").unbind("click");
                            jQuery("#btnSure").bind("click", function () {
                                $("#delet").dialog("close");
                                data = "id:'" + result[i].id + "'";
                                $.AjaxCommon("/ServicesFile/webBasicInfo/AccountService.asmx/deleteInfo", data, false, false, function (json1) {
                                    if (json1.d != "none") {
                                        if (json1.d == "True") {
                                            jQuery("#delet1").dialog({ model: true });
                                            data = "casino:'0',group:'',time1:'',time2:'',enable:'-1'";
                                            jQuery.AjaxCommon("/ServicesFile/webBasicInfo/AccountService.asmx/getCount", data, true, false, function (json) {
                                                count = parseInt(json.d);
                                            });
                                            if (count % 20 == 0) {
                                                page = count / 20;
                                            }
                                            else {
                                                page = count / 20 + 1;
                                            }
                                            IsPage(parseInt(page), count, '20', 'IDex', 'IDexC');
                                        }
                                    }
                                });
                            });
                            jQuery("#btnEsc").unbind("click");
                            jQuery("#btnEsc").bind("click", function () {
                                $("#delet").dialog("close");
                            });
                        });
                        tr.appendTo("#ShowWebInfo");
                    });
                    if(jQuery("#ShowWebInfo>tr").length == 0)
                    {
                        var setLang = "";
                        setLang = $.SetOrGetLanguage(setLang, function () {
                            languages = language;
                            jQuery("#ShowWebInfo").html("<tr><td colspan=\""+jQuery("#tb2>thead>tr>th").length+"\" align=\"center\">"+languages["H1013"]+"</td></tr>");
                        }, "/js/IndexGlobal/");
                        
                        jQuery("#tb2 tfoot tr:eq(1)").hide();
                    }
                    else
                    {
                        jQuery("#tb2 tfoot tr:eq(1)").show();
                    }
                    jQuery("#tb2").alterBgColor({ odd: "odd", even: "even", selected: "selected", tdCss: "tdCss", istdClick: true });
                }
            });
        }
    </script>
</head>
<body>
<table  id="right_main" border="0" width="100%" cellpadding="0" cellspacing="0">
<thead>
<tr class="h30">
<th width="12" class="tab_top_l"></th>
<th width="*" class="tab_top_m"><p id="wzss">网站刷水账号</p></th>
<th width="16" class="tab_top_r"></th>
</tr>
</thead>

<tbody>
<tr>
<td class="tab_middle_l"></td>
<td >
<div id="main">
<!--主题部分开始=========================================================================================-->
<input type="hidden" id="language" value="tw" />
    <form id="form1" runat="server">
    <input type="hidden" value="<%=ip %>" id="IpAddress" />
    <div id="selectAndAddButtonDiv" class="top_banner h24" style="display:none">
    <%if (addAc)
      { %>
    <div class="fl "  id="AddButtonDiv">
    <a  id="AddInfo" class="fa_add"><span class="fa_add_in">新增</span></a>
    </div>
    <%} %>
    <%if (slt)
      { %>
    <div id="selectDiv" style="width:90%" >
    <a id="wz">网站:</a><select id="webWhereVal" ></select>&nbsp;&nbsp;&nbsp;&nbsp;
    <a id="fz">分组:</a><input type="text" id="groupWhereVal" class="text_01 w_100" onmouseover="this.className='text_01_h w_100'" onmouseout="this.className='text_01 w_100'" maxlength="4" />&nbsp;&nbsp;&nbsp;&nbsp;
    <a id="sj">时间:</a><input type="text" id="time1WhereVal" class="text_01 w_100" onmouseover="this.className='text_01_h w_100'" onmouseout="this.className='text_01 w_100'" />&nbsp;&nbsp;
    <input type="text" id="time2WhereVal" class="text_01 w_100" onmouseover="this.className='text_01_h w_100'" onmouseout="this.className='text_01 w_100'" />&nbsp;&nbsp;&nbsp;&nbsp;
    <a id="sf">是否启用:</a><select id="enableWhereVal"><option value="-1">全部</option><option value="0">禁用</option><option value="1">启用</option></select>
    <a id="selectByWhere" class="fa_saurch"><span class="fa_saurch_in">搜索</span></a>
    </div>
    <%} %>
    </div>
    <div class="tc" id="AddInfoDiv" style="display:none">
    <input type="hidden" value="" id="hideID" />
    <div id="add_list" class="new_tr ">
<div align="center">
    <table cellpadding="0" cellspacing="0" class="boder_none" >
    <tr>
<td class="" colspan="4" id="headTitle" ><input type="checkbox" id="IsContinuous"/>连续新增&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;新增网站信息</td>
</tr>
    <tbody id="AddWebInfo">
    <tr>
    <td class="tr">网站</td>
    <td align="left"><select id="webList"></select></td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    </tr>
    <tr>
    <td class="tr">网站账号</td>
    <td class="tl"><input type="text" class="text_01" onmousemove="this.className='text_01_h'" onmouseout="this.className='text_01'" id="addID" maxlength="20" /></td>
    <td class="tr">密码</td>
    <td class="tl"><input type="text" class="text_01" onmousemove="this.className='text_01_h'" onmouseout="this.className='text_01'" id="addPassword" maxlength="20" /></td>
    </tr>
    <tr>
    <td class="tr">账号对应的网址</td>
    <td class="tl"><input type="text" class="text_01" onmousemove="this.className='text_01_h'" onmouseout="this.className='text_01'" id="addAddress" maxlength="50" /></td>
    <td class="tr">账号登录后的网址</td>
    <td class="tl"><input type="text" class="text_01" onmousemove="this.className='text_01_h'" onmouseout="this.className='text_01'" id="addAddress2" maxlength="100" /></td>
    </tr>
    <tr>
    <td class="tr">账号分组</td>
    <td class="tl"><input type="text" class="text_01" onmousemove="this.className='text_01_h'" onmouseout="this.className='text_01'" id="addGroup" maxlength="4" /></td>
    <td class="tr">Cookie</td>
    <td class="tl"><input type="text" class="text_01" onmousemove="this.className='text_01_h'" onmouseout="this.className='text_01'" id="AddCookie" maxlength="1000" /></td>
    </tr>
    <tr>
    <td class="tr">启用</td>
    <td class="tl"><input type="checkbox" checked id="addEnable" /></td>
    <td class="tr">手工取值</td>
    <td class="tl"><input type="checkbox" checked id="addIsquzhi" /></td>
    </tr>
    <tr id="trEnd">
    <td align="center" colspan="4">
<input type="button" id="sure" class="btn_02" onmouseover="this.className='btn_02_h'" onmouseout="this.className='btn_02'"  value="保存" />
<input type="button"  id="esc" class="btn_02" onmouseover="this.className='btn_02_h'" onmouseout="this.className='btn_02'"  value="取消" />
</td>
</tr>
    </tbody>
    </table>
    </div>
<div class="new_trfoot"></div>
</div>
    </div>
    <table class="tab2" id="tb2" style="width:100%;text-align:center" border="0" cellpadding="0" cellspacing="0">
        <thead>
        <tr><th>序号</th><th>网站账号</th><th>密码</th><th>网站</th><th>账号分组</th><th>账号对应网站</th><th>账号登录的网站</th>
        <%if (passwordAc)
          { %><th>Cookie</th><%} %><th>最后修改时间</th><th>是否手工取值</th><th>状态</th>
          <%if (fzAc || deleteAc || mdfAc || addAc)
              { %><th>操作</th><%} %></tr>
        </thead>
        <tbody id="ShowWebInfo">
        </tbody>
        <tfoot><tr id="tr1">
            <td id="IDNumber"></td>
            <td id="webID"></td>
            <td id="pwd"></td>
            <td id="web"></td>
            <td id="webIDGroup"></td>
            <td id="address"></td>
            <td id="address2"></td>
            <%if (passwordAc)
              { %>
            <td id="cook"></td>
            <%} %>
            <td id="updateTime"></td>
            <td id="isManual"></td>
            <td id="isShow"></td>
            <%if (fzAc || deleteAc || mdfAc || addAc)
              { %>
            <td id="updataInfo"><a></a>&nbsp;&nbsp;&nbsp;&nbsp;<a></a></td>
            <%} %>
            </tr>
            <tr class="tc"><td colspan="13"><div id="pageDiv" class="grayr"><span id="zg">总共</span><label id="infoCount"></label><span id="tjl">条记录</span>,<span id="g">共</span><label id="pageCount"></label><span id="y">页</span><a style="cursor:hand" id="sy"> 首页 </a><a style="cursor:hand" id="syy"> 上一页 </a><span id="pageSpan"></span><a style="cursor:hand" id="xyy"> 下一页 </a><a style="cursor:hand" id="wy"> 尾页 </a></div></td></tr>
            </tfoot>
            
    </table>
    </form>
    <div id="cookieDiv"></div>
    <div id="delet" title="删除" style="display:none" >
<div class="showdiv">
<p class="wrnning">确定要删除此项吗？</p>
<div align="center" class="mtop_50">
<input type="button" class="btn_02" id="btnSure" onmouseover="this.className='btn_02_h'" onmouseout="this.className='btn_02'" value="确定" />
<input type="button" class="btn_02" id="btnEsc" onmouseover="this.className='btn_02_h'" onmouseout="this.className='btn_02'" value="取消" />
</div>

</div>
</div>

<div id="delet1" title="提示" style="display:none">
<div class="showdiv">
<p class="wrnning">删除成功!</p>
<div align="center" class="mtop_50">
<input type="button" class="btn_02" id="Button1" onmouseover="this.className='btn_02_h'" onmouseout="this.className='btn_02'" value="确定" />
</div>

</div>
</div>

<!-- 消息提示DIV -->
    <div id="delet2" title="消息提示">

    <div id="reportDiv" class="showdiv">
    <div class=" h30">

</div>
    <div align="center" class="mtop_50">
<input type="button" class="btn_02" id="closeButton" onmouseover="this.className='btn_02_h'" onmouseout="this.className='btn_02'" value="关闭" />
</div>
</div>
    </div>
    <!-- 消息提示DIV结束 -->

<!--主题部分结束=========================================================================================-->
</div>
</td>
<td class="tab_middle_r"></td>
</tr>
</tbody>

<tfoot>
<tr class="h35">
<td width="12" class="tab_foot_l"></td>
<td width="*" class="tab_foot_m">

</td>
<td width="16" class="tab_foot_r"></td>
</tr>
</tfoot>
</table>
</body>
</html>
