Subject: [RFC PATCH] 0/2 decouple fscontext/context add new rootcontext
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 28 Jun 2006 18:10:51 -0400
Message-Id: <1151532651.26384.43.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set allows the user mounting new filesystems greater control
over the superblock context, the root inode context.  

**CURRENTLY**
(I exclude defcontext= as it's use is not directly related)

Currently there exist 2 knobs to turn context= and fscontext=.  Context=
will set the context of the superblock and will change the filesystem to
use SECURITY_FS_USE_MOUNTPOINT so all file on that filesystem will
inherit their label from the superblock label.

The fscontext= option will set only the superblock context.  This can be
useful on filesystems even with XATTRs as this is what the fs associate
permission is checking again.

these knobs cannot be used together as they both operate by setting the
context of the superblock

**WITH PATCH SET**

First fscontext and context are decoupled.  It is possible to use them
both.  If context= is specified without fscontext it will operate just
as before, if both are specified we will use mount point labeling and
all inodes will get the label specified by context=.   The superblock
will be labeled with the label of fscontext=, thus affecting associate
permissions.

The second patch will introduce a new rootcontext= option to mounting.
This option will allow you to explicitly label the root inode of a FS
being mounted.  This was found to be useful for things like stateless
linux, see https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=190001
I'd like some close eyes on this patch, specifically because I had to
move the avc_has_perm() checks farther up the stack.  I'm also not sure
even if we want perms on this operation.  Right now you need the same
perms to use rootcontext= that you need to use chcon /mnt/point after
you mount.  I'm also not sure if this might be a good mechanism to
usefully mount a fs (with XATTR support) from a different machine that
had contexts that may not even exist on the mounting machine.

Thoughts, questions, comments, nits about style, and all other input
greatly encouraged.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
