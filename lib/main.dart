// main.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  
  void toggleThemeMode() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light 
          ? ThemeMode.dark 
          : ThemeMode.light;
    });
    _saveThemePreference();
  }
  
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }
  
  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _themeMode == ThemeMode.dark);
  }
  
  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FraudShield',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5E5BF7),
          primary: const Color(0xFF5E5BF7),
          secondary: const Color(0xFF8359FF),
          background: const Color(0xFFF9FAFC),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF9FAFC),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF5E5BF7),
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF5E5BF7), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1F36),
          ),
          titleLarge: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1F36),
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1F36).withOpacity(0.9),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: const Color(0xFF1A1F36).withOpacity(0.9),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: const Color(0xFF1A1F36).withOpacity(0.7),
          ),
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5E5BF7),
          primary: const Color(0xFF6B68F8),
          secondary: const Color(0xFF9371FF),
          background: const Color(0xFF121212),
          surface: const Color(0xFF1E1E1E),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: const Color(0xFF1E1E1E),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF5E5BF7),
            elevation: 4,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2A2A2A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade800),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade800),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF6B68F8), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: HomePage(toggleThemeMode: toggleThemeMode, isDarkMode: _themeMode == ThemeMode.dark),
    );
  }
}

class HomePage extends StatefulWidget {
  final Function toggleThemeMode;
  final bool isDarkMode;

