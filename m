Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hARKrdRb025114
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 15:53:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hARKrcqY018444
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 20:53:38 GMT
Received: from unicorn.lemuria.org (c152152.adsl.hansenet.de [213.39.152.152])
        by jazzband.ncsc.mil  with ESMTP id hARKrb0o018441 for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 20:53:38 GMT
Date: Thu, 27 Nov 2003 21:46:35 +0100
From: Tom <tom@lemuria.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: BSD Secure levels for linux
Message-ID: <20031127214635.I7755@lemuria.org>
References: <3FC54560.5050303@diyab.net> <200311271326.53583.russell@coker.com.au> <3FC61C05.90400@diyab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FC61C05.90400@diyab.net>; from diyab@diyab.net on Thu, Nov 27, 2003 at 10:45:09AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 27, 2003 at 10:45:09AM -0500, Diyab wrote:
> I never thought about something like that.  On the plus side not only 
> would you have more control over what your specific "levels" will do but 
> you can easily and securely switch between levels.  The patch I 
> mentioned does not have that functionality.

Remember that it's a _feature_ of the securelevels implementation that
you can _not_ switch back. Once locked down, nothing short of a reboot
will unlock, and a reboot is a very noisy action in any production
environment.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
