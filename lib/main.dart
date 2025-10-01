// lib/main.dart
// Flutter — Class & Inheritance Encyclopedia (Single-file)
// Detailed reference covering classes, inheritance, polymorphism, abstract classes,
// interfaces, mixins, encapsulation, constructors, methods, parameters, static members,
// generics, copyWith, serialization, operator overloading, and extensions.
// Copy this entire file into lib/main.dart of a Flutter project and run.

import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(const ClassEncyclopediaApp());
}

class ClassEncyclopediaApp extends StatelessWidget {
  const ClassEncyclopediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Class Encyclopedia',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class Topic {
  final String id;
  final String title;
  final Widget page;
  Topic({required this.id, required this.title, required this.page});
}

// ---------------- Home / Navigation ----------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _search = TextEditingController();
  late final List<Topic> topics;

  @override
  void initState() {
    super.initState();
    topics = [
      Topic(id: 'intro', title: 'Introduction to Classes', page: const IntroPage()),
      Topic(id: 'syntax', title: 'Class Syntax & Fields', page: const SyntaxPage()),
      Topic(id: 'constructors', title: 'Constructors (default, named, factory)', page: const ConstructorsPage()),
      Topic(id: 'methods', title: 'Methods & Parameters', page: const MethodsPage()),
      Topic(id: 'encapsulation', title: 'Encapsulation (getters/setters)', page: const EncapsulationPage()),
      Topic(id: 'static', title: 'Static Members & Singletons', page: const StaticPage()),
      Topic(id: 'inheritance', title: 'Inheritance Basics', page: const InheritanceBasicPage()),
      Topic(id: 'override', title: 'Method Overriding & super', page: const OverridePage()),
      Topic(id: 'polymorphism', title: 'Polymorphism & Interfaces', page: const PolymorphismPage()),
      Topic(id: 'abstract', title: 'Abstract Classes', page: const AbstractPage()),
      Topic(id: 'mixins', title: 'Mixins & with', page: const MixinsPage()),
      Topic(id: 'generics', title: 'Generics & Type Constraints', page: const GenericsPage()),
      Topic(id: 'copywith', title: 'copyWith & Immutability', page: const CopyWithPage()),
      Topic(id: 'serialization', title: 'Serialization (toJson/fromJson)', page: const SerializationPage()),
      Topic(id: 'operators', title: 'Operator Overloading & Equality', page: const OperatorsPage()),
      Topic(id: 'extensions', title: 'Extensions', page: const ExtensionsPage()),
      Topic(id: 'realworld', title: 'Real-world Example: Shapes & Animals', page: const RealWorldPage()),
      Topic(id: 'playground', title: 'Live Playground (demos)', page: const PlaygroundPage()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _search.text.isEmpty
        ? topics
        : topics.where((t) => t.title.toLowerCase().contains(_search.text.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Class & Inheritance Encyclopedia')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _search,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search topics...', border: OutlineInputBorder()),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Expanded(
            child: ListView(
              children: filtered.map((t) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(t.title),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => t.page)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: const Text('Topics', style: TextStyle(color: Colors.white, fontSize: 20)), decoration: BoxDecoration(color: Colors.indigo)),
            ...topics.map((t) => ListTile(title: Text(t.title), onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => t.page)); })),
          ],
        ),
      ),
    );
  }
}

// ---------------- Topic template ----------------
class TopicTemplate extends StatelessWidget {
  final String title;
  final String description; // long explanation
  final String code; // example code
  final Widget? demo; // optional live demo widget

  const TopicTemplate({super.key, required this.title, required this.description, required this.code, this.demo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 14),
            const Text('Code (copyable):', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(6)),
              child: SelectableText(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
            ),
            const SizedBox(height: 16),
            if (demo != null) const Text('Live demo:', style: TextStyle(fontWeight: FontWeight.bold)),
            if (demo != null) const SizedBox(height: 8),
            if (demo != null) demo!,
          ],
        ),
      ),
    );
  }
}

// ---------------- Pages ----------------

// 1. Introduction
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Why classes?
- Classes group related state (fields) and behavior (methods).
- Instances (objects) are created from classes.
- OOP principles: Encapsulation, Inheritance, Polymorphism, Abstraction.

This encyclopedia focuses on how to use Dart classes effectively in Flutter apps, with patterns and live demos.
''';
    const code = '''
