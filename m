Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j137LH53028414
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 02:21:17 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j137J6o7011847
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 07:19:07 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Villalovos, John L" <john.l.villalovos@intel.com>
Subject: Re: Advice on bringing up SE Linux
Date: Thu, 3 Feb 2005 18:20:50 +1100
Cc: "Stephen Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
References: <60C14C611F1DDD4198D53F2F43D8CA3B035B559E@orsmsx410>
In-Reply-To: <60C14C611F1DDD4198D53F2F43D8CA3B035B559E@orsmsx410>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502031820.54692.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 02 February 2005 07:51, "Villalovos, John L" 
<john.l.villalovos@intel.com> wrote:
> > /sbin/init is what normally loads the policy during startup.  Are you
> > using the modified /sbin/init (included in Fedora)?  What is in your
> > /etc/selinux/config?
>
> Okay.  We are using Busybox for the init.  So it does not have the SE
> Linux stuff in it.

The upstream developer of busybox was accepting of SE Linux patches, I had 
some SE Linux patches in the busybox CVS at one time (not sure if they are 
still there).  If I get a bit of spare time I'll do some more work on Busybox 
SE Linux support, it's good to have for recovery purposes and I think I've 
still got some patches hanging around that I never got sorted out properly 
for release.

Also you may want to check out the paper I presented at OLS on getting SE 
Linux running on iPaQ's, the stuff about wrapping busybox etc will probably 
be of interest to you.

If you get the JFFS2 support written I'll be very interested, I have a couple 
of iPaQ's I want to get running SE Linux again.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
