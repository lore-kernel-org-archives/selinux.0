Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA12866
	for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2003 05:37:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA21689
	for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2003 10:34:48 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id KAA21685
	for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2003 10:34:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Solar Designer <solar@openwall.com>
Subject: Re: tcb for debian?
Date: Thu, 30 Jan 2003 11:37:27 +0100
Cc: selinux@tycho.nsa.gov
References: <20030128021923.GA27564@openwall.com> <200301280742.04671.russell@coker.com.au> <20030130040353.GA5400@openwall.com>
In-Reply-To: <20030130040353.GA5400@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301301137.27061.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 30 Jan 2003 05:03, Solar Designer wrote:
> But one point I wanted to make by mentioning this was that it is
> possible to have a Linux system, without kernel mods, on which the
> SUID root on passwd(1) would be about the highest risk.  It is also
> possible to setup a Debian system in this way, -- not using network
> services which came with it.  I think that some Debian users do so.

There may be some such Debian users.  But there's an issue of how much effort 
we should spend trying to help them instead of helping other groups of Debian 
users that are comprised of more people.

> Similarly, I think that our approach to SUID-less crontab(1) would
> benefit Debian, too.

That sounds interesting.

> > Programs can be excluded from Debian for being insecure, but they will
> > not be excluded for being likely to be insecure!
>
> I understand that and it's one of the reasons I decided to start the
> work on Owl.

Of course it wouldn't be difficult to create a little package that conflicts 
with all the Debian packages that are likely to be security risks...

> > This situation is vastly different from your own and therefore the way we
> > manage other issues has to be different to match.
>
> I'm not convinced.  I don't see how these are related so closely.  I
> can understand that a package maintainer may not accept a patch to a
> network service that limits its functionality in the default install.
> But things such as support for our tcb scheme or non-SUID crontab(1)
> have no impact on functionality.

They do require some effort to implement, they will also cause some confusion 
for users, which takes more time from developers to answer the questions.

libc6 already has far too many open bug reports.  I've looked at the code in 
the past and found it difficult enough to resolve the issues that affect me 
personally.  I am not convinced that it is most desirable for us to have the 
libc6 maintainers working on adding another feature that lacks upstream 
support when there's so much to fix in the core functionality.

I've just checked the Debian BTS, the libc6 people are doing a really good 
job, there's only one important bug that's over a year old now, and only a 
dozen normal bugs that are over two years old.  Just from quickly scanning 
the web page I can see a few bugs that could potentially have a security 
impact.

If someone wants to create a private apt repository for modified libc6 with 
tcb support then I would encourage them to do so.  But I don't think that 
having the efforts of the main libc6 maintainers diverted from their current 
bug squashing work will benefit us at the moment.

> Well, it seems the only thing I don't get is why you think it's right
> for Debian to not accept security solutions like the two I've mentioned
> above.  I don't see how they go against any constraints the project has.

Constraints don't just come in the form of rules, they also come in terms of 
practical issues of managing code etc.

The more differences there are between a Debian package and the upstream 
source the more work it is for every release.  Spending an entire day working 
on a Debian package to add a new upstream release is very common.

> > Regarding depending on an unofficial kernel.  Debian like all major
> > distributions has a patched kernel.  If "different from ftp.kernel.org"
> > == "unofficial" then it's unofficial.
>
> But, maybe except for a few special bits, it would work with a kernel
> right off kernel.org, right?

Correct.  I always use kernels from kernel.org because I don't agree with some 
of the decisions made by the Debian people in this regard.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
