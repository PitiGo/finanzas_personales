int daysInMonth(int month){
  var now = DateTime.now();

  var lastDaydateTime = (month < 12)?
    new DateTime(now.year,month+1,0): new DateTime(now.year +1,1,0);

    return lastDaydateTime.day;

}