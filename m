Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6KMglt6032342
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 18:42:47 -0400
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6KMgkEE000845
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 22:42:46 GMT
Date: Fri, 20 Jul 2007 18:42:43 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Anthony Liguori <anthony@codemonkey.ws>
cc: "Daniel P. Berrange" <berrange@redhat.com>,
        kvm-devel <kvm-devel@lists.sourceforge.net>,
        David Windsor <dwindsor@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
In-Reply-To: <46A11F1A.2080004@codemonkey.ws>
Message-ID: <Line.LNX.4.64.0707201834490.10703@d.namei>
References: <C2C68600.366D%dwindsor@tresys.com> <20070720201101.GC12218@redhat.com>
 <Line.LNX.4.64.0707201628150.9702@d.namei> <46A11F1A.2080004@codemonkey.ws>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Jul 2007, Anthony Liguori wrote:

> James Morris wrote:
> > On Fri, 20 Jul 2007, Daniel P. Berrange wrote:
> > 
> >   
> > > It could be - if your put the policy at the control API layer instead of
> > > in QEMU itself.
> > >     
> > 
> > Then you can bypass MAC security by invoking qemu directly.
> >   
> 
> You can bypass MAC security by writing your own binary that uses the KVM
> kernel interfaces.

Yep, I was thinking only about qemu.

I guess you'd have OS policy preventing normal domains from accessing 
/dev/kvm (or /dev/lguest etc.), while a security-aware launcher would 
enforce access control policy over which domains could launch which disk 
images as VMs, and also setup the execution context & fork.

So, perhaps this would be better done at the libvirt layer (i.e. make 
libvirt the object manager).



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
