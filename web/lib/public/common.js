/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//表单自定义验证
var datatype={
    "price": /^\d+(?:\.\d{1,2})?$/,
    "intNum": /^[1-9]\d*$/,
    "time": /^(([01]?[0-9])|(2[0-3])):[0-5]?[0-9]$/,
    "dateCompar": function (gets, obj, curform, regxp) {

        if (gets == "") {
            //$.Tipmsg.w['dateCompar'] = "请选择日期！";
            return false;
        }
        var begintime = new Date(curform.find("input[name='begintime']").val());
        var endtime = new Date(curform.find("input[name='endtime']").val());
        if (begintime > endtime) {
            //$.Tipmsg.w['dateCompar'] = "结束日期不能小于开始日期！";
            return false;
        }
        return true;
    }
}


var stateInfo = {
    curObj: new Object(), //当前元素对象
    isLock: 0, //锁定当前操作
}

var windowList = {};//窗口句柄列表

//初始化页面控件
$(document).ready(function () {
    formInit(".form");        //初始化表单
    $(".layer_close").click(function () {
        layer.closeAll();
    });

});

//初始化表单
function formInit(formId, url, noAjax) {
    var ajaxPost = true;
    if (noAjax) {
        ajaxPost = false;
    }
    $(formId).Validform({
        tipSweep: true,
        tiptype: function (msg, o, cssctl) {
            if (!o.obj.is("form")) {
                if (o.type == 3) {
                    layer.tips(msg, o.obj, { time: 2000 , tips:[3, '#c00']});
                }
            }
        },
        datatype: datatype,
        beforeSubmit: function (re) {
        },
        ajaxPost: ajaxPost,
        callback: function (data) {
            if (ajaxPost) {
                if (data.status == 200) { 
                    layer.alert(data.info, {title: '温馨提示', icon: 1});
                    
                    if (url) {
                        window.location = url;
                    } else {
                        //window.location.reload();
                    }
                } else {
                    layer.alert(data.info, {title: '温馨提示', icon: 2});
                }
            }

            //window.location.reload();
        },
    });

}


function callBackForm(formId, template, display, append) {
    $(formId).Validform({
        tipSweep: true,
        tiptype: function(msg, o, cssctl) {
            if (!o.obj.is("form")) {
                if (o.type == 3) {
                    layer.tips(msg, o.obj, { time: 2000 , tips:[3, '#c00']});
                }
            }
        },
        datatype: datatype,
        beforeSubmit: function(re) {
        },
        ajaxPost: true,
        callback: function(data) {
            if (!display) {
                display = "return";
            }
            bindTemplate(data,display,template, append);
        },
    });
}



/**
 * 给指定模板绑定数据
 * @param {array} res  数据源
 * @param {type} boxId    显示板块ID
 * @param {type} tempId   模板ID
 * @returns {html}
 */
function bindTemplate(res, boxId, tempId, append) {
    if (boxId) {
        if (res.status === 200) {
            var renderData = {};
            renderData.data = res.data;
            var list_tpl = template(tempId, renderData);
            if (!append) {
                $('#' + boxId).html(list_tpl);
            } else {
                $('#' + boxId).append(list_tpl);
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
function dataBind(res, boxId, tempId,append) {
    var list_tpl = template(tempId, res);
    if (!append) {
        $('#' + boxId).html(list_tpl);
    } else {
        $('#' + boxId).append(list_tpl);
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
function getTemplate(dataInfo, ajaxUrl, boxId, tempId, append) {
    var reData = {};
    $.ajax({
        url: ajaxUrl,
        type: 'post',
        data: dataInfo,
        dataType: "json",
        async: false,
        success: function (res) {
            bindTemplate(res, boxId, tempId, append);
            reData = res;
        },
        error: function () {
            return ;
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
function getLayerTemplate(winId, width, height, title, zIndex) {
    if (!zIndex) {
        zIndex = 1000;
    }
    var layerName = layer.open({
        type: 1,
        title: title,
        shadeClose: true,
        zIndex: zIndex,
        shade: 0.3,
        area: [width + 'px', height + 'px'],
        content: $('#' + winId)
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


//页面跳转
function goPage(url) {
    window.location.href = url;
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
function jumpPage(dataInfo) {
    var myurl = new LG.URL(window.location.href);

    for (var index in dataInfo) {
        myurl.set(index, dataInfo[index]);
    }

    //alert (myurl.url());
    window.location.href = myurl.url();
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
        msg =reInfo.info?reInfo.info:"您无权操作！";
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