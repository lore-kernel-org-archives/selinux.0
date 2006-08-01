Subject: Re: infelicity in context_user_set; new syscalls: setfileconat,
	etc.?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, SELinux@tycho.nsa.gov
In-Reply-To: <87ejw1k9wo.fsf@rho.meyering.net>
References: <87zmeslb2v.fsf@rho.meyering.net>
	 <1154352403.26550.24.camel@localhost.localdomain>
	 <87ejw1k9wo.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 16:17:36 -0400
Message-Id: <1154463456.3582.165.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-31 at 18:37 +0200, Jim Meyering wrote:
> Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:
> 
> > On Sat, 2006-07-29 at 16:50 +0200, Jim Meyering wrote:
> >> Hello,
> >>
> >> I've just discovered what may be a documentation error
> >> for context_user_set, context_role_set, etc.
> >>
> >> Those functions are documented as setting errno upon failure,
> >> yet the following program prints "failed with errno=0":
> >>
> >>   #include <stdio.h>
> >>   #include <errno.h>
> >>   #include <selinux/context.h>
> >>
> >>   int
> >>   main ()
> >>   {
> >>     context_t c = context_new ("a:b:c");
> >>     if (!c)
> >>       return 1;
> >>     errno = 0;
> >>     if (context_user_set (c, ":") != 0)
> >>       printf ("failed with errno=%d\n", errno);
> >>     return 0;
> >>   }
> >>
> >
> > Looks like a documentation error to me - there is no attempt to set
> > errno in the code. In fact, most of libselinux looks like errno will
> > only get set as a result of a call to a lower level library function
> > (e.g., open or getxattr).
> >
> > Can you create a patch to correct the documentation?
> 
> I've looked at the code and now feel that the documentation
> should continue to say those functions set errno on failure.
> There are many ways in which context_user_set can fail and
> set errno to a useful value.  Callers should be able to use
> errno in all cases.
> 
> The solution is to ensure that whenever those functions
> fail they set errno to *something*.  In the case above,
> a tiny change to src/context.c would accomplish this,
> using EINVAL to tell the caller that ":" is invalid:
> 
> --- src/context.c.~1~	2006-07-31 18:29:01.000000000 +0200
> +++ src/context.c	2006-07-31 18:30:57.000000000 +0200
> @@ -2,6 +2,7 @@
>  #include <string.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <errno.h>
>  
>  #define COMP_USER  0
>  #define COMP_ROLE  1
> @@ -157,6 +158,7 @@ static int set_comp(context_private_t *
>  			if (*p == '\t' || *p == '\n' || *p == '\r' ||
>  			    ((*p == ':' || *p == ' ') && idx != COMP_RANGE)) {
>  				free(t);
> +				errno = EINVAL;
>  				return 1;
>  			}
>  		}

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
