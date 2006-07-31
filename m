Subject: Re: infelicity in context_user_set; new syscalls: setfileconat,
	etc.?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Jim Meyering <jim@meyering.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <87zmeslb2v.fsf@rho.meyering.net>
References: <87zmeslb2v.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 09:26:43 -0400
Message-Id: <1154352403.26550.24.camel@localhost.localdomain>
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
> 

Looks like a documentation error to me - there is no attempt to set
errno in the code. In fact, most of libselinux looks like errno will
only get set as a result of a call to a lower level library function
(e.g., open or getxattr).

Can you create a patch to correct the documentation?

<snip>

> 
> Has anyone considered adding these system calls?
>   getfileconat
>   lgetfileconat
>   setfileconat
>   lsetfileconat
> 
> They'd be useful for the same reasons openat, lstatat, etc.
> are useful (and are now in the Linux kernel).
> 

Seems much simpler to use fgetfilecon, etc. that take a fd instead of a
path. They can be used in conjunction with openat and do not require a
new system call.

Currently there are no system calls for SELinux and I doubt that there
would be much enthusiasm for them upstream.

Karl

> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
