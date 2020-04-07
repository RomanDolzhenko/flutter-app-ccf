import 'dart:async';

void main() {
  // ignore: close_sinks
  final controller = StreamController();
  final order = Order('banana');
  final baker = StreamTransformer.fromHandlers(
    handleData: (cakeType, sink) {
      if(cakeType == 'chocolet')
        sink.add(Cake());
      else
        sink.addError('We in shit');
    }
  );
  controller.sink.add(order);

  controller.stream
    .map((order) => order.type)
    .transform(baker)
    .listen(
      (cake) => print('Here we go'),
      onError: (err) => print(err)
    );

}

class Cake{}

class Order{
  String type;
  Order(this.type);
}