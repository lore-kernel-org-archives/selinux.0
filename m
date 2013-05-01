Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r41MviYJ031074
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2013 18:57:44 -0400
Received: by mail-ie0-f178.google.com with SMTP id b11so17660iee.9
        for <selinux@tycho.nsa.gov>; Wed, 01 May 2013 15:57:43 -0700 (PDT)
Date: Wed, 1 May 2013 22:57:30 +0000
From: Michael Seyfert <michael@codesand.org>
To: Joshua Brindle <brindle@quarksecurity.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Current Makefile system is inconvenient/limited
Message-ID: <51819de6.9042320a.547a.3e91@mx.google.com>
References: <5181072c.4648320a.7ef1.ffff8111@mx.google.com>
 <CADjGSjjHJk=M97=qTH+hybhZ8v9dCkt8eYO+LWtrDrS0k6ofsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADjGSjjHJk=M97=qTH+hybhZ8v9dCkt8eYO+LWtrDrS0k6ofsw@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SCons or CMake maybe. I might try a few changes to make packaging
for distributions easier. Thing is setools depends on parts of selinux
and selinux depends on parts of setools, as you were saying.

On Wed, May 01, 2013 at 08:43:30AM -0400, Joshua Brindle wrote:
> No, we all think it. It's become unwieldy with optional dependencies
> too. There are also mutual dependencies between parts of the SELinux
> userspace.
> 
> Do you have any suggestions on improving it? IMHO autoconf is hell on
> earth, and it was attempted a couple time. Something like Scons
> *might* help, but I'm not convinced.
> 
> On Wed, May 1, 2013 at 8:14 AM, Michael Seyfert <michael@codesand.org> wrote:
> > The current system for building selinux requires a lot of workarounds like C_INCLUDE_PATH and is also interdependent on setools. I was looking at the debian packages and they require two build throughs of selinux just to get things to compile properly. Am I the only one that thinks this is a problem?
> > --
> > Michael Seyfert
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
