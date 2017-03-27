//检测字符长度(一个中文字算2个字节)
$.validator.addMethod("byteRangeLength", function(value, element, param) {
    var length = value.length;
    var param = eval('(' + param + ')');
    for(var i = 0; i < value.length; i++){
        if(value.charCodeAt(i) > 127){
            length++;
        }
    }
    return this.optional(element) || ( length >= param[0] && length <= param[1] );   
}, $.validator.format("字符长度错误(一个中文字算2个字节)"));

//正数
$.validator.addMethod("positive", function(value, element, param) {
    var parnt = /^[0-9]\d*(\.\d+)?$/;
    if(!parnt.exec(value)){
        return false;    
    } 
    return true;    
}, $.validator.format("必须输入数字(大于等于零)"));

//表单数据转对象类型
jQuery.prototype.serializeObject=function(){  
    var obj=new Object();  
    $.each(this.serializeArray(),function(index,param){  
        if(!(param.name in obj)){  
            obj[param.name]=param.value;  
        }  
    });  
    return obj;  
}; 