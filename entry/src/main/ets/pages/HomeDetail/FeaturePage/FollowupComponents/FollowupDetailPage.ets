import { FollowupDetail } from '../../../../models/HomeModels/FollowupModel';
import { FollowupApi } from '../../../../api/FollowupApi';
import router from '@ohos.router';

@Entry
@Component
struct FollowupDetailPage {
  @State detail: FollowupDetail | null = null;
  @State isLoading: boolean = true;
  private followupid: string = '';

  aboutToAppear() {
    const params = router.getParams() as Record<string, string>;
    this.followupid = params.id || '';
    this.loadDetail();
  }

  async loadDetail() {
    this.isLoading = true;
    try {
      this.detail = await FollowupApi.getFollowupDetail(this.followupid);
    } catch (e) {
      console.error('加载随访详情失败', e);
    } finally {
      this.isLoading = false;
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(24)
          .height(24)
          .onClick(() => router.back())
        Text('随访记录')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .margin({ left: 12 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16 })
      .backgroundColor('#E8F4F4')

      if (this.isLoading || !this.detail) {
        LoadingProgress()
          .width(50)
          .height(50)
          .margin({ top: 100 })
      } else {
        Scroll() {
          Column() {
            // 基本信息
            Row() {
              Column({ space: 12 }) {
                Text(`随访编号: ${this.detail.id}`)
                  .fontSize(14)
                  .fontColor('#333333')
                Text(`姓名: ${this.detail.name}`)
                  .fontSize(14)
                  .fontColor('#333333')
                Text(`随访时间: ${this.detail.time}`)
                  .fontSize(14)
                  .fontColor('#333333')
                Text(`随访方式: ${this.detail.way}`)
                  .fontSize(14)
                  .fontColor('#333333')
                Text(`责任医生: ${this.detail.doctor}`)
                  .fontSize(14)
                  .fontColor('#333333')
                Text(`症状: ${this.detail.symptom}`)
                  .fontSize(14)
                  .fontColor('#333333')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Column({ space: 12 }) {
                Text(`心理调整: ${this.detail.mental}`)
                  .fontSize(14)
                  .fontColor('#333333')
                Text(`遵医行为: ${this.detail.compliance}`)
                  .fontSize(14)
                  .fontColor('#333333')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .margin({ bottom: 12 })

            // 体征
            Column({ space: 12 }) {
              Text('体征')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .alignSelf(ItemAlign.Start)
              Row() {
                Column({ space: 8 }) {
                  Text(`血压: ${this.detail.vitalSigns.bloodPressure}`)
                    .fontSize(14)
                    .fontColor('#666666')
                  Text(`身高: ${this.detail.vitalSigns.height}`)
                    .fontSize(14)
                    .fontColor('#666666')
                  Text(`体重: ${this.detail.vitalSigns.weight}`)
                    .fontSize(14)
                    .fontColor('#666666')
                  Text(`目标体重: ${this.detail.vitalSigns.targetWeight}`)
                    .fontSize(14)
                    .fontColor('#666666')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column({ space: 8 }) {
                  Text(`体质指数: ${this.detail.vitalSigns.bmi}`)
                    .fontSize(14)
                    .fontColor('#666666')
                  Text(`目标体质指数: ${this.detail.vitalSigns.targetBmi}`)
                    .fontSize(14)
                    .fontColor('#666666')
                  Text(`足背动脉搏动: ${this.detail.vitalSigns.pulse}`)
                    .fontSize(14)
                    .fontColor('#666666')
                  Text(`其他: ${this.detail.vitalSigns.other}`)
                    .fontSize(14)
                    .fontColor('#666666')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
              }
              .width('100%')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .margin({ bottom: 12 })

            // 生活指导方式
            Column({ space: 12 }) {
              Text('生活指导方式')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .alignSelf(ItemAlign.Start)
              Text(`日吸烟量/目标: ${this.detail.lifeStyle.smoke}`)
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
              Text(`日饮酒量/目标: ${this.detail.lifeStyle.drink}`)
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
              Text(`日运动量/目标: ${this.detail.lifeStyle.exercise}`)
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .margin({ bottom: 12 })

            // 辅助检查
            Column({ space: 12 }) {
              Text('辅助检查')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .alignSelf(ItemAlign.Start)
              if (this.detail.lab.fastingGlucose) {
                Text(`空腹血糖值: ${this.detail.lab.fastingGlucose}`)
                  .fontSize(14)
                  .fontColor('#666666')
                  .alignSelf(ItemAlign.Start)
              }
              if (this.detail.lab.randomGlucose) {
                Text(`随机血糖值: ${this.detail.lab.randomGlucose}`)
                  .fontSize(14)
                  .fontColor('#666666')
                  .alignSelf(ItemAlign.Start)
              }
              if (this.detail.lab.hba1c) {
                Text(`糖化血红蛋白: ${this.detail.lab.hba1c}`)
                  .fontSize(14)
                  .fontColor('#666666')
                  .alignSelf(ItemAlign.Start)
              }
              Text(`其他说明: ${this.detail.lab.other}`)
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
              Text(`服药依从性: ${this.detail.medication.adherence}`)
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
              Text(`药物不良反应: ${this.detail.medication.adverseReaction}`)
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
              Text(`低血糖反应: ${this.detail.medication.hypoglycemia}`)
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .margin({ bottom: 12 })

            // 用药情况
            Column({ space: 12 }) {
              Text('用药情况')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .alignSelf(ItemAlign.Start)
              ForEach(this.detail.medication.drugs, (drug: string, index: number) => {
                Text(`药品${index + 1}: ${drug}`)
                  .fontSize(14)
                  .fontColor('#666666')
                  .alignSelf(ItemAlign.Start)
              })
              Text(`服药阶段: ${this.detail.medication.period}`)
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .margin({ bottom: 12 })

            // 随访结果
            Text(`此次随访结果: ${this.detail.result}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF6B00')
              .alignSelf(ItemAlign.Start)
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
          }
          .width('100%')
          .padding(16)
        }
        .width('100%')
        .layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}