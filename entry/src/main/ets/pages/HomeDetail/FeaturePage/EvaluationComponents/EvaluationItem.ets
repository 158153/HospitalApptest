/**
 * 评估记录列表项组件
 * 功能：展示单条健康评估记录的核心信息（患者基本信息、评估时间、评估结果）
 * 适用场景：评估记录列表页中循环渲染每条记录
 */

// 定义组件属性接口，约束传入的参数类型，增强代码健壮性
interface EvaluationItemProps {
  name: string; // 患者姓名
  gender: string; // 患者性别
  age: number; // 患者年龄
  evaluateTime: string; // 评估时间（格式：YYYY-MM-DD HH:MM）
  result: string; // 评估核心结果
}

@Component
export struct EvaluationItem {
  // 组件内部私有属性，接收外部传入的参数
  private name: string = '';
  private gender: string = '';
  private age: number = 0;
  private evaluateTime: string = '';
  private result: string = '';

  build() {
    // 外层Row：横向布局整个列表项
    Row() {
      // 左侧内容区：占满剩余宽度
      Column() {
        // 第一行：患者基本信息（姓名+性别+年龄）
        Row() {
          Text(`${this.name}  ${this.gender}  ${this.age}岁`)
            .fontSize(18)          // 字体大小
            .fontWeight(FontWeight.Medium) // 字体加粗
        }
        .width('100%') // 占满父容器宽度
        .margin({ bottom: 12 }) // 底部间距

        // 第二行：评估时间 + 评估结果（左右分布）
        Row() {
          // 左侧：评估时间
          Text(`评估时间: ${this.evaluateTime}`)
            .fontSize(14)          // 字体大小
            .fontColor('#666666') // 浅灰色字体

          // 空白占位：推挤右侧内容到最右
          Blank()

          // 右侧：评估结果
          Text(`评估结果: ${this.result}`)
            .fontSize(14)          // 字体大小
            .fontColor('#333333') // 深灰色字体
        }
        .width('100%') // 占满父容器宽度
      }
      .layoutWeight(1) // 占满Row剩余宽度
      .padding({
        // 内边距
        top: 16,
        bottom: 16,
        left: 16,
        right: 16
      })

      // 右侧箭头图标：表示可点击进入详情
      Image($r('app.media.ic_public_arrow_left')) // 替换为实际右箭头图标资源
        .width(20)                 // 图标宽度
        .height(20)                // 图标高度
        .margin({ right: 16 }) // 右侧间距
    }
    .width('100%') // 占满屏幕宽度
    .backgroundColor('#FFFFFF') // 白色背景
  }
}