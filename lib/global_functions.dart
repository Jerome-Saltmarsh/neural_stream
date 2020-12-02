library event_stream;

import 'reaction.dart';
import 'global_instance.dart';

void add<T>(T trigger) => globalNeuralStream.add(trigger);
void subscribe<T>(Reaction<T> reaction) =>  globalNeuralStream.listen(reaction);