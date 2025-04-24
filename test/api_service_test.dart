import 'package:flutter_test/flutter_test.dart';
import 'package:sample/api_service.dart';
import 'package:sample/model/data.dart';

void main() {
  group('ApiService', (){
    group('getuser function', (){
      test('returns a Person if the http call completes successfully', () async {
        //Arrange where environment is set up
        final ApiService x = ApiService();
        //Act where the function is called in here its getPerson function
        final person = await x.getPerson();
        //Assert where the result is checked
        expect(person, isA<Person>());
      });
      
      test('throws an exception if the http call fails', () async {
        //Arrange where environment is set up in here we creating instance of ApiService
        final  ApiService x = ApiService();
        expect(x.getPerson(), throwsException);
      });
      
    });
  });
  
}