Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h989i7Wt017839
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 05:44:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h989i67d013346
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 09:44:06 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h989hSRn013325 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 09:43:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: 2.6.0-test6 boot process failures
Date: Wed, 8 Oct 2003 19:43:20 +1000
References: <20031007230348.E11325@lemuria.org> <200310081341.12645.russell@coker.com.au> <20031008100006.F11916@lemuria.org>
In-Reply-To: <20031008100006.F11916@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310081943.20925.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Oct 2003 18:00, Tom wrote:
> > Where's Colin's script?
>
> It's in his selinux-policy-default package. Here's the script:

OK, I've just released a new version of my selinux-policy-default package with 
this.  I have made a few changes, the noteworthy change is that I check for 
the policy version, so the same script will work for the old SE Linux (apart 
from trying to mount /selinux which I forgot), the new SE Linux, and future 
releases.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
