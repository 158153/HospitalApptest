@Entry
@Component
struct MessagePage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Text("我是消息通知");
    }
  }
}