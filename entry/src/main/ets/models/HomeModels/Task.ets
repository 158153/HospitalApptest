/**
 * 健康目标条目参数接口 - TargetItemParams
 * 描述：定义TargetItem构建器所需的参数类型，统一条目数据格式
 */
export interface TargetItemParams {
  /** 条目主标题（如：血糖监测（未完成0/5）） */
  title: string;

  /** 条目副标题（补充说明，如：已坚持0天 血糖保持稳定） */
  subTitle: string;

  /** 右侧主文本（核心数据/操作说明，如：空腹前测血糖） */
  rightText: string;

  /** 右侧子文本（辅助说明/单位，如：mmol/L） */
  rightSubText: string;

  /** 右侧子文本颜色（可选，默认#333333，成功态用#00B578） */
  rightSubColor?: string;
  type?: 'bloodSugar' | 'medicine' | 'diet' | 'exercise' | 'custom'; // 新增类型标识
}

export enum DialogType {
  BLOOD_SUGAR = 'bloodSugar',
  MEDICINE = 'medicine',
  DIET = 'diet',
  EXERCISE = 'exercise',
  CUSTOM = 'custom'
}

/**
 * 药品记录条目接口 - MedicineRecordItem
 * 描述：定义药品弹框中每条用药记录的数据结构
 */
export interface MedicineRecordItem {
  /** 用药时间（如：早餐前） */
  time: string;

  /** 药品名称 */
  name: string;

  /** 用药剂量与方式 */
  dosage: string;

  /** 是否已完成服药 */
  isCompleted: boolean;
}

/**
 * 血糖记录项
 */
export interface BloodSugarRecordItem {
  time: string;
  value: string;
  unit: string;
  isCompleted: boolean;
}

/**
 * 饮食记录项
 */
export interface DietRecordItem {
  mealType: string;
  intake: string;
  calorie: string;
  isCompleted: boolean;
}

/**
 * 运动记录项
 */
export interface ExerciseRecordItem {
  type: string;
  duration: string;
  calorie: string;
  isCompleted: boolean;
}

/**
 * 弹框数据类型
 */
export interface DialogData {
  type: 'bloodSugar' | 'medicine' | 'diet' | 'exercise' | 'custom';
  title: string;
  data: MedicineRecordItem[] | BloodSugarRecordItem[] | DietRecordItem[] | ExerciseRecordItem[];
}


