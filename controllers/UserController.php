<?php
//导航管理
namespace app\controllers;

use Yii;

class UserController extends CommonController implements CommonInterface{

    public function init(){
        parent::init();
        //注册服务
        $this->registService("UserService");//注册用户服务
        $this->registService("UserGroupService");//注册用户服务
    }
    
    //列表信息
    public function actionIndex(){
        $params = $this->getParams();  //获取页面参数
        $resultInfo=$this->getService("UserService")->getUserList($params);
        $resultInfo['data']['params']=$params;
        return $this->render('index.tpl',$resultInfo);
    }
    
    //添加用户
    public function actionAdd(){
        //页面操作
        if(Yii::$app->request->isPost){
            $params=$this->getValidateParams('add');
            if($params['status']!=200){
                return $this->asJson($params);
            }
            $this->result = $this->getService("UserService")->updateUser($params['data']);
            return $this->asJson($this->result);
        }

        $userGroupList=$this->getService("UserGroupService")->getUserGroupAll();
        $resultInfo["userGroupList"]=$userGroupList['data'];
        return $this->render('add.tpl',$resultInfo);
    }

    //编辑用户
    public function actionEdit(){
        //页面操作
        if(Yii::$app->request->isPost){
            $params=$this->getValidateParams('edit');
            if($params['status']!=200){
                return $this->asJson($params);
            }
            $this->result = $this->getService("UserService")->updateUser($params['data']);
            return $this->asJson($this->result);
        }
  
        //页面数据
        $params=$this->getParams();
        if(empty($params['id'])){
            $this->redirect('/site/error');
        }
        $userInfo=$this->result = $this->getService("UserService")->getUserInfo($params);
        $userGroupList=$this->getService("UserGroupService")->getUserGroupAll();
        $resultInfo["userGroupList"]=$userGroupList['data'];
        $resultInfo['userInfo']=$userInfo['data'];
        return $this->render('edit.tpl',$resultInfo);
    }

    //删除导航
    public function actionDelete(){
        $params=$this->getValidateParams('delete');
        if($params['status']!=200){
            return $this->asJson($params);
        }
        
        $this->result = $this->getService("UserService")->deleteUser($params['data']);
        return $this->asJson($this->result);
    }
    
    //更新状态
    public function actionUpdatestatus(){
        if(Yii::$app->request->isPost){
            $params=$this->getValidateParams('updatestatus');
            if($params['status']!=200){
                return $this->asJson($params);
            }
            $this->result = $this->getService("UserService")->updateUser($params['data']);
            return $this->asJson($this->result);
        }
    }
    
    //获取用户信息
    public function actionUserinfo(){
        //页面数据
        $params=$this->getValidateParams('userInfo');
        if($params['status']!=200){
            return $this->asJson($params);
        }
        $userInfo=$this->result = $this->getService("UserService")->getUserInfo($params['data']);
        $this->result['data']=$userInfo['data'];
        return $this->asJson($this->result);
    }

    //获取参数规则
    public function getRulesArray($ruleIndex){
        $result['add']=array(  
            array('status', 'in', 'range'=>array(1,2),'message'=>'状态码错误.'),  
        ); 
        
        $result['edit']=array(
            array('id','required','message'=>'id必须！'), 
        );
        
        $result['delete']=array(
            array('id','required','message'=>'id必须！'), 
        );
        
        $result['userInfo']=array(
            array('id','required','message'=>'id必须！'), 
        );

        $result['updatestatus']=array(  
            array('id','required','message'=>'id必须！'), 
            array('status', 'in', 'range'=>array(1,2),'message'=>'状态码错误.'),  
        ); 
        
        return $result[$ruleIndex];
    }
   
}
