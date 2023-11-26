import 'package:url_launcher/url_launcher.dart';

Future<bool> openUrl(String? href) async {
  if (href == null) {
    return false;
  }
  final uri = Uri.tryParse(href);
  if (uri == null) {
    return false;
  }

  if (!await launchUrl(uri)) {
    return false;
  }
  return true;
}
