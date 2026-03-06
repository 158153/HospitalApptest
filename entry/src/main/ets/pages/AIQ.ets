import BottomInput from '../pages/ChatDetail/BottomInput'

@Component
struct Connect {
  build() {
    Column() {
      // 标题栏
      Row() {
        Stack({ alignContent: Alignment.Start }) {
          Text("智能问答")
            .width("100%")
            .textAlign(TextAlign.Center)
            .fontSize(16)
            .fontColor($r("app.color.text_primary"))

          Image($r("app.media.ic_public_arrow_left"))
            .width(30)
            .height(30)
        }
      }
      .height(50)

      // 聊天内容区
      Blank()

      // 底部输入框
      BottomInput()
    }
    .height('100%')
    .width('100%')
  }
}

export default Connect