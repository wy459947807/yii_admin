<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "sys_nav".
 *
 * @property integer $id
 * @property integer $pid
 * @property string $name
 * @property integer $icon
 * @property string $path
 * @property integer $status
 * @property string $type
 * @property integer $sort
 * @property string $remark
 */
class SysNav extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sys_nav';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['pid', 'icon', 'status', 'sort'], 'integer'],
            [['type'], 'string'],
            [['name', 'path', 'remark'], 'string', 'max' => 255],
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
            'icon' => 'Icon',
            'path' => 'Path',
            'status' => 'Status',
            'type' => 'Type',
            'sort' => 'Sort',
            'remark' => 'Remark',
        ];
    }
}
