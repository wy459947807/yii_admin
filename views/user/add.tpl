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
            <form id="addUser" class="form form-horizontal"  action="/user/add" enctype="multipart/form-data" method="post">
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>用户名：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input type="text" name="username" class="input-text" datatype="*" nullmsg="请填写用户名！" errormsg="用户名格式不正确"  value="" placeholder="">
                    </div>
                </div>
                
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>密码：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input type="password"   name="pwd" class="input-text" datatype="*" nullmsg="请填写密码！" errormsg="密码格式不正确"  value="" placeholder="">
                    </div>
                </div>
                
                 <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>确认密码：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input type="password"  name="password" class="input-text " recheck="pwd"  datatype="*" nullmsg="请确认密码！" errormsg="两次密码不一致！"  value="" placeholder="">
                    </div>
                </div>
                <div style="height: 30px">
                  
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>昵称：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input type="text"  name="nickname" class="input-text"  datatype="*" nullmsg="请填写昵称！" errormsg="昵称格式不正确"  value="" placeholder="">
                    </div>
                </div>
                
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>性别：</label>
                    <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                        <div class="radio-box">
                            <input name="sex" value="男" type="radio" id="sex-1" checked>
                            <label for="sex-1">男</label>
                        </div>
                        <div class="radio-box">
                            <input name="sex" value="女" type="radio" id="sex-2" >
                            <label for="sex-2">女</label>
                        </div>
                    </div>
                </div>
                
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>手机：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input type="text"  name="mobile" class="input-text" value="" placeholder="">
                    </div>
                </div>
                
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>邮箱：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input type="text"  name="email" class="input-text" value="" placeholder="">
                    </div>
                </div>
                
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3">角色：</label>
                    <div class="formControls col-xs-8 col-sm-9"> <span class="select-box">
                            <select class="select" size="1" name="role">
                                <!--{foreach $userGroupList as $key=>$val}-->
                                <option value="<!--{$val.name}-->"><!--{$val.name}--></option>
                                <!--{/foreach}-->
                            </select>
                        </span> </div>
                </div>
                
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>状态：</label>
                    <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                        <div class="radio-box">
                            <input name="status" value="1" type="radio" id="sex-1" checked>
                            <label for="sex-1">启用</label>
                        </div>
                        <div class="radio-box">
                            <input name="status" value="2" type="radio" id="sex-2">
                            <label for="sex-2">禁用</label>
                        </div>
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
                        <input class="btn btn-primary radius" onclick="$('#addUser').submit()" type="button" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
                    </div>
                </div>
            </form>
        </article>

        <!--{include file="public/foot.tpl"}-->
        <script type="text/javascript" src="/js/user.js"></script>
        <!--请在下方写此页面业务相关的脚本--> 
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