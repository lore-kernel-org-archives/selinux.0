Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA12422
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 04:52:29 -0400 (EDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tracy R Reed <treed@ultraviolet.org>, Tom <tom@lemuria.org>
Subject: Re: SE Linux on Debian
Date: Wed, 2 Oct 2002 10:50:27 +0200
Cc: selinux@tycho.nsa.gov
References: <20021001153638.J5416@ultraviolet.org> <20021002092056.A4475@lemuria.org> <20021002003004.C28686@ultraviolet.org>
In-Reply-To: <20021002003004.C28686@ultraviolet.org>
MIME-Version: 1.0
Message-Id: <200210021050.27797.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2 Oct 2002 09:30, Tracy R Reed wrote:
> I realized that I still have xdm running and logged in through that so I
> was logged in as xdm_t and my username wasn't in the users file which of
> course causes all sorts of problems.

If you want an X login then the only Debian package for you is kdm (the KDE 
XDM program), and that's for the 2.2.2 version of KDE.

There is a patch for GDM which I haven't packaged because it's not something I 
use (and the things I use don't work to my satisfaction yet).

If kde 2.2.2 isn't an option for you then you have to use startx.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
