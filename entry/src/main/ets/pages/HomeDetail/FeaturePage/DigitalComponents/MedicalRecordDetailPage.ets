//   # 病历详情页

import { MedicalRecord } from '../../../../models/HomeModels/DigitalMedicalModels';
import router from '@ohos.router';

@Entry
@Component
struct MedicalRecordDetailPage {
  @State record: MedicalRecord | null = null;

  aboutToAppear() {
    // 接收传递的参数
    const params = router.getParams() as Record<string, string>;
    if (params?.record) {
      this.record = JSON.parse(params.record);
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => router.back());
        Text('病历详情')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 16 });
        Blank();
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#E8F4F5');

      if (this.record) {
        // 病历详情内容
        Column() {
          Text(`${this.record.name} ${this.record.gender} ${this.record.age}岁`)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 20 });

          Row() {
            Text('就诊时间：')
              .fontSize(16)
              .fontColor('#666666');
            Text(this.record.visitTime)
              .fontSize(16);
          }
          .width('100%')
          .margin({ bottom: 12 });

          Row() {
            Text('病历来源：')
              .fontSize(16)
              .fontColor('#666666');
            Text(this.record.source)
              .fontSize(16);
          }
          .width('100%');

          // 此处可扩展更多病历详情内容
        }
        .width('100%')
        .padding(20)
        .backgroundColor(Color.White)
        .borderRadius(8)
        .margin({ top: 12, left: 16, right: 16 });
      } else {
        Column() {
          Text('暂无病历数据')
            .fontSize(16)
            .fontColor('#999999')
            .layoutWeight(1)
        }
        .justifyContent(FlexAlign.Center);
      }

      Blank();
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5');
  }
}