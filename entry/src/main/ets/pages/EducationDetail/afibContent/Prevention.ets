@Component
struct Prevention {
  build() {
    Column({ space: 16 }) {
      Text("预防篇")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
      // 模拟长文本内容
      ForEach(Array.from({ length: 15 }), (_: object, index: number) => {
        Text(`预防相关内容 ${index + 1}：房颤的预防需要控制高血压、糖尿病等基础疾病，戒烟限酒，保持健康体重，规律运动，避免熬夜和过度劳累。`)
          .fontSize(15)
          .fontColor('#555555')
          .lineHeight(24)
      })
    }
    .width('100%')
    .padding(16)
  }
}

export default Prevention;