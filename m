Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IE8nRb001646
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 10:08:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IE8kAR021788
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:08:47 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4IE8jHn021658 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:08:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Les Bell" <lesbell@lesbell.com.au>
Subject: Re: suggestion to help transition to selinux: dynamic loading of libselinux
Date: Wed, 19 May 2004 00:07:35 +1000
Cc: "Chris Babcock" <cbabcock@luthresearch.com>, selinux@tycho.nsa.gov
References: <OFC9F6DDFC.10588DF6-ONCA256E98.00360A82@lesbell.com.au>
In-Reply-To: <OFC9F6DDFC.10588DF6-ONCA256E98.00360A82@lesbell.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405190007.35107.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 May 2004 19:50, "Les Bell" <lesbell@lesbell.com.au> wrote:
> "Chris Babcock" <cbabcock@luthresearch.com> wrote:
> > Does this sound dangerous to anybody else?

If you can replace /lib/libselinux.so then you can surely compromise the 
entire system in many other ways.

> Does the design of SELinux depend on the state machine theory of security,
> i.e. if a system starts in a secure state, and all transitions are secure,
> then the system will remain secure? This design would seem unable to
> support that theory, i.e. until the selinux library is loaded, there are no
> constraints on the state of the machine. Just a thought. . .

Until the policy is loaded there are no SE Linux constraints on the machine 
state.  However at that time only init is running so it shouldn't be a 
problem.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
