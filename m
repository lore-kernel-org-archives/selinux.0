Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9IF3IrT021726
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 11:03:18 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9IF3FhO000161
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 15:03:18 GMT
Date: Mon, 18 Oct 2004 11:03:15 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>, lsm <linux-security-module@wirex.com>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
In-Reply-To: <1098107356.27895.51.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0410181102350.22995-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 18 Oct 2004, Stephen Smalley wrote:

> a) Add a flag to avc_audit(), optionally passed via avc_audit_data, that
> tells it to use audit_log_end_irq() so that it merely enqueues the audit
> message for later processing, and change capable and setscheduler hooks
> to pass this flag, or 
> b) Move the security checks in setscheduler outside of the runqueue
> lock, then just recheck that no security-relevant conditions changed
> after taking the lock.

A seems simpler, but perhaps better to do via a wrapper function.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
