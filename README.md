# punycode.mbt

> Punycode encoding and decoding in MoonBit

## Installation

Add the library to your project as a dependency:

```sh
moon add chawyehsu/punycode
```

## API

**⚠️ The API is subject to change before the MoonBit language enters the mature stage.**

### `punycode.encode(input: String): String?`

Encode a string of Unicode symbols to a Punycode string of ASCII-only symbols.

```moonbit
@punycode.encode("bücher") // Some("bcher-kva")
```

### `punycode.decode(input: String): String?`

Decode a Punycode string of ASCII-only symbols to a string of Unicode symbols.

```moonbit
@punycode.decode("bcher-kva") // Some("bücher")
```

## Contributing

The codebase might not yet be updated to support the latest version of MoonBit
language. A explicit version of the MoonBit toolchain has been pinned in the
`moonbit-version` file, which is used by the [moonup] tool.

```sh
moonup pin <toolchain_version>
```

To contribute, it is suggested to use `moonup` to manage the MoonBit toolchain:

## References

- [RFC 3492] - Punycode: A Bootstring encoding of Unicode for Internationalized Domain Names in Applications (IDNA)
- [punycode.c] - The original C reference implementation of Punycode in RFC 3492

## License

**punycode.mbt** © [Chawye Hsu](https://github.com/chawyehsu). Licensed under either of the [Apache License 2.0](LICENSE-APACHE) or [The Unlicense](UNLICENSE) license at your option.

> [Blog](https://chawyehsu.com) · GitHub [@chawyehsu](https://github.com/chawyehsu) · Twitter [@chawyehsu](https://twitter.com/chawyehsu)

[moonup]: https://github.com/chawyehsu/moonup
[RFC 3492]: https://datatracker.ietf.org/doc/html/rfc3492
[punycode.c]: https://gist.github.com/chawyehsu/2792814973cdc0e9315fae7b96be38cc
