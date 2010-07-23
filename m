From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 4/5] selinux: place open in the common file perms
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Fri, 23 Jul 2010 11:44:09 -0400
Message-ID: <20100723154409.13217.5816.stgit@paris.rdu.redhat.com>
In-Reply-To: <20100723154351.13217.85595.stgit@paris.rdu.redhat.com>
References: <20100723154351.13217.85595.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

kernel can dynamically remap perms.  Drop the open lookup table and put open
in the common file perms.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c            |   24 +++---------------------
 security/selinux/include/classmap.h |   15 ++++++++-------
 2 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 754a775..42043f9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1776,27 +1776,9 @@ static inline u32 open_file_to_av(struct file *file)
 {
 	u32 av = file_to_av(file);
 
-	if (selinux_policycap_openperm) {
-		mode_t mode = file->f_path.dentry->d_inode->i_mode;
-		/*
-		 * lnk files and socks do not really have an 'open'
-		 */
-		if (S_ISREG(mode))
-			av |= FILE__OPEN;
-		else if (S_ISCHR(mode))
-			av |= CHR_FILE__OPEN;
-		else if (S_ISBLK(mode))
-			av |= BLK_FILE__OPEN;
-		else if (S_ISFIFO(mode))
-			av |= FIFO_FILE__OPEN;
-		else if (S_ISDIR(mode))
-			av |= DIR__OPEN;
-		else if (S_ISSOCK(mode))
-			av |= SOCK_FILE__OPEN;
-		else
-			printk(KERN_ERR "SELinux: WARNING: inside %s with "
-				"unknown mode:%o\n", __func__, mode);
-	}
+	if (selinux_policycap_openperm)
+		av |= FILE__OPEN;
+
 	return av;
 }
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index d64603e..41990cb 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -2,7 +2,8 @@
     "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append"
 
 #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
-    "rename", "execute", "swapon", "quotaon", "mounton", "audit_access"
+    "rename", "execute", "swapon", "quotaon", "mounton", "audit_access", \
+    "open"
 
 #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
     "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
@@ -43,22 +44,22 @@ struct security_class_mapping secclass_map[] = {
 	    "quotaget", NULL } },
 	{ "file",
 	  { COMMON_FILE_PERMS,
-	    "execute_no_trans", "entrypoint", "execmod", "open", NULL } },
+	    "execute_no_trans", "entrypoint", "execmod", NULL } },
 	{ "dir",
 	  { COMMON_FILE_PERMS, "add_name", "remove_name",
-	    "reparent", "search", "rmdir", "open", NULL } },
+	    "reparent", "search", "rmdir", NULL } },
 	{ "fd", { "use", NULL } },
 	{ "lnk_file",
 	  { COMMON_FILE_PERMS, NULL } },
 	{ "chr_file",
 	  { COMMON_FILE_PERMS,
-	    "execute_no_trans", "entrypoint", "execmod", "open", NULL } },
+	    "execute_no_trans", "entrypoint", "execmod", NULL } },
 	{ "blk_file",
-	  { COMMON_FILE_PERMS, "open", NULL } },
+	  { COMMON_FILE_PERMS, NULL } },
 	{ "sock_file",
-	  { COMMON_FILE_PERMS, "open", NULL } },
+	  { COMMON_FILE_PERMS, NULL } },
 	{ "fifo_file",
-	  { COMMON_FILE_PERMS, "open", NULL } },
+	  { COMMON_FILE_PERMS, NULL } },
 	{ "socket",
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "tcp_socket",


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
