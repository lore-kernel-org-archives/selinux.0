Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MJbadW025322
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 14:37:36 -0500 (EST)
Subject: Re: [RFC][PATCH] Pass requested protection to
	security_file_mmap/mprotect hooks
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Daniel J Walsh <dwalsh@redhat.com>,
   lsm <linux-security-module@wirex.com>, Chris Wright <chrisw@osdl.org>,
   selinux@tycho.nsa.gov
In-Reply-To: <1109099410.3858.23.camel@nexus.verbum.private>
References: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil>
	 <1109097647.3858.14.camel@nexus.verbum.private>
	 <1109097979.15893.52.camel@moss-spartans.epoch.ncsc.mil>
	 <1109099410.3858.23.camel@nexus.verbum.private>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 14:12:01 -0500
Message-Id: <1109099521.15893.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-22 at 14:10 -0500, Colin Walters wrote:
> But we have already worked around the gpg (and other) issues by enabling
> the unconfined_t execmod/execmem booleans by default, no?

I was speaking in the context of strict policy (or more generally, any
confined process).  Strict policy is where we are seeing the greatest
impact of the read-implies-exec logic, as you would expect.

> From your patch, it looks like the default is to have it disabled.  I do
> feel that for Fedora we will want it enabled by default, so providing a
> kernel build option for it is useful; the fewer magic things are in the
> init scripts, the better.

Right, that is what I expected.  Security-focused distros may still
choose to disable by default, as it does reflect the actual protection
that is being applied, but I expect the major distros to enable
checkreqprot by default.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
