@Entry
@Component
struct SettingPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Text("我是设备绑定");
    }
  }
}