Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i94I8RrT020294
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 14:08:27 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i94I7KYE001851
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 18:07:20 GMT
Subject: RE: SELinux  Doesn't Complete Initialization
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alex Ackerman <alex@darkhonor.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B130E4@maat.darkhonor.net>
References: <A52BEA1D8EE8634B9196A136333637B130E4@maat.darkhonor.net>
Content-Type: text/plain
Message-Id: <1096913145.32008.133.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 04 Oct 2004 14:05:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-04 at 13:40, Alex Ackerman wrote:
> Thank you for the advice. However, due to the system requirements of my
> course, I need to have it working on a FC2 system. What packages would
> be required then? Here is the list of packages from the development tree
> that I figured would be required:
> 
> SysVinit-2.85-33
> checkpolicy-1.17.5-1
> coreutils-5.2.1-26
> initscripts-7.86-1
> kernel-<latest>
> libselinux-1.17.13-3
> libsepol-1.1.1-2
> mkinitrd-4.1.14-1
> openssh-3.9p1-7
> openssh-clients-3.9p1-7
> openssh-server-3.9p1-7
> pam-0.77-60
> passwd-0.68-10
> procps-3.2.3-5
> psacct-6.3.2-31
> selinux-policy-strict-1.17.26-1
> selinux-policy-strict-source-1.17.26-1
> setools-1.4-2
> shadow-utils-4.0.3-30
> star-1.5a25-6
> system-config-securitylevel-1.4.7-1
> util-linux-2.12a-10
> vixie-cron-4.1-17
> 
> Any corrections/deletions from this list would be appreciated.  Thanks!

If you are updating all of those packages from the development tree, is
it still truly a FC2 system?

I'd start out smaller, beginning with just the new SELinux packages
(libsepol*, libselinux*, checkpolicy, policycoreutils,
selinux-policy-strict*, setools*) and only those patched packages that
absolutely must be updated to still work (SysVinit, rpm, sudo,
usermode).  rpm is an important one; otherwise, subsequent updates won't
preserve file contexts properly.  I don't think you need the development
kernel, initscripts, mkinitrd; can't you just continue using the FC2
updated kernel?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
