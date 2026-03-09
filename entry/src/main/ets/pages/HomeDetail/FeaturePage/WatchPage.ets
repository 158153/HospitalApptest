@Entry
@Component
struct WatchPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Text("我是健康监测内容");
    }
  }
}