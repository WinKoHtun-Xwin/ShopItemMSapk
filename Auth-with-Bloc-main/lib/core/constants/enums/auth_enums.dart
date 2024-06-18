enum AuthStatus { unknown, authenticated, guest }

enum ProductError {hostUnreachable}
enum AuthError {
  hostUnreachable,
  unknown,
  wrongEmailOrPassword,
}
