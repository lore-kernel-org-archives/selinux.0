Subject: Re: [PATCH] SELinux: allow fstype unknown to policy to use xattrs
	if present
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1213291584.3029.1.camel@localhost.localdomain>
References: <1213291584.3029.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Jun 2008 13:57:13 -0400
Message-Id: <1213293433.11146.14.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-06-12 at 13:26 -0400, Eric Paris wrote:
> Currently if a fs is mounted for which selinux policy does not define an
> fs_use_* or a genfscon statement that FS will not support labeling of
> any kind.  This patch allows the kernel to check if the filesystem
> supports security xattrs and if so will use those if there is no
> fs_use_* rule in policy.  An fstype with a genfs rule will use xattrs if
> available and will follow the genfs rule if they are not.

Let met verify what I think I read in the patch.  The filesystem
labeling behavior (filesystem class) is unchanged, right? i.e.

1. no fs_use + genfs + security xattr on fs = genfs type for fs
2. no fs_use + no genfs + ﻿security xattr on fs = unlabeled isid for fs

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
