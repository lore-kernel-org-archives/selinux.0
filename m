Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2UI1fRb014053
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 13:01:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2UI1eOl007036
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 18:01:40 GMT
Received: from mail.c-sam.net ([81.27.0.26])
        by jazzband.ncsc.mil  with ESMTP id i2UI1dkH006495 for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 18:01:39 GMT
Date: Tue, 30 Mar 2004 20:00:10 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: James Morris <jmorris@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: IPv6 support available
Message-ID: <20040330180008.GD3867@lukas.schuldei.com>
References: <Xine.LNX.4.44.0403300942280.20550-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Xine.LNX.4.44.0403300942280.20550-100000@thoron.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* James Morris (jmorris@redhat.com) [040330 19:50]:
> A set of preliminary patches providing IPv6 support may be found at:
> http://people.redhat.com/jmorris/selinux/ipv6/
> 
> The kernel patch requires recent -mm kernels, and ipv6-exthdrs-core.patch 
> needs to be applied if IPv6 is compiled as a module.
> 
> The kernel patches are expected to be submitted to mainline after 2.6.5 is 
> released.
> 
> Any review or testing of the IPv6 code will be appreciated.

this is what i have waited for for some time. could you give a
short overview of what features there are, now?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
