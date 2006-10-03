Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93GOfmK016723
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 12:24:41 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93GNU50025246
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 16:23:31 GMT
Message-ID: <45228EAA.5050105@hp.com>
Date: Tue, 03 Oct 2006 12:24:10 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com, paul.moore@hp.com, vyekkirala@TrustedCS.com
Subject: Re: RHEL5 Kernel with labeled networking
References: <1159834998.28144.115.camel@localhost.localdomain>  <452282F2.1000107@hp.com> <1159890356.28144.136.camel@localhost.localdomain> <Pine.LNX.4.64.0610031207260.21081@d.namei>
In-Reply-To: <Pine.LNX.4.64.0610031207260.21081@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Tue, 3 Oct 2006, Eric Paris wrote:
> 
> 
>>I think there is going to need to be a policy change that I'm actually
>>talking with Dan about as I type this e-mail.  I think we  need
>>
>>allow $1 unlabeled_t:packet { flow_in flow_out };
>>
>>to be added to policy to allow things to work as they did.  I'll post
>>again as soon as we have a policy that appears to let normal networking
>>work in enforcing.
> 
> 
> We need this policy in rawhide before the kernel patches are merged 
> upstream, so we can note the required policy version associated with the 
> patches.  We've do not want to kill Andrew Morton's box again with this 
> kind of thing.

Dumb question....should compat_net be "1" by default?

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
