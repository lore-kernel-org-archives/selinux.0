Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA24453
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 06:49:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA10481
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 11:47:59 GMT
Received: from web40008.mail.yahoo.com (web40008.mail.yahoo.com [66.218.78.26])
	by jazzswing.ncsc.mil  with SMTP id LAA10477
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 11:47:58 GMT
Message-ID: <20021104114948.17224.qmail@web40008.mail.yahoo.com>
Date: Mon, 4 Nov 2002 03:49:48 -0800 (PST)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: When should I upgrade SELinux?
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200211040224.48164.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:
> On Mon, 4 Nov 2002 01:39, Brad Chapman wrote:
> > I've been reading a lot on this list about changes to the core
> > SELinux policy system. I've been trying to get 2.4.19 SELinux working
> > with RH8, but haven't had very much time (been busy fixing hardware
> > problems with other machines).
> >
> > Should I upgrade to the new version of SELinux, Russell's policy, and to
> > 2.4.20 when it becomes available? Or should I upgrade now?
> 
> Currently my policy is not very different from the CVS policy, so it may be 
> most conveniant for people who don't use Debian to get the policy from the 
> Sourceforge CVS.

OK. I will try to get the CVS and use that to compile with.

> 
> I highly recommend getting the V12 policy.  Everyone who is actively doing 
> things with SE Linux is tracking the latest versions, and not having the 
> latest will make it more difficult for you to get support.

ACK.

> 
> When 2.4.20 comes out I am not likely to support it as fast as I have 
> supported previous versions due to the fact that the LSM kernel patch is not 
> containing all the necessary code (so I will have to do more coding to get it

> to work properly).  So full support for 2.4.20 may wait until the next NSA 
> release after 2.4.20 is released, and therefore there's not much point in 
> basing your upgrade decisions on the potential of installing 2.4.20 IMHO.

All right. I was just wondering, since I would like to use 2.4.20, but don't
have to if there will be issues with it and SELinux. I'll try upgrading some-
time this week.

> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>

Brad 


__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
