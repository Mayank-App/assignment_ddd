
import '../../../domain/models/save.dart';

abstract class InternetState{

}
class InternetIntialState extends InternetState{

}
class InternetLossedState extends InternetState{

  List<SaveData> box;

  InternetLossedState({required this.box});
}
class InternetGainedState  extends InternetState{

}