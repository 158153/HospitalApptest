/**
 * 健康评估列表页面
 * 核心功能：
 * 1. 展示用户历史健康评估记录列表
 * 2. 提供"开始评估"按钮，跳转至病情描述与AI预测页面
 * 3. 支持返回上一级页面
 */

// 导入路由模块：用于页面跳转（返回上一页/跳转到评估输入页）
import router from '@ohos.router';
// 导入自定义列表项组件：用于渲染单条评估记录
import { EvaluationItem } from '../FeaturePage/EvaluationComponents/EvaluationItem';

// 定义评估记录数据结构接口：约束每条记录的字段类型，增强代码健壮性
interface EvaluationRecord {
  name: string; // 患者姓名
  gender: string; // 患者性别
  age: number; // 患者年龄
  evaluateTime: string; // 评估时间（格式：YYYY-MM-DD HH:MM）
  result: string; // 评估核心结果（如：房颤可能性较大）
}

// 页面入口组件：@Entry标记为应用入口页，@Component为自定义组件
@Entry
@Component
struct EvaluationPage {
  // 状态变量：存储历史评估记录列表，@State标记为响应式变量（数据变化自动更新UI）
  @State evaluationRecords: EvaluationRecord[] = [
    // 模拟历史评估数据1
    {
      name: '张三',
      gender: '男',
      age: 78,
      evaluateTime: '2026-01-21 14:30',
      result: '房颤可能性较大'
    },
    // 模拟历史评估数据2
    {
      name: '张三',
      gender: '男',
      age: 78,
      evaluateTime: '2025-06-21 14:30',
      result: '房颤可能性较大'
    }
  ];

  // 构建UI布局的核心方法
  build() {
    // 根容器：纵向布局（Column），占满全屏宽度和高度
    Column() {
      // ========== 顶部导航栏模块 ==========
      Row() {
        // 返回按钮：点击返回上一级页面
        Image($r('app.media.ic_public_arrow_left')) // 替换为项目实际返回图标资源
          .width(24)                 // 图标宽度
          .height(24)                // 图标高度
          .onClick(() => { // 点击事件
            router.back(); // 路由返回上一页
          })
        // 页面标题
        Text('健康评估')
          .fontSize(20)              // 字体大小
          .fontWeight(FontWeight.Medium) // 字体加粗
          .margin({ left: 16 }) // 左侧间距
      }
      .width('100%') // 占满屏幕宽度
      .height(60) // 导航栏高度
      .padding({ left: 16 }) // 左侧内边距
      .backgroundColor('#E8F4F5') // 浅蓝背景色

      // ========== 评估记录列表模块 ==========
      List() { // 列表容器：用于展示多条数据
        // 循环渲染列表项：ForEach(数据源, 项构建函数, 唯一标识函数)
        ForEach(
          this.evaluationRecords, // 数据源：历史评估记录数组
          (item: EvaluationRecord, index: number) => { // 项构建函数：处理每条数据
            ListItem() { // 列表项容器：List的子项必须用ListItem包裹
              // 引用自定义列表项组件，传递当前记录的字段作为属性
              EvaluationItem({
                name: item.name,
                gender: item.gender,
                age: item.age,
                evaluateTime: item.evaluateTime,
                result: item.result
              })
            }
            // 列表项样式：仅添加底部边框（分割线效果）
            .border({
              width: { bottom: 1 }, // 仅底部有边框，宽度0.5px
              color: '#E5E5E5'       // 边框颜色：浅灰色
            })

          }
          // 【可选优化】添加唯一标识函数，提升列表渲染性能
          // (item, index) => index.toString()
        )
      }
      .margin({ top: 15 })
      .width('95%') // 列表占满屏幕宽度
      .layoutWeight(1) // 占满剩余垂直空间（挤压底部按钮到最下方）

      // ========== 底部"开始评估"按钮模块 ==========
      Button('开始评估')
        .width('40%')                // 按钮宽度（屏幕宽度的40%）
        .height(48)                  // 按钮高度
        .backgroundColor('#B4D8D8')  // 按钮背景色（浅青色）
        .fontSize(16)                // 按钮文字大小
        .fontColor('#000000')        // 按钮文字颜色（黑色）
        .borderRadius(15)             // 按钮圆角（8px）
        .margin({ bottom: 35 })      // 底部间距（24px）
        .onClick(() => { // 点击事件：跳转至病情描述页面
          router.pushUrl({
            // 目标页面路由地址：根据项目实际目录结构调整
            url: 'pages/HomeDetail/FeaturePage/EvaluationComponents/EvaluationInputPage'
          });
        })
    }
    .width('100%') // 根容器占满屏幕宽度
    .height('100%') // 根容器占满屏幕高度
    .backgroundColor('#F5F5F5') // 页面背景色（浅灰色）
  }
}