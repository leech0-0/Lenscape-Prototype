import SwiftUI
import PhotosUI

struct QuestInputView: View {
    @Environment(\.dismiss) private var dismiss
    let viewModel: QuestsCompletedViewModel
    let communityViewModel: CommunityViewModel
    let task: QuestItem
    
    @State private var reflectionText: String = ""
    
    // Photo selection state
    @State private var selectedImage: UIImage?
    @State private var selectedPickerItem: PhotosPickerItem?
    @State private var showCamera: Bool = false
    @State private var showImageSourceDialog: Bool = false
    @State private var showPhotoPicker = false
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 16) {
                
                VStack {
                    Text("Task Completed!")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("How do you feel about the quest?")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        ZStack {
                            Image("placeholder")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .offset(x: -20)
                        }
                    }
                }
                
                Text(task.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(task.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                TextEditor(text: $reflectionText)
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .frame(height: 140)
                
                // MARK: - Image Display or Selection Trigger
                if let selectedImage {
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Button {
                            self.selectedImage = nil
                            self.selectedPickerItem = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                                .background(Circle().fill(Color.black.opacity(0.6)))
                        }
                        .padding(8)
                    }
                } else {
                    Button {
                        showImageSourceDialog = true
                    } label: {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Add Photo")
                        }
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    }
                }
                
                Spacer()
                
                Button {
                    viewModel.submitReflection(for: task.id,
                                               reflectionText: reflectionText,
                                               communityViewModel: communityViewModel)
                    dismiss()
                } label: {
                    Text("Submit Reflection")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(reflectionText.isEmpty ? Color.gray : Color.blue, in: Capsule())
                }
                .disabled(reflectionText.isEmpty)
            }
            .padding()
            .navigationTitle("Log Reflection")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                reflectionText = task.userReflection
            }
            // Source Selection Action Sheet
            .confirmationDialog(
                "Choose Photo Source",
                isPresented: $showImageSourceDialog,
                titleVisibility: .visible
            ) {
                
                Button("Take Photo") {
                    
                    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                        print("Camera is unavailable.")
                        return
                    }
                    
                    showCamera = true
                }
                
                Button("Choose from Library") {
                    showPhotoPicker = true
                }
                
                Button("Cancel", role: .cancel) {}
            }
            .photosPicker(
                isPresented: $showPhotoPicker,
                selection: $selectedPickerItem,
                matching: .images
            )
            // Load Selected Photo from Library
            .onChange(of: selectedPickerItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        await MainActor.run {
                            self.selectedImage = image
                        }
                    }
                }
            }
            // Camera Modal
            .sheet(isPresented: $showCamera) {
                CameraView(image: $selectedImage)
            }
        }
    }
    
    // MARK: - UIKit Camera View Bridge
    struct CameraView: UIViewControllerRepresentable {
        
        @Binding var image: UIImage?
        
        @Environment(\.dismiss)
        private var dismiss
        
        
        func makeUIViewController(
            context: Context
        ) -> UIImagePickerController {
            
            let picker = UIImagePickerController()
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
            }
            
            picker.delegate = context.coordinator
            
            return picker
        }
        
        
        func updateUIViewController(
            _ uiViewController: UIImagePickerController,
            context: Context
        ) {
        }
        
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        
        final class Coordinator:
            NSObject,
            UIImagePickerControllerDelegate,
            UINavigationControllerDelegate {
            
            let parent: CameraView
            
            
            init(_ parent: CameraView) {
                self.parent = parent
            }
            
            
            func imagePickerController(
                _ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info:
                [UIImagePickerController.InfoKey: Any]
            ) {
                
                if let uiImage = info[.originalImage] as? UIImage {
                    parent.image = uiImage
                }
                
                parent.dismiss()
            }
            
            
            func imagePickerControllerDidCancel(
                _ picker: UIImagePickerController
            ) {
                
                parent.dismiss()
            }
        }
    }
}

#Preview {
    QuestInputView(
        viewModel: QuestsCompletedViewModel(),
        communityViewModel: CommunityViewModel(),
        task: QuestItem(
            title: "Sample Quest",
            description: "Sample Description"))
}
