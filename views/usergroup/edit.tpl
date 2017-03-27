<!--_meta 作为公共模版分离出去-->
<!DOCTYPE HTML>
<html>
    <head>
        <!--{include file="public/head.tpl"}-->

        <title>新建网站角色 - 管理员管理 - H-ui.admin v2.3</title>
        <meta name="keywords" content="H-ui.admin v2.3,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
        <meta name="description" content="H-ui.admin v2.3，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
    </head>
    <body>
        <article class="page-container">
            <form id="editUserGroup" class="form form-horizontal"  action="/usergroup/edit" enctype="multipart/form-data" method="post">
                <input type="hidden" name="id" value="<!--{$userGroupInfo.id}-->"/>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>分组名称：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input type="text" name="name"  class="input-text" value="<!--{$userGroupInfo.name}-->" placeholder="" datatype="*4-16" nullmsg="分组名称不能为空" errormsg="分组名称格式不正确">
                    </div>
                </div>
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3">备注：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <input type="text" name="remark"  id="" class="input-text" value="<!--{$userGroupInfo.remark}-->" placeholder="">
                    </div>
                </div>
                
                
                <div class="row cl">
                    <label class="form-label col-xs-4 col-sm-3">分组权限：</label>
                    <div class="formControls col-xs-8 col-sm-9">
                        <!--{foreach $rbacTree.list as $key=>$val}-->
                        <dl class="permission-list">
                            <dt>
                                <label>
                                    <input type="checkbox" <!--{if isset($userRoleList[$val.name])}--> checked="checked" <!--{/if}--> value="<!--{$val.name}-->" name="rbac[]" id="user-Character-<!--{$key}-->">
                                    <!--{$val.name}-->
                                </label>
                            </dt>
                            <dd>
                                
                                <!--{if !empty($val['child']['list'])}-->
                                <!--{foreach $val.child.list as $k=>$v}-->
                                <dl class="cl permission-list2">
                                    <dt>
                                        <label class="">
                                            <input type="checkbox" <!--{if isset($userRoleList[$v.name])}--> checked="checked" <!--{/if}--> value="<!--{$v.name}-->" name="rbac[]" id="user-Character-<!--{$key}-->-<!--{$k}-->">
                                            <!--{$v.name}--></label>
                                    </dt>
                                    <dd>
                                        <!--{if !empty($v['child']['list'])}-->
                                        <!--{foreach $v.child.list as $i=>$n}-->
                                        <label class="" style=" display: block; float: left;">
                                            <input type="checkbox" <!--{if isset($userRoleList[$n.path])}--> checked="checked" <!--{/if}--> value="<!--{$n.path}-->" name="rbac[]" id="user-Character-<!--{$key}-->-<!--{$k}-->-<!--{$i}-->">
                                            <!--{$n.name}--></label>
                                        <!--{/foreach}-->
                                        <!--{/if}-->
                                    </dd>
                                </dl>
                                <!--{/foreach}-->
                                <!--{/if}-->
                            </dd>
                        </dl>
                        <!--{/foreach}-->
 
                    </div>
                </div>
                <div class="row cl">
                    <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                        <button type="button"  onclick="$('#editUserGroup').submit()"  class="btn btn-success radius" id="admin-role-save" name="admin-role-save"><i class="icon-ok"></i> 确定</button>
                    </div>
                </div>
            </form>
        </article>

       <!--{include file="public/foot.tpl"}-->
       <script type="text/javascript" src="/js/usergroup.js"></script>
      
    </body>
</html>