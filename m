Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IEp6Rb002128
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 10:51:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IEp3AR025017
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:51:03 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4IEoxHn024900 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:51:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Chris Babcock" <cbabcock@luthresearch.com>
Subject: Re: suggestion to help transition to selinux: dynamic loading of  libselinux
Date: Wed, 19 May 2004 00:49:45 +1000
Cc: selinux@tycho.nsa.gov
References: <OFC9F6DDFC.10588DF6-ONCA256E98.00360A82@lesbell.com.au> <200405190007.35107.russell@coker.com.au> <2613.68.6.187.64.1084889973.squirrel@mxlx1.surveysavvy.com>
In-Reply-To: <2613.68.6.187.64.1084889973.squirrel@mxlx1.surveysavvy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405190049.45870.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 May 2004 00:19, "Chris Babcock" <cbabcock@luthresearch.com> wrote:
> > Until the policy is loaded there are no SE Linux constraints on the
> > machine
> > state.  However at that time only init is running so it shouldn't be a
> > problem.
>
> The danger involved with replacement of /lib/libselinux.so on an selinux
> system is pretty obvious, however if the system is operating properly it
> shouldn't be too much of an issue.
>
> What I was thinking about was more along the lines of what happens on a
> system where a vendor distributes selinux enabled utilities (using dlopen
> as described) but doesn't install the library by default and leaves
> selinux disabled in kernel.

If the vendor in question does not install libselinux then the are designing 
their system to be only protected by Unix permissions.  To create a file 
in /lib you have to have UID 0, so again anyone who can install libselinux 
has already taken over the system.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
