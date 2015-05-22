From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 gregkh@linuxfoundation.org
Subject: [RFC] [PATCH] kernfs: hook inode initialization for LSMs
Date: Fri, 22 May 2015 11:25:35 -0700
Message-Id: <1432319136-160378-1-git-send-email-william.c.roberts@intel.com>
Cc: sds@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

On the Android side of the house, were required to label each and
every sysfs file with a specific label. sysfs often has transient
files, and this uncovered a limitation in SELinux. In most filesystems
the new inode inherits from the parents label, but in sysfs, this
was not the case. The new inode would inherit the syfs wide "default"
label. Because of this, many hacks in userspace were performed, but
alas there were many races and so it didn't work well. The reason
sysfs differed from other filesystems was because the inode creation
for kernfs was missing the security callback.

This patch adds that security callback, however, is not yet ready to
apply. Since sysfs differs from other filesystems in that their is no
inode create implementation, since create is not supported, the inode's
are generated in the lookup operation. We added the hook there, however
the error code path for unwind is unclear.

I would like to get some comments on the design (is lookup ok) as well
as the unwind paths on lsm initialization error, see the XXX in
fs/kernfs/inode.c.

William Roberts (1):
  [RFC] kernfs: hook inode initialization for LSMs

 fs/kernfs/dir.c             |  2 +-
 fs/kernfs/inode.c           | 34 ++++++++++++++++++++++++++++++----
 fs/kernfs/kernfs-internal.h | 26 +++++++++++++++++++++++++-
 fs/kernfs/mount.c           |  2 +-
 4 files changed, 57 insertions(+), 7 deletions(-)

-- 
1.9.1
