import { MessageInfo, MessageInfoModel } from '../../models/message'
import { currentUser } from '../../models/users'


/**
 * 消息气泡组件
 * 用于在聊天界面中显示单条消息，支持左右布局（自己发送的消息在右侧，对方的消息在左侧）
 */
@Component
struct message {
  /**
   * @Prop 装饰器：表示这是一个属性，可以从父组件传入
   * 当父组件的状态变化时，会自动更新这个组件
   * currentMessage: 当前要显示的消息对象
   * 默认值：创建一个空的消息对象，防止undefined错误
   */
  @Prop
  currentMessage: MessageInfoModel = new MessageInfoModel({} as MessageInfo)

  build() {
    Row() {
      // 发送者头像
      Image(this.currentMessage.sendUser.avatar)
        .width(40)
        .height(40)
        .borderRadius(6)

      // 消息内容容器行，用于放置消息气泡
      Row() {
        Column() {
          // 消息文本内容
          Text(this.currentMessage.messageContent)
          // 根据消息发送者是否当前用户，设置不同的背景色
          // 自己发送：使用次主题色；对方发送：使用白色
            .backgroundColor(currentUser.user_id === this.currentMessage.sendUser.user_id ?
              $r("app.color.second_primary") : $r("app.color.white"))
            .fontColor($r("app.color.text_primary"))
            .padding(10)
            .margin({
              left: 10,
              right: 10
            })
            .borderRadius(5)
        }
      }
      .layoutWeight(6)
      // 根据消息发送者是否当前用户，设置子元素的对齐方式，自己发送：靠右对齐；对方发送：靠左对齐
      .justifyContent(currentUser.user_id === this.currentMessage.sendUser.user_id ? FlexAlign.End : FlexAlign.Start)

      // 空白占位文本，用于平衡布局，权重为1，与上面的.layoutWeight(6)配合，实现左右两侧的空白区域分配
      Text()
        .layoutWeight(1)

    }
    // 设置整个行容器的布局方向，自己发送：从右向左布局（RTL）；对方发送：从左向右布局（LTR）
    .direction(currentUser.user_id === this.currentMessage.sendUser.user_id ? Direction.Rtl : Direction.Ltr)
    .alignItems(VerticalAlign.Top) // 设置子元素在垂直方向上的对齐方式为顶部对齐
    .padding({
      left: 20,
      right: 20
    })
    .width("100%")

  }
}

export default message