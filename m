Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA05501
	for <selinux@tycho.nsa.gov>; Sun, 1 Dec 2002 07:09:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA18576
	for <selinux@tycho.nsa.gov>; Sun, 1 Dec 2002 12:07:14 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA18559 for <selinux@tycho.nsa.gov>; Sun, 1 Dec 2002 12:07:13 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: expect
Date: Sun, 1 Dec 2002 13:08:58 +0100
References: <200211292002.PAA23890@moss-shockers.ncsc.mil>
In-Reply-To: <200211292002.PAA23890@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200212011308.58878.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Nov 2002 21:02, Stephen D. Smalley wrote:
> > Due to what I believe to be bugs in expect, the new open_init_pty program
> > will not work correctly with old versions of expect.  Version 5.38.0
> > works fine, version 5.32.2 is broken.  I don't know when the bug was
> > fixed exactly.
>
> I've backed out the open_init_pty changes to our internal copy of
> run_init.   I'd rather not have the base run_init functionality dependent
> on a particular version of expect, and I'm not even sure that it is
> wise to depend on having expect installed at all.

I will not do the same for my Debian packages.

I can see the benefit in having two options available for users in this case, 
as some smaller devices such as PDAs may not have space for expect.  But 
Debian is a heavy distribution primarily designed for workstations and 
servers.  Debian works well on laptops too but is not designed to scale down 
any further than that.  So I think that there is no reason not to depend on 
expect.

I have made my Debian packages depend on the appropriate version of expect so 
you can just install the packages and be sure that the right things are 
automatically installed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
