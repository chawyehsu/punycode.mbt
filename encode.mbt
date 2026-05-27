///|
/// Convert a string of Unicode symbols to a Punycode string of ASCII-only symbols.
pub fn encode(raw : String) -> String? {
  // Basic code point segregation, extract ASCII characters that are
  // encoded as-is
  let encoded = raw.iter().filter(fn(c) { c.to_int() < 0x7F }).collect()
  let basic_length = encoded.length().reinterpret_as_uint()
  // Initialize the state
  let mut n = initial_n
  let mut delta = 0U
  let mut bias = initial_bias
  let mut h = basic_length
  if h > 0 {
    encoded.push(delimiter)
  }
  let input_lenght = raw.length().reinterpret_as_uint()
  // Main encoding loop
  while h < input_lenght {
    // let m = the minimum {non-basic} code point >= n in the input
    let mut m = @uint.max_value
    for j = 0U; j < input_lenght; j = j + 1U {
      let code = raw[j.reinterpret_as_int()].to_uint()
      if code >= n && code < m {
        m = code
      }
    }
    if m - n > (@uint.max_value - delta) / (h + 1) {
      return None // Overflow
    }
    delta += (m - n) * (h + 1)
    n = m
    for j = 0U; j < input_lenght; j = j + 1U {
      let code = raw[j.reinterpret_as_int()].to_uint()
      if code < n {
        delta += 1
        if delta == 0 {
          return None // Overflow
        }
      }
      if code == n {
        let mut q = delta
        let mut k = base
        for {
          let t = if k <= bias {
            tmin
          } else if k >= bias + tmax {
            tmax
          } else {
            k - bias
          }
          if q < t {
            break
          }
          encoded.push(encode_digit(t + (q - t) % (base - t)))
          q = (q - t) / (base - t)
          k += base
        }
        encoded.push(encode_digit(q))
        bias = adapt(delta, h + 1, h == basic_length)
        delta = 0
        h += 1
      }
    }
    delta += 1
    n += 1
  }

  // FIXME(chawyehsu): I was expecting to convert the array to a string
  // using `.to_string()` here but it seems it's not the right way to
  // do it in MoonBit, `.join("")` doesn't work as expected either.
  let mut encoded_str = ""
  let mut i = 0
  while i < encoded.length() {
    encoded_str = encoded_str + encoded[i].to_string()
    i += 1
  }
  Some(encoded_str)
}

///|
fn encode_digit(d : UInt) -> Char {
  if d < 26U {
    Int::unsafe_to_char(d.reinterpret_as_int() + 97) // a-z
  } else if d < 36U {
    Int::unsafe_to_char(d.reinterpret_as_int() - 26 + 48) // 0-9
  } else {
    abort("Invalid digit")
  }
}
