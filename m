Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6KKZjT9024124
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 16:35:45 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6KKZi2i008424
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 20:35:44 GMT
Date: Fri, 20 Jul 2007 16:35:41 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: David Windsor <dwindsor@tresys.com>
cc: selinux <selinux@tycho.nsa.gov>,
        kvm-devel <kvm-devel@lists.sourceforge.net>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
In-Reply-To: <C2C68600.366D%dwindsor@tresys.com>
Message-ID: <Line.LNX.4.64.0707201631220.9702@d.namei>
References: <C2C68600.366D%dwindsor@tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Jul 2007, David Windsor wrote:

> One problem with this approach is that loading a VM is not an exec-based
> operation.  Dynamic transitions could be used, but could possibly be avoided
> by altering the patch to fork, then re-exec in the target domain.
> 
> This patch applies cleanly to kvm-userspace trunk.
> 
> Thoughts?

I think we need to ensure that these object classes and permissions 
generalize to similar Linux-based virtualization schemes.  As far as I can 
tell, this particular case should.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
