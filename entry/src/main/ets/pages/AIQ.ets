import { DefaultUserList, UserInfo } from '../models/AiQmodels/users'
import { router } from '@kit.ArkUI'

@Component
struct Connect {
  // filterList: 用来接收 来自models/users/中的 ai联系人信息列表DefaultUserList

  @State
  filterList: UserInfo[] = []
  @State
  @Watch("filterName")
  searchName: string = ""

  // 组件开始加载的时候触发,
  aboutToAppear(): void {
    // 组件一开始加载的时候, 将自定义的数据，自己在models/users写的模拟ai联系人数据信息，DefaultUserList赋值给filterList
    this.filterList = DefaultUserList
  }

  // 筛选联系人方法
  filterName() {
    this.filterList = DefaultUserList.filter((user: UserInfo) => {
      // 如果联系人列表数据中,存在输入的联系人名称,则将搜索到的联系人数据返回给filterList
      return user.username.includes(this.searchName)
    })
  }

  build() {
    Column() {
      // 搜索栏
      Row() {
        Search({ placeholder: "搜索-历史对话", value: $$this.searchName })
          .backgroundColor($r("app.color.white"))
          .height(45)
          .borderRadius(4)
      }
      .height(50)
      .width("100%")
      .padding({
        left: 10,
        right: 10,
        bottom: 7
      })

      // ai联系人列表 - 用Column+ForEach实现块状布局

      List() {
        ForEach(this.filterList, (item: UserInfo) => {
          ListItem() {
            Row({ space: 22 }) {
              Image(item.avatar)// ai显示联系人头像
                .width(45)
                .height(45)
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
              left: 20,
              right: 200
            })
            .height(65) // 设置整个联系人块的高度
            .width("95%")
            .backgroundColor($r("app.color.white")) // 设置背景色为白色
            .border({
              // 添加边框，让每块更明显
              width: 4,
              color: $r("app.color.border_color"),
              radius: 15  // 添加圆角
            })
            .margin({
              left: 25,
              right: 20,
              // 每块之间的间距 底部外边距15vp，实现块与块之间的间隔
              bottom: 15
            })
            .stateStyles({
              pressed: { // 按下状态
                .backgroundColor($r("app.color.back_color"))
              },
              normal: { // 正常状态
                .backgroundColor($r("app.color.white"))
              }
            })
          }
          .onClick(() => { // 使用路由跳转到聊天详情页
            router.pushUrl({
              url: "pages/AI_ChatDetail/ChatPage",
              params: item
            })
          })
        })
      }
      .width("100%")
      .height("100%")
      .padding({
        top: 10,
        bottom: 10
      })
      .divider({
        strokeWidth: 1,
        color: $r("app.color.border_color")
      })
      .layoutWeight(1)
      .backgroundColor($r("app.color.white"))

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