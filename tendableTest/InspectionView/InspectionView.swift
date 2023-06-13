// InspectionView.swift

import SwiftUI


struct InspectionView: View {
    @EnvironmentObject private var inspectionCoordinator: InspectionCoordinator
    @EnvironmentObject private var viewModel: InspectionViewModel

    var body: some View {
        VStack {
            Text("Inspection")
                .font(.title)
                .padding(.top, 20)

            
            if let currentQuestion = viewModel.getCurrentQuestion() {
                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        Text(currentQuestion.name)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .padding(.bottom, 40)
                        
                        ForEach(currentQuestion.answerChoices) { answerChoice in
                            RadioButtonView(
                                title: answerChoice.name,
                                isSelected: viewModel.isSelected(answerChoice),
                                action: {
                                    viewModel.selectAnswer(answerChoice)
                                }
                            )
                            .padding(.vertical, 4)
                        }
                    }
                    .padding()
                    .padding(.top, 40)
                }
            }



            Spacer()

            HStack {
                if !viewModel.isFirstQuestion {
                                Button(action: {
                                    viewModel.goToPreviousQuestion()
                                }) {
                                    Text("Previous")
                                        .padding()
                                        .frame(width: 120)
                                        .foregroundColor(.white)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                                }
                            }


                Spacer()

                Button(action: {
                    if viewModel.selectedAnswer() != nil {
                        if viewModel.isLastQuestion() {
                            inspectionCoordinator.showSubmitView()
                        } else {
                            viewModel.goToNextQuestion()
                        }
                    }
                }) {
                    Text("Next")
                        .padding()
                        .frame(width: 120)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 10).fill(viewModel.selectedAnswer() == nil ? Color.gray : Color.blue))
                        .disabled(viewModel.selectedAnswer() == nil)
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.loadSurveyQuestionsFromJSON()
        }
        .sheet(isPresented: $inspectionCoordinator.showingSubmitView) {
            SubmitView()
        }
    }
}


struct RadioButtonView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                Text(title)
                    .font(.body)
            }
            .frame(width: 200, height: 60) // Set the height of the button
            .padding(.horizontal, 20) // Add horizontal padding
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2) // Set border color and width
            )
        }
        .foregroundColor(.primary)
        .padding(.vertical, 4) // Add vertical padding for spacing
    }
}

