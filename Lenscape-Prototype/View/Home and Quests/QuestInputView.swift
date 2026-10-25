//
//
// Quest Input View
//

import SwiftUI
import PhotosUI
import SwiftData

struct QuestInputView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.colorScheme) private var colorScheme
    

    let viewModel: QuestsCompletedViewModel
    let communityViewModel: CommunityViewModel
    let task: QuestItem

    // MARK: - Photo Selection State
    @State private var selectedImage: UIImage?
    @State private var selectedPickerItem: PhotosPickerItem?
    @State private var showCamera = false
    @State private var showImageSourceDialog = false
    @State private var showPhotoPicker = false

    // MARK: - Reflection State
    @State private var reflectionText = ""
    @FocusState private var isReflectionFocused: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // MARK: - Header
                VStack(alignment: .leading, spacing: 12) {
                    Text("Task Completed!")
                        .font(.title)
                        .fontWeight(.bold)

                    HStack {
                        Text("How do you feel about the quest?")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Spacer()

                        Image(colorScheme == .dark ? "celebrateShapeDM" : "celebrateShapeLM")
                            .resizable()
                            .frame(width: 110, height: 110)
                    }
                }

                // MARK: - Quest Details
                Text(task.title)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(task.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                // MARK: - Reflection Editor
                TextEditor(text: $reflectionText)
                    .focused($isReflectionFocused)
                    .scrollContentBackground(.hidden)
                    .padding(8)
                    .frame(height: 140)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                isReflectionFocused ? Color.blue : Color.gray.opacity(0.3),
                                lineWidth: 1
                            )
                            .allowsHitTesting(false)
                    }
                    .accessibilityLabel("Your reflection")
                    .onTapGesture {
                        isReflectionFocused = true
                    }

                // MARK: - Selected Photo
                if let selectedImage {
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 180)
                            .clipped()
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12)
                            )

                        Button {
                            self.selectedImage = nil
                            self.selectedPickerItem = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .background(
                                    Circle().fill(Color.black.opacity(0.6))
                                )
                        }
                        .padding(8)
                    }
                } else {
                    // MARK: - Add Photo Button
                    Button {
                        isReflectionFocused = false
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
                        .foregroundStyle(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }

                
                // MARK: - Submit Reflection
                Button {
                    let trimmedReflection = reflectionText.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )

                    guard !trimmedReflection.isEmpty else {
                        return
                    }

                    let imageData = selectedImage?.jpegData(
                        compressionQuality: 0.8
                    )

                    viewModel.submitReflection(
                        for: task.id,
                        reflectionText: trimmedReflection,
                        imageData: imageData,
                        modelContext: modelContext
                    )

                    dismiss()

                } label: {
                    Text("Submit Reflection")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            reflectionText.trimmingCharacters(
                                in: .whitespacesAndNewlines
                            ).isEmpty ? Color.gray : Color.blue,
                            in: Capsule()
                        )
                }

                
                Button(role: .destructive) {
                    viewModel.deleteReflection(
                        for: task.id,
                        modelContext: modelContext
                    )

                    reflectionText = ""
                    selectedImage = nil

                    dismiss()
                } label: {
                    Text("Delete Reflection")
                        .frame(maxWidth: .infinity)
                }
                
                .disabled(
                    reflectionText.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty
                )
            }
            .padding()
        }
        .scrollDismissesKeyboard(.interactively)
        
        


        // MARK: - Load Existing Reflection
        .onAppear {
            let taskID = task.id
            
            let descriptor = FetchDescriptor<CommunityPost>(
                predicate: #Predicate {
                    $0.taskID == taskID
                }
            )
            
            do {
                if let existingPost = try modelContext.fetch(
                    descriptor
                ).first {
                    reflectionText = existingPost.userReflection
                    
                    if let imageData = existingPost.imageData {
                        selectedImage = UIImage(data: imageData)
                    }
                } else {
                    reflectionText = task.userReflection
                    
                    if let imageData = task.imageData {
                        selectedImage = UIImage(data: imageData)
                    }
                }
            } catch {
                print("Failed to load reflection: \(error)")
            }
        }

        // MARK: - Choose Photo Source
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

        // MARK: - Photo Library
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: $selectedPickerItem,
            matching: .images
        )
        .onChange(of: selectedPickerItem) { _, newItem in
            Task {
                guard let newItem,
                      let data = try? await newItem.loadTransferable(type: Data.self),
                      let image = UIImage(data: data) else {
                    return
                }

                await MainActor.run {
                    selectedImage = image
                }
            }
        }
        .onChange(of: showPhotoPicker) { _, isShowing in
            if !isShowing {
                restoreTextEditorFocus()
            }
        }
        .sheet(isPresented: $showCamera,
               onDismiss: {
            restoreTextEditorFocus()
        }
        ) {
            CameraView(image: $selectedImage, isPresented: $showCamera)
        }
    }
    
    // MARK :-  fixing up error with textinput
    private func restoreTextEditorFocus() {
        Task { @MainActor in
            //allow the photo interface to finish dissmissing
            try? await Task.sleep(for: .milliseconds(500))
            
            //Restore focus to the reflection editor
            isReflectionFocused = true
        }
    }

    // MARK: - Camera View
    struct CameraView: UIViewControllerRepresentable {
        @Binding var image: UIImage?
        @Binding var isPresented: Bool
        @Environment(\.dismiss) private var dismiss

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
        ) {}

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        final class Coordinator: NSObject,
                                 UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {
            let parent: CameraView

            init(_ parent: CameraView) {
                self.parent = parent
            }

            func imagePickerController(
                _ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [
                    UIImagePickerController.InfoKey: Any
                ]
            ) {
                if let uiImage = info[.originalImage] as? UIImage {
                    parent.image = uiImage
                }

                parent.isPresented = false
            }

            func imagePickerControllerDidCancel(
                _ picker: UIImagePickerController
            ) {
                parent.isPresented = false
            }
        }
    }
}
    
    #Preview {
        NavigationStack {
            QuestInputView(
                viewModel: QuestsCompletedViewModel(),
                communityViewModel: CommunityViewModel(),
                task: QuestItem(
                    title: "Sample Quest",
                    description: "Sample Description"
                )
            )
        }
        .modelContainer(for: CommunityPost.self)
    }
