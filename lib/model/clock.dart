
class Clock {

bool _running = true;


Stream<String> clock() async* {
  while(_running) {
    await Future.delayed(const Duration(seconds: 1));
    DateTime _now = DateTime.now();
    yield "${_now.hour} : ${_now.minute} : ${_now.second}";

  }
  // int num = 10;
  // while(num > 0) {
  //   await Future.delayed(Duration(seconds: 2));
  //   yield "Counting ${num}";
  //   num--;
  // }
  // yield "Congratulation finished";
}





}