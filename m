Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAODhaIi019235
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 08:43:36 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAODhdC8024477
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 13:43:39 GMT
Subject: Re: xen 2.0 - adding selinux permissions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041123220352.GF5146@lkcl.net>
References: <20041123220352.GF5146@lkcl.net>
Content-Type: text/plain
Message-Id: <1101303556.22014.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 24 Nov 2004 08:39:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-23 at 17:03, Luke Kenneth Casson Leighton wrote:
> - add in some new selinux security ids representing the xen commands
>   (create virtual machine, list virtual machines, shutdown a machine,
>    suspend-a-session-to-disk, etc.)

I assume you actually mean add a new security class (xen) and define an
access vector for it with permissions for each of these operations, not
add a security identifier.  As there is no real object for these
requests, I suppose you could just make them task->self checks as with
the existing capability checks.  No need to add a new security id for
the target.

> should i be adding a new function to the LSM function table, examining
> the xen ioctl kernel call and calling the new security function in the
> xen ioctl?

Yes, you would need to embed the hook in the xen code if you want to
have the desired granularity of control.  Long term, we'd like to have
similar hooks in other drivers and filesystem implementations, but that
wasn't viewed as practical for the initial phase of LSM, where we were
mostly limited to hooks in the core kernel.

> if i add a new function to the LSM function table, then presumably that
> means that someone could write a linux "capabilities" function too, yes?

Yes, but there is no room for expansion of capability definitions
presently, so they would have to just map all xen commands to existing
capabilities.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
