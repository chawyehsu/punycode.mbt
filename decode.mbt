///|
/// Converts a Punycode string of ASCII-only symbols to a string of Unicode symbols.
pub fn decode(encoded : String) -> String? {
  let decoded = []
  let encoded_length = encoded.length().reinterpret_as_uint()
  let delimiter_idx = encoded.rev_find(delimiter.to_string())
  let basic = match delimiter_idx {
    None => 0U
    Some(idx) => idx.reinterpret_as_uint()
  }
  // Basic ASCII code point extraction
  let encoded = encoded.to_array()
  for j = 0U; j < basic; j = j + 1U {
    let c = encoded[j.reinterpret_as_int()]
    let code = c.to_int()
    if code >= 0x80 {
      // Not basic ASCII code point
      return None
    }
    decoded.push(c)
  }
  // Initialize the state
  let mut n = initial_n
  let mut i = 0U
  let mut bias = initial_bias
  // Main decoding loop
  let mut idx = if basic > 0U { basic + 1U } else { 0U }
  while idx < encoded_length {
    let oldi = i
    let mut w = 1U
    for k = base; ; k = k + base {
      let digit = decode_digit(encoded[idx.reinterpret_as_int()])
      idx += 1
      if digit > (@uint.max_value - i) / w {
        return None // Overflow
      }
      i += digit * w
      let t = if k <= bias {
        tmin
      } else if k >= bias + tmax {
        tmax
      } else {
        k - bias
      }
      if digit < t {
        break
      }
      if w > @uint.max_value / (base - t) {
        return None // Overflow
      }
      w *= base - t
    }
    let out = decoded.length().reinterpret_as_uint() + 1U
    bias = adapt(i - oldi, out, oldi == 0U)
    if i / out > @uint.max_value - n {
      return None // Overflow
    }
    n += i / out
    i %= out
    decoded.insert(
      i.reinterpret_as_int(),
      Int::unsafe_to_char(n.reinterpret_as_int()),
    )
    i += 1U
  }

  // FIXME(chawyehsu): I was expecting to convert the array to a string
  // using `.to_string()` here but it seems it's not the right way to
  // do it in MoonBit, `.join("")` doesn't work as expected either.
  let mut decoded_str = ""
  let mut i = 0
  while i < decoded.length() {
    decoded_str = decoded_str + decoded[i].to_string()
    i += 1
  }
  Some(decoded_str)
}

///|
fn decode_digit(c : Char) -> UInt {
  let code = c.to_int()
  if code >= 48 && code < 58 {
    code.reinterpret_as_uint() - 48U + 26U // 0-9
  } else if code >= 65 && code < 91 {
    code.reinterpret_as_uint() - 65U // A-Z
  } else if code >= 97 && code < 123 {
    code.reinterpret_as_uint() - 97U // a-z
  } else {
    abort("Invalid punycode")
  }
}
