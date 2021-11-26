import 'package:flutter/cupertino.dart';
import 'package:flutterapp/Modules/data.dart';
import 'package:flutterapp/Modules/event.dart';

class EventProvider extends ChangeNotifier {
  List<Event> _events = topEvents;
  Event? _eventToEdit;

  getAllEvents() {
    return _events;
  }

  getEventToEdit() {
    return _eventToEdit;
  }

  setEvents(List<Event> events) {
    _events = events;
    notifyListeners();
  }

  setEventToEdit(Event? event) {
    _eventToEdit = event;
  }
}
