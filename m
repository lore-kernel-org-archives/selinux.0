Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ADr5rT027423
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 09:53:06 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5ADr1aH007745
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 09:53:02 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Magnus Therning <magnus-work@therning.org>
Subject: Re: SELinux on Debian (Sid)
Date: Thu, 10 Jun 2004 23:53:53 +1000
Cc: selinux@tycho.nsa.gov
References: <20040609144404.GJ5477@philips.com> <200406101817.28861.russell@coker.com.au> <20040610120344.GM5477@philips.com>
In-Reply-To: <20040610120344.GM5477@philips.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406102353.53028.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 10 Jun 2004 22:03, Magnus Therning <magnus-work@therning.org> wrote:
> >Sounds like you have old SE Linux, that is ancient and no longer being
> >supported.  It is only supported to kernel 2.4.21 upstream and 2.4.22
> >on my web site (in the section that is no longer maintained).  I
> >strongly recommend the new SE Linux.
>
> The selinux-default-policy came from the apt-repository mentioned above.

So how did you end up with a Makefile calling chsid?  I haven't had any script 
calling chsid for ages!

> My initial attempt to get things working was a few weeks ago, and then I
> had even more problems, that time with the Makefile not being able to
> handle the output from 'checkpolicy' (a cut -f 1 -d ' ' was needed).
> This was apparently fixed.

Yes, this should be fixed.

> >>       security:  policydb magic number 0x8 does not match expected magic
> >> number 0xf97cff8c load_policy: security_load_policy failed
> >
> >Sounds like you have new SE Linux in the kernel and old SE Linux in the
> >utilities.  Don't use the packages in woody.  Start with Brian's
> >back-ports if you want to use SE Linux in woody, but they haven't been
> >maintained for a while either.  It's best to use Debian/unstable (the
> >next version of Debian will be out soon so there seems little point in
> >starting with the old version now).
>
> Again all packages come from your repository.
>
> I'll take a look at it again later today, to see if there has been any
> new packages uploaded since my last attempt.

Show me the versions of those packages.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
