<!DOCTYPE HTML>
<html>
    <head>
        <!--{include file="public/head.tpl"}-->
        <title>用户分组</title>
    </head>
        
    <body>
        <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 用户中心 <span class="c-gray en">&gt;</span> 用户管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
        <div class="page-container">
            
                
            <div class="cl pd-5 bg-1 bk-gray mt-20"> 
                <span class="l">
                    <a href="javascript:;" onclick="deleteAll()" class="btn btn-danger radius">
                        <i class="Hui-iconfont">&#xe6e2;</i> 批量删除
                    </a> 
                    <a href="javascript:;" onclick="layer_show('添加分组','/usergroup/add')" class="btn btn-primary radius">
                        <i class="Hui-iconfont">&#xe600;</i> 添加分组
                    </a>
                </span> 
                <span class="r">共有数据：<strong><!--{$data.num}--></strong> 条</span> </div>
            <div class="mt-20">
                <table class="table table-border table-bordered table-hover table-bg table-sort">
                    <thead>
                        <tr class="text-c">
                            <th width="25"><input type="checkbox" name="" value=""></th>
                            <th width="30">ID</th>
                            <th width="100">分组名称</th>
                            <th width="100">分组描述</th>
                           
                            <th width="50">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <!--{if !empty($data.list)}-->
                        <!--{foreach $data.list as $key=>$val}-->
                        <tr class="text-c">
                            <td><input type="checkbox" value="<!--{$val.id}-->" name="id[]"></td>
                            <td><!--{$val.id}--></td>
                            <td><u style="cursor:pointer" class="text-primary" onclick=""><!--{$val.name}--></u></td>
                            <td><!--{$val.remark}--></td>
                            
                            <td class="td-manage">
 
                                <a title="编辑" href="javascript:;" onclick="layer_show('编辑分组','/usergroup/edit?id=<!--{$val.id}-->')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
                                <a title="删除" href="javascript:;" onclick="deleteUserGroup(<!--{$val.id}-->)" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>
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
        <script type="text/javascript" src="/js/usergroup.js"></script>
        

    </body>
</html>