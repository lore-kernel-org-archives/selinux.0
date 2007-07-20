Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6KNXdIf002136
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 19:33:39 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6KNXZEE007577
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 23:33:36 GMT
Date: Fri, 20 Jul 2007 19:33:33 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Anthony Liguori <anthony@codemonkey.ws>
cc: "Daniel P. Berrange" <berrange@redhat.com>,
        kvm-devel <kvm-devel@lists.sourceforge.net>,
        David Windsor <dwindsor@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
In-Reply-To: <46A13CDB.7020900@codemonkey.ws>
Message-ID: <Line.LNX.4.64.0707201922220.12412@d.namei>
References: <C2C68600.366D%dwindsor@tresys.com> <20070720201101.GC12218@redhat.com>
 <Line.LNX.4.64.0707201628150.9702@d.namei> <46A11F1A.2080004@codemonkey.ws>
 <Line.LNX.4.64.0707201834490.10703@d.namei> <46A13CDB.7020900@codemonkey.ws>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Jul 2007, Anthony Liguori wrote:

> > I guess you'd have OS policy preventing normal domains from accessing
> > /dev/kvm (or /dev/lguest etc.), while a security-aware launcher would
> > enforce access control policy over which domains could launch which disk
> > images as VMs, and also setup the execution context & fork.
> >   
> 
> I really think you have to start with the assumption that a guest can access
> anything that QEMU can access and attempt to build security around that.  If
> you want to restrict what the guest can see, restrict what QEMU can see.

Right, we are talking about specific invocations of qemu running in 
different security domains.  SELinux policy at the OS level would control 
what each domain (i.e. instance of qemu) can do.

> At some point, we may do crazy stuff like syscall pass-through in which case,
> it would be all but impossible to have a "security-aware" launcher.

We need some mechanism to invoke VM instances so that they execute in a 
specific security domain, and to ensure that the domain performing the 
invocation is authorized to do so, on the specific disk image, and to be 
transitioned to a specific domain of execution according to policy.

This is just the invocation phase.

There may need to be further controls on e.g. inter-VM communication or 
other things which may operate outside the standard host OS mechanisms.

I'm not sure exactly what syscall passthrough entails, or what the 
security implications are.  How would it make it impossible to have a 
security-aware launcher (i.e. the application which invokes the VM 
instance per above) ?



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
