<!--_meta 作为公共模版分离出去-->
<!DOCTYPE HTML>
<html>
    <head>
        <!--{include file="public/head.tpl"}-->
        <title>添加用户 - H-ui.admin v2.3</title>
        <meta name="keywords" content="H-ui.admin v2.3,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
        <meta name="description" content="H-ui.admin v2.3，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
    </head>
    <body>
        <article class="page-container">
            <form action="/nav/add" method="post" class="form form-horizontal" id="addNav">
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3">
                        <span class="c-red">*</span>菜单名称：
                    </label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input  name="name" type="text"  class="input-text" datatype="*" nullmsg="请填写菜单名！" errormsg="菜单名格式不正确" value="" placeholder="" >
                    </div>
                </div>
                    
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3">所属栏目：</label>
                    <div class="formControls col-xs-8 col-sm-9"> 
                        <span class="select-box">
                            <select class="select" size="1" name="pid">
                                <option value="0" selected>顶级栏目</option>
                                <!--{foreach $moduleList as $key=>$val}-->
                                <option value="<!--{$val.id}-->"><!--{$val.name}--></option>
                                <!--{/foreach}-->
                            </select>
                        </span> 
                    </div>
                </div>
                   
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3">
                        <span class="c-red">*</span>栏目路径：
                    </label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input  name="path" type="text"  class="input-text" datatype="*" nullmsg="请填写栏目路径！" errormsg="栏目路径格式不正确" value="" placeholder="" >
                    </div>
                </div>
                    
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3">
                        <span class="c-red">*</span>排序：
                    </label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input  name="sort" type="text"  class="input-text" datatype="n"  errormsg="请填写数字！" ignore="ignore"  value="0" placeholder="" >
                    </div>
                </div> 

                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>状态：</label>
                    <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                        <div class="radio-box">
                            <input name="status" type="radio" id="status-1" value="1" checked>
                            <label for="status-1">启用</label>
                        </div>
                        <div class="radio-box">
                            <input name="status" type="radio" id="status-2" value="2">
                            <label for="status-2">禁用</label>
                        </div>
                    </div>
                </div>
               
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>图标：</label>
                    <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                        <!--{foreach $navIcon as $key=>$val}-->
                        <div class="radio-box">
                            <!--{if $key==1}-->
                            <input name="icon" value="<!--{$key}-->" type="radio" id="icon-<!--{$key}-->" checked>
                            <!--{else}-->
                            <input name="icon" value="<!--{$key}-->" type="radio" id="icon-<!--{$key}-->">
                            <!--{/if}-->
                            <label for="icon-<!--{$key}-->"><i class="Hui-iconfont"><!--{$val}--></i></label>
                        </div>
                        <!--{/foreach}-->
                        
                    </div>
                </div>   
                
                    
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3">备注：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <textarea name="remark" cols="" rows="" class="textarea"  placeholder="说点什么...最少输入10个字符" onKeyUp="textarealength(this, 100)"></textarea>
                        <p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
                    </div>
                </div>
                <div class="row cl">
                    <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                        <input class="btn btn-primary radius" onclick="$('#addNav').submit()" type="button" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
                    </div>
                </div>
            </form>
        </article>

        <!--{include file="public/foot.tpl"}-->
        <!--请在下方写此页面业务相关的脚本--> 
        <script type="text/javascript" src="/js/nav.js"></script>
        <script type="text/javascript">
            $(function () {
                $('.skin-minimal input').iCheck({
                    checkboxClass: 'icheckbox-blue',
                    radioClass: 'iradio-blue',
                    increaseArea: '20%'
                });
            });
        </script> 
        <!--/请在上方写此页面业务相关的脚本-->
    </body>
</html>