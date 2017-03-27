<?php

namespace app\service;

use app\models\SysUserGroup;
use app\service\CommonService;
use Yii;
use yii\db\Exception;
class UserGroupService extends CommonService{
    
    public function __construct (){
        $this->registService("RbacService");//注册权限管理实例
        $this->registService("Rbac","app\common\\");//注册权限管理实例
    }

    
    //更新用户
    public function updateUserGroup($params){

        //添加菜单操作
        $tr = Yii::$app->db->beginTransaction();//事务开始
        try {
            if(empty($params['id'])){
                $sysUserGroup=new SysUserGroup();
                
                if(!empty($params['name'])){
                    $roleArray['name']=$params['name'];
                    $roleArray['description']=$params['remark'];
                    $this->getService("Rbac")->createRole($roleArray);//创建角色
                }
                
            }else{
                $sysUserGroup= SysUserGroup::findOne($params['id']);
                
                //权限管理
                if(!empty($params['name'])){
                    $roleArray['name']=$params['name'];
                    $roleArray['description']=$params['remark'];
                    $this->getService("Rbac")->updateRolePermission($sysUserGroup->name,$roleArray);//编辑访问许可
                }
            }
            
            if(!empty($params['pid']))      $sysUserGroup->pid      =(int)$params['pid'];
            if(!empty($params['name']))     $sysUserGroup->name     =(string)$params['name'];
            if(!empty($params['sort']))     $sysUserGroup->sort     =(int)$params['sort'];
            if(!empty($params['remark']))   $sysUserGroup->remark   =(string)$params['remark'];

            if($sysUserGroup->save()){
                
                //分配权限
                $rbacArray = !empty($params['rbac'])?$params['rbac']:array();
                $rbacList=$this->getService("RbacService")->getRbacAll(array());
                foreach ($rbacList['data'] as $key=>$val){
                    $rbacName=($val['type']=="action")?$val['path']:$val['name'];
                    if(in_array($rbacName, $rbacArray)){
                        $this->getService("Rbac")->createEmpowerment($sysUserGroup->name,$rbacName);//给角色分配许可
                    }else{
                        $this->getService("Rbac")->delEmpowerment($sysUserGroup->name,$rbacName);//删除角色许可
                    }
                } 
                   
 
                $this->result['status']=200;
                $this->result['info']="修改成功！";
            }else{
                $this->result['status']=500;
                $this->result['info']="修改失败！";
            }
            $tr->commit();//事务提交
        } catch (Exception $e) {
            $tr->rollBack();//事务回滚
        }
        return $this->result;
    }
    
    //删除用户
    public function deleteUserGroup($params){
        //删除菜单操作
        $tr = Yii::$app->db->beginTransaction();//事务开始
        try {
            
            $userGroupList = SysUserGroup::find()
                ->where(["in",'id',$params['id']])
                ->all();        
            
            foreach ($userGroupList as $key=>$val){
                $this->getService("Rbac")->delRolePermission($val->name);//删除许可
            }

            $retInfo=SysUserGroup::deleteAll(["in",'id',$params['id']]); 
            if($retInfo){
                $this->result['status']=200;
                $this->result['info']="删除成功！";
            }else{
                $this->result['status']=500;
                $this->result['info']="删除失败！";
            }
            $tr->commit();//事务提交
        } catch (Exception $e) {
            $tr->rollBack();//事务回滚
        }
        
        return $this->result;
    }
    
    //获取用户列表
    public function getUserGroupList($params){
        $this->sqlFrom=" sys_user_group ";        
        $this->sqlField=" * ";       
        $this->sqlWhere=" (1=1) ";
        $this->bindValues=array();
        
        if(!empty($params['page'])) $this->page = $params['page'];
        if(!empty($params['pageLimit'])) $this->pageLimit = $params['pageLimit'];

        return $this->getPageList();
    }
    
    //获取分组
    public function getUserGroupInfo($params){
        $this->sqlFrom=" sys_user_group ";        
        $this->sqlField=" * ";       
        $this->sqlWhere=" (1=1) ";
        $this->bindValues=array();
        
        
        //条件筛选
        if(!empty($params['id'])){
            $this->sqlWhere.=" and id=:id ";
            $this->bindValues[':id'] = $params['id'];
        }
        
        return $this->getOne();
        
    }
    
    
    public function getUserGroupAll(){
        $this->sqlFrom=" sys_user_group ";        
        $this->sqlField=" * ";       
        $this->sqlWhere=" (1=1) ";
        $this->bindValues=array();
        
      
        return $this->getAll();
    }
    

    
}
