/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var stateInfo={
    curObj:new Object(),    //当前元素对象
    isLock:0,               //锁定当前操作
}

var windowList={};//窗口句柄列表

//初始化页面控件
$(document).ready(function () {
    
    initSubmitForm(".form");        //初始化表单
    $(".layer_close").click(function () {
       layer.closeAll();
    });
    
});

/**
 * 绑定表单验证
 * @param {type} formId
 * @returns {undefined}
 */
function initSubmitForm(formId){
    $(formId).validate({
        //重写showErrors
        showErrors: function (errorMap, errorList) {
            var msg = "";
            $.each(errorList, function (i, v) {
                //msg += (v.message + "\r\n");
                //在此处用了layer的方法,显示效果更美观
                v.element.focus();
                layer.tips(v.message, v.element, { time: 2000 , tips:[3, '#c00']});
                return false;
            });  
        },
        /* 失去焦点时不验证 */
        onfocusout: false,
        onkeyup:false
    });          //初始化表单验证
}

/**
 * 给指定模板绑定数据
 * @param {array} res  数据源
 * @param {type} boxId    显示板块ID
 * @param {type} tempId   模板ID
 * @returns {html}
 */
function bindTemplate(res,boxId,tempId,append){
    if(boxId){
        if (res.status === 200) {
            var renderData = {};
            renderData.data = res.data;
            var list_tpl = template(tempId, renderData);
            if (!append) {
                $('#'+boxId).html(list_tpl);
            } else {
                $('#'+boxId).append(list_tpl);
            }
 
        } else {
            console.log(res.info);
        }
    }
}

/**
 * 给指定模板绑定数据
 * @param {type} res
 * @param {type} boxId
 * @param {type} tempId
 * @returns {undefined}
 */
function dataBind(res,boxId,tempId){
    var list_tpl = template(tempId, res);
    $('#'+boxId).html(list_tpl);
}

/**
 * 提交AJAX表单
 * @param {type} formId 表单ID
 * @param {type} fromAction 表单提交地址
 * @returns {undefined}
 */
function ajaxFormSubmit(formId,fromAction,boxId,tempId,append){
   
    if(stateInfo.isLock){
        layer_tip("请勿重复操作！");
        return;
    }

    if($(formId).valid()){
        var reData={};
        stateInfo.isLock=1;
        var dataInfo=$(formId).serializeObject();
        $.ajax({
            url: fromAction,
            type: 'post',
            data:dataInfo,
            dataType: "json",
            async: false,
            success: function (res) {
                bindTemplate(res,boxId,tempId,append);
                reData=res;
                stateInfo.isLock=0;
            },
            error: function () {
                stateInfo.isLock=0;
                layer_tip("数据加载错误！");
            }
        });
        return reData;
    }
}

/**
 * 获取模板
 * @param {type} dataInfo POST参数
 * @param {type} ajaxUrl  AJAX请求地址
 * @param {type} tempId   模板ID
 * @param {type} boxId    显示板块ID
 * @returns {html}
 */
function getTemplate(dataInfo,ajaxUrl,boxId,tempId,append){
    var reData={};
    $.ajax({
        url: ajaxUrl,
        type: 'post',
        data:dataInfo,
        dataType: "json",
        async: false,
        success: function (res) {
            bindTemplate(res,boxId,tempId,append);
            reData=res;
        },
        error: function () {
            layer_tip("数据加载错误！");
        }
    });
    return reData;
}


/**
 * 弹窗
 * @param {type} winId 窗口ID
 * @param {type} width 窗口宽度
 * @param {type} height 窗口高度
 * @returns {html}
 */
function getLayerTemplate(winId,width,height,title,zIndex){
    if (!zIndex) {
        zIndex = 1000;
    }
    var layerName = layer.open({
        type: 1,
        title: title,
        shadeClose: true,
        zIndex: zIndex,
        shade: 0.3,
        area: [width+'px', height+'px'],
        content: $('#'+winId)
    }); 
    
    if (winId) {
        windowList[winId] = layerName;//注册窗口
    }
}

/**
 * 关闭指定窗口
 * @param {type} windowId
 * @returns {undefined}
 */
function closeWindow(windowId) {
    layer.close(windowList[windowId]);
}

/**
 * 提示框
 * @returns {undefined}
 */
function layer_tip(reInfo,refresh){ 
    if(!reInfo) return;
    var msg="出现错误，请重试！%>_<%";
    var icon=2;
    if (reInfo) {
        msg =reInfo.info;
        icon=reInfo.status==200 ? 1 : 2;
    }
    
    layer.alert(msg, {
        title: '温馨提示',
        icon: icon
    });
    
    if(refresh){
        setTimeout("window.location.reload()", 1500);
    }
	
}

//页面跳转
function goPage(url){
    window.location.href=url;
}

/**
* 获取url参数值
* @param {string} url 需要获取参数的url
* @param {string} name 需要获取的参数名
* @return {string} 返回获取的参数名
*/
function getUrlParam(name, url) {
    if (!name) {
            return '';
    }
    url = url || location.search;
    name = name.replace(/(?=[\\^$*+?.():|{}])/, '\\');
    var reg = new RegExp('(?:[?&]|^)' + name + '=([^?&#]*)', 'i');
    var match = url.match(reg);
    return !match ? '' : match[1];
}

//页面跳转
function jumpPage(dataInfo){
    var myurl=new LG.URL(window.location.href);

    for (var index in dataInfo){
        myurl.set(index,dataInfo[index]);
    }

    //alert (myurl.url());
    window.location.href=myurl.url();
}

