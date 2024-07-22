import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  // Vars
  // final feature = context.vars['feature'] as String;
  final features = context.vars['features'] as List<dynamic>;
  // var vars = <String, dynamic>{'feature_name': feature};

  // Get Directory
  final directory = Directory.current;
  context.logger.info("Directory path - ${directory.toString()}");
  final target = DirectoryGeneratorTarget(directory);

  // Make Brick
  final brick = Brick.version(name: 'clean_archy_feature', version: '0.1.0+2');
  final generator = await MasonGenerator.fromBrick(brick);
  for (var feature in features) {
    // Var for the feature name
    var vars = <String, dynamic>{'feature_name': feature};

    // PreGen Hook
    await generator.hooks.preGen(
      vars: vars,
      onVarsChanged: (vars) => vars = vars,
    );

    // Generate
    final files = await generator.generate(
      target,
      vars: vars,
      logger: context.logger,
      fileConflictResolution: FileConflictResolution.overwrite,
    );

    // PostGen Hook
    await generator.hooks.postGen(
      vars: vars,
      logger: context.logger,
    );
  }
}
