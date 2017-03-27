<?php

namespace app\service;

use app\models\SysUser;
use app\service\CommonService;
use Yii;
use yii\db\Exception;
class UserService extends CommonService{
    
    public function __construct (){
        $this->registService("RbacService");//注册权限管理实例
        $this->registService("Rbac","app\common\\");//注册权限管理实例
    }
    
    //更新用户
    public function updateUser($params){
        //添加菜单操作
        $tr = Yii::$app->db->beginTransaction();//事务开始
        try {
            if(empty($params['id'])){
                $sysUser=new SysUser();
                $sysUser->createtime = date("Y-m-d H:i:s");
            
            }else{
                $sysUser= SysUser::findOne($params['id']);
    
            }
            
            if(!empty($params['username'])) $sysUser->username   =(string)$params['username'];
            if(!empty($params['password'])) $sysUser->password   = md5 ($params['password']);
            if(!empty($params['nickname'])) $sysUser->nickname   =(string)$params['nickname'];
            if(!empty($params['sex']))      $sysUser->sex        =(string)$params['sex'];
            if(!empty($params['mobile']))   $sysUser->mobile     =(string)$params['mobile'];
            if(!empty($params['email']))    $sysUser->email      =(string)$params['email'];
            if(!empty($params['role']))     $sysUser->role       =(string)$params['role'];
            if(!empty($params['status']))   $sysUser->status     =(int)$params['status'];
            if(!empty($params['remark']))   $sysUser->remark     =(string)$params['remark'];
            
            if(!empty($params['login_time']))     $sysUser->login_time   =(string)$params['login_time'];
            if(!empty($params['login_ip']))       $sysUser->login_ip     =(string)$params['login_ip'];
            if(!empty($params['login_num']))      $sysUser->login_num    =(int)$params['login_num'];
  
            if($sysUser->save()){
                if(!empty($params['username'])){
                    $userId=$sysUser->attributes['id'];
                    $this->getService("Rbac")->delAssignAll($userId);//删除该角色所有的权限分配
                    $this->getService("Rbac")->assign($params['role'],$userId);//创建访问许可
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
    public function deleteUser($params){
        //删除菜单操作
        $tr = Yii::$app->db->beginTransaction();//事务开始
        try {

            $retInfo=SysUser::deleteAll(["in",'id',$params['id']]); 
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
    public function getUserList($params){
        $this->sqlFrom=" sys_user ";        
        $this->sqlField=" * ";       
        $this->sqlWhere=" (1=1) ";
        $this->bindValues=array();
        
        if(!empty($params['page'])) $this->page = $params['page'];
        if(!empty($params['pageLimit'])) $this->pageLimit = $params['pageLimit'];
       
        //搜索信息筛选
        if(!empty($params['searchInfo'])){
            $this->sqlWhere.=" and (nickname like :nickname or mobile like :mobile or email like :email)  ";
            $this->bindValues[":nickname"] = "%".$params['searchInfo']."%";
            $this->bindValues[":mobile"]   = "%".$params['searchInfo']."%";
            $this->bindValues[":email"]    = "%".$params['searchInfo']."%";
        }
        
        //创建时间筛选
        if(!empty($params['starTime'])&&!empty($params['endTime'])){
            $this->sqlWhere.=" and (createtime BETWEEN :starTime AND :endTime) ";
            $this->bindValues[':starTime'] = $params['starTime'];
            $this->bindValues[':endTime']  = $params['endTime'];
        }
        return $this->getPageList();
    }
    
     //获取用户列表
    public function getUserInfo($params){
        $this->sqlFrom=" sys_user ";        
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
    

    
}
