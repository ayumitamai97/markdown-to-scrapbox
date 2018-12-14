# `markdown_to_scrapbox`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'markdown_to_scrapbox'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install markdown_to_scrapbox

## Usage

```bash
$ bundle exec markdown_to_scrapbox -i TARGET_MARKDOWN_FILE.md -o OUTPUT_FILE.txt
```

## Options

### `-i`, `--input` [required]

Indicate the target markdown file.

### `-o`, `--output` [required]

Indicate the output file name.

### `-t`, `--type-of-indent` [optional]

Indicate indent type from `space` and `tab`.
Default indent type is `space`.

```bash
$ bundle exec markdown_to_scrapbox -i TARGET_MARKDOWN_FILE.md -o OUTPUT_FILE.txt -t tab
```

### `-c`, `--count-of-indent` [optional]

Indicate the number of indent from `2` and `4`.
Default indent count is `2`.

```bash
$ bundle exec markdown_to_scrapbox -i TARGET_MARKDOWN_FILE.md -o OUTPUT_FILE.txt -c 2
```

## Any questions?

If you would like to improve this CLI app, please contact me on Twitter [@a_ta_tama](https://twitter.com/a_ta_tama)

# License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
