Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7THTWrT000637
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 13:29:32 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7THSgwc029779
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 17:28:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Andreas Schuldei <andreas@schuldei.org>
Subject: Re: selinux and kde
Date: Mon, 30 Aug 2004 03:29:27 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823234320.GC12720@lkcl.net> <20040824122646.GA1655@lukas.schuldei.com>
In-Reply-To: <20040824122646.GA1655@lukas.schuldei.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408300329.27393.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Aug 2004 22:26, Andreas Schuldei <andreas@schuldei.org> wrote:
> the amount of avc messages i got when running normal operation
> without any special stuff (postfix mostly, where spam filtering
> with spamd is the most advanced operation i do) discouraged me
> slightly to pursue this path right now.

Give me a list of AVC messages, some are probably things that should go into 
the main policy.

> i conclude that debian is not a viable platform for selinux for
> non-selinux development right now. this is a real tragedy since
> both russel and colins were working on it some time ago as their
> prime platform, pushing it hard on debian, but i guess the
> enormous debian initeria and the reluctance to include their lib
> into base along with their jobs at redhat killed it for now.

The lib will go into base post-sarge.  The Debian inertia is the main problem.

I am continuing to develop Debian packages in my spare time, I just have much 
less spare time.  This means I can't spend so much time recompiling packages 
because of Debian developers being unwilling to accept patches.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
