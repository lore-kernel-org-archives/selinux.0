Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1MItrdW024948
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 13:55:53 -0500 (EST)
Subject: Re: [RFC][PATCH] Pass requested protection to
	security_file_mmap/mprotect hooks
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Daniel J Walsh <dwalsh@redhat.com>,
   lsm <linux-security-module@wirex.com>, Chris Wright <chrisw@osdl.org>,
   selinux@tycho.nsa.gov
In-Reply-To: <1109097647.3858.14.camel@nexus.verbum.private>
References: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil>
	 <1109097647.3858.14.camel@nexus.verbum.private>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 13:46:19 -0500
Message-Id: <1109097979.15893.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-22 at 13:40 -0500, Colin Walters wrote:
> One thing I wonder is if there's any other issues tied to legacy
> binaries that would possibly make sense to control via this interface.
> checkreqprot is a fairly specific name; You had suggested legacycompat
> earlier?

As is, the patch won't affect any execute-related checking that is
requested by the application, and that includes anything requested by
ld.so.  Hence, for example, running gpg on a FC3 system still triggers
an execmod check against the gpg binary but no longer triggers various
other execute-related checks that were being caused by the read-implies-
exec logic in the kernel.  That seems appropriate to me, and much more
manageable in the policy.  We can't distinguish what ld.so does from
what the "application" does in the kernel, and I don't think we want to
try heuristics there.  The only clean distinction is between what was
requested by the caller vs. what the kernel is applying.

> >Should the default value for /selinux/checkreqprot be configurable?
> 
> I think having e.g. a sysctl would be nice.  For Fedora we will probably
> want it enabled by default to maximize compatibility.  But with the new
> execmod/execmem bits, it would be nice to add an entry to the SELinux
> FAQ or a Fedora security guide about these so users who don't have
> issues with legacy binaries can toggle these bits and get the stronger
> protection.

As is, the patch allows you to set /selinux/checkreqprot (if you have
appropriate permission), so /sbin/init or an init script could easily
initialize it to some default.  But I was wondering whether the original
compiled-in value should be a kernel config option, similar to the
bootparam default, so that a vendor can set the initial value as desired
depending on their preference, without requiring any customization by
init or an init script at all.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
