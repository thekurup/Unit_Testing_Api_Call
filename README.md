# Flutter API Testing

## Project Overview

This project demonstrates how to implement and test API calls in Flutter applications. It focuses on testing HTTP requests, handling API responses, and ensuring your app properly manages both successful responses and error cases.

## 🌐 What's Inside

- Basic model class with JSON serialization
- API service with HTTP request implementation
- Unit tests for API functionality
- UI integration with FutureBuilder
- Error handling for failed requests

## 📁 Project Structure

```
lib/
  ├── api_service.dart       # API service implementation
  ├── model/
  │   └── data.dart          # Person model with JSON parsing
  └── main.dart              # Main app with UI implementation
test/
  └── api_service_test.dart  # Unit tests for API service
```

## 🔍 Key Components

### 1. Person Model Class

The `Person` class represents the data structure we're fetching from the API:

```dart
class Person {
  final String name;
  final int age;
  final String email;

  Person({required this.name, required this.age, required this.email});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      age: json['age'],
      email: json['email'],
      name: json['name'],
    );
  }
}
```

### 2. API Service

The `ApiService` class handles the HTTP communication with the backend:

```dart
class ApiService {
  Future<Person> getPerson() async {
    final response = await http.get(
      Uri.parse("https://run.mocky.io/v3/95234dec-fc30-477b-97c6-12c58a0c0e93")
    );
    
    if (response.statusCode == 200) {
      return Person.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }
}
```

### 3. UI Implementation

The main UI uses `FutureBuilder` to handle the asynchronous API response:

```dart
FutureBuilder(
  future: apiService.getPerson(), 
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      final person = snapshot.data!;
      return Text('Name: ${person.name}, Age: ${person.age}, Email: ${person.email}');
    }
  },
)
```

## 📚 Testing Approach

The API service is tested with two main test cases:

### 1. Success Case Test

```dart
test('returns a Person if the http call completes successfully', () async {
  //Arrange where environment is set up
  final ApiService x = ApiService();
  //Act where the function is called in here its getPerson function
  final person = await x.getPerson();
  //Assert where the result is checked
  expect(person, isA<Person>());
});
```

This test verifies that:
- The API call successfully completes
- The JSON response is correctly parsed
- A valid Person object is returned

### 2. Error Case Test

```dart
test('throws an exception if the http call fails', () async {
  //Arrange where environment is set up in here we creating instance of ApiService
  final ApiService x = ApiService();
  expect(x.getPerson(), throwsException);
});
```

This test verifies that:
- The API service throws an exception when the HTTP call fails
- Error handling is working as expected

## 🚀 Running the Tests

To run the tests, use the following command:

```bash
flutter test
```

Or run individual test files:

```bash
flutter test test/api_service_test.dart
```

## 🎓 Learning Points

This project demonstrates:

1. **API Integration**: How to make HTTP requests in Flutter
2. **JSON Parsing**: Converting JSON responses to Dart objects
3. **Async Testing**: Testing asynchronous API calls
4. **Error Handling**: Managing failed requests gracefully
5. **UI Integration**: Using FutureBuilder to display API data

## 📝 Notes About API Testing

### Current Limitations

The current testing approach has some limitations:

1. **Real Network Calls**: Tests make actual network requests, which:
   - Makes tests slower and less reliable
   - Creates external dependencies
   - May incur costs for paid APIs

2. **Limited Scenario Testing**: We can't easily test:
   - Various HTTP status codes
   - Different response formats
   - Network timeouts
   - Rate limiting

### Recommended Improvements

For production code, consider these improvements:

1. **Mock HTTP Client**:
   ```dart
   class ApiService {
     final http.Client client;
     
     ApiService({http.Client? client}) : this.client = client ?? http.Client();
     
     Future<Person> getPerson() async {
       final response = await client.get(...);
       // Rest of method
     }
   }
   ```

2. **Test with Mocks**:
   ```dart
   test('returns Person on successful call', () async {
     final mockClient = MockClient();
     when(mockClient.get(any)).thenAnswer((_) async => 
       http.Response('{"name":"John","age":30,"email":"john@example.com"}', 200)
     );
     
     final apiService = ApiService(client: mockClient);
     final person = await apiService.getPerson();
     
     expect(person.name, equals("John"));
   });
   ```

## 🔄 API Testing Workflow

Comprehensive API testing should cover:

```
1. Setup (mocks or test environment)
   ├── Test successful responses
   │   ├── Test correct data parsing
   │   └── Test edge cases (empty fields, null values)
   └── Test error scenarios
       ├── Test 404, 500, etc. status codes
       ├── Test timeout handling
       └── Test malformed JSON responses
```

## 📈 Next Steps

After mastering these basics, you might want to explore:

- **Mocking with mockito** or other mocking libraries
- **HTTP interceptors** for logging and debugging
- **Repository pattern** for better separation of concerns
- **Caching strategies** for API responses
- **Authentication** for protected API endpoints
- **Integration testing** for complete API flows
