Date: Fri, 17 Oct 2003 21:02:10 -0700
From: Michael Reilly <michaelr@cisco.com>
To: russell@coker.com.au
Cc: SELinux@tycho.nsa.gov
Subject: Re: Yet another question - newrole and xterm's
Message-Id: <20031017210210.0c4e7894.michaelr@cisco.com>
In-Reply-To: <200310171339.33673.russell@coker.com.au>
References: <20031015191716.5478c74b.michaelr@cisco.com>
	<200310170216.37933.russell@coker.com.au>
	<20031016104026.78cacc68.michaelr@cisco.com>
	<200310171339.33673.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you Russell - once again your help was invaluable.

su on my system requires pam_wheel.so so when newrole was installed newrole also required pam_wheel.  No problem on a normal terminal.

However xterm is not allowed to update utmp so the getlogin() call made by pam_wheel.so returned NULL which made pam_wheel.so fail so newrole printed the "bad password" message.

You can pass an option to pam_wheel.so to use the UID and call getpwuid(getuid()) instead of getlogin() to determine the who the user is.  Since using UIDs to identify a user is generally a bad thing for security reasons I did not take this approach.

Instead I commented out pam_wheel.so so any user may run newrole.  Sounds like the way to go anyway.

Is there any reason to use pam_wheel.so with newrole?  If so it would be fairly esy to modify pam_wheel.c to sue the same calls newrole uses to get the user name (get the context and call context_user_get(context);  For now I'll leave pam_wheel.so commented out for newrole.

BTW - nothing was logged in auth.log.  I enabled debug of the pam modules for newrole and found the problem quickly once I was pointed at the pam modules.

michael

On Fri, 17 Oct 2003 13:39:33 +1000
Russell Coker <russell@coker.com.au> wrote:

> On Fri, 17 Oct 2003 03:40, Michael Reilly wrote:
> > I am running old SElinux.  I verified last night - put the entry back as
> > dontaudit and newrole says the password does not match - looking at the
> > newrole.c code I think this is the result it received from PAM.
> 
> What PAM modules are you using?  Is anything logged to auth.log?
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page


-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
