Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBANltIi024359
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 18:47:55 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBANkFwg029877
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 23:46:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: can_network patch.
Date: Sat, 11 Dec 2004 10:47:46 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Jim Carter <jwcart2@epoch.ncsc.mil>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
References: <41741A2C.8040408@redhat.com> <200412110511.12960.russell@coker.com.au> <200412102101.iBAL1NeN009808@turing-police.cc.vt.edu>
In-Reply-To: <200412102101.iBAL1NeN009808@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200412111047.51803.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 11 December 2004 08:01, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 11 Dec 2004 05:11:07 +1100, Russell Coker said:
> > We have mozilla running in it's own domain to limit the risk of exploits
> > of mozilla taking over the rest of the system.  Allowing mozilla to
> > install packages seems to directly contradict this aim.
>
> Gaak.  Given the "browser can install software" mentality that's one of the
> single biggest design borkages in That Other Browser/Operating System, we
> should do what we can to fix this...

I agree.

> > Maybe we should just remove the mozilla policy?
>
> I'd rather have a mozilla policy that enforces (roughly) "it can play
> inside the ~/.mozilla tree, and download into ~/Downloads or similar, and
> any other activity is constrained".

Same here.

> Or did you mean "remove the bit of policy that allows it to install
> packages", in which case we're in total agreement....

If we were going to give Mozilla the access to install packages (as was in the 
CVS until recently) then there was no benefit in trying to restrict it's 
access so we may as well have removed mozilla.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
