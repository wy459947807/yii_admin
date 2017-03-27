<?php

namespace app\service;

use app\common\InstanceFactory;
use Yii;

class CommonService {
    public $serviceList=array();//服务列表
    public $result = array(
        "status" => 200, 
        "info" => "操作成功！",
        "data" => ""
    );//返回数据格式
    
    

    public $page=1;             //当前页码
    public $pageLimit=10;       //每页显示条数
    
    public $sqlFrom="";         //数据库查询表
    public $sqlField="";        //数据库查询字段
    public $sqlWhere=" (1=1) "; //数据库查询条件
    public $sqlGroupby="" ;     //数据库查询分组
    public $sqlLimit="";        //数据库查询限制条数
    public $sqlOrder="";        //数据库查询排序
    public $bindValues=array(); //数据库查询pdo字段绑定

    public function getPageList(){
        $offset = ($this->page - 1) * $this->pageLimit;
        $sqlLimit=" limit {$offset},{$this->pageLimit} ";
        
        $list_sql="SELECT ".$this->sqlField." FROM ".$this->sqlFrom." WHERE  ".$this->sqlWhere.$this->sqlGroupby.$sqlLimit;
        $count_sql = "SELECT COUNT(*) as num FROM " .$this->sqlFrom." WHERE  ".$this->sqlWhere;
        $count = Yii::$app->db->createCommand($count_sql)->bindValues($this->bindValues)->queryOne();
        $list  = Yii::$app->db->createCommand($list_sql)->bindValues($this->bindValues)->queryAll();

        $resultData['list']=$list;
        $resultData['page']=$this->page;
        $resultData['pageLimit']=$this->pageLimit;
        $resultData['num']=$count['num'];
        $this->result['data']=$resultData;
        return $this->result;  
                
    }
    
    public function getAll(){
        $list_sql="SELECT ".$this->sqlField." FROM ".$this->sqlFrom." WHERE  ".$this->sqlWhere.$this->sqlGroupby.$this->sqlLimit;
        $list  = Yii::$app->db->createCommand($list_sql)->bindValues($this->bindValues)->queryAll();
        $this->result['data']=$list;
        return $this->result;  
    }
    
    public function getOne(){
        $data_sql="SELECT ".$this->sqlField." FROM ".$this->sqlFrom." WHERE  ".$this->sqlWhere.$this->sqlGroupby.$this->sqlLimit;
        $data    = Yii::$app->db->createCommand($data_sql)->bindValues($this->bindValues)->queryOne();
        $this->result['data']=$data;
        return $this->result;  
    }
    
    
   
    //注册实例
    public function registService($serviceName,$nameSpace="app\service\\"){
        $this->serviceList[$serviceName]=InstanceFactory::getInstance($nameSpace.$serviceName);
    }
    
    //获取实例
    public function getService($serviceName){
        if(isset($this->serviceList[$serviceName])){
            return $this->serviceList[$serviceName];
        }
        return;
    }
    
    
}
