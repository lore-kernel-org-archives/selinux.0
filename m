Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA07333
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 22:17:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0I3HhI09239
	for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 03:17:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0I3Hff09235 for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 03:17:42 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>, Tom <tom@lemuria.org>
Subject: Re: version mismatch in Debian packages
Date: Sat, 18 Jan 2003 04:17:36 +0100
Cc: selinux@tycho.nsa.gov
References: <20030116160010.A2883@lemuria.org> <20030116221605.GA13472@snoopy.apana.org.au>
In-Reply-To: <20030116221605.GA13472@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301180417.36062.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 16 Jan 2003 23:16, Brian May wrote:
> > The tools seem to be compiled to version 12, but the lsm patch for
> > kernel 2.4.18 is version 11. The patches for 2.4.19 and 2.4.20 are
> > version 12, it's only the 2.4.18 that is affected.
>
> I think 2.4.18 is no longer supported anymore. The patch should probably
> get deleted from the package. Russell?

Sounds reasonable to me.

> > This is ugly because woody doesn't contain source packages for 19 or
> > 20, only for 2.4.18
>
> You could use the prepatched kernels (source and image) already
> on my website...

If you use a package that's outside woody then it's reasonable to expect that 
you may need other supporting packages from outside of woody.

I don't think that we need to change anything at the moment, other than 
possibly removing 2.4.18.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
