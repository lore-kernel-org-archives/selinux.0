Date: Fri, 12 Apr 2002 14:50:14 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Sung Kim <hunkim@cse.ucsc.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Stat compile error.
In-Reply-To: <Pine.GSO.4.44.0204121131350.9478-100000@sundance.cse.ucsc.edu>
Message-ID: <Pine.GSO.4.33.0204121441560.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Apr 2002, Sung Kim wrote:

> When I compile /usr/src/selinux/utils/stat-2.5, I've got the error:
>
> [root@hunkim stat-2.5]# make
> gcc -O2 -g -Wall -DFLASK_LINUX -D_FILE_OFFSET_BITS=64 -I/usr/local/selinux/include   -c -o stat.o stat.c
> stat.c:29:1: directives may not be used inside a macro argument
> stat.c:29:1: unterminated argument list invoking macro "printf"
> stat.c: In function `do_statfs':
> stat.c:32: parse error before "filename"
> stat.c:49: warning: long int format, int arg (arg 5)
> stat.c:122: warning: long unsigned int format, int arg (arg 3)
> stat.c:128: warning: long int format, int arg (arg 6)
> stat.c: In function `usage':
> stat.c:293: warning: implicit declaration of function `exit'
> make: *** [stat.o] Error 1
>
> [root@hunkim stat-2.5]# gcc --version
> 3.0.2

That's an issue for the upstream provider of stat, not us.  The problem
is in the base stat code, not the SELinux modifications.  Compiles fine on
RH7.1 and RH7.2 with the provided gcc (2.96-81 or 2.96-98).

Also, it isn't generally recommended that you use gcc 3.x for the
Linux kernel, as noted in lsm-2.4/Documentation/Changes.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
