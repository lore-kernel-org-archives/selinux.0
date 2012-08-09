Message-ID: <1344534669.8427.11.camel@lenny>
Subject: Re: A filename to label translation daemon
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: russell@coker.com.au, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov, lennart@poettering.net, sds@tycho.nsa.gov
Date: Thu, 09 Aug 2012 13:51:09 -0400
In-Reply-To: <5023EE1C.5060205@redhat.com>
References: <1344454290.25533.12.camel@localhost>
	 <1344461186.4612.27.camel@lenny> <201208100037.21877.russell@coker.com.au>
	 <5023EE1C.5060205@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-09 at 13:06 -0400, Daniel J Walsh wrote:

> I believe we just add support for this service and have the labeling fall back
> to the default if the labeling socket does not exists, and then distributions
> can decide whether or not they want to use it.

There are other possible intermediate steps though - for example,
caching the precompiled regular expressions in a file accessible via
mmap().

Basically:

* Your mmap file is in some data format - you can make up your own, but
  I like using http://developer.gnome.org/glib/stable/glib-GVariant.html
* Check the timestamp on the regexp text file versus the cached copy, if
  newer, use the text file
* Otherwise, mmap the cached blob, loop through each regexp, passing
  a pointer to the mmap cache file for regexec()

The mmap cache file would probably need to be tied to a specific version
of glibc though; you wouldn't want to upgrade and use old compiled
regexps that the new glibc doesn't understand.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
