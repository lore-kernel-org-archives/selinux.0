Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4KFqBI4010466
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 11:52:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4KFpotV000093
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 15:51:50 GMT
Received: from unicorn.lemuria.org (c145125.adsl.hansenet.de [213.39.145.125])
        by jazzband.ncsc.mil  with ESMTP id h4KFpjal000070 for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 15:51:48 GMT
Date: Tue, 20 May 2003 17:49:21 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: xdm (not kdm) policy ?
Message-ID: <20030520174914.A10662@lemuria.org>
References: <20030520145143.C400@lemuria.org> <200305210015.37136.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200305210015.37136.russell@coker.com.au>; from russell@coker.com.au on Wed, May 21, 2003 at 12:15:37AM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 21, 2003 at 12:15:37AM +1000, Russell Coker wrote:
> My patch for kdm 2.2 is still online.
> 
> I've attached the latest patch I was playing with for kdm 3.1.x.  I never 
> tested this one because I never could get kdm to compile.

I played with these yesterday, for several hours. Now I hate KDE (or
rather: it's build process - have they never heard of modularization?), but
I still have no working kdm. :)


I'm currently working on patching wdm. The necessary changes seem to be
easy enough to make. And since it uses autoconf, I'll try submitting it
to the upstream author once it works.

One question, though: wdm uses system() calls for reboot and halt. How
should I deal with those?


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
