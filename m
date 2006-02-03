From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: labeling of compilers etc
Date: Fri, 3 Feb 2006 22:15:32 +1100
Cc: James Morris <jmorris@namei.org>, SELinux-dev@tresys.com,
   SELinux List <selinux@tycho.nsa.gov>
References: <200601291156.13076.russell@coker.com.au> <200602021027.16336.russell@coker.com.au> <1138883552.18268.114.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138883552.18268.114.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602032215.44188.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 02 February 2006 23:32, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > You are correct that there is no domain transition related to the script
> > when the shell is executed directly.  However it's still desirable to
> > enforce access control over which files can be executed.
>
> True.  But it isn't clear what you gain from shell-enforced access
> control when the shell is running in the caller's domain, because the
> caller can then easily influence and control the shell in order to
> bypass its checking (e.g. using LD_* variables, running the shell under
> a debugger, etc).  This might require first importing precompiled code
> into the target system from an external site, but that likely isn't
> difficult if one gained access in the first place.

How would they get that precompiled code to be executed?  We want to make such 
things as difficult as possible.  One of the first aims of such work is to 
make all debuggers etc unavailable to such processes.

The shell is no easier to control via debuggers etc than any other process.

Also in regard to precompiled code the person writing such code must either 
know in advance what type of system is being targeted or send several 
sections of code for different systems.  The former requires more knowledge 
of the target than is often available and the latter requires bigger payloads 
and more attempts which increase the risk of detection.  People who are 
launching attacks on Linux systems now are using shell scripts and compiling 
source on the target machine because such methods provide them some benefits.  
So it seems worth-while to deny them such benefits.

> Russell Coker wrote:
> > That is a really good idea.  You are correct that setuid and
> > domain_auto_trans() shell scripts are still a really bad idea (the shell
> > is far too dependent on environment variables etc).  But anything that
> > makes hostile action more difficult is a good thing.
>
> Yes.  If I recall correctly, one stumbling block in making the above
> change in Linux is that in Linux, the /dev/fd/<n> links
> -> /proc/self/fd/<n> links become inaccessible under setuid/setgid
> (except for setuid to root, of course).  So one would have to alter that
> restriction while still dealing with the potential leak issue there.

Given that setuid/setgid scripts aren't supported anyway this shouldn't be an 
issue.  Any system that implements such setuid/setgid scripts (IE the 
perl-suidperl package) will also solve this problem because the script 
interpreter is not setuid/setgid and is run with the euid==uid and the 
egid==gid.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
