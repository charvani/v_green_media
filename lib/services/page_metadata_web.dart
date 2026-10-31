
import 'package:web/web.dart' as web;

void setPageMetadata({
  required String title,
  required String description,
  required String imageUrl,
}) {
  web.document.title = title;
  _setMeta('name', 'description', description);
  _setMeta('property', 'og:title', title);
  _setMeta('property', 'og:description', description);
  _setMeta('property', 'og:image', imageUrl);
  _setMeta('name', 'twitter:title', title);
  _setMeta('name', 'twitter:description', description);
  _setMeta('name', 'twitter:image', imageUrl);
}

void _setMeta(String attribute, String key, String value) {
  final selector = 'meta[$attribute="$key"]';
  final existing = web.document.querySelector(selector);
  final element = existing ?? web.document.createElement('meta');
  element.setAttribute(attribute, key);
  element.setAttribute('content', value);
  if (existing == null) web.document.head?.appendChild(element);
}
