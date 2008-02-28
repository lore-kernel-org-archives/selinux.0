Subject: [PATCH -v2] SELinux: create new open permission
From: Eric Paris <eparis@redhat.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 12:58:40 -0500
Message-Id: <1204221520.3206.86.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Adds a new open permission inside SELinux when 'opening' a file.  The
idea is that opening a file and reading/writing to that file are not the
same thing.  Its different if a program had its stdout redirected
to /tmp/output than if the program tried to directly open /tmp/output.
This should allow policy writers to more liberally give read/write
permissions across the policy while still blocking many design and
programing flaws SELinux is so good at catching today.

Signed-off-by: Eric Paris <eparis@redhat.com>

---
As an example, process1 in httpd_t opened a bunch of files of type
user_tmp_t.  It then called process2 running as ntpd_t which did nothing
but accept those open fd's and terminate.  Notice proc1 needed open
perms and proc2 only needed read and write.

#============= httpd_t ==============
allow httpd_t tmp_t:dir open;
allow httpd_t user_tmp_t:blk_file { read write open };
allow httpd_t user_tmp_t:chr_file { read write open };
allow httpd_t user_tmp_t:dir { read open };
allow httpd_t user_tmp_t:fifo_file { read write open };
allow httpd_t user_tmp_t:file { read write execute entrypoint open };
allow httpd_t user_tmp_t:lnk_file read;

#============= ntpd_t ==============
allow ntpd_t user_tmp_t:blk_file { read write };
allow ntpd_t user_tmp_t:chr_file { read write };
allow ntpd_t user_tmp_t:dir read;
allow ntpd_t user_tmp_t:fifo_file { read write };
allow ntpd_t user_tmp_t:file { read write entrypoint };

 security/selinux/hooks.c                     |   31 +++++++++++++++++++++++++-
 security/selinux/include/av_perm_to_string.h |    5 ++++
 security/selinux/include/av_permissions.h    |    5 ++++
 security/selinux/include/security.h          |    2 +
 security/selinux/selinuxfs.c                 |    3 +-
 security/selinux/ss/services.c               |    3 ++
 6 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 75c2e99..a4cf5ff 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1599,6 +1599,35 @@ static inline u32 file_mask_to_av(int mode, int mask)
 	return av;
 }
 
+/*
+ * Convert a file mask to an access vector and include the correct open
+ * open permission.
+ */
+static inline u32 open_file_mask_to_av(int mode, int mask)
+{
+	u32 av = file_mask_to_av(mode, mask);
+
+	if (selinux_policycap_openperm) {
+		/*
+		 * lnk files and socks do not really have an 'open'
+		 */
+		if (S_ISREG(mode))
+			av |= FILE__OPEN;
+		else if (S_ISCHR(mode))
+			av |= CHR_FILE__OPEN;
+		else if (S_ISBLK(mode))
+			av |= BLK_FILE__OPEN;
+		else if (S_ISFIFO(mode))
+			av |= FIFO_FILE__OPEN;
+		else if (S_ISDIR(mode))
+			av |= DIR__OPEN;
+		else
+			printk(KERN_ERR "SELinux: WARNING: inside open_file_to_av "
+				"with unknown mode:%x\n", mode);
+	}
+	return av;
+}
+
 /* Convert a Linux file to an access vector. */
 static inline u32 file_to_av(struct file *file)
 {
@@ -2517,7 +2546,7 @@ static int selinux_inode_permission(struct inode *inode, int mask,
 	}
 
 	return inode_has_perm(current, inode,
-			       file_mask_to_av(inode->i_mode, mask), NULL);
+			       open_file_mask_to_av(inode->i_mode, mask), NULL);
 }
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index d569669..1223b4f 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -14,12 +14,17 @@
    S_(SECCLASS_DIR, DIR__REPARENT, "reparent")
    S_(SECCLASS_DIR, DIR__SEARCH, "search")
    S_(SECCLASS_DIR, DIR__RMDIR, "rmdir")
+   S_(SECCLASS_DIR, DIR__OPEN, "open")
    S_(SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, "execute_no_trans")
    S_(SECCLASS_FILE, FILE__ENTRYPOINT, "entrypoint")
    S_(SECCLASS_FILE, FILE__EXECMOD, "execmod")
