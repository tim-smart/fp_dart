import 'package:fp_dart/function.dart';
import 'package:fp_dart/option.dart' as O;
import 'package:test/test.dart';

void main() {
  group('of', () {
    test('return Some for non-null values', () {
      expect(O.of(123), O.some(123));
    });

    test('returns None for null values', () {
      expect(O.of<int>(null), O.none());
    });
  });

  group('fold', () {
    test('executes ifSome on Some', () {
      final result = O.of(123).chain(O.fold(
            () => 'none',
            (value) => 'some',
          ));
      expect(result, 'some');
    });

    test('executes ifNone on None', () {
      final result = O.of<int>(null).chain(O.fold(
            () => 'none',
            (value) => 'some',
          ));
      expect(result, 'none');
    });
  });

  group('isSome', () {
    test('true for Some', () {
      expect(O.of(123).chain(O.isSome), true);
    });

    test('false for None', () {
      expect(O.of(null).chain(O.isSome), false);
    });
  });

  group('isNone', () {
    test('false for Some', () {
      expect(O.of(123).chain(O.isNone), false);
    });

    test('true for None', () {
      expect(O.of(null).chain(O.isNone), true);
    });
  });

  group('orElse', () {
    test('does nothing for Some', () {
      expect(
        O.of(123).chain(O.orElse(() => O.some(-1))),
        O.some(123),
      );
    });

    test('returns new option if None', () {
      expect(
        O.none<int>().chain(O.orElse(() => O.some(-1))),
        O.some(-1),
      );
    });
  });

  group('getOrElse', () {
    test('returns wrapped value if Some', () {
      expect(
        O.some(123).chain(O.getOrElse(() => -1)),
        123,
      );
    });

    test('returns alternate value if None', () {
      expect(
        O.none<int>().chain(O.getOrElse(() => -1)),
        -1,
      );
    });
  });

  group('map', () {
    test('transforms value if Some', () {
      expect(
        O.some(123).chain(O.map((i) => i * 2)),
        O.some(246),
      );
    });

    test('does nothing if None', () {
      expect(
        O.none<int>().chain(O.map((i) => i * 2)),
        O.none(),
      );
    });
  });

  group('flatMap', () {
    test('transforms value if Some', () {
      expect(
        O.some(123).chain(O.flatMap((i) => O.some(i * 2))),
        O.some(246),
      );
    });

    test('returns None if predicate returns None', () {
      expect(
        O.some(123).chain(O.flatMap((i) => O.none())),
        O.none(),
      );
    });

    test('does nothing if None', () {
      expect(
        O.none<int>().chain(O.flatMap((i) => O.some(i * 2))),
        O.none(),
      );
    });
  });

  group('filter', () {
    test('does nothing if predicate passes', () {
      expect(
        O.some(123).chain(O.filter((i) => i == 123)),
        O.some(123),
      );
    });

    test('returns None if predicate returns false', () {
      expect(
        O.some(123).chain(O.filter((i) => i != 123)),
        O.none(),
      );
    });

    test('does nothing if None', () {
      expect(
        O.none<int>().chain(O.filter((i) => i == 123)),
        O.none(),
      );
    });
  });

  group('map2', () {
    test('transforms the values if both options are some', () {
      final one = O.some(1);
      final two = O.some(2);
      final map = O.map2((int a, int b) => a + b);

      expect(
        map(one, two),
        O.some(3),
      );
    });

    test('returns None if one of the options is None', () {
      final one = O.some(1);
      final two = O.none<int>();
      final map = O.map2((int a, int b) => a + b);

      expect(
        map(one, two),
        O.none(),
      );
    });
  });

  group('map3', () {
    test('transforms the values if all options are some', () {
      final one = O.some(1);
      final two = O.some(2);
      final three = O.some(3);
      final map = O.map3((int a, int b, int c) => a + b + c);

      expect(
        map(one, two, three),
        O.some(6),
      );
    });

    test('returns None if one of the options is None', () {
      final one = O.some(1);
      final two = O.some(2);
      final three = O.none<int>();
      final map = O.map3((int a, int b, int c) => a + b + c);

      expect(
        map(one, two, three),
        O.none(),
      );
    });
  });
}
