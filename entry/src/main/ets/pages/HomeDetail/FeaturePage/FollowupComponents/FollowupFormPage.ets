import { FollowupForm } from '../../../../models/HomeModels/FollowupModel';
import { FollowupApi } from '../../../../api/FollowupApi';
import router from '@ohos.router';

@Entry
@Component
struct FollowupFormPage {
  @State form: FollowupForm | null = null;
  @State isLoading: boolean = true;
  // 1. 重命名避免与基类id冲突
  private recordId: string = '';

  aboutToAppear() {
    const params = router.getParams() as Record<string, string>;
    this.recordId = params.id || '';
    this.loadForm();
  }

  async loadForm() {
    this.isLoading = true;
    try {
      this.form = await FollowupApi.getFollowupForm(this.recordId);
    } catch (e) {
      console.error('加载随访问卷失败', e);
    } finally {
      this.isLoading = false;
    }
  }

  async handleSubmit() {
    if (!this.form) {
      return;
    }
    try {
      await FollowupApi.submitFollowupForm(this.form);
      router.back({
        url: 'pages/HomeDetail/FollowupPage'
      });
    } catch (e) {
      console.error('提交问卷失败', e);
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

      if (this.isLoading || !this.form) {
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
                Text(`随访编号: ${this.form.id}`)
                  .fontSize(14)
                  .fontColor('#333333')
                Text(`姓名: 李建平`)
                  .fontSize(14)
                  .fontColor('#333333')
                Text(`随访时间: ${new Date().toLocaleString()}`)
                  .fontSize(14)
                  .fontColor('#333333')
                Text(`随访方式: 随访问卷`)
                  .fontSize(14)
                  .fontColor('#333333')
                Text(`责任医生: 刘志辉`)
                  .fontSize(14)
                  .fontColor('#333333')
                Text('症状:')
                  .fontSize(14)
                  .fontColor('#333333')
                TextInput({ text: this.form.symptom })
                  .width('100%')
                  .height(40)
                  .border({ width: 1, color: '#CCCCCC' })
                  .borderRadius(4)
                  // 2. 替换对象展开为直接赋值
                  .onChange((value: string) => {
                    if (this.form) {
                      this.form.symptom = value;
                    }
                  })
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
                  Text(`血压: ${this.form.vitalSigns.bloodPressure}`)
                    .fontSize(14)
                    .fontColor('#666666')
                  Text(`身高: ${this.form.vitalSigns.height}`)
                    .fontSize(14)
                    .fontColor('#666666')
                  Text(`体重: ${this.form.vitalSigns.weight}`)
                    .fontSize(14)
                    .fontColor('#666666')
                  Text(`目标体重: ${this.form.vitalSigns.targetWeight}`)
                    .fontSize(14)
                    .fontColor('#666666')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column({ space: 8 }) {
                  Text(`体质指数: ${this.form.vitalSigns.bmi}`)
                    .fontSize(14)
                    .fontColor('#666666')
                  Text(`目标体质指数: ${this.form.vitalSigns.targetBmi}`)
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
              Text('日吸烟量/目标: --')
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
              Text('日饮酒量/目标: --')
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
              Row() {
                Text('日运动量/目标:')
                  .fontSize(14)
                  .fontColor('#333333')
                TextInput({ text: this.form.lifeStyle.exercise })
                  .width(100)
                  .height(30)
                  .border({ width: 1, color: '#CCCCCC' })
                  .borderRadius(4)
                  .margin({ left: 8 })
                  .onChange((value: string) => {
                    if (this.form) {
                      this.form.lifeStyle.exercise = value;
                    }
                  })
                Text('/267kcal')
                  .fontSize(14)
                  .fontColor('#666666')
                  .margin({ left: 4 })
              }
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
              Row() {
                Text('最高血压:')
                  .fontSize(14)
                  .fontColor('#333333')
                TextInput({ text: this.form.lab.maxBloodPressure })
                  .width(150)
                  .height(30)
                  .border({ width: 1, color: '#CCCCCC' })
                  .borderRadius(4)
                  .margin({ left: 8 })
                  .onChange((value: string) => {
                    if (this.form) {
                      this.form.lab.maxBloodPressure = value;
                    }
                  })
              }
              .alignSelf(ItemAlign.Start)

              Row() {
                Text('最低血压:')
                  .fontSize(14)
                  .fontColor('#333333')
                TextInput({ text: this.form.lab.minBloodPressure })
                  .width(150)
                  .height(30)
                  .border({ width: 1, color: '#CCCCCC' })
                  .borderRadius(4)
                  .margin({ left: 8 })
                  .onChange((value: string) => {
                    if (this.form) {
                      this.form.lab.minBloodPressure = value;
                    }
                  })
              }
              .alignSelf(ItemAlign.Start)

              Row() {
                Text('其他说明:')
                  .fontSize(14)
                  .fontColor('#333333')
                TextInput({ text: this.form.lab.other })
                  .width(150)
                  .height(30)
                  .border({ width: 1, color: '#CCCCCC' })
                  .borderRadius(4)
                  .margin({ left: 8 })
                  .onChange((value: string) => {
                    if (this.form) {
                      this.form.lab.other = value;
                    }
                  })
              }
              .alignSelf(ItemAlign.Start)

              Row() {
                Text('服药依从性:')
                  .fontSize(14)
                  .fontColor('#333333')
                TextInput({ text: this.form.medication.adherence })
                  .width(150)
                  .height(30)
                  .border({ width: 1, color: '#CCCCCC' })
                  .borderRadius(4)
                  .margin({ left: 8 })
                  .onChange((value: string) => {
                    if (this.form) {
                      this.form.medication.adherence = value;
                    }
                  })
              }
              .alignSelf(ItemAlign.Start)

              Row() {
                Text('药物不良反应:')
                  .fontSize(14)
                  .fontColor('#333333')
                TextInput({ text: this.form.medication.adverseReaction })
                  .width(150)
                  .height(30)
                  .border({ width: 1, color: '#CCCCCC' })
                  .borderRadius(4)
                  .margin({ left: 8 })
                  .onChange((value: string) => {
                    if (this.form) {
                      this.form.medication.adverseReaction = value;
                    }
                  })
              }
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
              ForEach(this.form.medication.drugs, (drug: string, index: number) => {
                Text(`药品${index + 1}: ${drug}`)
                  .fontSize(14)
                  .fontColor('#666666')
                  .alignSelf(ItemAlign.Start)
              })
              Text(`服药阶段: ${this.form.medication.period}`)
                .fontSize(14)
                .fontColor('#666666')
                .alignSelf(ItemAlign.Start)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .margin({ bottom: 24 })

            // 提交按钮
            Button('提交')
              .width('80%')
              .height(48)
              .backgroundColor('#F5A6A6')
              .fontSize(16)
              .fontColor('#FFFFFF')
              .borderRadius(24)
              .onClick(() => this.handleSubmit())
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