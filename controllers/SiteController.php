<?php

namespace app\controllers;

use app\common\ValidateCode;
use app\models\SysUser;

use Yii;
use yii\filters\AccessControl;
class SiteController extends CommonController implements CommonInterface{

    //访问过滤
    public function behaviors() {
        return [
            'access' => [
                'class' => AccessControl::className(), //登录状态过滤器
                'except' => ['captcha','login','error','test'],   
                'rules' => [
                        [
                        'actions' => ['logout', 'index','welcome'],
                        'allow' => true,
                        'roles' => ['@'],
                    ]
                ],
            ],
           
        ];
    }
    
    public function init(){
        parent::init();
        $this->registService("NavService");//注册权限验证服务
        $this->registService("UserService");//注册菜单服务
        $this->registService("RbacService");//注册权限验证服务
        $this->registService("Rbac","app\common\\");//注册菜单服务
    }
    
    
    public function actionIndex(){
        
        $userInfo=Yii::$app->user->getIdentity();//用户登录信息
        $assignList=$this->getService("Rbac")->getAssignList($userInfo->id);
      
        
        $navIcon=Yii::$app->params['navIcon'];//获取图标列表
        $navList=$this->getService("NavService")->getNavList();//获取菜单列表
        $navArray=$this->objectsToArrays($navList['data']);//类型转换
        $navTree=$this->getListTree($navArray);
        $resultInfo['navIcon']=$navIcon;
        $resultInfo['navTree']=$navTree;
        $resultInfo['assignList']=$assignList;
        return $this->render('index.tpl',$resultInfo);
    }
    
    //登录欢迎页面
    public function actionWelcome(){


        $userInfo=Yii::$app->user->getIdentity();//用户登录信息
        $serviceInfo=array();//服务器信息
        
        $serviceInfo["serverName"]      =$_SERVER['SERVER_NAME'];           //服务器名称
        $serviceInfo["serverAddr"]      =$_SERVER['SERVER_ADDR'];           //服务器ip地址
        $serviceInfo["httpHost"]        =$_SERVER['HTTP_HOST'];             //服务器域名
        $serviceInfo["serverPort"]      =$_SERVER['SERVER_PORT'];           //服务器端口
        $serviceInfo["serverSoftware"]  =$_SERVER['SERVER_SOFTWARE'];       //服务器版本
        $serviceInfo["documentRoot"]    =$_SERVER['DOCUMENT_ROOT'];         //本文件所在文件夹
        $serviceInfo["operateSystem"]   =PHP_OS;                            //操作系统
        $serviceInfo["SystemRoot"]      =$_SERVER['SystemRoot'];            //系统所在文件夹
        $serviceInfo["executionTime"]   =get_cfg_var("max_execution_time"); //服务器脚本超时时间(秒)
        $serviceInfo["language"]        =$_SERVER['HTTP_ACCEPT_LANGUAGE'];  //服务器的语言种类
        $serviceInfo["phpVersion"]      =PHP_VERSION;                       //php版本    
        $serviceInfo["serverTime"]      =date('Y-m-d H:i:s',time());        //服务器时间
        $serviceInfo["browserVersion"]  =$_SERVER['HTTP_USER_AGENT'];       //浏览器版本

        $resultInfo['serviceInfo']  =$serviceInfo;
        $resultInfo['userInfo']     =$userInfo;
         
        return $this->render('welcome.tpl',$resultInfo);//加载页面
    }

