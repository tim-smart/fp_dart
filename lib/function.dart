typedef Lazy<A> = A Function();

T identity<T>(T value) => value;

/// Return a [Lazy] version of `value`.
Lazy<A> lazy<A>(A value) => () => value;

extension ChainExtension<T> on T {
  R chain<R>(R Function(T value) f) => f(this);
  R pipe<R>(R Function(T value) f) => f(this);
}

extension ComposeExtension0<A> on A Function() {
  B Function() compose<B>(B Function(A a) f) => () => f(this());
}

extension ComposeExtension1<A, B> on B Function(A) {
  C Function(A a) compose<C>(C Function(B b) f) => (a) => f(this(a));
}

extension ComposeExtension2<A, B, C> on C Function(A, B) {
  D Function(A a, B b) compose<D>(D Function(C c) f) => (a, b) => f(this(a, b));
}

extension ComposeExtension3<A, B, C, D> on D Function(A, B, C) {
  E Function(A a, B b, C c) compose<E>(E Function(D d) f) =>
      (a, b, c) => f(this(a, b, c));
}

extension ComposeExtension4<A, B, C, D, E> on E Function(A, B, C, D) {
  F Function(A a, B b, C c, D d) compose<F>(F Function(E e) f) =>
      (a, b, c, d) => f(this(a, b, c, d));
}
