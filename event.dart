import 'dart:io';

//months
enum Months {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  Octobar,
  November,
  December
}

//venue
enum Venue {
  MAIN_AUDITORIUM,
  MINI_AUDITORIUM,
}

void main() {
  String? eventTitle;
  String organizerName;
  int eventStartingTime = 8;
  int eventEndingTime = 5;
  int eventYearintNumber;
  int eventDateintNumber;
  int eventMonthintNumber;
  String? continueToBook;
  bool checkDate;
  bool checkMonth;
  bool checkVenue;
  bool addNewBooking;

  //local storage List indise Map to store event details
  var events = <Map>[];
  print('------------------------------');
  print('-   Event Management System  -');
  print('------------------------------');

  print('');

//do while loop to continue this program multiple times based on users wish
  do {
    print('1. Book a new Event');
    print('2. Check events list');
    print('Choose (1/2) : ');

    //User input
    var chooseFromList = stdin.readLineSync();
    var chooseFromListintNumber = int.parse(chooseFromList!);

    if (chooseFromListintNumber == 1) {
      //User input
      print("Enter event Title: ");
      eventTitle = stdin.readLineSync();

      //User input
      print("Enter Organizer Name:");
      organizerName = stdin.readLineSync()!;
//1811239 Nazmi : This is what I assigned from choose date until the clash part
      //date validation
      do {
        print("Select Schedule for the events (Date, Month, Year)");
        print("Choose Date (1 - 31): ");
        var eventDate = stdin.readLineSync();
        eventDateintNumber = int.parse(eventDate!);

        checkDate = false;

        if (eventDateintNumber < 1 || eventDateintNumber > 31) {
          print('Wrong Input');
          checkDate = true;
        }
      } while (checkDate == true);

      print("Choose Month: ");

      //display all months name
      Months.values.forEach((month) {
        print('${month.index + 1}. ${month.name}');
      });

      //month validation
      do {
        print("Choose(1 - 12): ");
        var eventMonth = stdin.readLineSync();
        eventMonthintNumber = int.parse(eventMonth!);

        checkMonth = false;

        if (eventMonthintNumber < 1 || eventMonthintNumber > 12) {
          print('Wrong Input');
          checkMonth = true;
        }
        eventMonthintNumber--;
      } while (checkMonth == true);

      print("Year: ");
      var eventYear = stdin.readLineSync();
      eventYearintNumber = int.parse(eventYear!);

      print("Select Venue: ");

      //display all available venue too book
      Venue.values.forEach((venue) {
        print('${venue.index + 1}. ${venue.name}');
      });

      var selectVenueintNumber;

      //venue validation
      do {
        print("Choose (1/2): ");
        var selectVenue = stdin.readLineSync();
        selectVenueintNumber = int.parse(selectVenue!);

        checkVenue = false;

        if (selectVenueintNumber < 1 || selectVenueintNumber > 2) {
          print('Wrong Input');
          checkVenue = true;
        }
        selectVenueintNumber--;
      } while (checkVenue == true);

      //check if event is classing based on day,month,year and venue
      addNewBooking = checkEventClash(
          date: eventDateintNumber,
          month: eventMonthintNumber,
          year: eventYearintNumber,
          events: events,
          venue: selectVenueintNumber)!;

      if (addNewBooking == true) {
        // if event is not clasing the add new event to the local storage List
        events.add({
          'Event Title': eventTitle,
          'Event Organizer Name': organizerName,
          'Event Date': eventDateintNumber,
          'Event Month': Months.values[eventMonthintNumber].name,
          'Event year': eventYearintNumber,
          'Event Starting Time': eventStartingTime,
          'Event Closing Time': eventEndingTime,
          'Event Venue': Venue.values[selectVenueintNumber].name,
        });

        print('Booking Successful');
      } else if (addNewBooking == false) {
        print(
            'Booking Failed! Clash with another event. Please Choose a different Schedule');
      }
    } else if (chooseFromListintNumber == 2) {
      printEventDetails(events);
    } else {
      print('Wrong Input');
    }
// Until here
    //ask user is he/she want's to continue of end the program
    print('Do you want to continue: (Y/N) : ');
    continueToBook = stdin.readLineSync();
  } while (continueToBook == 'Y' || continueToBook == 'y');
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
            if (events[x]['Venue'] == Venue.values[venue].name) {
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
