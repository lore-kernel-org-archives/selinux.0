Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2I032P2018498
	for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2006 19:03:02 -0500
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2I02whG008264
	for <selinux@tycho.nsa.gov>; Sat, 18 Mar 2006 00:02:59 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 18 Mar 2006 01:02:59 +0100
Date: Sat, 18 Mar 2006 01:02:55 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: semodule dumps core
Message-Id: <20060318000255.GB8168@thorium.jmh.mhn.de>
References: <20060316224834.GA8552@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060316224834.GA8552@thorium.jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Thomas Bleher <bleher@informatik.uni-muenchen.de> [2006-03-16 23:56]:
> Seems like semodule doesn't like me. I just recompiled my policy with
> the new versions of the tools and now semodule dumps core when I do a 
> "semodule -b base.pp".

Stephen gave me many good suggestions, among them to compile without
-O2. I tried this and the problem went away! Tracking this down further
I narrowed it down to libsepol being miscompiled with -O2, it works fine
with -O0 or -O1. So this looks like a compiler bug in gcc (as shipped in
current Ubuntu Dapper). Unfortunately I won't have time to track down
this problem but if anyone wants to look into this I can provide the
sources I used.

Thanks,
Thomas


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
