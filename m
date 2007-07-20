Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6KKUQGI023658
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 16:30:26 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6KKUPKP017589
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 20:30:25 GMT
Date: Fri, 20 Jul 2007 16:30:22 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
cc: David Windsor <dwindsor@tresys.com>,
        kvm-devel <kvm-devel@lists.sourceforge.net>,
        Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
In-Reply-To: <20070720201101.GC12218@redhat.com>
Message-ID: <Line.LNX.4.64.0707201628150.9702@d.namei>
References: <C2C68600.366D%dwindsor@tresys.com> <20070720201101.GC12218@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Jul 2007, Daniel P. Berrange wrote:

> It could be - if your put the policy at the control API layer instead of
> in QEMU itself.

Then you can bypass MAC security by invoking qemu directly.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
