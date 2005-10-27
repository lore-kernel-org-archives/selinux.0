Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9RJSrMA014839
	for <selinux@tycho.nsa.gov>; Thu, 27 Oct 2005 15:28:53 -0400 (EDT)
Received: from mail22.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9RJOgcv029240
	for <selinux@tycho.nsa.gov>; Thu, 27 Oct 2005 19:24:42 GMT
Date: Thu, 27 Oct 2005 15:23:25 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, SELinux-dev@tresys.com,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] SELinux - canonicalize getxattr() (fwd)
In-Reply-To: <1130439786.18805.322.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.63.0510271520390.24160@excalibur.intercode>
References: <Pine.LNX.4.63.0509141014520.7898@excalibur.intercode>
 <1130439786.18805.322.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Oct 2005, Stephen Smalley wrote:

> Thoughts?

It may be helpful to have type aliases, but are they truly necessary?  

Seems like a lot of potential problems arise from them, including 
confusing SELinux developers.

Perhaps type aliasing would be better implemented as a higher level policy 
construct?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
