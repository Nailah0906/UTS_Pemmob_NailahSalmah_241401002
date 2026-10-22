import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //utk nyesuaikan ukuran layar(devicenya)
    final size = MediaQuery.of(context).size; 

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

          //hachiware 
          Positioned(
            bottom: 0,
            right: 0,
            child: IgnorePointer( 
              child: SizedBox(
                width: size.width * 0.85, 
                height: size.width * 0.75, 
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
  
                    Positioned(
                      right: -30, 
                      bottom: 0, 
                      child: Image.asset(
                        'assets/images/liku1.png',
                        width: size.width * 0.85, 
                      ),
                    ),


                    Positioned(
                      right: size.width * 0.05,
                      bottom: 10, 
                      child: Image.asset(
                        'assets/images/hachi1.png',
                        width: size.width * 0.35, 
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        )
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logoNaiQ.png',
                      width: 160,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Siap Kuis?',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'ComicRelief',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(3 , 3 ),
                          blurRadius: 7,
                          color: Color.fromARGB(137, 53, 52, 52),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // button nama dan mulai
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        // Input Nama
                        TextField(
                          controller: _nameController,
                          style: const TextStyle(fontFamily: 'ComicRelief', fontSize: 16),
                          decoration: InputDecoration(
                            hintText: 'Masukkan Nama',
                            hintStyle: TextStyle(color: AppTheme.abu.withValues(alpha: 0.5)),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.person_outline, color: AppTheme.biruPastel),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Start Button
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigasi nyusul
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.biruPastel,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'MULAI',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  

                  SizedBox(height: size.width * 0.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}