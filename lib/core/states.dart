abstract class States {}

class InitState extends States {}

class LoadingState extends States {}

class SucessState extends States {
}

class ErrorState extends States {
  String message;
  ErrorState(this.message);
}
