From: william.c.roberts@intel.com
To: sgrubb@redhat.com, linux-audit@redhat.com
Cc: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] field-dictionary: add ioctlcmd
Date: Fri, 15 Jul 2016 12:55:13 -0700
Message-Id: <1468612513-28042-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

From: William Roberts <william.c.roberts@intel.com>

Per-request ioctlcmd controls were added to SE Linux, however
the audit field dictionary was not updated.

This patch updates that dictionary.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 specs/fields/field-dictionary.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/specs/fields/field-dictionary.csv b/specs/fields/field-dictionary.csv
index a645085..5a922e5 100644
--- a/specs/fields/field-dictionary.csv
+++ b/specs/fields/field-dictionary.csv
@@ -82,6 +82,7 @@ inode,numeric,inode number,
 inode_gid,numeric,group id of the inode's owner,
 inode_uid,numeric,user id of the inode's owner,
 invalid_context,encoded,SELinux context,
+ioctlcmd,numeric,The request argument to the ioctl syscall,
 ipx-net,numeric,IPX network number,
 item,numeric,which item is being recorded,
 items,numeric,the number of path records in the event,
-- 
1.9.1
