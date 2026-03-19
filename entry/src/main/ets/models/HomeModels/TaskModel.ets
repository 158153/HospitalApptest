// 目标数据模型
export interface TargetItem {
  id: string;
  title: string;
  progress: string; // 进度文本，如"已完成1/3"
  desc: string; // 描述文本，如"血糖偏高"
  extra: string; // 额外信息，如"今日步数 3601步"
}

// 事项数据模型
export interface TodoItem {
  id: string;
  title: string;
  desc: string; // 描述文本，如"还有3天"
  progress?: number; // 可选进度条值（0-1）
}

// 新增目标请求参数
export interface AddTargetParams {
  title: string;
  count: number; // 次数/步数
  remindDate?: string; // 提醒日期
}

// 新增事项请求参数
export interface AddTodoParams {
  title: string;
  remindDate?: string; // 提醒日期
}