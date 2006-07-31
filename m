Subject: Re: infelicity in context_user_set; new syscalls: setfileconat,
	etc.?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
        SELinux@tycho.nsa.gov
In-Reply-To: <87zmeslb2v.fsf@rho.meyering.net>
References: <87zmeslb2v.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 09:44:20 -0400
Message-Id: <1154353460.1447.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-07-29 at 16:50 +0200, Jim Meyering wrote:
> Hello,
> 
> I've just discovered what may be a documentation error
> for context_user_set, context_role_set, etc.
> 
> Those functions are documented as setting errno upon failure,
> yet the following program prints "failed with errno=0":
> 
>   #include <stdio.h>
>   #include <errno.h>
>   #include <selinux/context.h>
> 
>   int
>   main ()
>   {
>     context_t c = context_new ("a:b:c");
>     if (!c)
>       return 1;
>     errno = 0;
>     if (context_user_set (c, ":") != 0)
>       printf ("failed with errno=%d\n", errno);
>     return 0;
>   }

Yes, that is a documentation error.

> FYI, as part of merging the coreutils SE Linux changes "upstream",
> I've just rewritten chcon to use fts (and new openat-style functions,
> getfileconat, lgetfileconat, setfileconat, lsetfileconat[*]).  Now,
> chcon -R can operate on an arbitrarily deep hierarchy.
> One test was to process a 100K-level hierarchy -- finished in just 19sec.
> The old version chokes on PATH_MAX at a depth of 2k.
> 
> Can any of you point me to a test suite for chcon.
> That might save me the trouble of writing my own.

I don't think that there is one; the selinux kernel testsuite (included
in LTP) does make use of chcon as part of its tests of the kernel access
checks, but there isn't a separate testsuite that fully exercises chcon
at present.

> Jim
> 
> [*] With linux and /proc, I can emulate functions like openat and
> setfileconat, but not everyone has linux, and some linux environments
> lack access to /proc, so...
> 
> Has anyone considered adding these system calls?
>   getfileconat
>   lgetfileconat
>   setfileconat
>   lsetfileconat
> 
> They'd be useful for the same reasons openat, lstatat, etc.
> are useful (and are now in the Linux kernel).

Looks like we would only need fgetxattrat() and fsetxattrat() system
calls in the kernel, analogous to the fstatat() and fchmodat() calls,
and then libselinux could implement the *fileconat() functions on top of
them.  cc'd Ulrich since he introduced the *at functions into Linux.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
