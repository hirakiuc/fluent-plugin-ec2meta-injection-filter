# Ec2meta Injection Filter for [Fluent](http://github.com/fluent/fluentd)

[![Build Status](https://travis-ci.org/hirakiuc/fluent-plugin-ec2meta-injection-filter.svg?branch=master)](https://travis-ci.org/hirakiuc/fluent-plugin-ec2meta-injection-filter)
[![Coverage Status](https://coveralls.io/repos/hirakiuc/fluent-plugin-ec2meta-injection-filter/badge.svg?branch=master)](https://coveralls.io/r/hirakiuc/fluent-plugin-ec2meta-injection-filter?branch=master)
[![Code Climate](https://codeclimate.com/github/hirakiuc/fluent-plugin-ec2meta-injection-filter/badges/gpa.svg)](https://codeclimate.com/github/hirakiuc/fluent-plugin-ec2meta-injection-filter)

Ec2meta Injection filter plugin inject AWS EC2 metadata to each events.

### WARNING

**This plugin works on only AWS EC2 instance.**

[AWS metadata API](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html) can available only from AWS EC2 instance. So if you use this plugin with `Dynamic Configuration` on a host which not AWS EC2 instance, this plugin will raise Timeout error.

If you want to use this plugin on a host which is not  AWS EC2 instance, use `Static Configuration`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-plugin-ec2meta-injection-filter'
```

NOTE: This plugin is not published yet.

## Configuration

### Dynamic Configuration

If you want to inject metadata from [AWS metadata API](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html), configure like below.

```
<filter pattern>
  type ec2meta_injection

  <meta>
    instance_id
    vpc_id
  </meta>
</filter>
```

With this configuration, this plugin inject `instance_id` and `vpc_id`.

Input:

```
debug.test: { "event" : "triggered" }
```

Output:

```
debug.test: { "event" : "triggered", "instance_id" : "id-xxxx", "vpc_id" : "vpc-yyyy" }
```

### Static Configuration

If you want to inject metadata with static value, configure like below.

```
<filter pattern>
  type ec2meta_injection

  <meta>
    vpc_id static_my_vpc_id
  </meta>
</filter>
```

Input:

```
debug.test: { "event" : "triggered" }
```

Output:

```
debug.test: { "event" : "triggered", "vpc_id" : "static_my_vpc_id" }
```

## Supported Metadata

Name | description
-----|--------------
instance_id | instance id for AWS EC2 instance.
vpc_id      | vpc id which first network interface belongs to

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fluent-plugin-ec2meta-injection-filter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

MIT
