import { AddTodoParams } from '../../../../models/HomeModels/TaskModel';

@Component
export struct AddTodoDialog {
  // 本地状态：待办标题
  @State title: string = '';
  // 本地状态：提醒日期
  @State remindDate: string = '';
  // 本地状态：控制日期选择器显示
  @State showDatePicker: boolean = false;
  // 修正：将 @BuilderParam 改为普通函数类型，用于事件回调
  onConfirm: (params: AddTodoParams) => void = () => {
  };
  onCancel: () => void = () => {
  };

  /**
   * 封装日期显示组件
   * 仅当remindDate有值时展示选中日期
   */
  @Builder
  RemindDateBuilder() {
    if (this.remindDate) {
      Text(this.remindDate)
        .fontSize(14)
        .fontColor('#666')
        .width('100%')
        .padding(12)
    }
  }

  /**
   * 封装日期选择器组件
   * 修复点1：解决 value.month 可能为 undefined 的类型报错
   * 修复点2：保持UI逻辑仅在build上下文内
   */
  @Builder
  DatePickerBuilder() {
    if (this.showDatePicker) {
      DatePicker({
        selected: new Date()
      })
        .onChange((value: DatePickerResult) => {
          // 非空断言 + 安全取值：解决 month 可能 undefined 的报错
          const month = value.month ?? 0; // 若month为undefined则默认0（后续+1修正为1）
          this.remindDate = `${value.year}年${month + 1}月${value.day}日`;
          this.showDatePicker = false;
        })
    }
  }

  build() {
    Column({ space: 0 }) {
      // 弹窗头部
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => {
            this.onCancel();
          })

        Text('添加事项')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('')
          .width(24)
      }
      .width('100%')
      .padding(12)
      .border({
        width: { bottom: 0.5 },
        color: '#eee'
      })

      // 待办输入框
      TextInput({ placeholder: '输入代办事项...' })
        .width('95%')
        .height(48)
        .padding(12)
        .margin({ top: 12 })
        .onChange((value: string) => this.title = value)

      // 提醒设置行
      Row() {
        Image($r('app.media.icon_home_bjsb'))
          .width(20)
          .height(20)
          .margin({ right: 8 })

        Text('设置提醒')
          .fontSize(14)
          .fontColor('#333')
          .layoutWeight(1)

        Checkbox()
          .select(this.remindDate !== '')
          .onChange((value: boolean) => {
            this.showDatePicker = value;
            if (!value) {
              this.remindDate = '';
            }
          })
      }
      .width('95%')
      .padding(12)
      .margin({ top: 12 })
      .borderRadius(8)
      .backgroundColor('#F5F5F5')

      // 日期显示组件
      this.RemindDateBuilder()

      // 确认按钮
      Button('确定')
        .width('90%')
        .height(44)
        .margin({ top: 24 })
        .backgroundColor('#fff67ea9')
        .fontColor(Color.White)
        .fontSize(16)
        .onClick(() => {
          if (!this.title) {
            return;
          }
          this.onConfirm({
            title: this.title,
            remindDate: this.remindDate
          });
        })

      // 日期选择器组件
      this.DatePickerBuilder()
    }
    .width('80%')
    .borderRadius(12)
    .backgroundColor('#ffeae7e7')
    .padding({ bottom: 24 })
  }
}