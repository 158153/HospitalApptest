import { router } from '@kit.ArkUI'

@Component
struct Connect {
  build() {
    Column() {
      Text("我是智能问答页面内容")
        .onClick(() => {
          router.pushUrl({
            url: "pages/ChatDetail/ChatPage",
          })
        })

    }
  }
}

export default Connect