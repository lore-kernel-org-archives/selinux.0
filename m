Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5LKsCrT005369
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2004 16:54:12 -0400 (EDT)
Date: Mon, 21 Jun 2004 16:53:55 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: sched_setscheduler()
In-Reply-To: <1087850479.4567.175.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0406211653170.25194-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 21 Jun 2004, Stephen Smalley wrote:

> On Mon, 2004-06-21 at 00:49, James Morris wrote:
> > setschedluler denials are not audited by the kernel, as doing so causes a 
> > deadlock with printk (the kernel logging function).  I believe this can be 
> > fixed with an asynchronous feature of the new audit framework, but am not 
> > sure if it's been looked into.
> 
> I haven't looked into it.  We could add a flag to the avc_audit_data to
> indicate that avc_audit() should call audit_log_end_irq() rather than
> audit_log_end().

Or a wrapper function, avc_audit_async().


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
