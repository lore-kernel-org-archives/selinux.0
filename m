Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2FBiRb015116
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 10:11:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB2FBgqY028441
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:11:42 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hB2FBf0o028432 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:11:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: wdm now has SELinux support out-of-the-box
Date: Wed, 3 Dec 2003 02:11:33 +1100
References: <20031202094639.C29282@lemuria.org> <200312022248.40562.russell@coker.com.au> <20031202145531.B1867@lemuria.org>
In-Reply-To: <20031202145531.B1867@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312030211.33587.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Dec 2003 00:55, Tom <tom@lemuria.org> wrote:
> On Tue, Dec 02, 2003 at 10:48:40PM +1100, Russell Coker wrote:
> > While you're on a roll perhaps you could look into trying to get some of
> > the other application patches accepted upstream.  At the moment I'm busy
> > enough just keeping things working...
>
> Tell me which ones are most important.
>
> I have a tight deadline next monday for my next paper. After that I'll
> have a bit of time. Until then, I'm struggling for free minutes.

Apart from login and sshd where the patches are deprecated I think that they 
are all equally important, so pick whichever you feel most comfortable 
working with.

If you choose psmisc then note that the patch does not have all desired 
functionality (IMHO), and you would probably be best starting from scratch.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
