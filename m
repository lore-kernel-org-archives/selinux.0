Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OG3urT028112
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 12:03:56 -0400 (EDT)
Received: from mail.c-sam.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OG36MZ016386
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 16:03:10 GMT
Received: from petrus.schuldei.org (petrus.schuldei.org [81.27.1.16])
	by mail.c-sam.net (8.11.6/8.11.6) with ESMTP id i7OCQoW23856
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 14:26:50 +0200
Date: Tue, 24 Aug 2004 14:26:46 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux and kde
Message-ID: <20040824122646.GA1655@lukas.schuldei.com>
References: <20040823234320.GC12720@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040823234320.GC12720@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Luke Kenneth Casson Leighton (lkcl@lkcl.net) [040824 03:46]:
> ... does anyone ever actually _use_ strict selinux policy enforcing
> and successfully run kde under it??
> 
> i mean, i know i've been doing a lot of messing about trying
> to get things to work, including perhaps unnecessarily adding
> a policy for k3b (and cdrecord) and one for usbmount, and
> fireflier too, but a 1,800 line patch to the default 1.14
> policy is a heck of a lot of messing.

i agree. i set up a debian unstable server some weeks ago and
installed (quite painfully) selinux, running into most of the
problems you encountered before. when it was up it crashed
regularly at least every other day, since i compiled a kernel
without apm (following a hunch), which improved the situation
drastically and the server reaches uptimes of up to seven days
now.

the amount of avc messages i got when running normal operation
without any special stuff (postfix mostly, where spam filtering
with spamd is the most advanced operation i do) discouraged me
slightly to pursue this path right now.

i conclude that debian is not a viable platform for selinux for
non-selinux development right now. this is a real tragedy since
both russel and colins were working on it some time ago as their
prime platform, pushing it hard on debian, but i guess the
enormous debian initeria and the reluctance to include their lib
into base along with their jobs at redhat killed it for now.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
