import { DefaultUserList, UserInfo } from '../models/users'
import { router } from '@kit.ArkUI'

@Component
struct Connect {
  // filterList: 用来接收 来自models/users/中的 ai联系人信息列表DefaultUserList
  @State
  filterList: UserInfo[] = []

  // 组件开始加载的时候触发,
  aboutToAppear(): void {
    // 组件一开始加载的时候, 将自定义的数据，自己在models/users写的模拟ai联系人数据信息，DefaultUserList赋值给filterList
    this.filterList = DefaultUserList
  }

  build() {
    Column() {

      // ai联系人列表 - 用Column+ForEach实现块状布局
      Column() {
        ForEach(this.filterList, (item: UserInfo) => {
          Row({ space: 10 }) {
            Image(item.avatar)// ai显示联系人头像
              .width(50)
              .height(50)
              .borderRadius(4)

            Column() {
              Text(item.username)
                .fontSize(20)
                .fontColor($r("app.color.text_primary"))
            }
            .layoutWeight(1) // 占据Row中的剩余空间，让名称区域自适应宽度
            .alignItems(HorizontalAlign.Start) // 名称区域内容水平左对齐
            .justifyContent(FlexAlign.Center) // 名称区域内容垂直居中对齐
          }
          .padding({
            // 设置内边距，头像离左边的距离
            left: 100,
            right: 200
          })
          .height(90) // 设置整个联系人块的高度
          .width("100%")
          .backgroundColor($r("app.color.white")) // 设置背景色为白色
          .border({
            // 添加边框，让每块更明显
            width: 3,
            color: $r("app.color.border_color"),
            radius: 40  // 添加圆角
          })
          .margin({
            // 每块之间的间距 底部外边距15vp，实现块与块之间的间隔
            bottom: 18
          })
          .stateStyles({
            pressed: { // 按下状态
              .backgroundColor($r("app.color.back_color"))
            },
            normal: { // 正常状态
              .backgroundColor($r("app.color.white"))
            }
          })
          .onClick(() => { // 使用路由跳转到聊天详情页
            router.pushUrl({
              url: "pages/ChatDetail/ChatPage",
              params: item
            })
          })
        })
      }
      .width("100%")
      .height("100%")
      .padding({
        // 设置Column的内边距
        top: 100, // 顶部内边距
        bottom: 10,
        left: 10,
        right: 10
      })
      .backgroundColor($r("app.color.back_color")) // 整体背景色为背景色

    }
    .width("100%")
    .height("100%")
    .padding({
      top: 20
    })
    .backgroundColor($r("app.color.back_color")) // 整体背景色为背景色
  }
}

export default Connect