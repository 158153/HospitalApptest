// 随访记录卡片数据模型
export interface FollowupRecord {
  id: string;
  time: string;
  type: string;
  hospital: string;
  status: '已填写' | '待填写';
  doctor: string;
  result?: string;
}

// 生命体征子模型
export interface VitalSigns {
  bloodPressure: string;
  height: string;
  weight: string;
  targetWeight: string;
  bmi: string;
  targetBmi: string;
  pulse: string;
  other: string;
}

// 生活方式子模型
export interface LifeStyle {
  smoke: string;
  drink: string;
  exercise: string;
}

// 实验室检查子模型
export interface LabData {
  fastingGlucose?: string;
  randomGlucose?: string;
  hba1c?: string;
  other: string;
}

// 用药情况子模型
export interface Medication {
  adherence: string;
  adverseReaction: string;
  hypoglycemia: string;
  drugs: string[];
  period: string;
}

// 随访详情数据模型
export interface FollowupDetail {
  id: string;
  name: string;
  time: string;
  way: string;
  doctor: string;
  symptom: string;
  vitalSigns: VitalSigns;
  lifeStyle: LifeStyle;
  mental: string;
  compliance: string;
  lab: LabData;
  medication: Medication;
  result: string;
}

// 随访问卷-生命体征子模型
export interface FormVitalSigns {
  bloodPressure: string;
  height: string;
  weight: string;
  targetWeight: string;
  bmi: string;
  targetBmi: string;
}

// 随访问卷-生活方式子模型
export interface FormLifeStyle {
  exercise: string;
}

// 随访问卷-实验室检查子模型
export interface FormLabData {
  maxBloodPressure: string;
  minBloodPressure: string;
  other: string;
}

// 随访问卷-用药情况子模型（复用 Medication 即可）
export interface FormMedication extends Medication {}

// 随访问卷表单模型
export interface FollowupForm {
  id: string;
  symptom: string;
  vitalSigns: FormVitalSigns;
  lifeStyle: FormLifeStyle;
  lab: FormLabData;
  medication: FormMedication;
}