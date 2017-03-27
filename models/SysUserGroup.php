<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "sys_user_group".
 *
 * @property integer $id
 * @property integer $pid
 * @property string $name
 * @property integer $sort
 * @property string $remark
 *
 * @property SysUser[] $sysUsers
 */
class SysUserGroup extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sys_user_group';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['pid', 'sort'], 'integer'],
            [['name', 'remark'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'pid' => 'Pid',
            'name' => 'Name',
            'sort' => 'Sort',
            'remark' => 'Remark',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getSysUsers()
    {
        return $this->hasMany(SysUser::className(), ['role' => 'name']);
    }
}
