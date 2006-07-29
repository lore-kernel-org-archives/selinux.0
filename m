From: Jim Meyering <jim@meyering.net>
To: SELinux@tycho.nsa.gov
Subject: infelicity in context_user_set; new syscalls: setfileconat, etc.?
Date: Sat, 29 Jul 2006 16:50:16 +0200
Message-ID: <87zmeslb2v.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I've just discovered what may be a documentation error
for context_user_set, context_role_set, etc.

Those functions are documented as setting errno upon failure,
yet the following program prints "failed with errno=0":

  #include <stdio.h>
  #include <errno.h>
  #include <selinux/context.h>

  int
  main ()
  {
    context_t c = context_new ("a:b:c");
    if (!c)
      return 1;
    errno = 0;
    if (context_user_set (c, ":") != 0)
      printf ("failed with errno=%d\n", errno);
    return 0;
  }

FYI, as part of merging the coreutils SE Linux changes "upstream",
I've just rewritten chcon to use fts (and new openat-style functions,
getfileconat, lgetfileconat, setfileconat, lsetfileconat[*]).  Now,
chcon -R can operate on an arbitrarily deep hierarchy.
One test was to process a 100K-level hierarchy -- finished in just 19sec.
The old version chokes on PATH_MAX at a depth of 2k.

Can any of you point me to a test suite for chcon.
That might save me the trouble of writing my own.

Jim

[*] With linux and /proc, I can emulate functions like openat and
setfileconat, but not everyone has linux, and some linux environments
lack access to /proc, so...

Has anyone considered adding these system calls?
  getfileconat
  lgetfileconat
  setfileconat
  lsetfileconat

They'd be useful for the same reasons openat, lstatat, etc.
are useful (and are now in the Linux kernel).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
