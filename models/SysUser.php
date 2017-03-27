<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "sys_user".
 *
 * @property integer $id
 * @property string $username
 * @property string $password
 * @property string $nickname
 * @property string $sex
 * @property string $mobile
 * @property string $email
 * @property string $role
 * @property string $createtime
 * @property integer $status
 * @property string $remark
 * @property string $access_token
 * @property string $auth_key
 * @property string $login_time
 * @property string $login_ip
 * @property integer $login_num
 */
class SysUser extends \yii\db\ActiveRecord implements \yii\web\IdentityInterface
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sys_user';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['username', 'password'], 'required'],
            [['sex'], 'string'],
            [['createtime', 'login_time'], 'safe'],
            [['status', 'login_num'], 'integer'],
            [['username', 'password', 'nickname', 'mobile', 'email', 'role', 'remark', 'access_token', 'auth_key', 'login_ip'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'username' => 'Username',
            'password' => 'Password',
            'nickname' => 'Nickname',
            'sex' => 'Sex',
            'mobile' => 'Mobile',
            'email' => 'Email',
            'role' => 'Role',
            'createtime' => 'Createtime',
            'status' => 'Status',
            'remark' => 'Remark',
            'access_token' => 'Access Token',
            'auth_key' => 'Auth Key',
            'login_time' => 'Login Time',
            'login_ip' => 'Login Ip',
            'login_num' => 'Login Num',
        ];
    }
    
     /**
     * Generates password hash from password and sets it to the model
     *
     * @param string $password
     */
    public function setPassword($password)
    {
        $this->password = md5($password);
}
    /**
     * @inheritdoc
     */
    public static function findIdentity($id)
    {
        return static::findOne($id);
        //return isset(self::$users[$id]) ? new static(self::$users[$id]) : null;
    }

    /**
     * @inheritdoc
     */
    public static function findIdentityByAccessToken($token, $type = null)
    {
        return static::findOne(['access_token' => $token]);
        /*foreach (self::$users as $user) {
            if ($user['accessToken'] === $token) {
                return new static($user);
            }
        }

        return null;*/
    }

    /**
     * Finds user by username
     *
     * @param  string      $username
     * @return static|null
     */
    public static function findByUsername($username)
    {
        $user = static::find()
            ->where(['username' => $username,"status"=>1])
            ->asArray()
            ->one();

        if($user){
            return new static($user);
        }
        return null;
    }

    /**
     * @inheritdoc
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @inheritdoc
     */
    public function getAuthKey()
    {
        return $this->auth_key;
    }

    /**
     * @inheritdoc
     */
    public function validateAuthKey($authKey)
    {
        return $this->auth_key === $authKey;
    }

    /**
     * Validates password
     *
     * @param  string  $password password to validate
     * @return boolean if password provided is valid for current user
     */
    public function validatePassword($password)
    {
        return $this->password === md5($password);
    }
    
    
}
