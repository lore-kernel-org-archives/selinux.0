Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAUK8oRb003530
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 15:08:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAUK8nqY016472
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 20:08:50 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAUK8m0o016469 for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 20:08:49 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Policy error of the day
Date: Mon, 1 Dec 2003 07:08:37 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20031129123120.GI18062@vnl.com>
In-Reply-To: <20031129123120.GI18062@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312010708.37773.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 29 Nov 2003 23:31, Dale Amon <amon@vnl.com> wrote:
> Ah...Russ... did you do something naughty? I note all of these are
> failing after the postinst.d/selinux. I wonder if you are
> expecting these installs to be occuring under selinux rather
> than on a non-selinux 'factory' machine in a chroot:

setfiles is supposed to operate on a non-SE machine.  The current version 
apparently still has the code to check for validity of a context before 
applying it, the plan is to fix this and I thought it was already fixed.  It 
will be fixed soon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
