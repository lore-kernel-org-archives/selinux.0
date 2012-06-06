Message-ID: <1339005512.4365.10.camel@lenny>
Subject: Re: [PATCH]: allow standard compilation of GIT development tree
 (was Re: [PATCH]: do not link static libraries from the system library
 directory)
From: Colin Walters <walters@verbum.org>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: SELinux@tycho.nsa.gov
Date: Wed, 06 Jun 2012 13:58:32 -0400
In-Reply-To: <201206061755.q56HtHFF004774@vivaldi48.register.it>
References: <201206061755.q56HtHFF004774@vivaldi48.register.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-06-06 at 19:55 +0200, Guido Trentalancia wrote:

> The autotools option has been discussed already several times and it has always been rejected.

You must not have even bothered to read the link or understand what I
was saying.  I'm not saying "switch to autotools!".  Rather,
implementing a subset of the API surface they expose.  

I've actually done this for various other components between GNOME and
Linux.

> If you want to propose the minimal configure script that you wrote,
> my personal opinion is that it might tidy up the build logic a little
> bit so that it can be better managed over time and it might also
> turn out to be handy to someone someday...

What I was actually saying is that your patch should explicitly
separate BUILD_INTERNAL_CFLAGS from CFLAGS.  Automake calls the former
AM_CFLAGS, but you can call it whatever you want in your Makefile.

The point is to leave CFLAGS as a meta-build (rpm/dpkg/yocto)
customization tool.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
