Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9ULQ5Wt015838
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 16:26:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9ULQ4Kl017342
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 21:26:04 GMT
Received: from unicorn.lemuria.org (d004029.adsl.hansenet.de [80.171.4.29])
        by jazzband.ncsc.mil  with ESMTP id h9ULQ35m017324 for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 21:26:03 GMT
Date: Thu, 30 Oct 2003 22:19:27 +0100
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user's access to files in their own home directory
Message-ID: <20031030221926.E27196@lemuria.org>
References: <200310310610.14859.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310310610.14859.russell@coker.com.au>; from russell@coker.com.au on Fri, Oct 31, 2003 at 06:10:14AM +1100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 31, 2003 at 06:10:14AM +1100, Russell Coker wrote:
> I would like some feedback on how people feel about having files/dirs under a 
> user's home directory that they can't unlink or rename.

Trojan protection comes to mind immediately. Any files that are
automatically executed or such like, which contains .bashrc and its
bretheren, but also .forward and others.

It might be good to not have these modifyable from the standard user_r,
but only from a special different role to guarantee that mistake or
malicious code can not mess them up.


Other than that, we should definitely provide the infrastructure. On
many systems, the admin might want to force some settings or start
scripts.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
