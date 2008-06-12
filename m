Subject: Re: [PATCH] SELinux: allow fstype unknown to policy to use xattrs
	if present
From: Eric Paris <eparis@redhat.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1213293433.11146.14.camel@gorn>
References: <1213291584.3029.1.camel@localhost.localdomain>
	 <1213293433.11146.14.camel@gorn>
Content-Type: text/plain; charset=utf-8
Date: Thu, 12 Jun 2008 14:09:01 -0400
Message-Id: <1213294141.3029.8.camel@localhost.localdomain>
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
no.  we set fs_sid = SECINITSID_FS and we use the labels in the xattr
> 2. no fs_use + no genfs + ﻿security xattr on fs = unlabeled isid for fs
fs_sid = SECINITSID_FS and we use the labeles in the xattrs

1st priority: fs_use_{xattr,transition,etc} wins
2nd priority: fs has xattr support wins (and we use xattrs)
3rd priority: genfscon statement wins

If there is a case where this is wrong I suggest we add a
fs_use_genfscon rule...   But I don't think such a case exists today.
genfscon has always been a fallback, and now it just falls further back.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
