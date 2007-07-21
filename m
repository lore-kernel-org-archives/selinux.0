Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6L1fZAr008711
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 21:41:35 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6L1fYH3025864
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2007 01:41:34 GMT
Date: Fri, 20 Jul 2007 21:41:31 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
cc: David Windsor <dwindsor@gmail.com>,
        kvm-devel <kvm-devel@lists.sourceforge.net>,
        David Windsor <dwindsor@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>,
        qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
In-Reply-To: <20070720235007.GA1595@redhat.com>
Message-ID: <Line.LNX.4.64.0707202138210.12822@d.namei>
References: <C2C68600.366D%dwindsor@tresys.com> <20070720201101.GC12218@redhat.com>
 <Line.LNX.4.64.0707201628150.9702@d.namei> <25a1d91b0707201457m6865a505maf93d22c5c28f0cc@mail.gmail.com>
 <20070720235007.GA1595@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 21 Jul 2007, Daniel P. Berrange wrote:

> obviously the UNIX user has a corresponding SELinux domain. In the remote 
> case, one could map x509 certificate IDs (the remote user's identify) to 
> appropriate local SELinux domains.

There is already a mechanism for conveying SELinux labels over the network 
via IPsec.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
