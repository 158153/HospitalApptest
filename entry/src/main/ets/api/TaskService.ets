import { AddTargetParams, AddTodoParams, TargetItem, TodoItem } from '../models/HomeModels/TaskModel';

// 模拟API延迟 - 显式指定Promise泛型参数
const mockDelay = (ms: number = 800): Promise<void> => {
  return new Promise<void>((resolve) => setTimeout(resolve, ms));
};

// 生成唯一ID - 显式指定返回类型
const generateId = (): string => {
  return Date.now().toString(36) + Math.random().toString(36).substr(2);
};

// 计算事项描述（根据日期差）- 显式指定返回类型
const calcTodoDesc = (date: string): string => {
  const now = new Date();
  const target = new Date(date);
  const diffTime = target.getTime() - now.getTime();
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
  return diffDays > 0 ? `还有${diffDays}天` : '已过期';
};

export class TaskService {
  // 模拟获取初始目标数据 - 显式指定Promise泛型参数
  async getTargetList(): Promise<TargetItem[]> {
    await mockDelay();
    return [
      {
        id: generateId(),
        title: '药品记录',
        progress: '已完成1/3',
        desc: '未到服药时间',
        extra: '下一次：阿司匹林普通片 未服药'
      },
      {
        id: generateId(),
        title: '血糖监测',
        progress: '已完成1/3',
        desc: '血糖偏高',
        extra: '空腹前测量 7.3 mmol/L'
      },
      {
        id: generateId(),
        title: '每日运动',
        progress: '已完成35%',
        desc: '已坚持7天',
        extra: '今日步数 3601步'
      }
    ];
  }

  // 模拟获取初始事项数据 - 显式指定Promise泛型参数
  async getTodoList(): Promise<TodoItem[]> {
    await mockDelay();
    return [
      {
        id: generateId(),
        title: '2026年4月15日：医院体检',
        desc: '还有3天'
      },
      {
        id: generateId(),
        title: '降压药请及时补充',
        desc: '预计还有3次吃完',
        progress: 0.2
      }
    ];
  }

  // 模拟添加目标 - 显式指定Promise泛型参数
  async addTarget(params: AddTargetParams): Promise<TargetItem> {
    await mockDelay();
    return {
      id: generateId(),
      title: params.title,
      progress: `已完成0/${params.count}`,
      desc: '未开始',
      extra: params.remindDate ? `提醒时间：${params.remindDate}` : '无提醒'
    };
  }

  // 模拟添加事项 - 显式指定Promise泛型参数
  async addTodo(params: AddTodoParams): Promise<TodoItem> {
    await mockDelay();
    return {
      id: generateId(),
      title: params.title,
      desc: params.remindDate ? calcTodoDesc(params.remindDate) : '无提醒',
      progress: params.title.includes('药') ? 0.1 : undefined
    };
  }
}