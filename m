From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 2/7] VFS: Add sid field to iattr structure for notify_change
Date: Wed,  1 Aug 2007 16:02:07 -0400
Message-Id: <11859985323116-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
References: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David P. Quigley <dpquigl@tycho.nsa.gov>

Since NFSv4 likes to directly modify fields in the incore inode we need a way
to inform notify_change that the secid for the inode has changed. This patch
adds a flag for notify_change and a field into the iattr struct to allow us to
persist incore inode changes to disk.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 include/linux/fs.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d33bead..f5d324b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -330,6 +330,7 @@ typedef void (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define ATTR_KILL_SUID	2048
 #define ATTR_KILL_SGID	4096
 #define ATTR_FILE	8192
+#define ATTR_MAC_LABEL  16384
 
 /*
  * This is the Inode Attributes structure, used for notify_change().  It
@@ -356,6 +357,7 @@ struct iattr {
 	 * check for (ia_valid & ATTR_FILE), and not for (ia_file != NULL).
 	 */
 	struct file	*ia_file;
+	u32		ia_sid;
 };
 
 /*
-- 
1.5.2.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
