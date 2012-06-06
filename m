Message-ID: <1338993272.12539.4.camel@lenny>
Subject: Re: [PATCH]: allow standard compilation of GIT development tree
 (was Re: [PATCH]: do not link static libraries from the system library
 directory)
From: Colin Walters <walters@verbum.org>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: eparis@parisplace.org, SELinux@tycho.nsa.gov
Date: Wed, 06 Jun 2012 10:34:32 -0400
In-Reply-To: <201206042207.q54M7fLJ009293@vivaldi13.register.it>
References: <201206042207.q54M7fLJ009293@vivaldi13.register.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-06-05 at 00:07 +0200, Guido Trentalancia wrote:

> >I've never really seen something which can get it right 'all the
> >time'.  Fedora, and I assume other distros actually just use the git
> >tree subdirectories.  I feel like any such patch to handle this is
> >going to have to be something set in the top level Makefile and will
> >have to cause no difficulties for other workflows....

See http://people.gnome.org/~walters/docs/build-api.txt

This patch looks roughly right to me, though it'd make me happier
if you also added a configure script.  (Note: configure script does
not have to be implemented with autoconf; see
http://git.gnome.org/browse/gtk-doc-stub/tree/configure for a minimal
plain sh one).

> My problem with this patch is that now all of the CFLAGS stuff we have
> lower in the tree (namely -W* stuff) is not going to get picked up
> since
> CFLAGS are already exported...
> 
> So how do we solve that one too?

The automake way is to have AM_CFLAGS, AM_CPPFLAGS which are
build-internal (and always used).  CFLAGS is then something that can
be added by the builder.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
