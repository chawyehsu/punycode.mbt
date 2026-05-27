// Bootstring parameter values for Punycode

///|
let base : UInt = 36U

///|
let tmin : UInt = 1U

///|
let tmax : UInt = 26U

///|
let skew : UInt = 38U

///|
let damp : UInt = 700U

///|
let initial_bias : UInt = 72U

///|
let initial_n : UInt = 0x80U // 128

///|
/// Delimiter between literal portion and encoded portion
let delimiter : Char = '-'

///|
/// Bias adaptation function
fn adapt(delta : UInt, num_points : UInt, first_time : Bool) -> UInt {
  let mut delta = delta
  delta /= if first_time { damp } else { 2U }
  delta += delta / num_points
  let mut k = 0U
  while delta > (base - tmin) * tmax / 2U {
    delta /= base - tmin
    k += base
  }
  k + (base - tmin + 1U) * delta / (delta + skew)
}