// Minimal class
class Person {
  String name;
  int age;
  Person(this.name, this.age);
  void greet() => print('Hello \$name, \$age');
}
''';
    return TopicTemplate(title: 'Introduction to Classes', description: desc, code: code);
  }
}

// 2. Syntax & Fields
class SyntaxPage extends StatelessWidget {
  const SyntaxPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Class syntax:
- Use 'class' keyword.
- Fields: instance variables (use final for immutability).
- Private members: start with underscore (_).
- Getters/setters for controlled access.

Use 'late' for deferred initialization, 'const' constructors for compile-time constants.
''';
    const code = '''
class Product {
  final String id;
  String name;
  double price;
  Product({required this.id, required this.name, required this.price});
}
''';
    final demo = Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('Demo: Product instance'),
          SizedBox(height: 8),
          Text('Create Product(id: "p1", name: "Shoe", price: 49.99)'),
        ]),
      ),
    );
    return TopicTemplate(title: 'Class Syntax & Fields', description: desc, code: code, demo: demo);
  }
}

// 3. Constructors (default, named, factory)
class ConstructorsPage extends StatelessWidget {
  const ConstructorsPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Constructors:
- Default constructor: Person(this.name, this.age);
- Named constructors: Person.guest();
- Redirecting constructors: A.fromB(...) : this(...);
- Factory constructor: return cached instances or subclasses.

Factory constructor is useful for singletons, caching, parsing.
''';
    const code = '''
class Point {
  final int x, y;
  const Point(this.x, this.y);
  Point.origin() : x = 0, y = 0;
  factory Point.fromJson(Map<String,int> j) => Point(j['x']!, j['y']!);
}
''';
    final demo = Builder(builder: (context) {
      final p1 = const Point(3, 4);
      final p2 = Point.origin();
      final p3 = Point.fromJson({'x': 7, 'y': 8});
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Point p1: (${p1.x}, ${p1.y})'),
            Text('Point origin: (${p2.x}, ${p2.y})'),
            Text('Point fromJson: (${p3.x}, ${p3.y})'),
          ]),
        ),
      );
    });
    return TopicTemplate(title: 'Constructors', description: desc, code: code, demo: demo);
  }
}

class Point {
  final int x, y;
  const Point(this.x, this.y);
  Point.origin() : x = 0, y = 0;
  factory Point.fromJson(Map<String, int> j) => Point(j['x']!, j['y']!);
}

// 4. Methods & Parameters
class MethodsPage extends StatelessWidget {
  const MethodsPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Methods are functions inside classes. Parameters:
- Positional: int add(int a, int b)
- Optional positional: void f([int? x])
- Named: void greet({String? name})
- Use required for named params in null-safety.
''';
    const code = '''
class Calculator {
  int add(int a, int b) => a + b;
  int mul(int a, int b) => a * b;
  void printResult(String label, int value) => print('\$label: \$value');
}
''';
    final demo = Builder(builder: (context) {
      final calc = Calculator();
      final add = calc.add(2, 3);
      final mul = calc.mul(4, 5);
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('2 + 3 = $add'),
            Text('4 * 5 = $mul'),
          ]),
        ),
      );
    });
    return TopicTemplate(title: 'Methods & Parameters', description: desc, code: code, demo: demo);
  }
}

class Calculator {
  int add(int a, int b) => a + b;
  int mul(int a, int b) => a * b;
  void printResult(String label, int value) => debugPrint('$label: $value');
}

// 5. Encapsulation (getters/setters)
class EncapsulationPage extends StatelessWidget {
  const EncapsulationPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Encapsulation:
- Make fields private (_field).
- Provide getters and setters for validation.
- Use computed getters for derived values.
''';
    const code = '''
class BankAccount {
  double _balance = 0;
  double get balance => _balance;
  void deposit(double amount) {
    if (amount <= 0) throw ArgumentError('positive amount');
    _balance += amount;
  }
}
''';
    final demo = Builder(builder: (context) {
      final acct = BankAccount();
      acct.deposit(100);
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text('Balance after depositing 100: ${acct.balance}'),
        ),
      );
    });
    return TopicTemplate(title: 'Encapsulation', description: desc, code: code, demo: demo);
  }
}

class BankAccount {
  double _balance = 0;
  double get balance => _balance;
  void deposit(double amount) {
    if (amount <= 0) throw ArgumentError('amount must be positive');
    _balance += amount;
  }
}

// 6. Static members & singletons
class StaticPage extends StatelessWidget {
  const StaticPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Static members:
- Belong to the class, not instance. Access via ClassName.member.
Singleton pattern:
- Use a private constructor + static instance or factory.

Prefer dependency injection over singletons for testability.
''';
    const code = '''
class Config {
  static final Config _instance = Config._internal();
  factory Config() => _instance;
  Config._internal();
  String api = "https://api.example.com";
}
''';
    final demo = Builder(builder: (context) {
      final a = Config();
      final b = Config();
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text('Singleton equality: ${identical(a, b)} (should be true)'),
        ),
      );
    });
    return TopicTemplate(title: 'Static Members & Singleton', description: desc, code: code, demo: demo);
  }
}

