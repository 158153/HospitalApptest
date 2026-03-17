
import { FollowupDetail, FollowupForm, FollowupRecord } from '../models/HomeModels/FollowupModel';

// 模拟随访记录列表数据 - 用于前端开发阶段的假数据，替代真实接口返回
const mockRecords: FollowupRecord[] = [
  {
    id: 'r1',               // 随访记录唯一标识
    time: '2026-2-21 14:30',// 随访时间
    type: '房颤随访',        // 随访类型（如房颤、糖尿病等）
    hospital: '中山大学附属第一医院', // 随访医院
    status: '已填写',       // 随访记录状态
    doctor: '李四 主任医师' // 随访医生
  },
  {
    id: 'r2',
    time: '2025-12-21 14:30',
    type: '房颤随访',
    hospital: '中山大学附属第一医院',
    status: '已填写',
    doctor: '李四 主任医师',
    result: '血糖稳定，继续保持' // 随访结果/结论
  },
  {
    id: 'r3',
    time: '2025-11-21 14:30',
    type: '房颤随访',
    hospital: '中山大学附属第一医院',
    status: '已填写',
    doctor: '李四 主任医师',
    result: '血糖稳定，继续保持'
  }
];

// 模拟随访详情数据 - 单条随访记录的详细信息，包含患者各项检查/生活习惯等
const mockDetail: FollowupDetail = {
  id: 'd1',                // 详情唯一标识
  name: '李建平',          // 患者姓名
  time: '2022-12-03 14:30',// 随访时间
  way: '随访问卷',         // 随访方式
  doctor: '刘志辉',        // 随访医生
  symptom: '多尿、视力模糊',// 患者症状
  vitalSigns: {            // 生命体征数据
    bloodPressure: '80/120mmHg', // 血压
    height: '174cm',            // 身高
    weight: '75kg',             // 体重
    targetWeight: '70kg',       // 目标体重
    bmi: '23.4kg/m²',           // 身体质量指数
    targetBmi: '23kg/m²',       // 目标BMI
    pulse: '正常',              // 脉搏
    other: '无'                 // 其他生命体征说明
  },
  lifeStyle: {             // 生活方式数据
    smoke: '6/2支',        // 吸烟情况（如：每日6支，已减至2支）
    drink: '12/5两',       // 饮酒情况
    exercise: '200kcal/267kcal' // 运动量（消耗卡路里）
  },
  mental: '良好',          // 精神状态
  compliance: '良好',      // 治疗依从性
  lab: {                   // 实验室检查数据
    fastingGlucose: '8.9mmol/L', // 空腹血糖
    randomGlucose: '8.7mmol/L',  // 随机血糖
    hba1c: '3%',                 // 糖化血红蛋白
    other: '无'                  // 其他检查结果
  },
  medication: {            // 用药情况
    adherence: '规律',     // 用药依从性
    adverseReaction: '无', // 药物不良反应
    hypoglycemia: '无',    // 低血糖情况
    drugs: ['预混胰岛素', '阿司匹林普通片', '[倍怡]氯沙坦钾片'], // 用药列表
    period: '2022/01/01-2023/06/01' // 用药周期
  },
  result: '血糖异常，建议复查' // 随访结论
};

// 模拟随访问卷模板数据 - 用于前端填写随访信息的表单初始值
const mockFormTemplate: FollowupForm = {
  id: 'f1',                // 表单唯一标识
  symptom: '',             // 症状（初始为空，供用户填写）
  vitalSigns: {            // 生命体征（预设默认值）
    bloodPressure: '80/120mmHg',
    height: '174cm',
    weight: '75kg',
    targetWeight: '70kg',
    bmi: '23.4kg/m²',
    targetBmi: '23kg/m²'
  },
  lifeStyle: {             // 生活方式（部分字段为空，供用户填写）
    exercise: ''
  },
  lab: {                   // 实验室检查（部分字段为空，供用户填写）
    maxBloodPressure: '',  // 最高血压
    minBloodPressure: '',  // 最低血压
    other: ''              // 其他检查说明
  },
  medication: {            // 用药情况（部分字段为空，供用户填写）
    adherence: '',         // 用药依从性
    adverseReaction: '',   // 不良反应
    drugs: ['阿司匹林普通片', '无', '无'], // 用药列表（预设部分值）
    period: '2025/12/21-2026/01/21', // 用药周期（预设）
    hypoglycemia: ""       // 低血糖情况
  }
};

// 随访相关API封装类 - 统一管理随访模块的所有接口调用，便于后续维护和替换真实接口
export class FollowupApi {
  // 获取随访记录列表
  // 返回Promise类型，模拟异步接口调用，延迟500ms返回模拟数据
  static async getFollowupRecords(): Promise<FollowupRecord[]> {
    return new Promise(resolve => {
      setTimeout(() => resolve(mockRecords), 500); // 模拟网络请求延迟
    });
  }

  // 获取随访详情
  // 参数id：随访记录的唯一标识，用于查询对应详情
  static async getFollowupDetail(id: string): Promise<FollowupDetail> {
    return new Promise(resolve => {
      setTimeout(() => resolve(mockDetail), 500);
    });
  }

  // 获取随访问卷模板
  // 参数id：表单模板ID，用于获取对应模板数据（当前暂返回固定模拟数据）
  static async getFollowupForm(id: string): Promise<FollowupForm> {
    return new Promise(resolve => {
      setTimeout(() => resolve(mockFormTemplate), 500);
    });
  }

  // 提交随访问卷
  // 参数form：用户填写完成的随访表单数据
  // 返回值：新增的随访记录（包含自动生成的ID、提交时间等）
  static async submitFollowupForm(form: FollowupForm): Promise<FollowupRecord> {
    // 构建新的随访记录对象
    const newRecord: FollowupRecord = {
      id: `r${Date.now()}`,  // 用时间戳生成唯一ID
      time: new Date().toLocaleString(), // 获取当前时间作为提交时间
      type: '房颤随访',
      hospital: '中山大学附属第一医院',
      status: '已填写',
      doctor: '李四 主任医师',
      result: '已完成问卷填写'
    };
    // 将新记录添加到模拟列表的首位（最新记录在前）
    mockRecords.unshift(newRecord);
    // 模拟异步提交，延迟返回新记录
    return new Promise(resolve => {
      setTimeout(() => resolve(newRecord), 500);
    });
  }
}

// 真实接口调用替换示例（后续替换为真实接口）
/*
import { http } from '@kit.NetworkKit'; // 导入项目的网络请求工具
export class FollowupApi {
  static async getFollowupRecords(): Promise<FollowupRecord[]> {
    // 调用真实HTTP接口，GET方式请求随访记录列表
    const res = await http.createHttp().request('https://your-api.com/followup/records', {
      method: http.RequestMethod.GET
    });
    // 将接口返回结果转换为FollowupRecord类型数组
    return res.result as FollowupRecord[];
  }
  // 其他接口同理替换...
}
*/