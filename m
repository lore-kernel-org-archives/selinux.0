Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j04F49Ii024504
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 10:04:09 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j04F2FPZ025666
	for <selinux@tycho.nsa.gov>; Tue, 4 Jan 2005 15:02:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Richard Troth <rtroth@bmc.com>
Subject: Re: modules needed to be compiled in for selinux to work
Date: Wed, 5 Jan 2005 02:03:59 +1100
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
References: <20050102104530.GG6142@lkcl.net> <Pine.LNX.4.53.0501021201350.29068@rmt-desk.bmc.com>
In-Reply-To: <Pine.LNX.4.53.0501021201350.29068@rmt-desk.bmc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501050204.03428.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 03 January 2005 05:07, Richard Troth <rtroth@bmc.com> wrote:
> > i was wondering: which gets run first, /sbin/init or modprobe
> > capability from /etc/modules?
>
> Well ... 'init',  sort of.   Read on.
>
> > i think the question is fairly obviously /sbin/init but i want to be
> > absolutely sure.
>
> If "initrd" is not used,  then yes,  'init' runs first,
> and I supposed that can foul-up SELinux.   Of course,  one could
> replace 'init' with another program,  even a shell script,
> which would properly load the security modules and policies
> and then exec the real 'init'.

I initially experimented with a wrapper for /sbin/init to load the policy 
before the current method of loading policy was selected.

Having the wrapper named /sbin/init and having it call /sbin/init.real (or 
whatever) worked OK, but it wouldn't be good to continue having it like that 
as a shell script in case a shell upgrade broke the funky method of passing 
init state through a pipe.  The other option was to have a kernel parameter 
of init=/sbin/init.wrapper or similar but that seemed like a gross hack too 
and on some architectures passing a kernel command-line parameter is 
unreasonably painful.

Patching /sbin/init seemed the only viable option.

We could make an extra change to /sbin/init to make it call modprobe if 
absolutely necessary, it's not that difficult to do.

> Most often,  for SuSE and RedHat anyway,
> there's an "initrd" hack happening so that the distributor
> needs to ship only one or two pre-compiled kernels and then load
> modules in that mysterious early light just before dawn and
> real root and real /sbin/init.   After working its magic,
> the "initrd" initializer does a 'pivot_root'.

For Red Hat the solution is to just have capabilities linked into the kernel.  
For Debian we could have /sbin/init calling modprobe as it's first action 
after mounting /proc if necessary.

> > in other words, is CONFIG_CAPABILITY=m stopping selinux from
> > working in debian's 2.6.9 kernel?
>
> I really REALLY hope not,
> because having SELinux shipped as modules is a Good Thing.
> Several reasons for this position,  I will not enumerate now.

SE Linux has not worked correctly when compiled as a module since at least mid 
2001.  I don't believe that there are any plans to try and change this.  SE 
Linux must be linked into the kernel.  It makes sense to do the same with the 
capabilities module IMHO.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
