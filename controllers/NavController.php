<?php
//导航管理
namespace app\controllers;

use app\models\SysNav;
use Yii;

class NavController extends CommonController implements CommonInterface{

    public function init(){
        parent::init();
        //注册服务
        $this->registService("NavService");//菜单服务
    }
    
    //列表信息
    public function actionIndex(){
        $navList=$this->getService("NavService")->getNavList();//获取菜单列表
        $navArray=$this->objectsToArrays($navList['data']);//类型转换
        $navTree=$this->getListTree($navArray);
        $resultInfo['navTree']=$navTree; 
        $resultInfo['navCount']=count($navArray);
        return $this->render('index.tpl',$resultInfo);
    }
    
    //添加导航
    public function actionAdd(){
        
        //页面操作
        if(Yii::$app->request->isPost){
            $params=$this->getValidateParams('add');
            if($params['status']!=200){
                return $this->asJson($params);
            }
            $this->result = $this->getService("NavService")->updateNav($params['data']);
            return $this->asJson($this->result);
        }
        
        $navIcon=Yii::$app->params['navIcon'];//获取图标列表
        $moduleList=$this->getService("NavService")->getModuleList();//获取模块列表
        $resultInfo['moduleList']=$this->objectsToArrays($moduleList['data']);//类型转换
        $resultInfo['navIcon']=$navIcon;
        return $this->render('add.tpl',$resultInfo);
    }

    //编辑导航
    public function actionEdit(){
        //添加操作
        if(Yii::$app->request->isPost){
            $params=$this->getValidateParams('add');
            if($params['status']!=200){
                return $this->asJson($params);
            }
            $this->result = $this->getService("NavService")->updateNav($params['data']);
            return $this->asJson($this->result);
        }

        //页面数据
        $params=$this->getParams();
        if(empty($params['id'])){
            $this->redirect('/site/error');
        }
        $navInfo = SysNav::findOne($params['id']);
        if(empty($navInfo)){
            $this->redirect('/site/error');
        }
        $navIcon=Yii::$app->params['navIcon'];//获取图标列表
        $moduleList=$this->getService("NavService")->getModuleList();//获取模块列表
        $resultInfo['moduleList']=$this->objectsToArrays($moduleList['data']);//类型转换
        $resultInfo['navIcon']=$navIcon;
        $resultInfo['navInfo']=$navInfo ;
        return $this->render('edit.tpl',$resultInfo);
    }

    //删除导航
    public function actionDelete(){
        
        $params=$this->getValidateParams('delete');
        if($params['status']!=200){
            return $this->asJson($params);
        }
        
        $this->result = $this->getService("NavService")->deleteNav($params['data']);
        return $this->asJson($this->result);

    }

    //获取参数规则
    public function getRulesArray($ruleIndex){
        $result['add']=array(  
            array('status', 'in', 'range'=>array(1,2),'message'=>'状态码错误.'),  
        ); 
        
        $result['delete']=array(
            array('id','required','message'=>'id必须！'), 
        );
        
        return $result[$ruleIndex];
    }
   
}
