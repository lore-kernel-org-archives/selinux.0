Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA23984
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 10:08:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA11216
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 15:07:53 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id PAA11212
	for <selinux@tycho.nsa.gov>; Tue, 27 Nov 2001 15:07:53 GMT
Date: Tue, 27 Nov 2001 10:07:29 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: RedHat 7.2
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524249@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0111270930420.18809-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 27 Nov 2001, Westerman, Mark wrote:

> I have built the 2.4.16 kernel with the NSA and lsm modules.
> In the utils selection I get the following error
>
> m4/isc-posix.m4: 11: duplicated macro 'AC_ISC_POSIX'
>
> Any Suggestions ?????
>
> I am using this kernel because it has the ext3 file system in the
> kernel. I am try to build a Redhat 7.2 system. After I can
> get it to boot I will work on the policy configuration.

Did you merely merge the old lsm-2001_11_05 patch into 2.4.16, or did you
update to the new lsm-2001_11_26 patch against 2.4.16 from
lsm.immunix.org?  If the latter, you also need some updates to the SELinux
security module to reflect changes made to LSM.  Internally, we've now
updated to this new LSM patch, along with corresponding changes to the
SELinux module.  This kernel seems to work fine with RH7.2, although it
seems that you must enable the netlink socket options for RH7.2.  And, of
course, you need to configure grub for the new kernel.

We're currently working on updating the modified utilities and the policy
configuration for RH7.2, but it is likely to take a little time.  There
was a workaround posted earlier on the list by a SELinux user for the
fileutils build problem, but the preferred solution is to port the
fileutils patch to the fileutils-4.1 SRPM shipped with RH7.2.
Unfortunately, there have been some changes in fileutils-4.1 that conflict
with our changes.  So far, we've just ported the two most commonly used
fileutils, the modified ls program and the new chcon program.

As far as the other utilities go, you need to edit the utils/Makefile to
use the new version of logrotate (3.5.9) rather than the old one if you
are using RH7.2.  We've also updated the procps and sh-utils patches to
the SRPMS shipped with RH7.2, but you can probably continue using the old
versions until we release the updated ones.  The util-linux, openssh, and
vixie-cron packages were already updated in the last release.  The
modified tar, findutils, psmisc, and stat seem ok on RH7.2, but should be
updated sometime to newer base versions.

We've started adding new domains, types and allowed permissions to the
example policy for RH7.2, but this is still very preliminary.

If you want to help with porting the remaining fileutils changes or the
remaining modified packages to newer base versions, let me know.  Likewise
with the policy.  We should coordinate to avoid duplication of effort.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com













--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
