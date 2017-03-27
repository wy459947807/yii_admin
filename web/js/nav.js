//删除栏目
function deleteNav(id) {
    layer.confirm('确认要删除吗？', function (index) {
        var ids = {0: id};
        $(".view_" + id + " input[name='id[]']").each(function (index, element) {
            ids[index + 1] = $(this).val();
        });

        var dataInfo = {};
        dataInfo['id'] = ids;
        var reInfo = getTemplate(dataInfo, "/nav/delete");
        layer_tip(reInfo,1);//提示框
    });
}

//删除选中项
function deleteAll() {
    layer.confirm('确认要删除吗？', function (index) {
        var ids = {};
        $("input[name='id[]']:checked").each(function (index, element) {
            ids[index] = $(this).val();
        });

        var dataInfo = {};
        dataInfo['id'] = ids;
        var reInfo = getTemplate(dataInfo, "/nav/delete");
        layer_tip(reInfo,1);//提示框
    });
}

//添加菜单   
function addNav(){
    var reInfo = ajaxFormSubmit("#addNav",'/nav/add');
    layer_tip(reInfo,1);//提示框
}

//编辑菜单   
function editNav(){
    var reInfo = ajaxFormSubmit("#editNav",'/nav/edit');
    layer_tip(reInfo,1);//提示框
}

$(document).ready(function() {
    $(".module input[name='id[]']").click(function () {
        var id= $(this).val();
        if ($(this).prop("checked")) {
            $(".view_" + id + " input:checkbox").prop("checked", true); 
        } else {
            $(".view_" + id + " input:checkbox").prop("checked", false);
        }    
    });
}); 
    
 