Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2BmpRb013460
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 06:48:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB2BmAp5019007
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 11:48:10 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hB2Bm9t0019003
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 11:48:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>
Subject: Re: wdm now has SELinux support out-of-the-box
Date: Tue, 2 Dec 2003 22:48:40 +1100
References: <20031202094639.C29282@lemuria.org>
In-Reply-To: <20031202094639.C29282@lemuria.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312022248.40562.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Dec 2003 19:46, Tom <tom@lemuria.org> wrote:
> Just a short update:
>
> My wdm patches have been accepted and integrated upstream and wdm will
> now have SELinux support without any patches. You may have to recompile
> it with the proper ./configure switches, though.

Great work!

While you're on a roll perhaps you could look into trying to get some of the 
other application patches accepted upstream.  At the moment I'm busy enough 
just keeping things working...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
