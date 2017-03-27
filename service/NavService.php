<?php

namespace app\service;


use app\models\SysNav;
use app\service\CommonService;
use Yii;
use yii\db\Exception;
class NavService extends CommonService{
    
    public function __construct (){
        $this->registService("Rbac","app\common\\");//注册权限管理实例
    }


    //更新菜单
    public function updateNav($params){
        if(empty($params['id'])){
            $sysNav= SysNav::find()
                    ->where(['and',"name='{$params["name"]}'",['or',"type='view'","type='module'"]])
                    ->one();        
            if(!empty($sysNav)){
                $this->result['status']=500;
                $this->result['info']="菜单名称重复！";    
                return $this->result;
            }
        }

         //添加菜单操作
        $tr = Yii::$app->db->beginTransaction();//事务开始
        try {
            if(empty($params['id'])){
                $sysNav=new SysNav();
                
                //权限管理
                if(!empty($params['name'])){
                    $permissionArray['name']=$params['name'];
                    $permissionArray['description']=$params['remark'];
                    $this->getService("Rbac")->createPermission($permissionArray);//创建访问许可
                }
                
            }else{
                $sysNav= SysNav::findOne($params['id']);
                
                //权限管理
                if(!empty($params['name'])){
                    $permissionArray['name']=$params['name'];
                    $permissionArray['description']=$params['remark'];
                    $this->getService("Rbac")->updateRolePermission($sysNav->name,$permissionArray);//编辑访问许可
                }
            }
            if(!empty($params['pid']))      $sysNav->pid=   $params['pid'];
            if(!empty($params['name']))     $sysNav->name=  $params['name'];
            if(!empty($params['icon']))     $sysNav->icon=  $params['icon'];
            if(!empty($params['path']))     $sysNav->path=  $params['path'];
            if(!empty($params['status']))   $sysNav->status=$params['status'];
            if(!empty($params['sort']))     $sysNav->sort=  $params['sort'];
            if(!empty($params['remark']))   $sysNav->remark=$params['remark'];
            
            if(!empty($params['type'])){
                $sysNav->type= $params['type'];
            }else{
                $sysNav->type=  $params['pid']?"view":"module"; 
            }

        
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
    
    //删除菜单
    public function deleteNav($params){
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
    
    //获取菜单列表
    public function getNavList(){
        $navList=SysNav::find()
                ->where(['and','status=1',['or',"type='view'","type='module'"]])
                ->orderBy('sort asc')
                ->all();
       
        $this->result['data']=$navList;
        return $this->result;
    }
    
    //获取模块列表
    public function getModuleList(){
        $moduleList=SysNav::find()
                 ->where(['and','status=1',"type='module'"])
                 ->orderBy('sort asc')           
                 ->all(); 
        
        $this->result['data']=$moduleList;
        return $this->result;
         
    }
    
    
    //获取条件筛选列表
    public function getList($params){
        $this->sqlFrom=" sys_nav ";        
        $this->sqlField=" * ";       
        $this->sqlWhere=" (1=1) ";
        $this->sqlOrder=" order by sort asc ";
        $this->bindValues=array();
        
        
        //条件筛选
        if(!empty($params['pid'])){
            $this->sqlWhere.=" and pid=:pid ";
            $this->bindValues[':pid'] = $params['pid'];
        }
        
        if(!empty($params['type'])){
            $this->sqlWhere.=" and type=:type ";
            $this->bindValues[':type'] = $params['type'];
        }
        
        return $this->getAll();
    }
    
   
    
}
