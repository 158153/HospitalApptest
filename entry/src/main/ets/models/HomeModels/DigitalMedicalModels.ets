// 电子病历数据模型
export interface MedicalRecord {
  id: string; // 唯一标识
  name: string; // 姓名
  gender: string; // 性别
  age: number; // 年龄
  visitTime: string; // 就诊时间
  source: string; // 病历来源
}