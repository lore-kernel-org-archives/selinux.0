Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA22284
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 11:11:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA17745
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 15:09:37 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA17739 for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 15:09:35 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: pasi.kivikangas@nokia.com, <selinux@tycho.nsa.gov>
Subject: Re: SE Linux and UML compile problems...
Date: Mon, 30 Sep 2002 17:11:12 +0200
References: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE8440@esebe013.ntc.nokia.com>
In-Reply-To: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE8440@esebe013.ntc.nokia.com>
MIME-Version: 1.0
Message-Id: <200209301711.12581.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Sep 2002 10:44, pasi.kivikangas@nokia.com wrote:
> > -----Original Message-----
> > From: ext Jeff Dike [mailto:jdike@karaya.com] Sent: 27 September, 2002
> > 19:14
> >
> > pasi.kivikangas@nokia.com said:
> > > 	unsigned int magic = regs.regs.args[1];
> > >	unsigned int call = regs.regs.args[2];
> > >	unsigned long *args = (unsigned long *)regs.regs.args[3];
> >
> > Yeah, that would be better.
> >
> > 		Jeff
>
> Hi,
>
> Just wanted to confirm that SELinux enhanced UML kernel now boots.

I also got it to boot.  I haven't got around to installing SE Linux on it or 
doing anything useful with it.  So I'm not sure if my installation actually 
works.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
