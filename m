Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8P6pIsJ022524
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 02:51:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8P6pHCG001754
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 06:51:17 GMT
Received: from unicorn.lemuria.org (c152245.adsl.hansenet.de [213.39.152.245])
        by jazzband.ncsc.mil  with ESMTP id h8P6pGqJ001747 for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 06:51:16 GMT
Date: Thu, 25 Sep 2003 08:46:17 +0200
From: Tom <tom@lemuria.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Message-ID: <20030925084613.H11866@lemuria.org>
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <20030924221157.GS21997@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030924221157.GS21997@vnl.com>; from amon@vnl.com on Wed, Sep 24, 2003 at 11:11:57PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 24, 2003 at 11:11:57PM +0100, Dale Amon wrote:
> > Don't know if this helps much, but the only reference I see to /var/lib in the trace is sshd doing a stat on directory /var/lib/empty.
> 
> It certainly does. I wonder why I can't find it via a source grep? 

Because it is not hard-coded. It's whatever home-directory you set in
/etc/passwd for the privsep account.

That's also why others don't see that access. On Debian, for example,
it defaults to /var/empty

You might want to define a special type for the empty dir, so you can
move it around and don't have to give sshd access to all of /var

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
