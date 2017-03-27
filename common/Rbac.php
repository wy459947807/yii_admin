<?php
namespace app\common;
use Yii;
class Rbac {

    //创建许可
    public function createPermission($dataArray){
        $createPost = Yii::$app->authManager->createPermission($dataArray['name']);
        $createPost->description = $dataArray['description'];
        Yii::$app->authManager->add($createPost);
    }
    
    //创建角色
    public function createRole($dataArray){ 
        $role = Yii::$app->authManager->createRole($dataArray['name']);
        $role->description = $dataArray['description'];
        Yii::$app->authManager->add($role);
    }
    
    //给角色分配许可
    public function createEmpowerment($parentName,$childName){
        $parent = Yii::$app->authManager->createRole($parentName);
        $child = Yii::$app->authManager->createPermission($childName);
        if(!Yii::$app->authManager->hasChild($parent, $child)){
            Yii::$app->authManager->addChild($parent, $child);
        }
    }
    
    //给角色分配用户
    public function assign($roleName,$userId){ 
        $reader = Yii::$app->authManager->createRole($roleName);
        if(empty(Yii::$app->authManager->getAssignment($roleName, $userId))){
            Yii::$app->authManager->assign($reader, $userId);
        }
    }
    
    //删除角色(许可)
    public function delRolePermission($name){
        $reader = Yii::$app->authManager->createRole($name);
        Yii::$app->authManager->remove($reader);
    }
    
    //删除许可
    public function delEmpowerment($parentName,$childName){
        $parent = Yii::$app->authManager->createRole($parentName);
        $child = Yii::$app->authManager->createPermission($childName);
        Yii::$app->authManager->removeChild($parent, $child);
    }
    
    //取消角色用户分配
    public function  delAssign($roleName,$userId){
        $reader = Yii::$app->authManager->createRole($roleName);
        Yii::$app->authManager->revoke($reader, $userId);
    }
    
    //取消该用户所有的角色分配
    public function  delAssignAll($userId){
        Yii::$app->authManager->revokeAll($userId);
    }

    //更新角色(许可)
    public function updateRolePermission($name,$dataArray){
        $role = Yii::$app->authManager->createRole($name);
        $role->name = $dataArray['name'];
        $role->description = $dataArray['description'];
        Yii::$app->authManager->update($name,$role);
    }
    
    //获取权限分配列表
    public function getEmpowerment($name){
        return Yii::$app->authManager->getChildren($name);
    }
    
    
    //获取该用户的权限列表
    public function getAssignList($userId){
        return Yii::$app->authManager->getPermissionsByUser($userId);
    }
}
