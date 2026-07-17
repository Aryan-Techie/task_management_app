// About screen — shows app identity, version, brand info, and links
// Part of the AROICE Tasks alpha release

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Brand badge ──────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                AppConstants.brandName,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.4,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── App icon placeholder ──────────────────────────────────────
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Icons.check_rounded,
                size: 48,
                color: colorScheme.onPrimary,
              ),
            ),

            const SizedBox(height: 20),

            // ── App name ─────────────────────────────────────────────────
            Text(
              AppConstants.appName,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 6),

            // ── Tagline ──────────────────────────────────────────────────
            Text(
              AppConstants.appTagline,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // ── Version chip ─────────────────────────────────────────────
            Chip(
              avatar: Icon(
                Icons.science_outlined,
                size: 16,
                color: colorScheme.primary,
              ),
              label: Text(
                'v${AppConstants.appVersion}',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: colorScheme.primaryContainer.withValues(alpha: 0.5),
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),

            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 28),

            // ── Built by section ─────────────────────────────────────────
            _SectionLabel(label: 'Built by'),
            const SizedBox(height: 12),

            _InfoTile(
              icon: Icons.person_outline_rounded,
              title: AppConstants.developerName,
              subtitle: 'Developer',
            ),

            const SizedBox(height: 8),

            _InfoTile(
              icon: Icons.language_rounded,
              title: AppConstants.brandName,
              subtitle: AppConstants.brandWebsite.replaceFirst('https://', ''),
              onTap: () => _launch(AppConstants.brandWebsite),
              isLink: true,
            ),

            const SizedBox(height: 8),

            _InfoTile(
              icon: Icons.code_rounded,
              title: 'Source Code',
              subtitle: 'github.com/aryan-techie',
              onTap: () => _launch(AppConstants.developerGithub),
              isLink: true,
            ),

            const SizedBox(height: 28),
            const Divider(),
            const SizedBox(height: 28),

            // ── Tech section ─────────────────────────────────────────────
            _SectionLabel(label: 'Built with'),
            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: const [
                _TechChip(label: 'Flutter'),
                _TechChip(label: 'Riverpod 3'),
                _TechChip(label: 'GoRouter'),
                _TechChip(label: 'Dio'),
                _TechChip(label: 'Material 3'),
              ],
            ),

            const SizedBox(height: 48),

            // ── Footer ───────────────────────────────────────────────────
            Text(
              '© 2026 ${AppConstants.brandName}. All rights reserved.',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              'Alpha software — features and design may change.',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ── Reusable sub-widgets ──────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isLink;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.isLink = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 20, color: colorScheme.primary),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isLink
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              if (isLink)
                Icon(
                  Icons.open_in_new_rounded,
                  size: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}
