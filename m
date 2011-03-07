Subject: [GIT PULL] selinux for 2.6.39
From: Eric Paris <eparis@redhat.com>
To: jmorris@namei.org
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Date: Mon, 07 Mar 2011 12:08:32 -0500
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1299517713.7141.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please pull the following for 2.6.39.

The following changes since commit 821404434f3324bf23f545050ff64055a149766e:

  CacheFiles: Add calls to path-based security hooks (2011-01-24 10:49:45 +1100)

are available in the git repository at:
  git://git.infradead.org/users/eparis/selinux.git master

Eric Paris (6):
      fs/vfs/security: pass last path component to LSM on inode creation
      SELinux: Use dentry name in new object labeling
      selinux: drop unused packet flow permissions
      Revert "selinux: simplify ioctl checking"
      LSM: Pass -o remount options to the LSM
      SELinux: implement the new sb_remount LSM hook

Harry Ciao (3):
      SELinux: Auto-generate security_is_socket_class
      SELinux: Socket retains creator role and MLS attribute
      SELinux: Compute SID for the newly created socket

Lucian Adrian Grijincu (2):
      security/selinux: fix /proc/sys/ labeling
      security: remove unused security_sysctl hook

Steffen Klassert (3):
      selinux: Fix check for xfrm selinux context algorithm
      selinux: Fix wrong checks for selinux_policycap_netpeer
      selinux: Fix packet forwarding checks on postrouting

 fs/btrfs/inode.c                        |   13 +-
 fs/btrfs/xattr.c                        |    6 +-
 fs/btrfs/xattr.h                        |    3 +-
 fs/ext2/ext2.h                          |    2 +-
 fs/ext2/ialloc.c                        |    5 +-
 fs/ext2/namei.c                         |    8 +-
 fs/ext2/xattr.h                         |    6 +-
 fs/ext2/xattr_security.c                |    5 +-
 fs/ext3/ialloc.c                        |    5 +-
 fs/ext3/namei.c                         |    8 +-
 fs/ext3/xattr.h                         |    4 +-
 fs/ext3/xattr_security.c                |    5 +-
 fs/ext4/ialloc.c                        |    2 +-
 fs/ext4/xattr.h                         |    4 +-
 fs/ext4/xattr_security.c                |    5 +-
 fs/gfs2/inode.c                         |    7 +-
 fs/jffs2/dir.c                          |    9 +-
 fs/jffs2/nodelist.h                     |    2 +-
 fs/jffs2/security.c                     |    5 +-
 fs/jffs2/write.c                        |   18 +-
 fs/jffs2/xattr.h                        |    5 +-
 fs/jfs/jfs_xattr.h                      |    5 +-
 fs/jfs/namei.c                          |    8 +-
 fs/jfs/xattr.c                          |    6 +-
 fs/namespace.c                          |    4 +
 fs/ocfs2/namei.c                        |    4 +-
 fs/ocfs2/refcounttree.c                 |    3 +-
 fs/ocfs2/xattr.c                        |   10 +-
 fs/ocfs2/xattr.h                        |    4 +-
 fs/proc/proc_sysctl.c                   |    1 -
 fs/reiserfs/namei.c                     |    9 +-
 fs/reiserfs/xattr_security.c            |    3 +-
 fs/xfs/linux-2.6/xfs_iops.c             |    9 +-
 include/linux/ext3_fs.h                 |    3 +-
 include/linux/reiserfs_xattr.h          |    2 +
 include/linux/security.h                |   35 ++--
 kernel/sysctl.c                         |    5 -
 mm/shmem.c                              |    9 +-
 scripts/selinux/genheaders/genheaders.c |   20 ++
 security/capability.c                   |   15 +-
 security/security.c                     |   16 +-
 security/selinux/hooks.c                |  350 +++++++++++++++++--------------
 security/selinux/include/classmap.h     |    7 +-
 security/selinux/include/security.h     |    8 +-
 security/selinux/ss/avtab.h             |   22 +-
 security/selinux/ss/mls.c               |    5 +-
 security/selinux/ss/mls.h               |    3 +-
 security/selinux/ss/policydb.c          |  130 ++++++++++++
 security/selinux/ss/policydb.h          |   14 ++-
 security/selinux/ss/services.c          |   73 +++++--
 security/selinux/xfrm.c                 |    2 +-
 security/smack/smack_lsm.c              |    5 +-
 52 files changed, 594 insertions(+), 323 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
