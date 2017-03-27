<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="renderer" content="webkit|ie-comp|ie-stand">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
        <meta http-equiv="Cache-Control" content="no-siteapp" />
        <LINK rel="Bookmark" href="/favicon.ico" >
        <LINK rel="Shortcut Icon" href="/favicon.ico" />
        <!--[if lt IE 9]>
        <script type="text/javascript" src="/lib/html5.js"></script>
        <script type="text/javascript" src="/lib/respond.min.js"></script>
        <script type="text/javascript" src="/lib/PIE_IE678.js"></script>
        <![endif]-->
        <link rel="stylesheet" type="text/css" href="/static/h-ui/css/H-ui.min.css" />
        <link rel="stylesheet" type="text/css" href="/static/h-ui.admin/css/H-ui.admin.css" />
        <link rel="stylesheet" type="text/css" href="/lib/Hui-iconfont/1.0.7/iconfont.css" />
        <link rel="stylesheet" type="text/css" href="/lib/icheck/icheck.css" />
        <link rel="stylesheet" type="text/css" href="/static/h-ui.admin/skin/default/skin.css" id="skin" />
        <link rel="stylesheet" type="text/css" href="/static/h-ui.admin/css/style.css" />
        <!--[if IE 6]>
        <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
        <script>DD_belatedPNG.fix('*');</script>
        <![endif]-->
        <title>H-ui.admin v2.5</title>
        <meta name="keywords" content="H-ui.admin v2.5,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
        <meta name="description" content="H-ui.admin v2.5，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
    </head>
    <body>
        
        <form action="/site/test" method="post"  enctype="multipart/form-data"  class="form" id='modifyForm'>
                     
                        
                        
                        <div class="choose-dest layer_pageContent" style="display: block; width: auto">
                            <label style="display: block; float: left; line-height: 25px">目的地：</label>
                            <div class="region-wrap" id="region-wrap" style="float:left;"></div>
                        </div>

                        <div class="shuttleycontent product product-list" style=" padding: 0px;">
                            <table  class="iframe-position-control-table search">
                                <tbody> 
                                    <tr>
                                        <th  style="text-align: left;">   
                                             <span>地址：</span><input name="address" class="search-item-input" value="" type="password" style=" width: 284px;"  datatype="*"   nullmsg="请选择填写地址!"/>
                                        </th>
                                    </tr>
                                </tbody>
                            </table> 
                        </div>
        
                        <div class="hotelicon">
                            <input style=" cursor: pointer" type="button" class="hotelbtn-lg btn-bg-blue" onclick="$('#modifyForm').submit()" value="立即保存">
                            <input style=" cursor: pointer" type="button" class="hotelbtn-lg btn-bg-default" onclick="backList()" value="返回列表">
                        </div>
                        <div style="width: 100%; height: 100px;"></div>

                    </form>
        
        
        <script type="text/javascript" src="/lib/jquery/1.9.1/jquery.min.js"></script> 
        <script type="text/javascript" src="/lib/icheck/jquery.icheck.min.js"></script> 
        <script type="text/javascript" src="/lib/jquery.form/jquery.form.min.js"></script>
        <script type="text/javascript" src="/lib/jquery/1.9.1/jquery.metadata.js"></script>
        <script type="text/javascript" src="/lib/Validform/5.3.2/Validform.min.js"></script>
        <script type="text/javascript" src="/lib/artTemplate/artTemplate.js"></script>
        <script type="text/javascript" src="/lib/layer/2.1/layer.js"></script> 
        <script type="text/javascript" src="/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
        <script type="text/javascript" src="/lib/laypage/1.2/laypage.js"></script> 
        <script type="text/javascript" src="/lib/My97DatePicker/WdatePicker.js"></script> 
        <script type="text/javascript" src="/lib/public/LG.js"></script>
        
       
        <script type="text/javascript" src="/static/h-ui/js/H-ui.js"></script> 
        <script type="text/javascript" src="/static/h-ui.admin/js/H-ui.admin.js"></script>
        
        <script>
          //表单自定义验证
        var datatype={
            "price": /^\d+(?:\.\d{1,2})?$/,
            "intNum": /^[1-9]\d*$/,
            "time": /^(([01]?[0-9])|(2[0-3])):[0-5]?[0-9]$/,
            "dateCompar": function (gets, obj, curform, regxp) {

                if (gets == "") {
                    //$.Tipmsg.w['dateCompar'] = "请选择日期！";
                    return false;
                }
                var begintime = new Date(curform.find("input[name='begintime']").val());
                var endtime = new Date(curform.find("input[name='endtime']").val());
                if (begintime > endtime) {
                    //$.Tipmsg.w['dateCompar'] = "结束日期不能小于开始日期！";
                    return false;
                }
                return true;
            }
        }  
              //初始化表单
        function formInit(formId, url, noAjax) {
            var ajaxPost = true;
            if (noAjax) {
                ajaxPost = false;
            }
            $(formId).Validform({
                tipSweep: true,
                tiptype: function (msg, o, cssctl) {
                    if (!o.obj.is("form")) {
                        if (o.type == 3) {
                            layer.tips(msg, o.obj, { time: 2000 , tips:[3, '#c00']});
                        }
                    }
                },
                datatype: datatype,
                beforeSubmit: function (re) {
                    $(re).find("input[name='address']").val("666");
                    alert('eee');
                },
                ajaxPost: ajaxPost,
                callback: function (data) {
                    if (ajaxPost) {
                        if (data.status == 200) { 
                            layer.alert(data.info, {title: '温馨提示', icon: 1});

                            if (url) {
                                window.location = url;
                            } else {
                                //window.location.reload();
                            }
                        } else {
                            layer.alert(data.info, {title: '温馨提示', icon: 2});
                        }
                    }

                    //window.location.reload();
                },
            });

        }
        
        //初始化页面控件
        $(document).ready(function () {
            formInit(".form");        //初始化表单
         

        });

           
        </script>

    </body>
</html>