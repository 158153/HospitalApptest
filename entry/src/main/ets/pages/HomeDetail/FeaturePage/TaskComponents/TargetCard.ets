import { TargetItem } from '../../../../models/HomeModels/TaskModel';

@Component
export struct TargetCard {
  @Prop item: TargetItem;

  build() {
    Row() {
      Column({ space: 8 }) {
        // 标题与进度
        Row() {
          Text(this.item.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          Text(`(${this.item.progress})`)
            .fontSize(14)
            .fontColor('#999')
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        // 描述
        Text(this.item.desc)
          .fontSize(14)
          .fontColor('#666')
          .width('100%')

        // 额外信息
        Text(this.item.extra)
          .fontSize(14)
          .fontColor('#333')
          .width('100%')
      }
      .width('70%')
      .alignItems(HorizontalAlign.Start)

      // 完成状态勾选框（模拟）
      Row({ space: 20 }) {
        ForEach([1, 2, 3], (i: number) => {
          if (i <= Number(this.item.progress.match(/\d+\/(\d+)/)?.[1]) || this.item.title === '每日运动') {
            Image($r('app.media.task_add'))
              .width(20)
              .height(20)
              .fillColor('#4CAF50')
          } else {
            Circle({ width: 20, height: 20 })
              .stroke('#ccc')
              .strokeWidth(1)
              .fill(Color.Transparent)
          }
        })
      }
      .width('30%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .padding(12)
    .borderRadius(8)
    .backgroundColor(Color.White)
  }
}