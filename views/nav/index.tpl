<!DOCTYPE HTML>
<html>
    <head>
        <!--{include file="public/head.tpl"}-->
        <title>栏目管理</title>
    </head>
    <body>
        <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 系统管理 <span class="c-gray en">&gt;</span> 栏目管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
        <div class="page-container">
           
            <div class="cl pd-5 bg-1 bk-gray mt-20"> 
                <span class="l">
                    <a href="javascript:;" onclick="deleteAll()" class="btn btn-danger radius">
                        <i class="Hui-iconfont">&#xe6e2;</i> 批量删除
                    </a> 
                    <a class="btn btn-primary radius" onclick="layer_show('添加栏目','/nav/add')" href="javascript:;">
                        <i class="Hui-iconfont">&#xe600;</i> 添加栏目
                    </a>
                </span> 
                <span class="r">共有数据：<strong><!--{$navCount}--></strong> 条</span> </div>
            <div class="mt-20">
                <table class="table table-border table-bordered table-hover table-bg ">
                    <thead>
                        <tr class="text-c">
                            <th width="25"><input type="checkbox" name="" value=""></th>
                            <th width="80">ID</th>
                            <th width="80">排序</th>
                            <th>菜单名称</th>
                            <th>菜单描述</th>
                            <th width="100">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <!--{foreach $navTree.list as $key=>$val}-->
                        <tr class="text-c module">
                            <td><input type="checkbox" name="id[]" value="<!--{$val.id}-->"></td>
                            <td><!--{$val.id}--></td>
                            <td><!--{$val.sort}--></td>
                            <td class="text-l"><!--{$val.name}--></td>
                            <td class="text-l"><!--{$val.remark}--></td>
                            <td class="f-14">
                                <a title="编辑" href="javascript:;" onclick="layer_show('编辑栏目','/nav/edit?id=<!--{$val.id}-->')" style="text-decoration:none">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a> 
                                <a title="删除" href="javascript:;" onclick="deleteNav(<!--{$val.id}-->)" class="ml-5" style="text-decoration:none">
                                    <i class="Hui-iconfont">&#xe6e2;</i>
                                </a>
                            </td>
                        </tr>
                        <!--{if !empty($val['child']['list'])}-->
                        <!--{foreach $val.child.list as $k=>$v}-->
                        <tr class="text-c view_<!--{$val.id}-->">
                            <td><input type="checkbox" name="id[]" value="<!--{$v.id}-->"></td>
                            <td><!--{$v.id}--></td>
                            <td><!--{$v.sort}--></td>
                            <td class="text-l">&nbsp;&nbsp;├&nbsp;<!--{$v.name}--></td>
                            <td class="text-l"><!--{$v.remark}--></td>
                            <td class="f-14">
                                <a title="编辑" href="javascript:;" onclick="layer_show('编辑栏目','/nav/edit?id=<!--{$v.id}-->')" style="text-decoration:none">
                                    <i class="Hui-iconfont">&#xe6df;</i>
                                </a> 
                                <a title="删除" href="javascript:;" onclick="deleteNav(<!--{$v.id}-->)" class="ml-5" style="text-decoration:none">
                                    <i class="Hui-iconfont">&#xe6e2;</i>
                                </a>
                            </td>
                        </tr>
                        <!--{/foreach}-->
                        <!--{/if}-->
                        <!--{/foreach}-->

                    </tbody>
                </table>
            </div>
        </div>

        <!--{include file="public/foot.tpl"}-->
        <script type="text/javascript" src="/js/nav.js"></script> 
    </body>
</html>