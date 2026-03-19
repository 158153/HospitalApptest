// 导入添加目标所需的参数类型定义
import { AddTargetParams } from '../../../../models/HomeModels/TaskModel';

// 声明添加目标弹窗组件（导出供外部使用）
@Component
export struct AddTargetDialog {
  // 响应式状态：目标标题
  @State title: string = '';
  // 响应式状态：目标次数/步数
  @State count: number = 0;
  // 响应式状态：提醒日期（格式化后的字符串）
  @State remindDate: string = '';
  // 响应式状态：控制日期选择器的显示/隐藏
  @State showDatePicker: boolean = false;
  // 确认回调函数：给默认空实现避免初始化报错，外部调用时传入实际逻辑
  onConfirm: (params: AddTargetParams) => void = () => {
  };
  // 取消回调函数：默认空实现，外部传入关闭弹窗的逻辑
  onCancel: () => void = () => {
  };

  // 组件UI构建函数
  build() {
    // 根容器：垂直布局
    Column({ space: 0 }) {
      // 弹窗头部（返回按钮 + 标题 + 占位元素）
      Row() {
        // 返回/取消按钮：点击触发外部传入的取消回调
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => this.onCancel())
        // 弹窗标题
        Text('添加目标')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1) // 占满剩余空间，实现标题居中
          .textAlign(TextAlign.Center)
        // 占位元素：平衡布局，保证标题居中
        Text('')
          .width(24)
      }
      .width('100%')
      .padding(12)
      // 修复点：使用border属性精准设置仅底部边框（替代原borderBottom）
      .border({
        width: { bottom: 0.5 },
        color: '#eee'
      })

      // 目标标题输入框
      TextInput({ placeholder: '输入目标...' })
        .width('95%')
        .height(48)
        .padding(8)
        .margin({ top: 12 })
        .onChange((value: string) => this.title = value) // 实时更新标题状态

      // 次数/步数输入行
      Row() {
        // 输入提示文本
        Text('添加次数')
          .fontSize(14)
          .fontColor('#333')
        // 数字输入框：限制仅能输入数字
        TextInput({ placeholder: '请输入次数' })
          .width(200)
          .height(36)
          .type(InputType.Number) // 输入类型为数字
          .margin({ left: 12 })
          // 实时更新次数状态：转换为数字，非数字则设为0
          .onChange((value: string) => this.count = parseInt(value) || 0)
        // 单位文本
        Text('次')
          .fontSize(14)
          .fontColor('#666')
          .margin({ left: 4 })
      }
      .width('95%')
      .padding(12)
      .margin({ top: 12 })
      .borderRadius(8)
      .backgroundColor('#F5F5F5') // 浅灰色背景区分输入区域

      // 提醒日期设置行
      Row() {
        // 日历图标
        Image($r('app.media.icon_home_bjsb'))
          .width(20)
          .height(20)
          .margin({ right: 8 })
        // 设置提醒文本
        Text('设置提醒日期')
          .fontSize(14)
          .fontColor('#333')
          .layoutWeight(1) // 占满剩余空间，让复选框右对齐
        // 复选框：控制是否开启提醒
        Checkbox()
          .select(this.remindDate !== '') // 有日期则选中，无则未选中
          .onChange((value: boolean) => {
            if (value) {
              this.showDatePicker = true;
            } // 选中时打开日期选择器
            else {
              this.remindDate = '';
            } // 取消选中时清空提醒日期
          })
      }
      .width('95%')
      .padding(12)
      .margin({ top: 12 })
      .borderRadius(8)
      .backgroundColor('#F5F5F5')

      // 已选日期显示：有提醒日期时才渲染
      if (this.remindDate) {
        Text(this.remindDate)
          .fontSize(14)
          .fontColor('#666')
          .width('100%')
          .padding(12)
      }

      // 确认按钮
      Button('确定')
        .width('90%')
        .height(44)
        .margin({ top: 24 })
        .backgroundColor('#fff67ea9')
        .fontColor(Color.White)
        .fontSize(16)
        .onClick(() => {
          // 校验：标题为空或次数<=0时不触发确认
          if (!this.title || this.count <= 0) {
            return;
          }
          // 触发确认回调，传入组装好的参数
          this.onConfirm({
            title: this.title,
            count: this.count,
            remindDate: this.remindDate
          });
        })

      // 日期选择器：条件渲染（showDatePicker为true时显示）
      // 修复点：用Column包裹DatePicker，解决布局兼容问题
      if (this.showDatePicker) {
        Column() {
          DatePicker({
            selected: new Date() // 默认选中当前日期
          })
          // 日期选择变更时的回调
            .onChange((value: DatePickerResult) => {
              // 格式化选中的日期为「年-月-日」格式
              this.remindDate = `${value.year}年${value.month}月${value.day}日`;
              this.showDatePicker = false; // 选择后关闭日期选择器
            })
        }
        .width('100%')
      }
    }
    // 弹窗容器样式：90%宽度、白色背景、圆角、底部内边距
    .width('80%')
    .borderRadius(20)
    .backgroundColor('#ffeae7e7')
    .padding({ bottom: 24 })
  }
}