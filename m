Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2OGLMx6003559
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 11:21:22 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2OGLLR1013741
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 16:21:21 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h2OGLJj9013738 for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 16:21:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: Important fix for init.te
Date: Mon, 24 Mar 2003 17:21:08 +0100
References: <200303241615.LAA20568@moss-shockers.ncsc.mil>
In-Reply-To: <200303241615.LAA20568@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303241721.08554.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Mar 2003 17:15, Stephen D. Smalley wrote:
> > This is probably not the best solution however, the kernel thread
> > probably should not run as init_t.  But until I work out how to fix this
> > giving UDP access to init_t is necessary.
>
> The kernel thread calls reparent_to_init, so it is then assigned the
> SID of init.

Is this something that can/will be fixed?  Or will it have to remain like 
that?

If the latter then we could put ifdef(`rpcd.te' around that rule as it's only 
needed if you have rpcd installed.  What do you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
