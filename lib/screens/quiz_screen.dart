import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../themes/app_theme.dart';
import '../providers/quiz_provider.dart'; 
import '../widgets/option_card.dart'; 
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String playerName;
  const QuizScreen({super.key, required this.playerName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    //data dri provider
    final quizProvider = Provider.of<QuizProvider>(context);
    final currentQuestion = quizProvider.currentQuestion;

    return Scaffold(
      body: Stack(
        children: [
          // bg kotak
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgkotak2.png'), 
                fit: BoxFit.cover,
              ),
            ),
          ),

          // gradien bg 
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 450,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromARGB(255, 147, 205, 255).withValues(alpha: 0.9),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500), // BATASI LEBAR
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // header nama dan progress bar
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pemain: ${widget.playerName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold, 
                                      color: AppTheme.abu,
                                      fontFamily: 'ComicRelief', 
                                    ),
                                  ),
                                  Text(
                                    'Soal ${quizProvider.currentQuestionIndex + 1}/${quizProvider.totalQuestions}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold, 
                                      color: AppTheme.abu,
                                      fontFamily: 'ComicRelief', 
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              
                              // Progress Bar
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: (quizProvider.currentQuestionIndex + 1) / quizProvider.totalQuestions,
                                  backgroundColor: Colors.white.withValues(alpha: 0.5),
                                  color: const Color.fromARGB(255, 125, 218, 255),
                                  minHeight: 12,
                                ),
                              ),
                              const SizedBox(height: 30),

                              //soal ak ubah make center biar adaptive di web 
                              Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 450),
                                  child: Stack(
                                    clipBehavior: Clip.none, 
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 35, bottom: 24, left: 24, right: 24), 
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(24),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(alpha: 0.1),
                                              blurRadius: 15,
                                              offset: const Offset(0, 8),
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              currentQuestion.questionText,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 20, 
                                                fontWeight: FontWeight.bold, 
                                                color: AppTheme.abu,
                                                fontFamily: 'ComicRelief',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // kuping kiri
                                      Positioned(
                                        top: -15, 
                                        left: 30,
                                        child: Transform.rotate(
                                          angle: -0.8, 
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // kuping kanan
                                      Positioned(
                                        top: -15,
                                        right: 30,
                                        child: Transform.rotate(
                                          angle: 0.8, 
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                                bottomRight: Radius.circular(5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),

                              //jawaban 
                              ...List.generate(currentQuestion.options.length, (index) {
                                return OptionCard(
                                  text: currentQuestion.options[index],
                                  isSelected: quizProvider.selectedOptionIndex == index,
                                  onTap: () {
                                    quizProvider.answerQuestion(index); 
                                  },
                                );
                              }),
                              
                              // Spasi biar tombol ga ketutup
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),

                      // button next dan previous
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // previous button
                          if (quizProvider.currentQuestionIndex > 0) 
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: () {
                                  quizProvider.previousQuestion(); 
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppTheme.abu,
                                  shape: const CircleBorder(),
                                  elevation: 2,
                                ),
                                child: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
                              ),
                            )
                          else
                            const SizedBox(width: 60), 

                          // next button
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Validasi User harus jawab dulu sebelum next
                                    if (quizProvider.selectedOptionIndex == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Jawab dulu kuisnya O^O!!')),
                                      );
                                      return;
                                    }

                                    if (quizProvider.isLastQuestion) {
                                      // Hitung skor dan pindah ke ResultScreen
                                      quizProvider.finishQuiz();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ResultScreen(
                                            playerName: widget.playerName,
                                            finalScore: quizProvider.score,
                                            totalQuestions: quizProvider.totalQuestions,
                                          ),
                                        ),
                                      );
                                    } else {
                                      quizProvider.nextQuestion();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.biruPastel,
                                    foregroundColor: Colors.white,
                                    shape: const CircleBorder(),
                                    elevation: 2,
                                  ),
                                  child: const Icon(Icons.arrow_forward_ios_rounded, size: 24),
                                ),
                              ),
                              // Hachi nempel
                              Positioned(
                                top: -40,
                                left: -50,
                                child: IgnorePointer(
                                  child: Image.asset(
                                    'assets/images/hachi2.png',
                                    width: 100,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20), 
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}