Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA14658
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 14:17:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gB6JH4I00262
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 19:17:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gB6JH3f00252 for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 19:17:03 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>
Subject: Re: new policy
Date: Fri, 6 Dec 2002 20:16:53 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0212061326220.27615-100000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0212061326220.27615-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <200212062016.53488.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Dec 2002 20:00, Wayne Salamon wrote:
> On Fri, 6 Dec 2002, Russell Coker wrote:
> > There apparently is.  Apparently there is functionality needed by the
> > hwclock_t domain on Red Hat but not for other systems.  If this is not
> > the case then the following comment is wrong.
> > # hwclock needs to search file_t directories when run from rc.sysinit on
> > RH8
>
>   Yes, the comment is misleading; sorry. But it doesn't state this is
> the ONLY situation the rule applies. The actual rule has nothing to do
> with rpm_t domain. Easy to fix: remove the comment.

Or change it to ifdef(`redhat.te' ...

> > If you have hwclock on a non-RedHat system then you don't need policy
> > that is specific to Red Hat!
>
>   But I need a policy, and it would be easier to reuse the example policy
> if I don't have to untangle it from itself.

It's not that difficult!

> > I don't think that you'll need to do that often (if at all).
>
>   Not too often right now, and I'd like to keep it that way :) But
> initrc.te looks like it will need to have the if(rpm.te) because Slackware
> has /boot as well.

Every distribution has /boot.  I hoped that only Red Hat had the foolishness 
of having init scripts mess with /boot, use Debian as a good example for how 
a distribution can solve these problems in a sane fashion.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
