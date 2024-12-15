# Dart
.PHONY: format

format:
	dart format .

# Publishing
.PHONY: dry_run publish

dry_run:
	dart pub publish --dry-run

publish:
	dart pub publish