    //后台登录
    public function actionLogin(){

        //页面操作
        if(Yii::$app->request->isPost){
 
            $params=$this->getValidateParams('login');
            if($params['status']!=200){
                return $this->asJson($params);
            }
            $postArray=$params['data'];
            
            //判断验证码
            if($postArray['code']!=\Yii::$app->session['ValidateCode']){
                $this->result['status']=500;
                $this->result['info']="验证码错误！";
                return $this->asJson($this->result);    
            }
            
            $userInfo=SysUser::findByUsername($postArray['username']);
            if(empty($userInfo)){
                $this->result['status']=500;
                $this->result['info']="用户不存在！";
                return $this->asJson($this->result);     
            }
            
            if(!$userInfo->validatePassword($postArray['password'])){
                $this->result['status']=500;
                $this->result['info']="密码错误！";
                return $this->asJson($this->result); 
            }
            
            //登录操作
            Yii::$app->user->login($userInfo, isset($postArray['remember']) ? 3600*24*30 : 0);
            
            $loginInfo=array(
                "id"=>$userInfo->id,
                "login_time"=>date("Y-m-d H:i:s"),
                "login_ip"=>Yii::$app->request->getUserIP(),
                "login_num"=>$userInfo->login_num+1,
            );
            $this->getService("UserService")->updateUser($loginInfo);
            
            
            $this->result['status']=200;
            $this->result['info']="登录成功！";
            return $this->asJson($this->result);
        }
        
        //页面数据
        if (!Yii::$app->user->isGuest) {
            return $this->goHome();
        } 
        
        return $this->render('login.tpl',array());//加载页面
        
    }
    
    //测试页面
    public function actionTest() {
        /*
        $this->getService("Rbac")->createPermission(array("name"=>"/666/777","description"=>"简单描述1"));//创建访问许可
        $this->getService("Rbac")->createRole(array("name"=>"普通用户","description"=>"简单描述2"));//创建角色
        $this->getService("Rbac")->createEmpowerment("普通用户","/666/777");//给角色分配许可
        $this->getService("Rbac")->assign("普通用户",3);//给角色分配用户
       
        $this->getService("Rbac")->delAssign("普通用户",3);//取消用户分配
        $this->getService("Rbac")->delEmpowerment("普通用户","/666/777");//删除角色许可
        $this->getService("Rbac")->delRolePermission("/666/777");//删除许可
        $this->getService("Rbac")->delRolePermission("普通用户");//删除角色
        $this->getService("Rbac")->updateRolePermission("普通用户",array("name"=>"普通用户1","description"=>"简单描述1"));//更新角色(许可)
        */
    
        
     

       return $this->render('test.tpl',array());
    }

    //退出登录
    public function actionLogout(){
        Yii::$app->user->logout();
        return $this->goHome();
    }
   
    //错误页面
    public function actionError(){
        return $this->render('error.tpl',array());
    }

    //验证码
    public function actionCaptcha(){
        $ValidateCode = new ValidateCode();  //实例化一个对象
        $ValidateCode->doimg(); 
        \Yii::$app->session['ValidateCode']=$ValidateCode->getCode();
    }

    //获取参数规则
    public function getRulesArray($ruleIndex){
        
        $result['login']=array(   
            /*
            array('contact','required','on'=>'edit','message'=>'联系人必须填写.'),   
            //array('contact','length','on'=>'edit','min'=>2,'max'=>10,'tooShort'=>'联系人长度请控制在2-10个字符.','tooLong'=>'联系人长度请控制在2-10个字符.'),   

            array('tel', 'match','pattern' => '/^(\d{3}-|\d{4}-)(\d{8}|\d{7})?$/','message' => '请输入正确的电话号码.'),   
            array('fax', 'match','pattern' => '/^(\d{3}-|\d{4}-)(\d{8}|\d{7})?$/','message' => '请输入正确的传真号码.'),   
            array('mobile', 'match','pattern' => '/^13[0-9]{1}[0-9]{8}$|15[0189]{1}[0-9]{8}$|189[0-9]{8}$/','message' => '请输入正确的手机号码.'),   

            array('email','email','on'=>'edit','message'=>'邮箱输入有误.'),   

            array('zipcode','required','on'=>'edit','message'=>'邮编必须填写.'),   
            //array('zipcode','numerical','on'=>'edit','message'=>'邮编是6位数字.'),   
            //array('zipcode','length','on'=>'edit','min'=>6,'max'=>6,'tooShort'=>'邮编长度为6位数.','tooLong'=>'邮编长度为6位数.'),   

            array('website','url','on'=>'edit','message'=>'网址输入有误.'),   
            array('qq', 'match','pattern' => '/^[1-9]{1}[0-9]{4,11}$/','message' => '请输入正确的QQ号码.'),   
            array('msn','email','on'=>'edit','message'=>'MSN输入有误.'),   
            array('status', 'in', 'range'=>array(1,2,3)),  
             * 
             */
        );
        
        return $result[$ruleIndex];
    }
   
}
