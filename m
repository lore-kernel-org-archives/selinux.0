Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71BUQrT006473
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 07:30:26 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i71BTq52020263
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 11:29:53 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D6F0061C9D
	for <selinux@tycho.nsa.gov>; Sun,  1 Aug 2004 21:30:23 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 03773-04 for <selinux@tycho.nsa.gov>;
	Sun, 1 Aug 2004 21:30:23 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6CE6A61C9C
	for <selinux@tycho.nsa.gov>; Sun,  1 Aug 2004 21:30:23 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 3F529B59A2
	for <selinux@tycho.nsa.gov>; Sun,  1 Aug 2004 21:30:20 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: genhomedircon - bugs in sed stuff with unknown { } characters
Date: Sun, 1 Aug 2004 21:30:19 +1000
References: <20040731122721.GN3378@lkcl.net> <200408011932.54960.russell@coker.com.au> <20040801103509.GE7384@lkcl.net>
In-Reply-To: <20040801103509.GE7384@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408012130.19725.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 1 Aug 2004 20:35, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Sun, Aug 01, 2004 at 07:32:54PM +1000, Russell Coker wrote:
> > On Sat, 31 Jul 2004 22:27, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> > > okay, i removed the {s and }s from the genhomedircon's use of sed,
> > > and whoopee, off it went, looks like it's working now.
> >
> > You need to have a recent version of sed, do you have the latest version
> > installed?
>
>   ah.  probably not.
>
>   ... one for the .deb dependencies, methinks?

Already uploaded a new version of policycoreutils.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
