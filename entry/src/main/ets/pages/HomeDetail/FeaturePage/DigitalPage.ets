@Entry
@Component
struct DigitalPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Text("电子病历");
    }
  }

}