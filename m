Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j13LnR53003603
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 16:49:27 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Advice on bringing up SE Linux
Date: Thu, 3 Feb 2005 13:49:07 -0800
Message-ID: <60C14C611F1DDD4198D53F2F43D8CA3B036251F3@orsmsx410>
From: "Villalovos, John L" <john.l.villalovos@intel.com>
To: <russell@coker.com.au>
Cc: "Stephen Smalley" <sds@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> The upstream developer of busybox was accepting of SE Linux patches,
> I had some SE Linux patches in the busybox CVS at one time (not sure
> if they are still there).  If I get a bit of spare time I'll do some
> more work on Busybox SE Linux support, it's good to have for recovery
> purposes and I think I've still got some patches hanging around that
> I never got sorted out properly for release.
> 
> Also you may want to check out the paper I presented at OLS on
> getting SE Linux running on iPaQ's, the stuff about wrapping busybox
> etc will probably be of interest to you.
> 
> If you get the JFFS2 support written I'll be very interested, I have
> a couple of iPaQ's I want to get running SE Linux again.

At the moment Busybox does not compile with SE Linux enabled.  It am
guessing that is using the old 2.4 API stuff.  It is looking for an
include file which is no longer there in the new SE Linux code.

We will see on the JFFS2 stuff.  At the moment we haven't made a
commitment for that.  We still have more investigation to do to see if
it is necessary.

John


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
