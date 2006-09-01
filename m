Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81Cn2Am006571
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 08:49:02 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k81CmLOi021250
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 12:48:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: type transitioning script race condition?
Date: Fri, 1 Sep 2006 22:48:51 +1000
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@gentoo.org>, Klaus Weidner <klaus@atsec.com>,
        selinux@tycho.nsa.gov, Stephan Mueller <smueller@atsec.com>
References: <20060830223937.GB12307@w-m-p.com> <1157030632.3106.7.camel@localhost.localdomain> <1157032383.24429.90.camel@twoface.columbia.tresys.com>
In-Reply-To: <1157032383.24429.90.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200609012248.56275.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 31 August 2006 23:53, Joshua Brindle <method@manicmethod.com> 
wrote:
> The one you referenced is specific to python but I'd like something more
> general, basically what I'm envisioning is a wrapper that you symlink
> all your interpreters to:
>
> /usr/bin/perl -> /usr/lib/wrapper/envcleaner (or whatever)
> same with python, php, etc

Do all interpreters have the same requirements for environment cleaning?  Is 
there a case where cleaning the environment for interpreter A will break 
interpreter B in some way?

> and when the wrapper is run it looks at how it was run argv[0] and
> checks a config file, something like:

We are talking about a wrapper that does something similar to suid-perl.  The 
security history of suid-perl isn't that good, I am concerned that a program 
which is designed to suit more than one interpreter will be harder to 
secure...

http://www.coker.com.au/selinux/talks/ols2003/

In the paper I presented at OLS 2003 I considered some options for domain 
transitions with a single program.  I was looking at busybox, but a single 
interpreter with multiple scripts will work in similar ways.

If we were to have hundreds of types used for domain transitions then there 
would be an administrative burden in configuring the system which was not a 
factor I considered in my paper (I was just looking at the needs of programs 
that are parts of busybox).  In such a case the single wrapper would offer 
some benefits at the cost of slightly weakening security.

Will we have hundreds of types used for such transitions?  Or will the number 
of scripts that require domain transitions for correct operation be small 
enough that a wrapper for each is possible?

If there is only a small number of types used for scripts then we can have a C 
wrapper that causes the transition.

So you have /usr/bin/a.sh and /usr/bin/b.sh being shell scripts with the type 
bin_t and /usr/bin/a and /usr/bin/b being executables labeled with types to 
cause domain transition which would then execute the shell scripts.  Before 
executing the shell scripts they could change the environment as necessary.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
