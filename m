Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3N3B4gA020856
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 23:11:04 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3N32xrf016745
	for <selinux@tycho.nsa.gov>; Sat, 23 Apr 2005 03:03:01 GMT
Date: Sat, 23 Apr 2005 04:15:07 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Jochen Schmitt <Jochen@herr-schmitt.de>, selinux@tycho.nsa.gov
Subject: Re: Sugg. for SELinux enabled Interpreters
Message-ID: <20050423031507.GA8520@lkcl.net>
References: <E1CtATI-0008Ib-00@mrelayng.kundenserver.de> <200504230741.36883.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200504230741.36883.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

it goes a little further than even this, with KDE 3.4.

you can also select some pre-exec'ing and also disable it.

there is some sharing and cacheing of connections going on,
e.g. if you make a connection to an IMAP4 server, then _two_
programs can use that same connection to obtain email.
one program becomes a "proxy server".

in order to "optimise" this behaviour, it was decided by the
KDE team to pre-load all of the .so libraries that do this
kind of cacheing - one for HTTP connections, one for FTP,
one for this, for that, etc.

then of course once it was all implemented, someone _else_
pointed out that it might not be a good idea after all to have
just the one program doing all those connections.

so, at run-time, you can now define, just like KDE_IS_PRELINKED
(i forget what it's called... AH - got it)

	export KDE_FORK_SLAVES=1

and:

	export KDE_EXEC_SLAVES=1

you must do one or the other, and it _only_ works with kde 3.4.

i believe that the KDE_EXEC_SLAVES will be the most appropriate
behaviour for a paranoid KDE SE/Linux system, because you will
find that an executable called kio_slave_http gets created
(IIRC correctly) and another one called kio_slave_ftp etc.
whereas if you don't have either of those two environment
variables set, you get ONE executable and it does that silly
.so preloading stuff.

rambling again.  stop now.

l.

p.s. the kde team don't really grok selinux - nobody's paying
anybody in the kde team to integrate selinux properly.
why bother, when gnome "does the job" i think is the most
likely gist.

On Sat, Apr 23, 2005 at 07:41:34AM +1000, Russell Coker wrote:
> On Tuesday 25 January 2005 07:05, Jochen Schmitt <Jochen@herr-schmitt.de> 
> wrote:
> > Hallo,
> >
> > I have bought a book about SELinux form O'Reilly. In this book it
> > was discussed, that some applications, like KDE have issues with
> > SELinux.
> >
> > On KDE the problem is the kdeinit process, which coused, that
> > SELinux can not distlinguish the diffent programms started by
> > kdeinit.
> 
> Below is a message from Luke about this matter.  In this example reconfiguring 
> KDE is the better option.  I've pasted the message because I have no net 
> access at the moment and can't lookup a URL.
> 
> We should get some bugs filed against kdeinit in all the distributions to make 
> this an option that the administrator can configure permanently for the 
> entire system.  Also Fedora, RHEL, and any other distribution which gets SE 
> Linux as the default install option should probably default to this.
> 
> 
>  Subject: kdeinit
>  Date: 2004-07-25 23:01
>  From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
>  To: SE-Linux <selinux@tycho.nsa.gov>
>  
> as you've seen, i sent a message to the kde-devel list, stephan kindly
> responded by saying that it's possible to disable kdeinit by
> defining KDE_IS_PRELINKED.
> 
> i've modified startkde (possibly not the smartest thing to do) to
> have this at the top:
> 
>         #!/bin/sh
>         #
>         #  DEFAULT KDE STARTUP SCRIPT ( KDE-3.2 )
>         #
> 
>         KDE_IS_PRELINKED=1
>         export KDE_IS_PRELINKED
> 
> and voila, it appears that i end up saving about 30mbyte of virtual
> memory - something that _could_ save a lot of time on a system that
> is pushed for physical ram.
> 
> so it's a trade-off between saving some virtual memory and saving some
> speed in the library pre-loading.
> 
> ... but the important thing is that as far as SE/Linux is concerned
> it IS possible to remove kdeinit from the loop, and therefore it IS
> possible to write selinux policy files without kdeinit getting in
> the way.
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
