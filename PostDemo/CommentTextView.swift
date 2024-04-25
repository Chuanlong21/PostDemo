import SwiftUI

struct CommentTextView: UIViewRepresentable {
    
    @Binding var text : String
    
    let beginEdit: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.backgroundColor = .systemGray6
        view.font = .systemFont(ofSize: 18)
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.delegate = context.coordinator
        view.text = text
        
        if beginEdit {
            view.becomeFirstResponder() // 让文本视图成为第一响应者
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if beginEdit && !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        }
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        let parent: CommentTextView
        var didBecomeFirst: Bool = false
        
        init(_ view: CommentTextView) {
            self.parent = view
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
    }
}

// Preview
struct CommentTextView_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextView(text: .constant("Type something..."), beginEdit: true)
    }
}

