sealed class AuthIntent {
  const AuthIntent();
}

class LoginWithGoogleIntent extends AuthIntent {
  const LoginWithGoogleIntent();
}

class LoginWithFacebookIntent extends AuthIntent {
  const LoginWithFacebookIntent();
}

