$(function () {
    $(".permission-list dt input:checkbox").click(function () {
        $(this).closest("dl").find("dd input:checkbox").prop("checked", $(this).prop("checked"));
    });
    $(".permission-list2 dt input:checkbox").click(function () {
        var length2 = $(this).parents(".permission-list").find(".permission-list2 dt").find("input:checked").length;
        if ($(this).prop("checked")) {
            $(this).parents(".permission-list").find("dt").first().find("input:checkbox").prop("checked", true);
        } else {
            if (length2 == 0) {
                $(this).parents(".permission-list").find("dt").first().find("input:checkbox").prop("checked", false);
            }
        }
        
    });
    $(".permission-list2 dd input:checkbox").click(function () {
        var l = $(this).parent().parent().find("input:checked").length;
        
        if ($(this).prop("checked")) {
            $(this).closest("dl").find("dt input:checkbox").prop("checked", true);
            $(this).parents(".permission-list").find("dt").first().find("input:checkbox").prop("checked", true);
        } else {
            if (l == 0) {
                $(this).closest("dl").find("dt input:checkbox").prop("checked", false);
            }

            var l2 = $(this).parents(".permission-list").find(".permission-list2 dt").find("input:checked").length;
            if (l2 == 0) {
                $(this).parents(".permission-list").find("dt").first().find("input:checkbox").prop("checked", false);
            }
        }
    });
});
    


//删除选中项
function deleteAll() {
    layer.confirm('确认要删除吗？', function (index) {
        var ids = {};
        $("input[name='id[]']:checked").each(function (index, element) {
            ids[index] = $(this).val();
        });

        var dataInfo = {};
        dataInfo['id'] = ids;
        var reInfo = getTemplate(dataInfo, "/usergroup/delete");
        layer_tip(reInfo,1);//提示框
    });
}

//删除指定用户
function deleteUserGroup(id) {
    layer.confirm('确认要删除吗？', function (index) {
        var dataInfo = {};
        dataInfo['id'] = id;
        var reInfo = getTemplate(dataInfo, "/usergroup/delete");
        layer_tip(reInfo,1);//提示框
    });
}

///添加用户
function addUserGroup(){
    var reInfo = ajaxFormSubmit("#addUserGroup",'/usergroup/add');
    layer_tip(reInfo,1);//提示框
}

///编辑用户
function editUserGroup(){
    var reInfo = ajaxFormSubmit("#editUserGroup",'/usergroup/edit');
    layer_tip(reInfo,1);//提示框
}