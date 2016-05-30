From: Andreas Gruenbacher <agruenba@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: [RFC 0/2] selinux: Stop looking up dentries from inodes
Date: Mon, 30 May 2016 15:59:00 +0200
Message-Id: <1464616742-29271-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Here is an attempt at getting rid of d_find_alias in SELinux.  The first patch
makes SELinux call getxattr with a NULL dentry when the dentry is unknown
instead of using a random alias dentry, and makes getxattr fail with -ECHILD on
filesystems that cannot do getxattr with only an inode.  The second patch
changes getxattr on overlayfs so that it works with just an inode.  This leaves
9p and cifs as the filesystems where getxattr without a dentry doesn't make
sense.

These patches are based on mainline + Miklos's overlayfs-next branch:

  https://git.kernel.org/cgit/linux/kernel/git/mszeredi/vfs.git/log/?h=overlayfs-next

Git version:

  https://git.kernel.org/cgit/linux/kernel/git/agruen/linux.git/log/?h=work.selinux

Comments?

Thanks,
Andreas

Andreas Gruenbacher (2):
  selinux: Stop looking up dentries from inodes
  overlayfs: Make getxattr work with inode only

 fs/9p/acl.c              |  3 +++
 fs/9p/xattr.c            |  3 +++
 fs/cifs/xattr.c          |  9 +++++++--
 fs/ecryptfs/inode.c      |  8 ++++++--
 fs/overlayfs/inode.c     | 26 +++++++++++++++++---------
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/super.c     | 10 +++++++---
 net/socket.c             |  3 +++
 security/selinux/hooks.c | 43 +++++++++++++++----------------------------
 9 files changed, 62 insertions(+), 44 deletions(-)

-- 
2.5.5
