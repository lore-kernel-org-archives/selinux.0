Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96Hih8j002024
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 13:44:43 -0400
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96HhUQW028191
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 17:43:30 GMT
Message-ID: <4526960A.9040005@hp.com>
Date: Fri, 06 Oct 2006 13:44:42 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@redhat.com>, vyekkirala@TrustedCS.com,
        selinux@tycho.nsa.gov, redhat-lspp@redhat.com, chanson@TrustedCS.com
Subject: Re: Labeled Networking For LSPP: Where we are and where we need to
 go (quickly)
References: <1160150738.10614.116.camel@localhost.localdomain> <4526835A.2080707@hp.com> <Pine.LNX.4.64.0610061335270.6460@d.namei>
In-Reply-To: <Pine.LNX.4.64.0610061335270.6460@d.namei>
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Fri, 6 Oct 2006, Paul Moore wrote:
> 
>>>-netlabel unlabeled patch
>>
>>While not a bugfix like the previous two, this is a "logic bug" fix which should
>>go into RHEL5.
>  
> Where is the patch for this?
> 

I believe this is the patch I RFC'd to the SELinux list yesterday morning and
posted to netdev for inclusion yesterday evening.  Looking at my mail this
morning as well as your git tree show that it was accepted/applied.

Eric, please correct me if I'm wrong.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
