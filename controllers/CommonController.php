<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\filters\VerbFilter;
use ArrayObject;
use yii\validators\Validator;
use yii\httpclient\Client;
use yii\httpclient\Request;
use yii\httpclient\RequestEvent;
use app\common\Rbac;
use app\common\InstanceFactory;
use app\filters\RbacFilter;
class CommonController extends Controller {
    public $serviceList=array();//服务列表
    public $layout = false; //禁用yii默认布局
    public $result = array(
        "status" => 200, 
        "info" => "操作成功！",
        "data" => ""
    );//返回数据格式
    
    
    //rbac权限过滤
    public function behaviors() {
        return [
            'rbac' => [
                'class' => RbacFilter::className(),
            ]
        ];
    }
    
    
    //参数验证
    public function paramsValidate($paramsArray, $rulesArray) {
        $validators = new ArrayObject;
        foreach ($rulesArray as $rule) {
            if ($rule instanceof Validator) {
                $validators->append($rule);
            } elseif (is_array($rule) && isset($rule[0], $rule[1])) { // attributes, validator type
                $validator = Validator::createValidator($rule[1], $this, (array) $rule[0], array_slice($rule, 2));
                $validators->append($validator);
                $validatorItem= !empty($paramsArray[$rule[0]])?$paramsArray[$rule[0]]:'';
                $validator->validate($validatorItem, $error);
                if (!empty($error)) {
                    $this->result['status'] = 500;
                    $this->result['info'] = $error;
                    return $this->result;
                }
                
                
            } else {
                throw new InvalidConfigException('Invalid validation rule: a rule must specify both attribute names and validator type.');
            }
        }

        return $this->result;
    }

    //数组转对象
    function arrayToObject($array) {
        $obj = new StdClass();
        if (is_array($array)) {
            foreach ($array as $key => $val) {
                $obj->$key = $val;
            }
        } else {
            $obj = $array;
        }
        return $obj;
    }

    //对象转数组
    function objectToArray($object) {
        $array=array();
        if (is_object($object)) {
            foreach ($object as $key => $value) {
                $array[$key] = $value;
            }
        } else {
            $array = $object;
        }
        return $array;
    }
    
    //对象列表转数组列表
    function objectsToArrays($data){  
        $newData=array();
        foreach($data as $key=>$val){  
            $newData[$key] = $val->attributes;  
        }  
        return $newData;  
    }
    
    //列表类型转换成树状类型
    public function getListTree($rows, $id=0,$idField='id',$pidField='pid') {
        // global $rows;
        $childs = array('list'=>array(),'ids'=>array(),'indexIds'=>array(),'lastId'=>array(),'indexLastId'=>array());
        foreach ($rows as $k => $v) {
            if ($v[$pidField] == $id) {
                $childs['list'][] = $v;
                $childs['ids'][] = $v[$idField];
                $childs['lastId'] =$v[$idField];
            }
        }
        if (empty($childs['list']))  return $childs;
        foreach ($childs['list'] as $k => $v) {
            $rescurTree = $this->getListTree($rows, $v[$idField]);
            if (null != $rescurTree['list']) {
                $childs['list'][$k]['child'] = $rescurTree;
            }
            //获取当前节点下的所有子节点并建立索引
            $childs['ids']=array_merge($childs['ids'], $rescurTree['ids']);
            $childs['indexIds'][$id]=$childs['ids'];
            $childs['indexIds'] += $rescurTree['indexIds'];
            
            //获取当前节点下的最后一个节点并建立索引
            if($rescurTree['lastId']){
                $childs['lastId']=$rescurTree['lastId'];
            }
            $childs['indexLastId'][$id]=$childs['lastId'];
            $childs['indexLastId'] += $rescurTree['indexLastId'];
        }
        return $childs;
    }
 
    
    //验证页面参数
    function getValidateParams($ruleIndex){
        $paramsArray=$this->getParams();//获取页面参数
        $rulesArray=$this->getRulesArray($ruleIndex);//获取验证规则
        $result=$this->paramsValidate($paramsArray,$rulesArray);//校验参数
        if($result['status']==200){
           $result['data']=$paramsArray;
        }
        return $result;
    }
    
    //获取页面参数
    function getParams(){
        /*
        if (Yii::$app->request->isPost) {
            return Yii::$app->request->post(); //获取页面参数
        } else if (Yii::$app->request->isGet) {
            return Yii::$app->request->get(); //获取页面参数
        }*/
        
        return array_merge(Yii::$app->request->post(),Yii::$app->request->get());
    }
    
    //远程服务调用
    function remoteRequest($url,$data=array(),$method='get'){
        
        $client = new Client();
        $request = $client->createRequest()
                ->setMethod($method)
                ->setUrl($url)
                ->setData($data);
        
        
         // 发送前触发事件  
        /*$request->on(Request::EVENT_BEFORE_SEND, function (RequestEvent $event) {
            $data = $event->request->getData();

            $signature = md5(http_build_query($data));
            $data['signature'] = $signature;

            $event->request->setData($data);
        });*/
        
        // 发送后响应数据  
        /*$request->on(Request::EVENT_AFTER_SEND, function (RequestEvent $event) {
            $data = $event->response->getData();

            $data['content'] = base64_decode($data['encoded_content']);

            $event->response->setData($data);
        });*/
        
        $response = $request->send();
        return $response->getData();//返回数组
        
    }
    
    //传入url参数数组返回sign字段值
    public function getSign($array) {
        unset($array['sign']);
        $query = '';
        //循环拼接加密参数
        foreach ($array as $key => $value) {
            $key =$key;
            $value = $value;
            $query .= "$key=$value&";
        }
        //去掉最后一个"&"符号
        if (strlen($query)) {
            $query = substr($query, 0, -1);
        }

        return sha1($query."&key=".Yii::$app->params['apiKey']);
    }

    //根据地名获取地图坐标
    public function getMapInfo($address){
        $map= Yii::$app->params['map'];
        $testArray=array(
            "address"=>$address,
            "output"=>"json",
            "ak"=>$map['ak'],
        );
        $mapArray=$this->remoteRequest($map['url'],$testArray);  
        return $mapArray;
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
