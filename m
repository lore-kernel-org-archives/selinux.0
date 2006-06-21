Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LL1LEZ000669
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 17:01:21 -0400
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5LL1IYv004674
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 21:01:19 GMT
Date: Wed, 21 Jun 2006 17:01:16 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
cc: sds@tycho.nsa.gov, eparis@parisplace.org,
        David Howells <dhowells@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: inherit /proc/self/attr/keycreate across fork
In-Reply-To: <1150922057.3432.6.camel@moss-tarheels.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0606211700420.12597@d.namei>
References: <1150922057.3432.6.camel@moss-tarheels.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 Jun 2006, Michael LeMay wrote:

> This patch should apply cleanly after Eric's patch.

> 
> ---<snip>---
> From: Michael LeMay <mdlemay@epoch.ncsc.mil>
> 
> Inherit /proc/self/attr/keycreate across fork.
> Reset /proc/self/attr/keycreate upon execve.

Probably needs a more detailed explanation for upstream submission.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