class Config {
  static final Config _instance = Config._internal();
  factory Config() => _instance;
  Config._internal();
  String api = 'https://api.example.com';
}

// 7. Inheritance basics
class InheritanceBasicPage extends StatelessWidget {
  const InheritanceBasicPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Inheritance:
- Use 'extends' to reuse implementation.
- Child classes inherit fields/methods from parent.
- Prefer composition over inheritance when possible.
''';
    const code = '''
class Animal {
  void eat() => print('Animal eats');
}
class Dog extends Animal {
  void bark() => print('Dog barks');
}
''';
    final demo = Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
      Text('Dog inherits eat() from Animal'),
      Text('Dog has bark() method'),
    ])));
    return TopicTemplate(title: 'Inheritance Basics', description: desc, code: code, demo: demo);
  }
}

class Animal {
  void eat() => debugPrint('Animal eats');
}

class Dog extends Animal {
  void bark() => debugPrint('Dog barks');
}

// 8. Method overriding & super
class OverridePage extends StatelessWidget {
  const OverridePage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Method overriding:
- Child can change parent behavior by overriding method.
- Use @override annotation.
- Use super.methodName() to call parent implementation.
''';
    const code = '''
class Vehicle { void move() => print('Vehicle moves'); }
class Car extends Vehicle {
  @override
  void move() {
    super.move();
    print('Car drives');
  }
}
''';
    final demo = Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
      Text('Car.move() calls Vehicle.move() then adds its own behavior'),
    ])));
    return TopicTemplate(title: 'Method Overriding & super', description: desc, code: code, demo: demo);
  }
}

class Vehicle {
  void move() => debugPrint('Vehicle moves');
}

class CarDemo extends Vehicle {
  @override
  void move() {
    super.move();
    debugPrint('Car drives');
  }
}

// 9. Polymorphism & interfaces (implements)
class PolymorphismPage extends StatelessWidget {
  const PolymorphismPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Polymorphism:
- Objects of different classes can be treated as instances of the same base type.
- Interfaces in Dart: any class can be used as an interface via 'implements'.
- Use interfaces to enforce contracts without sharing implementation.
''';
    const code = '''
abstract class Printer { void printDoc(String doc); }
class DotMatrix implements Printer {
  @override void printDoc(String doc) => print('DotMatrix: \$doc');
}
class Laser implements Printer {
  @override void printDoc(String doc) => print('Laser: \$doc');
}
''';
    final demo = Builder(builder: (context) {
      final printers = <PrinterContract>[DotMatrixPrinter(), LaserPrinter()];
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (var p in printers) Text('Printer type: ${p.runtimeType} -> ${p.printDocStr('Hello')}'),
          ]),
        ),
      );
    });
    return TopicTemplate(title: 'Polymorphism & Interfaces', description: desc, code: code, demo: demo);
  }
}

abstract class PrinterContract {
  String printDocStr(String doc);
}

class DotMatrixPrinter implements PrinterContract {
  @override
  String printDocStr(String doc) => 'DotMatrix prints: $doc';
}

class LaserPrinter implements PrinterContract {
  @override
  String printDocStr(String doc) => 'Laser prints: $doc';
}

// 10. Abstract classes
class AbstractPage extends StatelessWidget {
  const AbstractPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Abstract classes:
- Can contain abstract methods (no body) and implemented members.
- Cannot be instantiated.
- Subclasses must implement abstract members unless they are abstract too.
''';
    const code = '''
abstract class Shape {
  double area();
}
class Circle extends Shape {
  final double r;
  Circle(this.r);
  @override double area() => 3.1415 * r * r;
}
''';
    final demo = Builder(builder: (context) {
      final circle = CircleS(5);
      return Card(child: Padding(padding: const EdgeInsets.all(12), child: Text('Circle area for r=5 -> ${circle.area().toStringAsFixed(2)}')));
    });
    return TopicTemplate(title: 'Abstract Classes', description: desc, code: code, demo: demo);
  }
}

// Use ShapeS / CircleS / RectangleS below for consistent types
abstract class ShapeBase {
  double area();
}

class CircleS extends ShapeBase {
  final double r;
  CircleS(this.r);
  @override
  double area() => 3.141592653589793 * r * r;
}

