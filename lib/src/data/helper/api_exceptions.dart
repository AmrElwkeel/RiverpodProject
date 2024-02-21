class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class LoginException implements Exception {
  final String message;

  LoginException(this.message);

  @override
  String toString() {
    return 'LoginException: $message';
  }
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Bad Request:");
}


class PhoneNumberException extends AppException {
  PhoneNumberException([String? message])
      : super(message, "Invalid Phone Number: ");
}

class UnauthorizedException extends AppException {
  UnauthorizedException([message]) : super(message, "Unauthorized: ");
}

class ForbiddenException extends AppException {
  ForbiddenException([message]) : super(message, "Forbidden: ");
}

class ServerErrorException extends AppException {
  ServerErrorException([message]) : super(message, "Forbidden: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException([String? message])
      : super(message, "Internal Server Error : ");
}
