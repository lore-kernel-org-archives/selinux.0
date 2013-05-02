Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r42C9Hbj010286
	for <selinux@tycho.nsa.gov>; Thu, 2 May 2013 08:09:17 -0400
Received: by mail-ee0-f43.google.com with SMTP id b15so244038eek.16
        for <selinux@tycho.nsa.gov>; Thu, 02 May 2013 05:09:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51821660.c5b5320a.15e4.ffff898a@mx.google.com>
References: <51821660.c5b5320a.15e4.ffff898a@mx.google.com>
Date: Thu, 2 May 2013 08:09:14 -0400
Message-ID: <CADjGSjg78ij_bAsGucZ1MLOPFsV5YHXr9UeMsdg1VTL-zx+LtA@mail.gmail.com>
Subject: Re: 'av.data' may be used uninitialized
From: Joshua Brindle <brindle@quarksecurity.com>
To: Michael Seyfert <michael@codesand.org>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 2, 2013 at 3:31 AM, Michael Seyfert <michael@codesand.org> wrote:
> When compiling libsepol with optimizations enabled I get this warning:
>
> gcc -o hierarchy.o -c -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute -D_GNU_SOURCE -O3 -I. -I/mnt/data/work/selinux/selinux/libsepol/include hierarchy.c
> hierarchy.c: In function 'check_avtab_hierarchy_callback':
> hierarchy.c:234:2: error: 'av.data' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> cc1: all warnings being treated as errors
> scons: *** [hierarchy.o] Error 1
> scons: building terminated because of errors.
>
> I'm not familiar enough with the internals of selinux to know if this is a problem or not. Could someone look at it?
>

Clever compiler isn't so clever. AFAICT the only way av.data would be
uninitialized is if no parent types were found, which would cause the
return 0 just above that ERR() line. I guess it could be initialized
up top, even though that seems completely unnecessary.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
