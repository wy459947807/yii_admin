<?php
//控制器统一接口
namespace app\controllers;

interface CommonInterface{
    //获取参数验证规则
    public  function getRulesArray($ruleIndex);
}
