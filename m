Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93G8eS4016184
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 12:08:40 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93G84O7000606
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 16:08:05 GMT
Date: Tue, 3 Oct 2006 12:08:35 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: Linda Knippers <linda.knippers@hp.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com, paul.moore@hp.com, vyekkirala@TrustedCS.com
Subject: Re: RHEL5 Kernel with labeled networking
In-Reply-To: <1159890356.28144.136.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0610031207260.21081@d.namei>
References: <1159834998.28144.115.camel@localhost.localdomain>
 <452282F2.1000107@hp.com> <1159890356.28144.136.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Oct 2006, Eric Paris wrote:

> I think there is going to need to be a policy change that I'm actually
> talking with Dan about as I type this e-mail.  I think we  need
> 
> allow $1 unlabeled_t:packet { flow_in flow_out };
> 
> to be added to policy to allow things to work as they did.  I'll post
> again as soon as we have a policy that appears to let normal networking
> work in enforcing.

We need this policy in rawhide before the kernel patches are merged 
upstream, so we can note the required policy version associated with the 
patches.  We've do not want to kill Andrew Morton's box again with this 
kind of thing.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
