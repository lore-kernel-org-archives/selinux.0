Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1MNI0QF019815
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 18:18:00 -0500
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1MNJHt2012999
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 23:19:18 GMT
Date: Thu, 22 Feb 2007 18:18:50 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] Reassign printk levels in selinux kernel code
In-Reply-To: <1172185891.3142.48.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0702221818270.21988@d.namei>
References: <1172185891.3142.48.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Feb 2007, Eric Paris wrote:

> Below is a patch which demotes many printk lines to KERN_DEBUG from
> KERN_INFO.  It should help stop the spamming of logs with messages in
> which users are not interested nor is there any action that users should
> take.  It also promotes some KERN_INFO to KERN_ERR such as when there
> are improper attempts to register/unregister security modules.

Looks ok to me.  I'll apply it if Stephen agrees.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
