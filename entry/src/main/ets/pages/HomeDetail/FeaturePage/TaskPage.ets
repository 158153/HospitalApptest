@Entry
@Component
struct TaskPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Text("我是代办事项内容");
    }
  }
}