  const HomePage({
    Key? key, 
    required this.toggleThemeMode,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  bool _hasSearched = false;
  Map<String, dynamic>? _courierData;
  List<dynamic>? _reviewsData;
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final isDarkMode = widget.isDarkMode;
    
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: screenHeight * 0.25,
              pinned: true,
              stretch: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: Icon(
                      isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      widget.toggleThemeMode();
                    },
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDarkMode ? 
                      [
                        const Color(0xFF3F3D9E),
                        const Color(0xFF5E5BF7),
                      ] : 
                      [
                        const Color(0xFF5E5BF7),
                        const Color(0xFF8359FF),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (isDarkMode ? const Color(0xFF3F3D9E) : const Color(0xFF5E5BF7)).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.shield_rounded,
                            size: 40,
                            color: isDarkMode ? const Color(0xFF6B68F8) : const Color(0xFF5E5BF7),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'FraudShield',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          'Protect your business from courier fraud',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                title: _hasSearched
                    ? const Text(
                        'Customer Check Results',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Check a Customer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.zero,
                      elevation: isDarkMode ? 5 : 2,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Customer Verification',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Enter a customer\'s phone number to check their delivery history',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone_rounded,
                                    color: isDarkMode ? Colors.grey[400] : null,
                                  ),
                                  hintText: 'Customer Phone Number',
                                  hintStyle: TextStyle(
                                    color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
                                  ),
                                  suffixIcon: _phoneController.text.isNotEmpty
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.clear,
                                            color: isDarkMode ? Colors.grey[400] : null,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _phoneController.clear();
                                            });
                                          },
                                        )
                                      : null,
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a phone number';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 55,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _searchCustomer,
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Check Customer',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      _buildErrorCard(),
                    ],
                  ],
                ),
              ),
            ),
            if (_hasSearched && _courierData != null) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.shield_rounded, 
                            size: 18, 
                            color: Theme.of(context).colorScheme.primary
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Trust Score',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTrustScoreCard(),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Icon(
                            Icons.bar_chart_rounded, 
                            size: 18, 
                            color: Theme.of(context).colorScheme.primary
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Courier Performance',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildCourierStatsCard(),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded, 
                                size: 18, 
                                color: Theme.of(context).colorScheme.primary
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Customer Reviews',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.add_comment_rounded, size: 16),
                            label: const Text('Add Review'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              foregroundColor: Theme.of(context).colorScheme.primary,
                              elevation: 0,
                            ),
                            onPressed: () {
                              _showAddReviewDialog();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (_reviewsData == null || _reviewsData!.isEmpty) {
                      return _buildEmptyReviewsCard();
                    }
                    final review = _reviewsData![index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 16.0,
                      ),
                      child: ReviewCard(
                        review: review,
                        isDarkMode: widget.isDarkMode,
                      ),
                    );
                  },
                  childCount: (_reviewsData == null || _reviewsData!.isEmpty)
                      ? 1
                      : _reviewsData!.length,
                ),
              ),
            ],
            SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard() {
    final isDarkMode = widget.isDarkMode;
    return Card(
      color: isDarkMode ? const Color(0xFF2D1A1A) : const Color(0xFFFFF5F5),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF3D2222) : const Color(0xFFFFE5E5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: Color(0xFFE53935),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE53935),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Color(0xFFE53935),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyReviewsCard() {
    final isDarkMode = widget.isDarkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.rate_review_outlined,
                size: 50,
                color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
              ),
              const SizedBox(height: 16),
              Text(
                'No reviews yet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Be the first to add a review for this customer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add First Review'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: () {
                  _showAddReviewDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrustScoreCard() {
    final isDarkMode = widget.isDarkMode;
    final summary = _courierData!['summary'];
    final successRatio = summary['success_ratio'] ?? 0;
    final totalParcels = summary['total_parcel'] ?? 0;
    final successParcels = summary['success_parcel'] ?? 0;
    final cancelledParcels = summary['cancelled_parcel'] ?? 0;
    
    String trustLevel;
    Color trustColor;
    String trustMessage;
    
    if (successRatio >= 95) {
      trustLevel = 'Highly Trustworthy';
      trustColor = const Color(0xFF00C853);
      trustMessage = 'This customer has an excellent delivery acceptance history';
    } else if (successRatio >= 85) {
      trustLevel = 'Trustworthy';
      trustColor = const Color(0xFF4CAF50);
      trustMessage = 'This customer has a good delivery acceptance history';
    } else if (successRatio >= 70) {
      trustLevel = 'Moderately Trustworthy';
      trustColor = const Color(0xFFFFC107);
      trustMessage = 'This customer has an acceptable delivery acceptance history';
    } else if (successRatio >= 50) {
      trustLevel = 'Exercise Caution';
      trustColor = const Color(0xFFFF9800);
      trustMessage = 'This customer has a mixed history - consider COD options';
    } else {
      trustLevel = 'High Risk';
      trustColor = const Color(0xFFE53935);
      trustMessage = 'This customer has a poor delivery acceptance history';
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: isDarkMode ? 4 : 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          successRatio >= 70 
                              ? Icons.verified_user_rounded 
                              : Icons.warning_amber_rounded,
                          size: 18,
                          color: trustColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          trustLevel,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: trustColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          fontFamily: 'Poppins',
                        ),
                        children: [
                          const TextSpan(text: 'Based on '),
                          TextSpan(
                            text: '$totalParcels',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const TextSpan(text: ' previous deliveries'),
                        ],
                      ),
                    ),
                  ],
                ),
                TrustScoreIndicator(
                  score: successRatio, 
                  color: trustColor,
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // New order summary section like in image 2
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF252525) : Colors.grey[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildOrderStatBox(
                      title: 'মোট অর্ডার',
                      value: '$totalParcels',
                      subtitle: 'Total',
                      icon: Icons.shopping_bag_outlined,
                      color: const Color(0xFF5E5BF7),
                      isDarkMode: isDarkMode,
                    ),
                    _buildOrderStatBox(
                      title: 'মোট ডেলিভারি',
                      value: '$successParcels',
                      subtitle: 'Delivered',
                      icon: Icons.check_circle_outline,
                      color: const Color(0xFF4CAF50),
                      isDarkMode: isDarkMode,
                    ),
                    _buildOrderStatBox(
                      title: 'মোট বাতিল',
                      value: '$cancelledParcels',
                      subtitle: 'Cancelled',
                      icon: Icons.cancel_outlined,
                      color: const Color(0xFFE53935),
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Status message
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: trustColor.withOpacity(isDarkMode ? 0.15 : 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: trustColor.withOpacity(isDarkMode ? 0.3 : 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    successRatio >= 70 
                        ? Icons.lightbulb_rounded 
                        : Icons.info_outline_rounded,
                    color: trustColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      trustMessage,
                      style: TextStyle(
                        color: trustColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // High risk alert for low success rates
            if (successRatio < 30) ... [
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF3D2222) : const Color(0xFFFFF5F5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE53935).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDarkMode ? const Color(0xFF4D2727) : const Color(0xFFFFE5E5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.error_rounded,
                        color: Color(0xFFE53935),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'High Risk Alert',
                            style: TextStyle(
                              color: Color(0xFFE53935),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'This customer has a concerning history with very low success rate. Additional verification strongly recommended.',
                            style: TextStyle(
                              color: Color(0xFFE53935),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatBox({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isDarkMode,
  }) {
    return Flexible(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 12,
                  color: color,
                ),
                const SizedBox(width: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourierStatsCard() {
    final isDarkMode = widget.isDarkMode;
    Map<String, dynamic> courierData = _courierData!;
    List<MapEntry<String, dynamic>> couriers = courierData.entries
        .where((entry) => entry.key != 'summary' && entry.key != 'reports')
        .toList();

    // Prepare data for the improved chart
    List<BarChartGroupData> barGroups = [];
    List<String> courierNames = [];
    double maxOrders = 0;
    
    for (int i = 0; i < couriers.length; i++) {
      final courier = couriers[i];
      final totalParcel = (courier.value['total_parcel'] ?? 0).toDouble();
      final successParcel = (courier.value['success_parcel'] ?? 0).toDouble();
      final cancelledParcel = (courier.value['cancelled_parcel'] ?? 0).toDouble();
      
      courierNames.add(courier.key);
      
      if (totalParcel > maxOrders) {
        maxOrders = totalParcel;
      }
      
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            // Total Orders Bar
            BarChartRodData(
              toY: totalParcel,
              color: const Color(0xFF5E5BF7),
              width: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            // Successful Deliveries Bar
            BarChartRodData(
              toY: successParcel,
              color: const Color(0xFF4CAF50),
              width: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            // Cancelled Orders Bar
            BarChartRodData(
              toY: cancelledParcel,
              color: const Color(0xFFE53935),
              width: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
        ),
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: isDarkMode ? 4 : 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Legend for chart colors
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem('Total Orders', const Color(0xFF5E5BF7), isDarkMode),
                  const SizedBox(width: 16),
                  _buildLegendItem('Successful Deliveries', const Color(0xFF4CAF50), isDarkMode),
                  const SizedBox(width: 16),
                  _buildLegendItem('Cancelled Orders', const Color(0xFFE53935), isDarkMode),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 250,
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxOrders * 1.2, // Add some padding at the top
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: isDarkMode 
                          ? const Color(0xFF2A2A2A) 
                          : const Color(0xFF5E5BF7),
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(12),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final courier = courierNames[groupIndex];
                        String label = '';
                        
                        switch (rodIndex) {
                          case 0:
                            label = 'Total: ${rod.toY.toInt()}';
                            break;
                          case 1:
                            label = 'Delivered: ${rod.toY.toInt()}';
                            break;
                          case 2:
                            label = 'Cancelled: ${rod.toY.toInt()}';
                            break;
                        }
                        
                        return BarTooltipItem(
                          '$courier\n$label',
                          TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: rodIndex == 0 ? 14 : 12,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= courierNames.length) {
                            return const SizedBox.shrink();
                          }
                          
                          final courierName = courierNames[value.toInt()];
                          String displayName = courierName;
                          
                          // Format courier name
                          if (courierName.toLowerCase() == 'pathao') {
                            displayName = 'Pathao';
                          } else if (courierName.toLowerCase() == 'steadfast') {
                            displayName = 'Steadfast';
                          } else if (courierName.toLowerCase() == 'redx') {
                            displayName = 'RedX';
                          } else if (courierName.toLowerCase() == 'paperfly') {
                            displayName = 'Paperfly';
                          }
                          
                          displayName = displayName.substring(0, 1).toUpperCase() + 
                                      (displayName.length > 1 ? displayName.substring(1) : '');
                          
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              displayName,
                              style: TextStyle(
                                color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                            ),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          // Calculate intervals based on max value
                          final interval = (maxOrders / 4).ceil();
                          if (value % interval != 0 || value > maxOrders) {
                            return const SizedBox.shrink();
                          }
                          
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              '${value.toInt()}',
                              style: TextStyle(
                                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: (maxOrders / 4).ceil().toDouble(),
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: barGroups,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              'Courier Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: couriers.length,
              separatorBuilder: (context, index) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final courier = couriers[index];
                final courierName = courier.key.substring(0, 1).toUpperCase() + courier.key.substring(1);
                final totalParcel = courier.value['total_parcel'] ?? 0;
                final successParcel = courier.value['success_parcel'] ?? 0;
                final cancelledParcel = courier.value['cancelled_parcel'] ?? 0;
                final successRatio = courier.value['success_ratio'] ?? 0;

                // Determine color based on success ratio
                Color statusColor;
                if (successRatio >= 80) {
                  statusColor = const Color(0xFF4CAF50);
                } else if (successRatio >= 60) {
                  statusColor = const Color(0xFFFFC107);
                } else {
                  statusColor = const Color(0xFFE53935);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          courierName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$successRatio%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildStatItem(
                            'Total Orders',
                            totalParcel.toString(),
                            Icons.shopping_bag_outlined,
                            const Color(0xFF5E5BF7),
                            isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildStatItem(
                            'Delivered',
                            successParcel.toString(),
                            Icons.check_circle_outline_rounded,
                            const Color(0xFF4CAF50),
                            isDarkMode,
                          ),
                          const SizedBox(width: 12),
                          _buildStatItem(
                            'Cancelled',
                            cancelledParcel.toString(),
                            Icons.cancel_outlined,
                            const Color(0xFFE53935),
                            isDarkMode,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, bool isDarkMode) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF252525) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _searchCustomer() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _hasSearched = false;
    });

    final phoneNumber = _phoneController.text.trim();

    try {
      // Fetch courier check data
      final courierResponse = await http.post(
        Uri.parse('https://courier-fraud.laravel.cloud/ap/courier-check'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phoneNumber}),
      );

      if (courierResponse.statusCode != 200) {
        throw Exception('Failed to check courier data. Please try again.');
      }

      final courierData = jsonDecode(courierResponse.body);

      // Fetch reviews data
      final reviewsResponse = await http.get(
        Uri.parse('https://courier-fraud.laravel.cloud/ap/customer-reviews/$phoneNumber'),
      );

      if (reviewsResponse.statusCode != 200) {
        throw Exception('Failed to get customer reviews. Please try again.');
      }

      final reviewsData = jsonDecode(reviewsResponse.body);

      setState(() {
        _courierData = courierData['courierData'];
        _reviewsData = reviewsData['data'];
        _hasSearched = true;
        _isLoading = false;
      });
      
      // Start animation
      _animationController.forward();
      
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _showAddReviewDialog() {
    final isDarkMode = widget.isDarkMode;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController commentController = TextEditingController();
    final TextEditingController ownNumberController = TextEditingController();
    double rating = 3.0;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Review',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Rate this customer:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                Center(
                  child: RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 36,
                    unratedColor: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) {
                      rating = value;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: isDarkMode ? Colors.grey[400] : null,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: ownNumberController,
                  decoration: InputDecoration(
                    labelText: 'Your Phone Number',
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: isDarkMode ? Colors.grey[400] : null,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    prefixIcon: Icon(
                      Icons.comment_outlined,
                      color: isDarkMode ? Colors.grey[400] : null,
                    ),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate inputs
                      if (nameController.text.isEmpty ||
                          ownNumberController.text.isEmpty ||
                          commentController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all fields'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }
                      
                      try {
                        final response = await http.post(
                          Uri.parse('https://courier-fraud.laravel.cloud/ap/customer-review'),
                          headers: {
                            'Content-Type': 'application/json',
                            // In a real app, you'd handle authentication properly
                            'Authorization': 'Bearer YOUR_BEARER_TOKEN_HERE',
                          },
                          body: jsonEncode({
                            'phone': _phoneController.text,
                            'ownNumber': ownNumberController.text,
                            'name': nameController.text,
                            'rating': rating.toString(),
                            'comment': commentController.text,
                          }),
                        );
                        
                        if (response.statusCode == 200 || response.statusCode == 201) {
                          // Refresh reviews after adding
                          _searchCustomer();
                          Navigator.pop(context);
                          _showSuccessSnackBar('Review added successfully!');
                        } else {
                          throw Exception('Failed to add review');
                        }
                      } catch (e) {
                        _showErrorSnackBar('Error adding review: ${e.toString()}');
                      }
                    },
                    child: const Text(
                      'Submit Review',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(12),
      ),
    );
  }
  
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(12),
      ),
    );
  }
}

class TrustScoreIndicator extends StatelessWidget {
  final double score;
  final Color color;
  final bool isDarkMode;

  const TrustScoreIndicator({
    Key? key,
    required this.score,
    required this.color,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDarkMode ? const Color(0xFF252525) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(isDarkMode ? 0.3 : 0.2),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              value: score / 100,
              strokeWidth: 10,
              backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${score.toInt()}%',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                score >= 75 ? 'Excellent' : (score >= 50 ? 'Average' : 'Poor'),
                style: TextStyle(
                  fontSize: 11,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;
  final bool isDarkMode;

  const ReviewCard({
    Key? key, 
    required this.review,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = review['name'] ?? 'Anonymous';
    final rating = double.tryParse(review['rating'].toString()) ?? 0.0;
    final comment = review['comment'] ?? 'No comment';
    final date = DateTime.tryParse(review['created_at'] ?? '');
    
    String formattedDate;
    if (date != null) {
      // More human-readable date format
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays < 1) {
        formattedDate = 'Today';
      } else if (difference.inDays < 2) {
        formattedDate = 'Yesterday';
      } else if (difference.inDays < 7) {
        formattedDate = '${difference.inDays} days ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        formattedDate = '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
      } else {
        formattedDate = '${date.day}/${date.month}/${date.year}';
      }
    } else {
      formattedDate = 'Unknown date';
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: isDarkMode ? 4 : 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : 'A',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Icon(
                              i < rating.floor()
                                  ? Icons.star_rounded
                                  : (i < rating ? Icons.star_half_rounded : Icons.star_border_rounded),
                              color: Colors.amber,
                              size: 16,
                            ),
                          const SizedBox(width: 8),
                          Text(
                            rating.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  formattedDate,
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF252525) : Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comment:',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}