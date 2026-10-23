import 'dart:math' as math;

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'game_over_screen.dart';
import 'view_model.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late final QuizViewModel viewModel = QuizViewModel();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final bool gameOver = viewModel.isGameOver;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          body: gameOver
              ? SafeArea(child: _buildGameOverTransition(context))
              : Column(
                  children: [
                    // Top Purple Gradient Header with StatusBar
                    _buildTopHeader(context),
                    // Scrollable Question & Answers
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Column(
                          children: [
                            QuestionCard(
                              question: viewModel.currentQuestion?.question,
                              questionIndex: viewModel.answeredQuestionCount,
                              totalQuestions: viewModel.totalQuestions,
                            ),
                            const SizedBox(height: 20),
                            AnswerCards(
                              answers:
                                  viewModel.currentQuestion?.possibleAnswers ??
                                      const <String>[],
                              questionKey:
                                  viewModel.currentQuestion?.question ?? '',
                              onTapped: viewModel.checkAnswer,
                              correctAnswer: viewModel.didAnswerQuestion
                                  ? viewModel.currentQuestion?.correctAnswer
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A148C), Color(0xFF6A1B9A), Color(0xFF7E57C2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x3D4A148C),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            children: [
              // Navigation / App title bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.quiz_rounded, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Flutter Animation',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Next Question button
                  FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      backgroundColor: viewModel.hasNextQuestion && viewModel.didAnswerQuestion
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.2),
                      foregroundColor: viewModel.hasNextQuestion && viewModel.didAnswerQuestion
                          ? const Color(0xFF4A148C)
                          : Colors.white54,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: viewModel.hasNextQuestion && viewModel.didAnswerQuestion
                        ? viewModel.getNextQuestion
                        : null,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Next', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // StatusBar with bolt icons and progress bar
              StatusBar(viewModel: viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverTransition(BuildContext context) {
    final Color surface = Theme.of(context).colorScheme.surface;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: double.infinity,
          child: OpenContainer<void>(
            transitionDuration: const Duration(milliseconds: 650),
            closedColor: surface,
            openColor: surface,
            closedElevation: 6,
            openElevation: 0,
            closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            openShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            closedBuilder: (context, openContainer) {
              return InkWell(
                onTap: openContainer,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3E5F5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.emoji_events_rounded,
                          color: Color(0xFF7E57C2),
                          size: 56,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Kuis Selesai!',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF263238),
                            ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Ketuk kartu ini untuk melihat rincian skor akhir Anda.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF78909C), fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5E35B1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Lihat Hasil Skor',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            openBuilder: (context, closeContainer) {
              return GameOverScreen(
                score: viewModel.score,
                totalQuestions: viewModel.totalQuestions,
                onClose: () => closeContainer(),
                onHome: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final String? question;
  final int questionIndex;
  final int totalQuestions;

  const QuestionCard({
    required this.question,
    this.questionIndex = 1,
    this.totalQuestions = 5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 450),
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      layoutBuilder: (entries) {
        return Stack(
          alignment: Alignment.topCenter,
          children: entries,
        );
      },
      child: Card(
        key: ValueKey<String?>(question),
        elevation: 6,
        shadowColor: const Color(0x1F5E35B1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'QUESTION $questionIndex OF $totalQuestions',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF5E35B1),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.help_outline_rounded,
                    color: Color(0xFFB0BEC5),
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                question ?? '',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF263238),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerCards extends StatelessWidget {
  final List<String> answers;
  final String questionKey;
  final ValueChanged<int> onTapped;
  final int? correctAnswer;

  const AnswerCards({
    required this.answers,
    required this.questionKey,
    required this.onTapped,
    required this.correctAnswer,
    super.key,
  });

  static const List<String> _optionLetters = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(answers.length, (index) {
        final bool isSelectedCorrect = correctAnswer == index;
        final bool isAnswered = correctAnswer != null;

        Color cardBg = Colors.white;
        Color borderColor = const Color(0xFFE0E0E0);
        Color textColor = const Color(0xFF37474F);
        Color badgeBg = const Color(0xFFEDE7F6);
        Color badgeColor = const Color(0xFF5E35B1);
        Widget? trailingIcon;

        if (isAnswered) {
          if (isSelectedCorrect) {
            cardBg = const Color(0xFFE8F5E9);
            borderColor = const Color(0xFF4CAF50);
            textColor = const Color(0xFF2E7D32);
            badgeBg = const Color(0xFF4CAF50);
            badgeColor = Colors.white;
            trailingIcon = const Icon(Icons.check_circle_rounded, color: Color(0xFF4CAF50));
          } else {
            cardBg = Colors.white;
            borderColor = const Color(0xFFEEEEEE);
            textColor = const Color(0xFF9E9E9E);
          }
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CardFlipEffect(
            key: ValueKey<String>('answer-slot-$index'),
            delayAmount: index.toDouble() / 2,
            child: Container(
              key: ValueKey<String>('$questionKey-$index'),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderColor, width: 1.8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: correctAnswer == null ? () => onTapped(index) : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        // Option Letter Badge (A, B, C, D)
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: badgeBg,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _optionLetters[index % _optionLetters.length],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: badgeColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Answer text
                        Expanded(
                          child: Text(
                            answers[index],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),
                        if (trailingIcon != null) trailingIcon,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class CardFlipEffect extends StatefulWidget {
  final Widget child;
  final double delayAmount;

  const CardFlipEffect({
    required this.child,
    required this.delayAmount,
    super.key,
  });

  @override
  State<CardFlipEffect> createState() => _CardFlipEffectState();
}

class _CardFlipEffectState extends State<CardFlipEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _animationWithDelay;
  Widget? _previousChild;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _animationWithDelay = _buildDelayedAnimation(widget.delayAmount);
    _animationController.addStatusListener(_handleAnimationStatus);
  }

  Animation<double> _buildDelayedAnimation(double delayAmount) {
    final double safeDelay = delayAmount > 0 ? delayAmount : 0.0;
    final List<TweenSequenceItem<double>> sequenceItems =
        <TweenSequenceItem<double>>[];

    if (safeDelay > 0) {
      sequenceItems.add(
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(0.0),
          weight: safeDelay,
        ),
      );
    }

    sequenceItems.add(
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.easeInOutCubic),
        ),
        weight: 1.0,
      ),
    );

    return TweenSequence<double>(sequenceItems).animate(_animationController);
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed &&
        mounted &&
        _previousChild != null) {
      setState(() {
        _previousChild = null;
      });
    }
  }

  @override
  void didUpdateWidget(covariant CardFlipEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool childChanged = oldWidget.child.key != widget.child.key;
    final bool delayChanged = oldWidget.delayAmount != widget.delayAmount;
    if (!childChanged && !delayChanged) {
      return;
    }

    if (_animationController.isAnimating &&
        _animationWithDelay.value < 0.5) {
      _previousChild = _previousChild ?? oldWidget.child;
    } else {
      _previousChild = oldWidget.child;
    }

    _animationController
      ..stop()
      ..reset();
    _animationWithDelay = _buildDelayedAnimation(widget.delayAmount);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController
      ..removeStatusListener(_handleAnimationStatus)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final bool isFlipping = _animationController.isAnimating;
        final double progress = _animationWithDelay.value;
        final double rotation = isFlipping ? progress : 0.0;
        Widget visibleChild = widget.child;

        if (isFlipping) {
          if (progress < 0.5) {
            visibleChild = _previousChild ?? widget.child;
          } else {
            visibleChild = Transform.flip(
              flipY: true,
              child: widget.child,
            );
          }
        }

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(rotation * math.pi),
          child: visibleChild,
        );
      },
    );
  }
}

class StatusBar extends StatelessWidget {
  final QuizViewModel viewModel;

  const StatusBar({
    required this.viewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int totalQuestions = viewModel.totalQuestions;
    final int answered = viewModel.answeredQuestionCount -
        (viewModel.didAnswerQuestion ? 0 : 1);
    final double progress = totalQuestions == 0
        ? 0.0
        : (answered / totalQuestions).clamp(0.0, 1.0).toDouble();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row Score & Question Count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.bolt, color: Colors.amberAccent, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    'Score: ${viewModel.score}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Text(
                '${viewModel.answeredQuestionCount} of $totalQuestions',
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Row of bolt icons (AnimatedScoreIcon)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(
                totalQuestions,
                (index) => AnimatedScoreIcon(
                  key: ValueKey<String>('score-icon-$index'),
                  isActive: index < viewModel.score,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Smooth Animated Progress Bar
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: progress),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 7,
                  color: const Color(0xFFFF9100), // Vibrant amber/orange
                  backgroundColor: Colors.white.withValues(alpha: 0.22),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AnimatedScoreIcon extends StatelessWidget {
  final bool isActive;

  const AnimatedScoreIcon({
    required this.isActive,
    super.key,
  });

  static const Duration _duration = Duration(milliseconds: 850);
  static const Curve _curve = Curves.elasticOut;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isActive ? 1.15 : 0.6,
      duration: _duration,
      curve: _curve,
      child: TweenAnimationBuilder<Color?>(
        duration: _duration,
        curve: _curve,
        tween: ColorTween(
          begin: Colors.white38,
          end: isActive ? Colors.deepOrange : Colors.white38,
        ),
        builder: (context, color, child) {
          return Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isActive ? Colors.deepOrange.withValues(alpha: 0.18) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bolt,
              size: 26,
              color: color,
            ),
          );
        },
      ),
    );
  }
}
