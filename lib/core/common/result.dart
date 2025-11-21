sealed class Result<T, E> {
  const Result();
  
  R when<R>({
    required R Function(T data) success,
    required R Function(E error) error,
  });
}

class Success<T, E> extends Result<T, E> {
  final T data;
  const Success(this.data);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(E error) error,
  }) {
    return success(data);
  }
}

class Error<T, E> extends Result<T, E> {
  final E error;
  const Error(this.error);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(E error) error,
  }) {
    return error(this.error);
  }
}
