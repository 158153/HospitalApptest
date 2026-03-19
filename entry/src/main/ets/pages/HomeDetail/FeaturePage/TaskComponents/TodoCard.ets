import { TodoItem } from '../../../../models/HomeModels/TaskModel';

@Component
export struct TodoCard {
  @Prop item: TodoItem;

  build() {
    Column({ space: 8 }) {
      // 标题
      Text(this.item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .width('100%')

      // 描述
      Text(this.item.desc)
        .fontSize(14)
        .fontColor('#666')
        .width('100%')

      // 进度条（可选）
      if (this.item.progress !== undefined) {
        Row() {
          Text('')
            .width(`${this.item.progress * 100}%`)
            .height(6)
            .borderRadius(3)
            .backgroundColor('#C8E6C9')
          Text('')
            .width(`${(1 - this.item.progress) * 100}%`)
            .height(6)
            .borderRadius(3)
            .backgroundColor('#E8F5E9')
        }
        .width('100%')
      }
    }
    .width('100%')
    .padding(12)
    .borderRadius(8)
    .backgroundColor(Color.White)
  }
}