// 11. Mixins
class MixinsPage extends StatelessWidget {
  const MixinsPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Mixins:
- Reuse code across classes without inheritance chain.
- Use 'mixin' keyword and 'with' to apply.
- Use 'on' to restrict mixin to certain base types.
''';
    const code = '''
mixin Logger { void log(String m) => print('[LOG] \$m'); }
class Service with Logger { void doWork() => log('work'); }
''';
    final demo = Builder(builder: (context) {
      final s = ServiceDemo();
      s.doWork();
      return Card(child: Padding(padding: const EdgeInsets.all(12), child: const Text('Service.doWork() invoked (check console log)')));
    });
    return TopicTemplate(title: 'Mixins', description: desc, code: code, demo: demo);
  }
}

mixin LoggerMixin {
  void log(String m) => debugPrint('[LOG] $m');
}

class ServiceDemo with LoggerMixin {
  void doWork() => log('doing work');
}

// 12. Generics & type constraints
class GenericsPage extends StatelessWidget {
  const GenericsPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Generics:
- Make classes/methods reusable for different types.
- Constraints: class Box<T extends num> { ... }
- Improves type-safety and avoids casts.
''';
    const code = '''
class Box<T> {
  final T value;
  Box(this.value);
}
final intBox = Box<int>(42);
''';
    final demo = Builder(builder: (context) {
      final b = BoxGeneric<int>(42);
      return Card(child: Padding(padding: const EdgeInsets.all(12), child: Text('Box<int> contains: ${b.value}')));
    });
    return TopicTemplate(title: 'Generics & Type Constraints', description: desc, code: code, demo: demo);
  }
}

class BoxGeneric<T> {
  final T value;
  BoxGeneric(this.value);
}

// 13. copyWith & immutability
class CopyWithPage extends StatelessWidget {
  const CopyWithPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Immutability + copyWith:
- Immutable data classes use final fields.
- copyWith returns a modified copy preserving other fields.
- Useful in state management.
''';
    const code = '''
class Person {
  final String name;
  final int age;
  const Person({required this.name, required this.age});
  Person copyWith({String? name, int? age}) => Person(name: name ?? this.name, age: age ?? this.age);
}
''';
    final demo = Builder(builder: (context) {
      const p1 = PersonData(name: 'Alice', age: 30);
      final p2 = p1.copyWith(age: 31);
      return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Original: ${p1.name}, ${p1.age}'),
        Text('Modified: ${p2.name}, ${p2.age}'),
      ])));
    });
    return TopicTemplate(title: 'copyWith & Immutability', description: desc, code: code, demo: demo);
  }
}

class PersonData {
  final String name;
  final int age;
  const PersonData({required this.name, required this.age});
  PersonData copyWith({String? name, int? age}) => PersonData(name: name ?? this.name, age: age ?? this.age);
}

// 14. Serialization
class SerializationPage extends StatelessWidget {
  const SerializationPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Serialization:
- Convert objects to Map<String, dynamic> and JSON strings.
- Implement toJson and fromJson (factory).
- For large projects, use json_serializable for generated code.
''';
    const code = '''
class Todo {
  final String id;
  final String title;
  Todo({required this.id, required this.title});
  factory Todo.fromJson(Map<String,dynamic> j) => Todo(id: j['id'], title: j['title']);
  Map<String,dynamic> toJson() => {'id': id, 'title': title};
}
''';
    final demo = Builder(builder: (context) {
      final t = TodoModel(id: '1', title: 'Write docs');
      final jsonStr = jsonEncode(t.toJson());
      final parsed = TodoModel.fromJson(jsonDecode(jsonStr));
      return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Serialized: $jsonStr'),
        Text('Parsed title: ${parsed.title}'),
      ])));
    });
    return TopicTemplate(title: 'Serialization (toJson/fromJson)', description: desc, code: code, demo: demo);
  }
}

class TodoModel {
  final String id;
  final String title;
  TodoModel({required this.id, required this.title});
  factory TodoModel.fromJson(Map<String, dynamic> j) => TodoModel(id: j['id'] as String, title: j['title'] as String);
  Map<String, dynamic> toJson() => {'id': id, 'title': title};
}

