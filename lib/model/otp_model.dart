class Otpresponse{
  String errorCode;
  String errorMessage;
  String details;


  Otpresponse({
    this.errorCode,
    this.errorMessage,
    this.details
  });

  factory Otpresponse.fromJson(Map<String, dynamic> parsedJson){
    return Otpresponse(
        errorCode: parsedJson['ErrorCode'],
        errorMessage : parsedJson['ErrorMessage'],
        details : parsedJson ['Details']
    );
  }
}