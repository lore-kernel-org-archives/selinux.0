Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4ADU6Pc011896
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 09:30:06 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4ADU3sL022468
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 13:30:04 GMT
Date: Wed, 10 May 2006 09:30:00 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Patrick McHardy <kaber@trash.net>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        netfilter-devel@lists.netfilter.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][SECMARK 03/08] Add xtables SECMARK target
In-Reply-To: <44618233.5020704@trash.net>
Message-ID: <Pine.LNX.4.64.0605100925340.30577@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
 <Pine.LNX.4.64.0605071134250.8588@d.namei> <44618233.5020704@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 10 May 2006, Patrick McHardy wrote:

> The netfilter parts all look fine too me (just one question,
> see below). Shall I add the userspace parts to SVN or do you
> want to do it yourself?

Might be better if you do it, although I'm still looking into one issue at 
this stage.

> I wonder if the result of this check could be invalidated later
> by removal of the selinux context and if it would matter, since
> you reject contexts not known at initialization time.

If the context is removed later by a change to SELinux policy, the kernel 
will remap them to "unlabeled_t", which is how packets would then be 
labeled by the rule.


- James 
-- 
James Morris <jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
