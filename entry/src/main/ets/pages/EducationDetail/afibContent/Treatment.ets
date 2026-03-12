@Component
struct Treatment {
  build() {
    Column({ space: 16 }) {
      Text("治疗篇")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
      Text("房颤的治疗目标包括：控制心室率、恢复并维持窦性心律、预防血栓栓塞并发症、治疗基础疾病。")
        .fontSize(16)
        .fontColor('#555555')
        .lineHeight(24)
      // 模拟长文本内容
      ForEach(Array.from({ length: 15 }), (_: object, index: number) => {
        Text(`治疗相关内容 ${index +
          1}：房颤的治疗方法包括药物治疗和非药物治疗两大类，药物治疗主要用于控制心室率和预防血栓，非药物治疗包括电复律、射频消融、左心耳封堵等。`)
          .fontSize(15)
          .fontColor('#555555')
          .lineHeight(24)
      })
    }
    .width('100%')
    .padding(16)
  }
}

export default Treatment;