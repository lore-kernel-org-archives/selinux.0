Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9IJAirT024082
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 15:10:45 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9IJAhhM013711
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 19:10:44 GMT
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Crispin Cowan <crispin@immunix.com>
Cc: James Morris <jmorris@redhat.com>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, SELinux ML <selinux@tycho.nsa.gov>,
   john johansen <johansen@immunix.com>
In-Reply-To: <4173F737.1070204@immunix.com>
References: 
	 <Xine.LNX.4.44.0410181102350.22995-100000@thoron.boston.redhat.com>
	 <4173F737.1070204@immunix.com>
Content-Type: text/plain
Message-Id: <1098126442.27895.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 18 Oct 2004 15:07:22 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-18 at 13:02, Crispin Cowan wrote:
> We (Immunix) discovered this bug a few weeks ago. At first we thought it 
> was a bug in our SubDomain module, but then determined that any attempt 
> to printk from within the scheduler hook was at risk of locking the kernel.
> 
> John Johansen (cc'd) has prepared a patch that fixes the problem, and we 
> just yesterday sent it to Andrea Arcangeli (scheduler maintainer) for 
> comment.
> 
> JJ, you wanna share your patch with the LSM list?

Does the patch address both the security_task_setscheduler() hook call
and the capable(CAP_SYS_NICE) calls by the setscheduler function? 
SELinux was already suppressing audit from its setscheduler hook to
avoid this deadlock, but was not doing so for the CAP_SYS_NICE check.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
