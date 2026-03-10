import {
  TargetItemParams,
  MedicineRecordItem,
  BloodSugarRecordItem,
  DietRecordItem,
  ExerciseRecordItem
} from './Task';

// 每日健康目标列表
export const mockTargetItems: TargetItemParams[] = [
  {
    title: "血糖监测（未完成0/5）",
    subTitle: "已坚持0天 血糖保持稳定",
    rightText: "空腹前测血糖",
    rightSubText: "mmol/L",
    type: 'bloodSugar'
  },
  {
    title: "药品记录（已完成0/3）",
    subTitle: "早餐前服药",
    rightText: "阿司匹林普通片",
    rightSubText: "一次3片 口服",
    rightSubColor: "#00B578",
    type: 'medicine'
  },
  {
    title: "饮食记录（已完成0/3）",
    subTitle: "还可以吃1832千卡",
    rightText: "早餐摄入",
    rightSubText: "368千卡",
    rightSubColor: "#00B578",
    type: 'diet'
  },
  {
    title: "每日运动（0/275千卡）",
    subTitle: "已坚持0天 时长3h20min",
    rightText: "今日步数",
    rightSubText: "2,461步",
    rightSubColor: "#00B578",
    type: 'exercise'
  }
];

// 药品记录
export const mockMedicineRecords: MedicineRecordItem[] = [
  { time: "早餐前", name: "阿司匹林普通片", dosage: "一次3片 口服", isCompleted: true },
  { time: "早餐后", name: "二甲双胍", dosage: "一次3片 口服", isCompleted: true },
  { time: "午餐前", name: "阿司匹林普通片", dosage: "一次3片 口服", isCompleted: false },
  { time: "午餐后", name: "二甲双胍", dosage: "一次3片 口服", isCompleted: false },
  { time: "晚餐前", name: "阿司匹林普通片", dosage: "一次3片 口服", isCompleted: false },
  { time: "晚餐后", name: "二甲双胍", dosage: "一次3片 口服", isCompleted: false }
];

// 血糖记录
export const mockBloodSugarRecords: BloodSugarRecordItem[] = [
  { time: "空腹", value: "未测量", unit: "mmol/L", isCompleted: false },
  { time: "早餐后2小时", value: "未测量", unit: "mmol/L", isCompleted: false },
  { time: "午餐前", value: "未测量", unit: "mmol/L", isCompleted: false },
  { time: "午餐后2小时", value: "未测量", unit: "mmol/L", isCompleted: false },
  { time: "晚餐前", value: "未测量", unit: "mmol/L", isCompleted: false }
];

// 饮食记录
export const mockDietRecords: DietRecordItem[] = [
  { mealType: "早餐", intake: "包子+豆浆", calorie: "368千卡", isCompleted: true },
  { mealType: "午餐", intake: "未记录", calorie: "0千卡", isCompleted: false },
  { mealType: "晚餐", intake: "未记录", calorie: "0千卡", isCompleted: false }
];

// 运动记录
export const mockExerciseRecords: ExerciseRecordItem[] = [
  { type: "步行", duration: "30分钟", calorie: "85千卡", isCompleted: true },
  { type: "慢跑", duration: "0分钟", calorie: "0千卡", isCompleted: false },
  { type: "太极", duration: "0分钟", calorie: "0千卡", isCompleted: false }
];