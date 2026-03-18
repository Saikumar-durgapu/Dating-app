import SwiftUI

struct SparkButton: View {
    let title: String
    var style: Style = .primary
    var action: () -> Void

    enum Style { case primary, secondary, destructive }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(background)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
    }

    private var background: some ShapeStyle {
        switch style {
        case .primary: return AnyShapeStyle(LinearGradient.sparkPrimary)
        case .secondary: return AnyShapeStyle(Color.gray.opacity(0.6))
        case .destructive: return AnyShapeStyle(SparkColor.danger)
        }
    }
}