+   S_(SECCLASS_FILE, FILE__OPEN, "open")
    S_(SECCLASS_CHR_FILE, CHR_FILE__EXECUTE_NO_TRANS, "execute_no_trans")
    S_(SECCLASS_CHR_FILE, CHR_FILE__ENTRYPOINT, "entrypoint")
    S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")
+   S_(SECCLASS_CHR_FILE, CHR_FILE__OPEN, "open")
+   S_(SECCLASS_BLK_FILE, BLK_FILE__OPEN, "open")
+   S_(SECCLASS_FIFO_FILE, FIFO_FILE__OPEN, "open")
    S_(SECCLASS_FD, FD__USE, "use")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NEWCONN, "newconn")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index 75b4131..c4c5116 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -79,6 +79,7 @@
 #define DIR__REPARENT                             0x00080000UL
 #define DIR__SEARCH                               0x00100000UL
 #define DIR__RMDIR                                0x00200000UL
+#define DIR__OPEN                                 0x00400000UL
 #define FILE__IOCTL                               0x00000001UL
 #define FILE__READ                                0x00000002UL
 #define FILE__WRITE                               0x00000004UL
@@ -99,6 +100,7 @@
 #define FILE__EXECUTE_NO_TRANS                    0x00020000UL
 #define FILE__ENTRYPOINT                          0x00040000UL
 #define FILE__EXECMOD                             0x00080000UL
+#define FILE__OPEN                                0x00100000UL
 #define LNK_FILE__IOCTL                           0x00000001UL
 #define LNK_FILE__READ                            0x00000002UL
 #define LNK_FILE__WRITE                           0x00000004UL
@@ -136,6 +138,7 @@
 #define CHR_FILE__EXECUTE_NO_TRANS                0x00020000UL
 #define CHR_FILE__ENTRYPOINT                      0x00040000UL
 #define CHR_FILE__EXECMOD                         0x00080000UL
+#define CHR_FILE__OPEN                            0x00100000UL
 #define BLK_FILE__IOCTL                           0x00000001UL
 #define BLK_FILE__READ                            0x00000002UL
 #define BLK_FILE__WRITE                           0x00000004UL
@@ -153,6 +156,7 @@
 #define BLK_FILE__SWAPON                          0x00004000UL
 #define BLK_FILE__QUOTAON                         0x00008000UL
 #define BLK_FILE__MOUNTON                         0x00010000UL
+#define BLK_FILE__OPEN                            0x00020000UL
 #define SOCK_FILE__IOCTL                          0x00000001UL
 #define SOCK_FILE__READ                           0x00000002UL
 #define SOCK_FILE__WRITE                          0x00000004UL
@@ -187,6 +191,7 @@
 #define FIFO_FILE__SWAPON                         0x00004000UL
 #define FIFO_FILE__QUOTAON                        0x00008000UL
 #define FIFO_FILE__MOUNTON                        0x00010000UL
+#define FIFO_FILE__OPEN                           0x00020000UL
 #define FD__USE                                   0x00000001UL
 #define SOCKET__IOCTL                             0x00000001UL
 #define SOCKET__READ                              0x00000002UL
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 837ce42..fa30f53 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -43,11 +43,13 @@ extern int selinux_mls_enabled;
 /* Policy capabilities */
 enum {
 	POLICYDB_CAPABILITY_NETPEER,
+	POLICYDB_CAPABILITY_OPENPERM,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
 
 extern int selinux_policycap_netpeer;
+extern int selinux_policycap_openperm;
 
 int security_load_policy(void * data, size_t len);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 0341567..1d996bb 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -42,7 +42,8 @@
 
 /* Policy capability filenames */
 static char *policycap_names[] = {
-	"network_peer_controls"
+	"network_peer_controls",
+	"open_perms"
 };
 
 unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f374186..23a61f1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -61,6 +61,7 @@ extern void selnl_notify_policyload(u32 seqno);
 unsigned int policydb_loaded_version;
 
 int selinux_policycap_netpeer;
+int selinux_policycap_openperm;
 
 /*
  * This is declared in avc.c
@@ -1306,6 +1307,8 @@ static void security_load_policycaps(void)
 {
 	selinux_policycap_netpeer = ebitmap_get_bit(&policydb.policycaps,
 						  POLICYDB_CAPABILITY_NETPEER);
+	selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
+						  POLICYDB_CAPABILITY_OPENPERM);
 }
 
 extern void selinux_complete_init(void);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
