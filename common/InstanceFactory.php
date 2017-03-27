<?php

namespace app\common;

use ReflectionClass;

class InstanceFactory
{

    private $_instanceList = array();
    private static $_instance = null;
    
    public static function getInstance($name)
    {
      
        if (empty (self::$_instance )) {
	        $class = __CLASS__;
	        self::$_instance = new $class ();
	    }
	    
	    $factoryInstance=self::$_instance;
	    
	    if (!isset($factoryInstance->_instanceList[$name])){
	        $n = new ReflectionClass($name);
	        if (!$n->hasMethod('getInstance')){
	            $factoryInstance->_instanceList[$name] = new $name();
	        }else{
	            $me_instance = $n->getMethod('getInstance');
	            $factoryInstance->_instanceList[$name] = $me_instance->invoke($n);
	        }
	    }
	    return $factoryInstance->_instanceList[$name];
    }
}