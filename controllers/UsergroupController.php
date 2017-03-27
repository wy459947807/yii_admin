<?php
//导航管理
namespace app\controllers;

use Yii;

class UsergroupController extends CommonController implements CommonInterface{

    public function init(){
        parent::init();
        //注册服务
        $this->registService("UserGroupService");//注册用户服务
        $this->registService("RbacService");//注册用户服务
        $this->registService("Rbac","app\common\\");//注册权限管理实例
    }
    
    //列表信息
    public function actionIndex(){
        $params = $this->getParams();  //获取页面参数
        $resultInfo=$this->getService("UserGroupService")->getUserGroupList($params);
        $resultInfo['data']['params']=$params;
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
            $this->result = $this->getService("UserGroupService")->updateUserGroup($params['data']);
            return $this->asJson($this->result);
        }
        
        $rbacList=$this->getService("RbacService")->getRbacAll(array());
        $rbacTree=$this->getListTree($rbacList['data']);
        $resultInfo['rbacTree']=$rbacTree;
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
            $this->result = $this->getService("UserGroupService")->updateUserGroup($params['data']);
            return $this->asJson($this->result);
        }
  
        //页面数据
        $params=$this->getParams();
        if(empty($params['id'])){
            $this->redirect('/site/error');
        }
        $rbacList=$this->getService("RbacService")->getRbacAll(array());//权限列表
        $rbacTree=$this->getListTree($rbacList['data']);//权限列表
        $userInfo=$this->result = $this->getService("UserGroupService")->getUserGroupInfo($params);
        $userRoleList=$this->getService("Rbac")->getEmpowerment($userInfo['data']['name']);
        
        $resultInfo['userGroupInfo']=$userInfo['data'];
        $resultInfo['rbacTree']=$rbacTree;
        $resultInfo['userRoleList']=$userRoleList;
        
        return $this->render('edit.tpl',$resultInfo);
    }

    //删除导航
    public function actionDelete(){
        $params=$this->getValidateParams('delete');
        if($params['status']!=200){
            return $this->asJson($params);
        }
        
        $this->result = $this->getService("UserGroupService")->deleteUserGroup($params['data']);
        return $this->asJson($this->result);
    }
    
    
    
    
    //获取参数规则
    public function getRulesArray($ruleIndex){
        $result['add']=array(  
             array('name','required','message'=>'name必须！'),  
        ); 
        
        $result['edit']=array(
            array('id','required','message'=>'id必须！'), 
            array('name','required','message'=>'name必须！'),  
        );
        
        $result['delete']=array(
            array('id','required','message'=>'id必须！'), 
        );

        return $result[$ruleIndex];
    }
   
}
