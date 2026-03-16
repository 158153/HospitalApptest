////ai智能问答页面-底部输入框

import { promptAction } from '@kit.ArkUI'

@Component
struct BottomInput {
  @State
  showVoice: boolean = false // 控制是否显示语音输入模式，默认false显示文本输入框
  @State
  content: string = "" // 保存的是输入框输入的内容
  sendTextMessage: (content: string) => void = () => {
  }

  build() {
    Column() {
      Row({ space: 10 }) {
        // ========== 左侧切换按钮 ==========
        // 切换语音/键盘模式的图标按钮
        Image(this.showVoice ? $r("app.media.ic_public_keyboard") : $r("app.media.ic_public_sound"))
          .width(25)
          .height(25)
          // 点击事件处理,切换显示状态（语音⇄键盘）
          .onClick(() => {
            this.showVoice = !this.showVoice
          })
        // ========== 中间输入区域（条件渲染）==========
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
          // ----- 文本输入模式：文本输入框 -----
          // 文本输入模式：文本输入框，把输入框输入的信息赋值给发送气泡内容，用双向绑定$$
          TextInput({ text: $$this.content })
            .layoutWeight(1)
            .height(35)
            .borderRadius(2)
            .backgroundColor(Color.White)
            .id("input")// .focusable(true)// 设置元素是否可以聚焦
            // .defaultFocus(true)// 通过defaultFocus()开启默认聚焦
            .onSubmit(() => {
              if (this.content) {
                // 输入的消息了, 给父组件, 父组件将输入框输入的数据放到messageList
                this.sendTextMessage(this.content)

                this.content = ""

                // 发送完消息之后,输入框可以进行聚焦,光标
                focusControl.requestFocus("input")
              } else {
                promptAction.showToast({
                  message: "内容不能为空"
                })
              }
            })
        }
        // ========== 右侧添加功能按钮 ==========
        // 右侧"添加"功能图标
        Image($r("app.media.ic_public_add_norm"))
          .width(25)
          .height(25)
          .onClick(() => {
            AlertDialog.show({
              message: this.content
            })
          })
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