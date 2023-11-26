import 'package:foxid/foxid.dart';

void main() {
  // Generating FOxID
  FOxID generatedFoxid = FOxID.generate();

  // Getting data from it
  print(generatedFoxid.time); // <-- UTC DateTime
  print(generatedFoxid.timestamp); // <-- Unix timestamp
  print(generatedFoxid.datacenter); // <-- Datacenter ID
  print(generatedFoxid.worker); // <-- Worker ID
  print(generatedFoxid.counter); // <-- Incremental counter
  print(generatedFoxid.random); // <-- Randomness

  // Creating empty FOxID
  FOxID emptyFoxid = FOxID.empty();

  // Modifying it
  emptyFoxid
    ..time = DateTime(2023, DateTime.november)
    ..counter = 256
    ..datacenter = 9
    ..worker = 6;

  // Exporting as string
  String stringFoxid = emptyFoxid.toJson();

  print(stringFoxid);

  // Parse from string
  FOxID parsedFoxid = FOxID.fromJson(stringFoxid);
}
