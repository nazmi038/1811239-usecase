import 'dart:io';
import 'event_management_functionality.dart';

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
  bool checkYear;
  bool? addNewBooking;
  bool? isLeapYear;
  var currDt = DateTime.now();

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

      print("Select Schedule for the events (Date, Month, Year)");

      //year validation
      do {
        print("Year: ");
        var eventYear = stdin.readLineSync();
        eventYearintNumber = int.parse(eventYear!);

        checkYear = false;

        if (eventYearintNumber < currDt.year) {
          print(
              'Wrong Input! Year must be 2022 or gretter that ${currDt.year}');
          checkYear = true;
        }
      } while (checkYear == true);

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
          print('Wrong Input!');
          checkMonth = true;
        } else if (currDt.year == eventYearintNumber &&
            eventMonthintNumber < currDt.month) {
          --eventMonthintNumber;
          print(
              'Wrong Input! Month must be gretter that (${Months.values[currDt.month - 1].name})');
          checkMonth = true;
        }

        --eventMonthintNumber;
      } while (checkMonth == true);

      //date validation
      do {
        print("Choose Date (1 - 31): ");
        var eventDate = stdin.readLineSync();
        eventDateintNumber = int.parse(eventDate!);

        checkDate = false;

        if (eventDateintNumber < 1 || eventDateintNumber > 31) {
          print('Wrong Input');
          checkDate = true;
        } else {
          var monthVal = eventMonthintNumber;
          monthVal++;

          if (currDt.month == monthVal) {
            if (eventDateintNumber <= currDt.day) {
              print(
                  'Wrong Input! Date must be gretter that ${Months.values[currDt.month - 1].name} ${currDt.day}');
              checkDate = true;
              if (eventMonthintNumber % 2 == 0) {
                if (eventDateintNumber > 30) {
                  print(
                      '${Months.values[currDt.month - 1].name} is only 30 days');
                  checkDate = true;
                }
              }
            }
          } else if (currDt.month != monthVal) {
            if (eventMonthintNumber % 2 != 0 && eventMonthintNumber != 1) {
              if (eventDateintNumber > 30) {
                print(
                    '${Months.values[eventMonthintNumber].name} is only 30 days');
                checkDate = true;
              }
            } else if (eventMonthintNumber == 1) {
              if (eventDateintNumber > 28) {
                isLeapYear = isLeapYearCheck(eventYearintNumber);
                if (isLeapYear == true) {
                  print('${eventYearintNumber} is Leap Year (29 Days)');
                  checkDate = true;
                } else if (isLeapYear == false) {
                  print(
                      '${Months.values[eventMonthintNumber].name} is 28 Days');
                  checkDate = true;
                }
              }
            }
          }
        }
      } while (checkDate == true);

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
          venue: selectVenueintNumber);

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

    //ask user is he/she want's to continue of end the program
    print('Do you want to continue: (Y/N) : ');
    continueToBook = stdin.readLineSync();
  } while (continueToBook == 'Y' || continueToBook == 'y');
}
