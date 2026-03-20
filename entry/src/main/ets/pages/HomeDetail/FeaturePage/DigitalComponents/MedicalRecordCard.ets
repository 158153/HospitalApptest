// # 病历卡片组件

import { MedicalRecord } from '../../../../models/HomeModels/DigitalMedicalModels';

@Component
export struct MedicalRecordCard {
  // 用 @Prop 装饰器标记为必传属性，由父组件传递
  @Prop record: MedicalRecord;
  // 点击事件回调（可选）
  onCardClick?: (record: MedicalRecord) => void;

  build() {
    Column() {
      // 患者基本信息行
      Row() {
        Text(this.record.name)
          .fontSize(18)
          .fontWeight(FontWeight.Medium);
        Text(this.record.gender)
          .fontSize(16)
          .margin({ left: 12 });
        Text(`${this.record.age}岁`)
          .fontSize(16)
          .margin({ left: 12 });
        Blank();
        Image($r('app.media.ic_public_right'))
          .width(20)
          .height(20)
          .fillColor('#999999');
      }
      .width('100%')
      .margin({ bottom: 12 });

      // 就诊信息行
      Row() {
        Text(`就诊时间: ${this.record.visitTime}`)
          .fontSize(14)
          .fontColor('#666666');
        Blank();
        Text(`病历来源: ${this.record.source}`)
          .fontSize(14)
          .fontColor('#666666');
      }
      .width('100%');
    }
    .width('100%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .margin({ bottom: 8 })
    .onClick(() => {
      if (this.onCardClick) {
        this.onCardClick(this.record);
      }
    })
  }
}