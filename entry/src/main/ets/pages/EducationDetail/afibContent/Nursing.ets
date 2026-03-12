@Component
struct Nursing {
  build() {
    Column({ space: 16 }) {
      Text("护理篇")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
      // 模拟长文本内容
      ForEach(Array.from({ length: 15 }), (_: object, index: number) => {
        Text(`护理相关内容 ${index +
          1}：房颤患者的日常护理需要注意监测心率、血压，遵医嘱服药，避免情绪激动和过度劳累，定期复查。`)
          .fontSize(15)
          .fontColor('#555555')
          .lineHeight(24)
      })
    }
    .width('100%')
    .padding(16)
  }
}

export default Nursing;