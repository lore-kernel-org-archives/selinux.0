Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2J1WRb017393
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 14:01:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB2J1VqY012336
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 19:01:31 GMT
Received: from unicorn.lemuria.org (c152152.adsl.hansenet.de [213.39.152.152])
        by jazzband.ncsc.mil  with ESMTP id hB2J1U0o012330 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 19:01:30 GMT
Date: Tue, 2 Dec 2003 19:54:33 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: selinux-policy-default
Message-ID: <20031202195432.H18433@lemuria.org>
References: <3FCC831A.1070002@zurich.ibm.com> <200312030159.41676.russell@coker.com.au> <3FCCAEA2.2040703@zurich.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FCCAEA2.2040703@zurich.ibm.com>; from vbc@zurich.ibm.com on Tue, Dec 02, 2003 at 04:24:18PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 02, 2003 at 04:24:18PM +0100, Chris Vanden Berghe wrote:
> Yes, but I did use --purge, so I expected that all configuration files
> would have been deleted by this.

I think I had the same issue. It appears some things are left behind.
Try --purge again and check if both /etc/selinux and /usr/share/selinux
have gone.


> And, as Dave suggested, I'm currently installing this under a
> non-selinux kernel (since the selinux one doesn't boot: it complains
> that it cannot find the policy file :-( ).  So the idea was to install
> all the selinux related packages under a non-selinux kernel and to
> afterwards boot with the selinux kernel.

You might want to check my step-by-step howto at
http://selinux.lemuria.org and check if you've done all that.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
