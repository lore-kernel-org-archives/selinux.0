Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4OLLHI4002066
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 17:21:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4OLLHtV021146
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 21:21:17 GMT
Received: from unicorn.lemuria.org (c145229.adsl.hansenet.de [213.39.145.229])
        by jazzband.ncsc.mil  with ESMTP id h4OLLGal021143 for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 21:21:16 GMT
Date: Sat, 24 May 2003 23:19:00 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: some policy patches
Message-ID: <20030524231853.D8955@lemuria.org>
References: <20030524180730.C8251@lemuria.org> <200305250418.34270.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200305250418.34270.russell@coker.com.au>; from russell@coker.com.au on Sun, May 25, 2003 at 04:18:34AM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, May 25, 2003 at 04:18:34AM +1000, Russell Coker wrote:
> Strange, it doesn't seem to do that on my system.  Maybe it's some module that 
> you are using.  In any case this is pretty harmless and should go in, but not 
> to xserver.te.  Putting it in xserver.te breaks policy compilation for 
> everyone who doesn't use xdm.
> 
> I've added it to xserver_macros.te in my tree.

I would've suggested putting #ifdef's around it, or adding it to xdm.te
(I'd assume that anyone running xdm is using X :) )


> > games.diff enables what I believe to be better games support. I have a
> 
> Firstly, don't use an apostrophy in words such as dont.  It causes problems 
> with m4.

Roger.


> For the games patch to be merged it will have to use the macros so that it can 
> work from user roles other than user_r.

Yes, I will fix that. I will post an updated version tomorrow.

I also have a policy for cdrom read and write access coming. I want to
use the cd-r/w writer in my notebook, too.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
