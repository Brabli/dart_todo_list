import 'dart:io' show Platform;

void main(List<String> arguments) async {
  // Creates a file at /Users/bradley
  // String homePath = Platform.environment['HOME']!;
}

/// Returns true if the current script is executing from a directory on the PATH
bool currentScriptInPath() {
  String scriptPath = Platform.script.path.substring(
      0,
      Platform.script.path.length -
          Platform.script.pathSegments.last.length -
          1);
  List<String> paths = Platform.environment['PATH']!.split(':');

  return paths.contains(scriptPath);
}
