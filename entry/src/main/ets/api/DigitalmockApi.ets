//模拟电子病历 # 模拟API数据
import { MedicalRecord } from '../models/HomeModels/DigitalMedicalModels';

// 模拟API请求延迟（显式指定Promise泛型类型）
const delay = (ms: number): Promise<void> => new Promise(resolve => setTimeout(resolve, ms));

// 模拟获取病历列表API
export const fetchMedicalRecords = async (): Promise<MedicalRecord[]> => {
  await delay(500); // 模拟网络请求
  return [
    {
      id: '1',
      name: '张三',
      gender: '男',
      age: 78,
      visitTime: '2026-01-21 14:30',
      source: '中山大学附属第一医院'
    },
    {
      id: '2',
      name: '张三',
      gender: '男',
      age: 78,
      visitTime: '2025-06-21 14:30',
      source: '中山大学附属第一医院'
    }
  ];
};

// 模拟解析病历API（拍照上传后调用）
// 1. 给未使用的image参数加下划线前缀，告诉ArkTS这是有意忽略的参数
// 2. 或者在函数体内使用该参数（比如打日志）
export const parseMedicalRecord = async (_image: string): Promise<MedicalRecord> => {
  await delay(2000); // 模拟解析耗时
  return {
    id: Date.now().toString(),
    name: '张三',
    gender: '男',
    age: 78,
    visitTime: new Date().toISOString().slice(0, 19).replace('T', ' '),
    source: '拍照上传解析'
  };
};