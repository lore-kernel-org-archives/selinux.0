Subject: Re: [PATCH] SELinux: allow fstype unknown to policy to use xattrs
	if present
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1213293433.11146.14.camel@gorn>
References: <1213291584.3029.1.camel@localhost.localdomain>
	 <1213293433.11146.14.camel@gorn>
Content-Type: text/plain; charset=utf-8
Date: Thu, 12 Jun 2008 14:06:16 -0400
Message-Id: <1213293976.17842.249.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-06-12 at 13:57 -0400, Christopher J. PeBenito wrote:
> On Thu, 2008-06-12 at 13:26 -0400, Eric Paris wrote:
> > Currently if a fs is mounted for which selinux policy does not define an
> > fs_use_* or a genfscon statement that FS will not support labeling of
> > any kind.  This patch allows the kernel to check if the filesystem
> > supports security xattrs and if so will use those if there is no
> > fs_use_* rule in policy.  An fstype with a genfs rule will use xattrs if
> > available and will follow the genfs rule if they are not.
> 
> Let met verify what I think I read in the patch.  The filesystem
> labeling behavior (filesystem class) is unchanged, right? i.e.
> 
> 1. no fs_use + genfs + security xattr on fs = genfs type for fs
> 2. no fs_use + no genfs + ﻿security xattr on fs = unlabeled isid for fs

No.  If there is a fs_use statement for the fs type, then that gets used
regardless.  If there is no fs_use type and the fs supports selinux
xattrs, then use them.  If there is no fs_use type and the fs does not
support selinux xattrs, use genfs or fall back to none/unlabeled if
none.

Thus, with ecryptfs, we can put a genfs statement in the policy as the
fallback behavior, yet use xattrs when the lower filesystem supports
them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
