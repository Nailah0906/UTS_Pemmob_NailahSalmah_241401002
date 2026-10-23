import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../data/dummy_data.dart';
import '../models/question_model.dart'; 


class QuizScreen extends StatefulWidget {
  final String playerName;
  const QuizScreen({super.key, required this.playerName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Data dummy 
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // Ambil soal dari data dummy
    final Question currentQuestion = dummyQuestions[_currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          // 1. bg kotak
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

          // 2. gradien bg 
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
            child: Padding(
              padding: const EdgeInsets.all(24.0),
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
                        'Soal ${_currentQuestionIndex + 1}/${dummyQuestions.length}', // Dinamis
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
                      value: (_currentQuestionIndex + 1) / dummyQuestions.length, // Dinamis
                      backgroundColor: Colors.white.withValues(alpha: 0.5),
                      color: const Color.fromARGB(255, 125, 218, 255),
                      minHeight: 12,
                    ),
                  ),
                  const SizedBox(height: 30),

                  //soal 
                  Stack(
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
                              currentQuestion.questionText, // Ambil dari model
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
                  const SizedBox(height: 30),

                  //jawaban
                  ...List.generate(currentQuestion.options.length, (index) {
                    bool isSelected = _selectedOptionIndex == index;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOptionIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.biruPastel.withValues(alpha: 0.2) : Colors.white,
                          border: Border.all(
                            color: isSelected ? AppTheme.biruPastel : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            if (!isSelected)
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                currentQuestion.options[index], // Ambil opsi dari model
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: AppTheme.abu,
                                  fontFamily: 'ComicRelief', 
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/images/ikan.png',
                              width: 35, 
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const Spacer(),

                  //prev dan next button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // previous button
                      if (_currentQuestionIndex > 0)
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _currentQuestionIndex--;
                                _selectedOptionIndex = null; 
                              });
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
                                // Navigasi nyusul
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
                            child: Image.asset(
                              'assets/images/hachi2.png',
                              width: 100,
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
        ],
      ),
    );
  }
}