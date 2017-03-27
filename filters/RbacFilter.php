<?php
namespace app\filters;
use Yii;
use yii\base\Action;
use yii\base\ActionFilter;
class RbacFilter extends ActionFilter
{
    //在action之前运行，可用来过滤输入
    public function beforeAction($action) {
        //$controller="/".Yii::$app->controller->id."/".Yii::$app->controller->action->id;
        $controller="/".$action->controller->id."/".$action->controller->action->id;
        if(Yii::$app->user->can($controller)){ 
            return true;
        }

        return false;
    }
    //在action之后运行，可用来过滤输出
    
    /*
    public function afterAction($action, $result) {
        
        //echo var_dump($result);
        //return '在调用action后显示<br/>';//可以对action输出的$result进行过滤，retun的内容会直接显示
    }*/
   
}