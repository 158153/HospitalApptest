@Component
struct BottomInput {
  @State
  showVoice: boolean = false // 控制是否显示语音输入模式，默认false显示文本输入框

  build() {
    Column() {
      Row({ space: 10 }) {
        // 切换语音/键盘模式的图标按钮
        Image(this.showVoice ? $r("app.media.ic_public_keyboard") : $r("app.media.ic_public_sound"))
          .width(25)
          .height(25)
          // 点击事件处理,切换显示状态（语音⇄键盘）
          .onClick(() => {
            this.showVoice = !this.showVoice
          })

        // 条件渲染：根据showVoice状态显示不同内容
        if (this.showVoice) {
          // 语音输入模式：按住说话按钮
          Button("按住 说话", {
            type: ButtonType.Normal
          })
            .backgroundColor(Color.White)
            .height(35)
            .layoutWeight(1)// 占据剩余空间（权重1）
            .borderRadius(2)
            .fontColor($r("app.color.text_primary"))
        } else {
          // 文本输入模式：文本输入框
          TextInput()
            .layoutWeight(1)
            .height(35)
            .borderRadius(2)
            .backgroundColor(Color.White)
        }

        // 右侧"添加"功能图标
        Image($r("app.media.ic_public_add_norm"))
          .width(25)
          .height(25)
      }
      .width("100%")
      .height(60)
      .padding({
        left: 10,
        right: 10
      })
    }
    .backgroundColor($r("app.color.second_back_color"))
  }
}

export default BottomInput