# Taggrrr

An image gallery that should make tagging easier.

Currently abandoned. Don't install, there are known security vulnerabilities in the dependencies.

## Another gallery?

I didn't like the existing gallery solutions. One of the biggest problem is that I already
have a huge image collection that is just loosely sorted into folders. I need something that
helps me in tagging huge amounts of images, while also displaying them on different devices.

Additionally I want to to write those tags back to the image files so that other applications
can use them as well.

## Tagging doesn't work!

Yes, it's still a work in progress.

## Installation

Installation should work like any other rails application.

Checkout the files, set up your database in config/database.yml and run:

```sh
$ bundle install
$ rake db:migrate
```

## Setup

On first run you should add at least one path where all images are located. In future versions
support of remote protocolls like smb or ftp is planned.

After adding a path you should scan it. Depending on the amount of images this will take a
while.
