// DeviceCard.ets
/**
 * 通用设备卡片组件
 * 复用：血糖仪/测压计卡片，支持自定义标题/数据/单位
 */
// 导入设备数据项类型（从主页面导出）
import { DeviceItem } from '../WatchPage';

@Component
export struct DeviceCard {
  // 卡片标题（如：血糖仪/测压计）
  private title: string = '';
  // 设备数据列表
  private dataList: DeviceItem[] = [];
  // 单位名称（如：血糖/血压）
  private unitName: string = '';
  // 单位符号（如：mmol/L/mmHg）
  private unit: string = '';

  build() {
    Column() {
      // 卡片标题
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 20 })
      // 循环渲染数据列表
      ForEach(this.dataList, (item: DeviceItem) => {
        Row() {
          // 测量值+单位
          Text(`${this.unitName} ${item.value} ${this.unit}`)
            .fontSize(16)
            .fontColor('#333333')
          // 状态标签（如：偏高）
          if (item.status) {
            Text(item.status)
              .fontSize(12)
              .fontColor('#FFFFFF')
              .backgroundColor('#F5E6A0')
              .padding({
                left: 6,
                right: 6,
                top: 2,
                bottom: 2
              })
              .borderRadius(4)
              .margin({ left: 8 })
          }
          // 测量时间（右对齐）
          Text(item.time)
            .fontSize(14)
            .fontColor('#999999')
            .layoutWeight(1)
            .textAlign(TextAlign.End)
        }
        .width('100%')
        .margin({ bottom: 12 })
      })
      // 开始测量按钮
      Button('开始测量')
        .width(120)
        .height(36)
        .backgroundColor('#E0F2F1')
        .fontSize(14)
        .fontColor('#00796B')
        .borderRadius(18)
        .margin({ top: 10 })
    }
    .width('48%')
    .height(280)
    .border({ width: 1, color: '#E0E0E0' })
    .borderRadius(12)
    .padding(20)
  }
}