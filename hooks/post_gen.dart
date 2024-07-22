import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Getting Packages...');
  await Process.run('flutter', ['packages', 'add', 'go_router', 'fpdart', 'flutter_bloc', '']);

  progress.complete();
}
