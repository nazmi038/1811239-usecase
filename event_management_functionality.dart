import 'event_management_system.dart';

//function to cheeck clash of any events
bool? checkEventClash({
  required List events,
  required int date,
  required int year,
  required int month,
  required int venue,
}) {
  if (events.length != 0) {
    for (int x = 0; x < events.length; x++) {
      if (events[x]['Event year'] == year) {
        if (events[x]['Event Month'] == Months.values[month].name) {
          if (events[x]['Event Date'] == date) {
            if (events[x]['Event Venue'] == Venue.values[venue].name) {
              //if new event is clashing with previously booked one return false
              return false;
            } else {
              //if new event is not clashing with previously booked one return true
              return true;
            }
          } else {
            //if new event is not clashing with previously booked one return true
            return true;
          }
        } else {
          //if new event is not clashing with previously booked one return true
          return true;
        }
      } else {
        //if new event is not clashing with previously booked one return true
        return true;
      }
    }
  } else {
    //if new event is not clashing with previously booked one return true
    return true;
  }
}

//function to print event details
void printEventDetails(List events) {
  print('--------All Booked Events---------');
  // if the list is not empthy print all events
  if (events.length != 0) {
    for (int x = 0; x < events.length; x++) {
      print('Event Details - Booking Number: ${x + 1}000TX');
      print('---------------------------------------------');
      print('Title: ${events[x]['Event Title']} ');
      print('Event Organizer Name: ${events[x]['Event Organizer Name']} ');
      print('Date: ${events[x]['Event Date']} ');
      print('Month: ${events[x]['Event Month']} ');
      print('Year: ${events[x]['Event year']} ');
      print('Starting Time: ${events[x]['Event Starting Time']} AM');
      print('Closing Time: ${events[x]['Event Closing Time']} PM');
      print('Venue: ${events[x]['Event Venue']} ');
      print('');
    }
  } else {
    // if the list is empthy
    print('No information available, Add new events');
  }
}

//check leap year
bool? isLeapYearCheck(int year) =>
    (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
