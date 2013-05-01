Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r41ChYwP027308
	for <selinux@tycho.nsa.gov>; Wed, 1 May 2013 08:43:36 -0400
Received: by mail-ee0-f54.google.com with SMTP id e49so668560eek.13
        for <selinux@tycho.nsa.gov>; Wed, 01 May 2013 05:43:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5181072c.4648320a.7ef1.ffff8111@mx.google.com>
References: <5181072c.4648320a.7ef1.ffff8111@mx.google.com>
Date: Wed, 1 May 2013 08:43:30 -0400
Message-ID: <CADjGSjjHJk=M97=qTH+hybhZ8v9dCkt8eYO+LWtrDrS0k6ofsw@mail.gmail.com>
Subject: Re: Current Makefile system is inconvenient/limited
From: Joshua Brindle <brindle@quarksecurity.com>
To: Michael Seyfert <michael@codesand.org>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

No, we all think it. It's become unwieldy with optional dependencies
too. There are also mutual dependencies between parts of the SELinux
userspace.

Do you have any suggestions on improving it? IMHO autoconf is hell on
earth, and it was attempted a couple time. Something like Scons
*might* help, but I'm not convinced.

On Wed, May 1, 2013 at 8:14 AM, Michael Seyfert <michael@codesand.org> wrote:
> The current system for building selinux requires a lot of workarounds like C_INCLUDE_PATH and is also interdependent on setools. I was looking at the debian packages and they require two build throughs of selinux just to get things to compile properly. Am I the only one that thinks this is a problem?
> --
> Michael Seyfert
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
