import 'package:get/get.dart';
import 'package:quiz_project/model/quiz.dart';
import 'package:quiz_project/services/firebase_quiz.dart';

class QuizController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchQuizzes();
  }

  final quizzes = <Quiz>[].obs;
  final FirebaseQuiz _firebaseQuiz = FirebaseQuiz();
  
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  
  void fetchQuizzes() async {
    isLoading(true); 
    try {
     _firebaseQuiz.fetchQuizzes().listen((quizList) {
      quizzes.assignAll(quizList); 
      isLoading(false);
    }, onError: (error) {
      errorMessage.value = 'Failed to fetch quizzes: $error';
      isLoading(false);
    });
    } catch (e) {
      errorMessage.value = 'Failed to fetch quizzes: $e';
      isLoading(false);
    }
  }
  Future<void> delectMainQuestion(String id)async{
    try {
     await _firebaseQuiz.deleteQuizzes(id);
    } catch (e) {
      Get.snackbar("Error", "Failed to delete question: $e");
    }
  }
  
 
}

