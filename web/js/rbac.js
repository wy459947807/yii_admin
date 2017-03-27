
//删除选中项
function deleteAll() {
    layer.confirm('确认要删除吗？', function (index) {
        var ids = {};
        $("input[name='id[]']:checked").each(function (index, element) {
            ids[index] = $(this).val();
        });

        var dataInfo = {};
        dataInfo['id'] = ids;
        var reInfo = getTemplate(dataInfo, "/rbac/delete");
        layer_tip(reInfo,1);//提示框
    });
}

//删除指定权限
function deleteRbac(id) {
    layer.confirm('确认要删除吗？', function (index) {
        var dataInfo = {};
        dataInfo['id'] = id;
        var reInfo = getTemplate(dataInfo, "/rbac/delete");
        layer_tip(reInfo,1);//提示框
    });
}

//添加权限   
function addRbac(){
    var reInfo = ajaxFormSubmit("#addRbac",'/rbac/add');
    layer_tip(reInfo,1);//提示框
}

//编辑权限   
function editRbac(){
    var reInfo = ajaxFormSubmit("#editRbac",'/rbac/edit');
    layer_tip(reInfo,1);//提示框
}


