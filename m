Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i42NKwRb002154
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 19:21:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i42NKuYW003536
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 23:20:56 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i42NKtBf003501 for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 23:20:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Matthew J. Fanto" <mattjf@uncompiled.com>
Subject: Re: Tinydns Policy Files
Date: Mon, 3 May 2004 09:19:34 +1000
Cc: selinux@tycho.nsa.gov
References: <1083518249.543.9.camel@ares>
In-Reply-To: <1083518249.543.9.camel@ares>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405030919.34619.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 3 May 2004 03:17, "Matthew J. Fanto" <mattjf@uncompiled.com> wrote:
> Here are updated policy files for tinydns. This is the first policy file
> I've written, so I'd appreciate any feedback. This was written for
> Debian stable.

Is it possible to configure this and the other DJB tools in a sane manner?  
For starters entry point executables should not be under /etc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
