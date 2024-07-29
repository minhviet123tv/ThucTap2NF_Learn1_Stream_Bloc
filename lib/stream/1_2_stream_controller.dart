import 'dart:async';

//I. Stream quản lý 1 number
class MyStreamNumber {
  //1. Tạo StreamController: Dùng ở nhiều chỗ (UI) thì bắt buộc phải đặt <>.broadcast() (nếu không sẽ bị lỗi)
  // Nếu chỉ đặt 1 nơi để sử dụng (UI) thì chỉ cần đặt StreamController<int>();
  StreamController<int> controller = StreamController<int>.broadcast();
  Sink get sink => controller.sink; // Thêm dữ liệu
  Stream get stream => controller.stream; // Lấy dữ liệu

  int count = 0;

  //2. increase
  increase(){
    count++;
    sink.add(count);
  }

  //3. StreamTransformer: Hàm xử lý (1 lần) trước khi được lấy ra (tuỳ sử dụng) | <int, int>: Định dạng dữ liệu vào và ra | data: của Stream, sink: thêm data cho Stream
  //Nếu sử dụng thì cần thêm hàm khi lấy ra bằng: .stream.transform();
  final _counterTranformer = StreamTransformer<int, int>.fromHandlers(handleData: (data, sink){
    data += 10; // Tăng thêm 10
    sink.add(data); // Thêm data vào Stream bằng sink của StreamController
  });

  //4. Lấy dữ liệu ra (sau khi StreamTransformer)
  Stream get getByTranformer {
    return controller.stream.transform(_counterTranformer); //Nếu không dùng Transformer thì chỉ cần: _counterController.stream
  }

  //5. Đóng luồng Stream, làm sạch
  void dispose(){
    controller.close();
  }

}


//II. Stream quản lý 1 String
class MyStreamString {
  StreamController controller = StreamController<String>.broadcast(); // <>.broadcast() : Dùng ở nhiều chỗ thì bắt buộc phải đặt (nếu không sẽ bị lỗi)
  Sink get sink => controller.sink;
  Stream get stream => controller.stream;

  addData(String data){
    sink.add(data);
  }
}

// class controlObjectStream {
//   StreamController
// }