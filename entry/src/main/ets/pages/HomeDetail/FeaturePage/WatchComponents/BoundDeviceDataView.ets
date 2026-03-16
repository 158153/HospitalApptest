// BoundDeviceDataView.ets
import { DeviceData } from '../WatchPage';
import { DeviceCard } from './DeviceCard';

@Component
export struct BoundDeviceDataView {
  private deviceData: DeviceData = {
    bloodSugar: [],
    bloodPressure: [],
    bandData: []
  };

  build() {
    Column() {
      Text('绑定设备')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Start)
        .margin({ top: 20, left: 20 })

      Row({ space: 20 }) {
        DeviceCard({
          title: '血糖仪',
          dataList: this.deviceData.bloodSugar,
          unitName: '血糖',
          unit: 'mmol/L'
        })
        DeviceCard({
          title: '测压计',
          dataList: this.deviceData.bloodPressure,
          unitName: '血压',
          unit: 'mmHg'
        })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20 })

      Column() {
        Text('华为智能手环')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 20 })
        Text('暂无数据')
          .fontSize(16)
          .fontColor('#999999')
      }
      .width('48%')
      .height(180)
      .border({ width: 1, color: '#E0E0E0' })
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .alignSelf(ItemAlign.Start)
      .margin({ top: 20, left: 20 })
    }
  }
}