// 15. Operators & equality
class OperatorsPage extends StatelessWidget {
  const OperatorsPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Operator overloading:
- Define operators (+, -, ==, [] etc.) in classes.
- When overriding ==, also override hashCode.
''';
    const code = '''
class Vec {
  final double x,y;
  Vec(this.x,this.y);
  Vec operator +(Vec o) => Vec(x+o.x, y+o.y);
  @override bool operator ==(Object o) => o is Vec && o.x==x && o.y==y;
  @override int get hashCode => Object.hash(x,y);
}
''';
    final demo = Builder(builder: (context) {
      final a = Vec(1, 2);
      final b = Vec(3, 4);
      final c = a + b;
      return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('a + b = (${c.x}, ${c.y})'),
      ])));
    });
    return TopicTemplate(title: 'Operator Overloading & Equality', description: desc, code: code, demo: demo);
  }
}

class Vec {
  final double x, y;
  Vec(this.x, this.y);
  Vec operator +(Vec o) => Vec(x + o.x, y + o.y);
  @override
  bool operator ==(Object other) => other is Vec && other.x == x && other.y == y;
  @override
  int get hashCode => Object.hash(x, y);
}

// 16. Extensions
class ExtensionsPage extends StatelessWidget {
  const ExtensionsPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Extensions:
- Add methods/getters to existing types without modifying them.
- Great for convenience helpers.
''';
    const code = '''
extension StringX on String {
  String get firstChar => isEmpty ? '' : this[0];
}
''';
    final demo = Builder(builder: (context) {
      final s = 'hello';
      return Card(child: Padding(padding: const EdgeInsets.all(12), child: Text('"$s".firstChar => ${s.firstChar}')));
    });
    return TopicTemplate(title: 'Extensions', description: desc, code: code, demo: demo);
  }
}

extension StringX on String {
  String get firstChar => isEmpty ? '' : this[0];
}

// 17. Real-world example: Shapes & Animals
class RealWorldPage extends StatelessWidget {
  const RealWorldPage({super.key});
  @override
  Widget build(BuildContext context) {
    const desc = '''
Real-world example showing inheritance, polymorphism and abstract classes:
- Shape (abstract) -> CircleS, RectangleS
- Animal (base) -> Dog, Cat with overridden methods
''';
    const code = '''
abstract class Shape { double area(); }
class RectangleS extends Shape { final double w,h; RectangleS(this.w,this.h); @override double area() => w*h; }
class CircleS extends Shape { final double r; CircleS(this.r); @override double area() => 3.14*r*r; }
''';
    final demo = Builder(builder: (context) {
      final shapes = <ShapeBase>[RectangleS(3, 4), CircleS(2)];
      return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        for (var s in shapes) Text('${s.runtimeType} area = ${s.area().toStringAsFixed(2)}'),
      ])));
    });
    return TopicTemplate(title: 'Real-world Examples', description: desc, code: code, demo: demo);
  }
}

class RectangleS extends ShapeBase {
  final double w, h;
  RectangleS(this.w, this.h);
  @override
  double area() => w * h;
}

// 18. Live Playground (interactive demos)
class PlaygroundPage extends StatefulWidget {
  const PlaygroundPage({super.key});
  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  int counter = 0;
  final List<String> logs = [];

  void _addLog(String s) => setState(() => logs.insert(0, s));

  @override
  Widget build(BuildContext context) {
    const desc = '''
Live Playground:
- Small interactive demos that show class usage in UI.
- Press buttons to run examples and see results in the log.
''';
    const code = '''
// Demo code executed by buttons: increment counter, create objects, serialize.
''';
    return TopicTemplate(
      title: 'Live Playground',
      description: desc,
      code: code,
      demo: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          ElevatedButton(onPressed: () {
            setState(() => counter++);
            _addLog('Counter incremented to $counter');
          }, child: const Text('Increment Counter')),
          const SizedBox(width: 8),
          ElevatedButton(onPressed: () {
            final p = PersonData(name: 'Demo', age: counter);
            _addLog('Created PersonData: ${p.name}, ${p.age}');
          }, child: const Text('Create Person')),
        ]),
        const SizedBox(height: 8),
        ElevatedButton(onPressed: () {
          final todo = TodoModel(id: 't${logs.length}', title: 'Task ${logs.length}');
          _addLog('Serialized todo: ${jsonEncode(todo.toJson())}');
        }, child: const Text('Serialize Todo')),
        const SizedBox(height: 12),
        const Text('Logs:', style: TextStyle(fontWeight: FontWeight.bold)),
        Container(height: 200, padding: const EdgeInsets.all(8), color: Colors.grey[100], child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: logs.map((s) => Text('- $s')).toList()))),
      ]),
    );
  }
}

// ---------------- Misc (helpers repeated above) ----------------
// Already defined: Point, Calculator, BankAccount, Config, Dog, Animal, etc.
// Also ensure types used in lists are consistent (ShapeBase used for shape list).

// End of file
