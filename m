Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9IJEXrT024165
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 15:14:33 -0400 (EDT)
Date: Mon, 18 Oct 2004 12:14:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: Crispin Cowan <crispin@immunix.com>
Cc: James Morris <jmorris@redhat.com>, john johansen <johansen@immunix.com>,
   SELinux ML <selinux@tycho.nsa.gov>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   lsm <linux-security-module@wirex.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: cdrecord deadlocks linux 2.6.8.1 (problem in setscheduler)
Message-ID: <20041018121432.O2357@build.pdx.osdl.net>
References: <Xine.LNX.4.44.0410181102350.22995-100000@thoron.boston.redhat.com> <4173F737.1070204@immunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4173F737.1070204@immunix.com>; from crispin@immunix.com on Mon, Oct 18, 2004 at 10:02:47AM -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Crispin Cowan (crispin@immunix.com) wrote:
> We (Immunix) discovered this bug a few weeks ago. At first we thought it 
> was a bug in our SubDomain module, but then determined that any attempt 
> to printk from within the scheduler hook was at risk of locking the kernel.
> 
> John Johansen (cc'd) has prepared a patch that fixes the problem, and we 
> just yesterday sent it to Andrea Arcangeli (scheduler maintainer) for 
> comment.

Andrea isn't the scheduler maintainer.

> JJ, you wanna share your patch with the LSM list?

That would be nice.  Why wasn't that done in the first place?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
