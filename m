Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5LKffrT005291
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 16:41:41 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5LKfceh012632
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 20:41:38 GMT
Subject: Re: sched_setscheduler()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0406210043150.22018-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0406210043150.22018-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1087850479.4567.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 21 Jun 2004 16:41:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-06-21 at 00:49, James Morris wrote:
> setschedluler denials are not audited by the kernel, as doing so causes a 
> deadlock with printk (the kernel logging function).  I believe this can be 
> fixed with an asynchronous feature of the new audit framework, but am not 
> sure if it's been looked into.

I haven't looked into it.  We could add a flag to the avc_audit_data to
indicate that avc_audit() should call audit_log_end_irq() rather than
audit_log_end().

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
