Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i719XZrT005964
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 05:33:37 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i719XS0x018711
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 09:33:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: genhomedircon - bugs in sed stuff with unknown { } characters
Date: Sun, 1 Aug 2004 19:32:54 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040731122721.GN3378@lkcl.net>
In-Reply-To: <20040731122721.GN3378@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408011932.54960.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 31 Jul 2004 22:27, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> okay, i removed the {s and }s from the genhomedircon's use of sed,
> and whoopee, off it went, looks like it's working now.

You need to have a recent version of sed, do you have the latest version 
installed?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
