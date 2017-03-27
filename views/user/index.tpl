<!DOCTYPE HTML>
<html>
    <head>
        <!--{include file="public/head.tpl"}-->
        <title>用户管理</title>
    </head>
        
    <body>
        <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户中心 <span class="c-gray en">&gt;</span> 用户管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
        <div class="page-container">
            <form  action="" method="get" class="form-horizontal">
            <div class="text-c"> 日期范围：

                <input type="text" name="starTime" value="<!--{if isset($data.params.starTime)}--><!--{$data.params.starTime}--><!--{/if}-->" onfocus="WdatePicker({maxDate: '#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemin" class="input-text Wdate" style="width:120px;">
                -
                <input type="text" name="endTime" value="<!--{if isset($data.params.endTime)}--><!--{$data.params.endTime}--><!--{/if}-->" onfocus="WdatePicker({minDate: '#F{$dp.$D(\'datemin\')}', maxDate: '%y-%M-%d'})" id="datemax" class="input-text Wdate" style="width:120px;">
                <input type="text" name="searchInfo" value="<!--{if isset($data.params.searchInfo)}--><!--{$data.params.searchInfo}--><!--{/if}-->" class="input-text" style="width:250px" placeholder="输入会员名称、电话、邮箱" id="" >
                <button type="submit" class="btn btn-success radius" id="" name=""><i class="Hui-iconfont">&#xe665;</i> 搜用户</button>
            </div>
            </form>  
                
            <div class="cl pd-5 bg-1 bk-gray mt-20"> 
                <span class="l">
                    <a href="javascript:;" onclick="deleteAll()" class="btn btn-danger radius">
                        <i class="Hui-iconfont">&#xe6e2;</i> 批量删除
                    </a> 
                    <a href="javascript:;" onclick="layer_show('添加会员','/user/add')" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加用户
                    </a>
                </span> 
                <span class="r">共有数据：<strong><!--{$data.num}--></strong> 条</span> </div>
            <div class="mt-20">
                <table class="table table-border table-bordered table-hover table-bg table-sort">
                    <thead>
                        <tr class="text-c">
                            <th width="25"><input type="checkbox" name="" value=""></th>
                            <th width="80">ID</th>
                            <th width="100">用户名</th>
                            <th width="40">性别</th>
                            <th width="90">手机</th>
                            <th width="150">邮箱</th>
                            <th width="">角色</th>
                            <th width="130">加入时间</th>
                            <th width="70">状态</th>
                            <th width="100">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <!--{if !empty($data.list)}-->
                        <!--{foreach $data.list as $key=>$val}-->
                        <tr class="text-c">
                            <td><input type="checkbox" value="<!--{$val.id}-->" name="id[]"></td>
                            <td><!--{$val.id}--></td>
                            <td><u style="cursor:pointer" class="text-primary" onclick=""><!--{$val.nickname}--></u></td>
                            <td><!--{$val.sex}--></td>
                            <td><!--{$val.mobile}--></td>
                            <td><!--{$val.email}--></td>
                            <td class="text-l"><!--{$val.role}--></td>
                            <td><!--{$val.createtime}--></td>
                            
                            <td class="td-status">
                                <!--{if $val.status==1}-->
                                <span class="label label-success radius">已启用</span>
                                <!--{else if $val.status==2}-->
                                <span class="label label-defaunt radius">已停用</span>
                                <!--{/if}-->
                            </td>
                            
                            <td class="td-manage">
                                
                                <!--{if $val.status==1}-->
                                <a style="text-decoration:none" onClick="updateStatus(<!--{$val.id}-->,2)" href="javascript:;" title="停用"><i class="Hui-iconfont">&#xe631;</i></a> 
                                <!--{else if $val.status==2}-->
                                <a style="text-decoration:none" onClick="updateStatus(<!--{$val.id}-->,1)" href="javascript:;" title="启用"><i class="Hui-iconfont">&#xe6e1;</i></a>
                                <!--{/if}-->
                                
                                <a title="编辑" href="javascript:;" onclick="layer_show('编辑会员','/user/edit?id=<!--{$val.id}-->')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
                                <a style="text-decoration:none" class="ml-5" onClick="changePasswordBox({id:<!--{$val.id}-->})" href="javascript:;" title="修改密码"><i class="Hui-iconfont">&#xe63f;</i></a> 
                                <a title="删除" href="javascript:;" onclick="deleteUser(<!--{$val.id}-->)" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
                            </td>
                        </tr>
                        <!--{/foreach}-->
                        <!--{/if}-->
                    </tbody>
                </table>      
                <!--{include file="public/page.tpl"}-->
            </div>
        </div>
        <!--{include file="public/foot.tpl"}-->
        <!--{include file="user/template/changePasswordBox.tpl"}-->
        <script type="text/javascript" src="/js/user.js"></script>
        

    </body>
</html>