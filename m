Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i431MPRb002475
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 21:22:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i431MNYW006372
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 01:22:24 GMT
Received: from dns1.outlandz.net (dns1.outlandz.net [66.132.132.24])
        by jazzband.ncsc.mil  with ESMTP id i431MNBf006369 for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 01:22:23 GMT
Subject: Re: Tinydns Policy Files
From: "Matthew J. Fanto" <mattjf@uncompiled.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200405030919.34619.russell@coker.com.au>
References: <1083518249.543.9.camel@ares>
	 <200405030919.34619.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1083547353.543.18.camel@ares>
Mime-Version: 1.0
Date: Sun, 02 May 2004 21:22:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-05-02 at 19:19, Russell Coker wrote:
> Is it possible to configure this and the other DJB tools in a sane manner?  
> For starters entry point executables should not be under /etc.

This is djb's recomended way of doing it. It's also the default for
Debians packages. It might require a decent amount of work to do it
differently. 

-Matthew J. Fanto


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
