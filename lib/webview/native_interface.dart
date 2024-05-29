// interface 정의

enum NativeError { noSuchInterface, wrongInputParams, unknown }

enum NativeInterface implements Comparable<NativeInterface> {
  // toast
  showToast("showToast");

  const NativeInterface(this.name);

  final String name;

  @override
  int compareTo(NativeInterface other) => name == other.name ? 1 : 0;
}

class WebViewMessage {
  // ( 웹뷰 -> 앱 ) 통신 interface 구조
  String name;
  Map? params;
  String? callback;

  WebViewMessage(this.name, this.params, this.callback);

  WebViewMessage.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        params = json['params'],
        callback = json['callback'];
}
