Volume Pricing
==============

[![Build Status](https://secure.travis-ci.org/spree/spree_volume_pricing.png)](http://travis-ci.org/spree/spree_volume_pricing)

Volume Pricing is an extension to Spree (a complete open source commerce solution for Ruby on Rails) that uses predefined ranges of quantities to determine the price for a particular product variant.  For instance, this allows you to set a price for quantities between 1-10, another price for quantities between (10-100) and another for quantities of 100 or more.  If no volume price is defined for a variant, then the standard price is used.

Each VolumePrice contains the following values:

1. **Variant:** Each VolumePrice is associated with a _Variant_, which is used to link products to particular prices.
2. **Display:** The human readable reprentation of the quantity range (Ex. 10-100).  (Optional)
3. **Range:** The quantity range for which the price is valid (See Below for Examples of Valid Ranges.)
4. **Amount:** The price of the product if the line item quantity falls within the specified range.
5. **Position:** Integer value for `acts_as_list` (Helps keep the volume prices in a defined order.)

Ranges
======

Ranges are expressed as Strings and are similar to the format of a Range object in Ruby.  The lower numeber of the range is always inclusive.  If the range is defined with '..' then it also includes the upper end of the range.  If the range is defined with '...' then the upper end of the range is not inclusive.

Ranges can also be defined as "open ended."  Open ended ranges are defined with an integer followed by a '+' character.  These ranges are inclusive of the integer and any value higher then the integer.

All ranges need to be expressed as Strings and must include parentheses.  "(1..10)" is considered to be a valid range. "1..10" is not considered to be a valid range (missing the parentheses.)

Examples
========
Consider the following examples of volume prices:

       Variant                Display            Range        Amount         Position
       -------------------------------------------------------------------------------
       Rails T-Shirt          1-5                (1..5)       19.99          1
       Rails T-Shirt          6-9                (6...10)     18.99          2
       Rails T-Shirt          10 or more         (10+)        17.99          3

## Example 1

Cart Contents:

       Product                Quantity       Price       Total
       ----------------------------------------------------------------
       Rails T-Shirt          1              19.99       19.99

## Example 2

Cart Contents:

       Product                Quantity       Price       Total
       ----------------------------------------------------------------
       Rails T-Shirt          5              19.99       99.95

## Example 3

Cart Contents:

      Product                Quantity       Price       Total
      ----------------------------------------------------------------
      Rails T-Shirt          6              18.99       113.94

## Example 4

Cart Contents:

      Product                Quantity       Price       Total
      ----------------------------------------------------------------
      Rails T-Shirt          10             17.99       179.90

## Example 5

Cart Contents:

      Product                Quantity       Price       Total
      ----------------------------------------------------------------
      Rails T-Shirt          20             17.99       359.80


Additional Notes
================

* The volume price is applied based on the total quantity ordered for a particular variant.  It does not apply different prices for the portion of the quantity that falls within a particular range.  Only the one price is used (although this would be an interesting configurable option if someone wanted to write a patch.)


Development
===========

This extension uses the testing support from spree core. Once you have installed the bundle you will be able to create the test app and run the rake tests. The factories from spree/core are available within the tests.

      bundle install
      rake test_app
      rake

