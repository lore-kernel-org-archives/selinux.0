Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1ML3qdW025940
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 16:03:53 -0500 (EST)
Received: from smtp.osdl.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MKx0MM011904
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 20:59:10 GMT
Date: Tue, 22 Feb 2005 13:01:13 -0800
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Colin Walters <walters@verbum.org>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Daniel J Walsh <dwalsh@redhat.com>, lsm <linux-security-module@wirex.com>,
   Chris Wright <chrisw@osdl.org>, selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] Pass requested protection to security_file_mmap/mprotect hooks
Message-ID: <20050222210113.GH15867@shell0.pdx.osdl.net>
References: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil> <1109097647.3858.14.camel@nexus.verbum.private> <1109097979.15893.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1109097979.15893.52.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Tue, 2005-02-22 at 13:40 -0500, Colin Walters wrote:
> > One thing I wonder is if there's any other issues tied to legacy
> > binaries that would possibly make sense to control via this interface.
> > checkreqprot is a fairly specific name; You had suggested legacycompat
> > earlier?
> 
> As is, the patch won't affect any execute-related checking that is
> requested by the application, and that includes anything requested by
> ld.so.  Hence, for example, running gpg on a FC3 system still triggers
> an execmod check against the gpg binary but no longer triggers various
> other execute-related checks that were being caused by the read-implies-
> exec logic in the kernel.  That seems appropriate to me, and much more
> manageable in the policy.  We can't distinguish what ld.so does from
> what the "application" does in the kernel, and I don't think we want to
> try heuristics there.  The only clean distinction is between what was
> requested by the caller vs. what the kernel is applying.

By heuristics did you mean taking current->personality into account and
trying to guess what the caller asked for?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
