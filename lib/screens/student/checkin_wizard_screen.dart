import 'package:flutter/material.dart';
import '../../widgets/attendly_app_bar.dart';
import '../../app/theme.dart';

class CheckinWizardScreen extends StatefulWidget {
  const CheckinWizardScreen({super.key});

  @override
  State<CheckinWizardScreen> createState() => _CheckinWizardScreenState();
}

class _CheckinWizardScreenState extends State<CheckinWizardScreen> {
  int _currentStep = 0;

  final List<_StepData> _steps = [
    _StepData(
      title: 'Time Check',
      subtitle: 'Verifying session is active',
      icon: Icons.access_time,
    ),
    _StepData(
      title: 'Location Check',
      subtitle: 'Verifying campus geofence',
      icon: Icons.location_on,
    ),
    _StepData(
      title: 'WiFi Check',
      subtitle: 'Verifying university network',
      icon: Icons.wifi,
    ),
    _StepData(
      title: 'Face Verification',
      subtitle: 'Liveness & identity check',
      icon: Icons.face,
    ),
    _StepData(
      title: 'Confirm',
      subtitle: 'Review & submit attendance',
      icon: Icons.check_circle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AttendlyAppBar(title: 'Check-in'),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: List.generate(_steps.length, (index) {
                final isCompleted = index < _currentStep;
                final isCurrent = index == _currentStep;
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? AttendlyTheme.successColor
                              : isCurrent
                              ? AttendlyTheme.primaryColor
                              : Colors.grey.shade300,
                        ),
                        child: Center(
                          child: isCompleted
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: isCurrent
                                        ? Colors.white
                                        : Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                        ),
                      ),
                      if (index < _steps.length - 1)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: isCompleted
                                ? AttendlyTheme.successColor
                                : Colors.grey.shade300,
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),

          // Current step content
          Expanded(
            child: _currentStep < _steps.length
                ? _buildStepContent(_steps[_currentStep])
                : _buildSuccessContent(),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentStep > 0 && _currentStep < _steps.length)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _currentStep--),
                      child: const Text('Back'),
                    ),
                  ),
                if (_currentStep > 0 && _currentStep < _steps.length)
                  const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentStep >= _steps.length) {
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName('/student-home'),
                        );
                      } else {
                        setState(() => _currentStep++);
                      }
                    },
                    child: Text(
                      _currentStep >= _steps.length
                          ? 'Done'
                          : _currentStep == _steps.length - 1
                          ? 'Submit'
                          : 'Next',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(_StepData step) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AttendlyTheme.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                step.icon,
                size: 48,
                color: AttendlyTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              step.title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              step.subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Step-specific mock content
            if (step.icon == Icons.face) ...[
              // Face verification mock
              Container(
                width: 200,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AttendlyTheme.primaryColor,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Camera Preview\n(Mock)',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Generic check animation mock
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AttendlyTheme.successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AttendlyTheme.successColor,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Verification Passed',
                      style: TextStyle(
                        color: AttendlyTheme.successColor,
                        fontWeight: FontWeight.w600,
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

  Widget _buildSuccessContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AttendlyTheme.successColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                size: 56,
                color: AttendlyTheme.successColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Check-in Successful!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AttendlyTheme.successColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your attendance has been recorded.\nCOS301 – Software Engineering',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            Text(
              'Time: 08:05 AM',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepData {
  final String title;
  final String subtitle;
  final IconData icon;

  const _StepData({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
