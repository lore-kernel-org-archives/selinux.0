Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7HHBArk031065
	for <selinux@tycho.nsa.gov>; Fri, 17 Aug 2007 13:11:10 -0400
Received: from moss-terrapins.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7HHB9Em022194
	for <selinux@tycho.nsa.gov>; Fri, 17 Aug 2007 17:11:09 GMT
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: jmorris@namei.org
Cc: selinux@tycho.nsa.gov
Subject: [RFC]Cleanup inode_getsecurity and callers for use with labeled NFS
Date: Fri, 17 Aug 2007 13:01:12 -0400
Message-Id: <1187370074408-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These patches modify inode_getsecurity and its callers to use the format
similar to the one used by getprocattr which was proposed by Al Viro. They
also rework vfs_getxattr to avoid unnecessary calls to the LSM. These patches
are to support the ongoing work on Labeled NFS.

The first patch converts inode_getsecurity to return the security blob via a
parameter and the length of the blob via the function's return value. This
removes the need for the called to guess the length of the security blob. The
patch also removed the unused err parameter. All of the callers are updated to
use a helper function named xattr_getsecurity which keeps the xattr style
interface and performs generic checks which were originally in the security
modules.

The second patch reworks vfs_getxattr to unconditionally call to the LSM in
the case that we are requesting a security namespace attribute. Originally we
would grab the value from disk then clobber it with the one from the LSM. This
way we can grab it directly from the LSM and in the case when there is no
module loaded or it does not support inode_getsecurity we fall back on the
inode getxattr operation.

David Quigley



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
