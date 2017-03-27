<?php

namespace app\service;

use app\models\SysNav;
use app\service\CommonService;
use Yii;
use yii\db\Exception;
class RbacService extends CommonService{
    
    public function __construct (){
         $this->registService("Rbac","app\common\\");//注册权限管理实例
    }


    //更新权限
    public function updateRbac($params){
        if(empty($params['id'])){
            $sysNav= SysNav::find()
                    ->where(['and',"path='{$params["path"]}'","type='action'"])
                    ->one();        
            if(!empty($sysNav)){
                $this->result['status']=500;
                $this->result['info']="操作路径重复！";    
                return $this->result;
            }
        }

         //添加菜单操作
        $tr = Yii::$app->db->beginTransaction();//事务开始
        try {
            if(empty($params['id'])){
                $sysNav=new SysNav();
                
                //权限管理
                if(!empty($params['path'])){
                    $permissionArray['name']=$params['path'];
                    $permissionArray['description']=$params['remark'];
                    $this->getService("Rbac")->createPermission($permissionArray);//创建访问许可
                }
                
            }else{
                $sysNav= SysNav::findOne($params['id']);
                
                //权限管理
                if(!empty($params['path'])){
                    $permissionArray['name']=$params['path'];
                    $permissionArray['description']=$params['remark'];
                    $this->getService("Rbac")->updateRolePermission($sysNav->path,$permissionArray);//编辑访问许可
                }
            }
           
            
            if(!empty($params['pid']))      $sysNav->pid=   (int)$params['pid'];
            if(!empty($params['name']))     $sysNav->name=  (string)$params['name'];
            if(!empty($params['icon']))     $sysNav->icon=  (int)$params['icon'];
            if(!empty($params['path']))     $sysNav->path=  (string)$params['path'];
            if(!empty($params['status']))   $sysNav->status=(int)$params['status'];
            if(!empty($params['sort']))     $sysNav->sort=  (int)$params['sort'];
            if(!empty($params['remark']))   $sysNav->remark=(string)$params['remark'];
            
            $sysNav->type= "action";
            
            if($sysNav->save()){
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
    
    //删除权限
    public function deleteRbac($params){
        //删除菜单操作
        $tr = Yii::$app->db->beginTransaction();//事务开始
        try {
            
            $sysList = SysNav::find()
                ->where(["in",'id',$params['id']])
                ->all();        
            
            foreach ($sysList as $key=>$val){
                if($val->type=="action"){
                    $this->getService("Rbac")->delRolePermission($val->path);//删除许可
                }else{
                    $this->getService("Rbac")->delRolePermission($val->name);//删除许可
                }
            }

            $retInfo=SysNav::deleteAll(["in",'id',$params['id']]); 
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
    
    //获取权限列表
    public function getRbacList($params){
        $this->pageLimit=10;       
        $this->sqlFrom=" sys_nav ";        
        $this->sqlField=" * ";       
        $this->sqlWhere=" (1=1) and type='action' ";
        $this->bindValues=array();
        
        if(!empty($params['page'])) $this->page = $params['page'];
        if(!empty($params['pageLimit'])) $this->pageLimit = $params['pageLimit'];
       
        //列表筛选
        if(!empty($params['pid'])){
            $this->sqlWhere.=" and pid=:pid ";
            $this->bindValues[':pid'] = $params['pid'];
        }
        return $this->getPageList();
    }
    
    //获取用户列表
    public function getRbacInfo($params){
        $this->sqlFrom=" sys_nav ";        
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
    
    public function getRbacAll($params){
        $this->sqlFrom=" sys_nav ";        
        $this->sqlField=" * ";       
        $this->sqlWhere=" (1=1) ";
        $this->bindValues=array();
        
        //列表筛选
        if(!empty($params['pid'])){
            $this->sqlWhere.=" and pid=:pid ";
            $this->bindValues[':pid'] = $params['pid'];
        }
        return $this->getAll();
    }
    
    
    
}
