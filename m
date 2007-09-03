Date: Mon, 03 Sep 2007 17:04:46 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: selinux@tycho.nsa.gov
Subject: [RFC]Tuning selinux_file_permission
Cc: ynakam@hitachisoft.jp, Stephen Smalley <sds@tycho.nsa.gov>,
        busybox@kaigai.gr.jp, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, kaigai@ak.jp.nec.com
Message-Id: <20070903170020.D7E4.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

As I posted before, 
I found big overhead in read/write on some CPUs.
http://marc.info/?t=118845343400001&r=1&w=2

I tried tuning based on manual inlining of selinux_file_permission, 
and it works to some extent,
but Stephen suggested better idea.

Stephen Smalley wrote:
> I'd also like to separately explore a different approach for improving
> the overhead on read/write that has come up previously, namely don't
> recheck at all unless one of the following conditions is met:
> 1) process SID has changed since open-time check (i.e. exec with SID
> transition or setcon),
> 2) file SID has changed since open-time check (i.e. setxattr) ,
> 3) policy seqno has changed since open-time check (i.e. policy reload or
> boolean change).

I tried tuning of selinux_file_permission based on this idea.
I wrote a patch that shows the concept, and it can reduce much overhead.
I want comments from community.

1. Detail of patch
1) Prepared global serial number, u32 sid_serial.
 It is initialized as 1, 
 is incremented when sid is changed in the system:
   - policy is reloaded
   - boolean is changed
   - domain transition/setcon happend 
   - setxattr happend

2) Added "sid_serial" member to struct file_secuirty.

3) In file open, file_security->sid_serial is set as global sid_serial.

4) In file read/write, selinux_file_permission is called. 
   file_security->sid_serial and global sid_serial is compared 
   before permission check.
   If sid_serial is not changed, permission check is skipped.
   If it is different, this means some relabel could happen after file open,
   then call do_selinux_file_permission and permission recheck happen.

5) If sid_serial is incremented too much, 
   and returned to zero.
   permission recheck in selinux_file_permission is forced by notify_sid_serial_end().
   This is to avoid following situation.
   * sid_serial = 10 at file open
   * sid_serial is incremented 2^32+10 times, then sid_serial returns to 10
   * In file read, selinux_file_permission is called.
     sid_serial is unchanged(=10), then permission check is skipped.
   * sid may be changed, but check is skipped

2. Benchmark
lmbench simple read/write.

1) Result for x86(Pentium 4)
             Base     SELinux   Overhead(%)
Simple read  1.1034   1.116    1.16(before 12.3)
Simple write 0.9989   1.018    1.97(before 14.0)
 * Base = SELinux disabled kernel

2) Result for SH(SuperH, processor for embedded devices)
                Base   SELinux  Overhead(%)
Simple read     2.6781  2.67    -0.37(before 141.5)
Simple write    2.0781  2.34     12.5(before 155.9)

Overhead is reduced a lot in both PC and embedded devices.


Below is a patch.

---
 security/selinux/avc.c            |   49 +++++++++++++++++++++++++
 security/selinux/hooks.c          |   74 +++++++++++++++++++++++++++++++++-----
 security/selinux/include/avc.h    |    4 ++
 security/selinux/include/objsec.h |    2 +
 security/selinux/selinuxfs.c      |    3 +
 5 files changed, 124 insertions(+), 8 deletions(-)
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/avc.c linux-2.6.22/security/selinux/avc.c
--- linux-2.6.22.orig/security/selinux/avc.c	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/avc.c	2007-09-03 14:22:22.000000000 +0900
@@ -29,8 +29,10 @@
 #include <linux/audit.h>
 #include <linux/ipv6.h>
 #include <net/ipv6.h>
+#include <linux/file.h>
 #include "avc.h"
 #include "avc_ss.h"
+#include "objsec.h"
 
 static const struct av_perm_to_string av_perm_to_string[] = {
 #define S_(c, v, s) { c, v, s },
@@ -126,6 +128,15 @@ static struct avc_cache avc_cache;
 static struct avc_callback_node *avc_callbacks;
 static struct kmem_cache *avc_node_cachep;
 
+/*This number is incremented when sids are changed
+ - policy reload
+ - boolean change
+ - domain transition
+ - setxattr
+*/
+static u32 sid_serial = 1;
+
+
 static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
 	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
@@ -913,3 +924,41 @@ int avc_has_perm(u32 ssid, u32 tsid, u16
 	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
 	return rc;
 }
+
+/*
+  Notify all processes that sid_serial returned to zero.
+*/
+void notify_sid_serial_end()
+{
+	struct task_struct *p;
+	struct files_struct *files;
+	struct file *file;
+	struct file_security_struct *fsec;
+	int i;
+
+	/*Mutex is not considered yet!*/
+	for_each_process(p) {
+		files = p->files;
+		for (i = 0; i < atomic_read(&(files->count)); i++) {
+			file = files->fd_array[i];
+			if (file) {
+				fsec = file->f_security;
+				if (fsec)
+					fsec->force_file_check = 1;
+			}
+		}
+	}
+}
+
+void sid_serial_incr()
+{
+	sid_serial++;
+	if (sid_serial == 0)
+		notify_sid_serial_end();
+
+}
+
+u32 read_sid_serial()
+{
+	return sid_serial;
+}
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/hooks.c linux-2.6.22/security/selinux/hooks.c
--- linux-2.6.22.orig/security/selinux/hooks.c	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/hooks.c	2007-09-03 14:31:54.000000000 +0900
@@ -220,7 +220,9 @@ static int file_alloc_security(struct fi
 
 	fsec->file = file;
 	fsec->sid = tsec->sid;
+	fsec->force_file_check = 0;
 	fsec->fown_sid = tsec->sid;
+	fsec->sid_serial = read_sid_serial();
 	file->f_security = fsec;
 
 	return 0;
@@ -991,6 +993,7 @@ out_unlock:
 out:
 	if (isec->sclass == SECCLASS_FILE)
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
+
 	return rc;
 }
 
@@ -1691,6 +1694,8 @@ static int selinux_bprm_set_security(str
 
 		/* Set the security field to the new SID. */
 		bsec->sid = newsid;
+
+		sid_serial_incr();
 	}
 
 	bsec->set = 1;
@@ -2289,7 +2294,7 @@ static int selinux_inode_getattr(struct 
 	return dentry_has_perm(current, mnt, dentry, FILE__GETATTR);
 }
 
-static int selinux_inode_setxattr(struct dentry *dentry, char *name, void *value, size_t size, int flags)
+static inline int do_selinux_inode_setxattr(struct dentry *dentry, char *name, void *value, size_t size, int flags)
 {
 	struct task_security_struct *tsec = current->security;
 	struct inode *inode = dentry->d_inode;
@@ -2348,6 +2353,17 @@ static int selinux_inode_setxattr(struct
 			    FILESYSTEM__ASSOCIATE,
 			    &ad);
 }
+static int selinux_inode_setxattr(struct dentry *dentry, char *name, void *value, size_t size, int flags)
+{
+	int rc;
+
+	rc = do_selinux_inode_setxattr(dentry, name, value, size, flags);
+	if (rc)
+		return rc;
+
+	sid_serial_incr();
+	return 0;
+}
 
 static void selinux_inode_post_setxattr(struct dentry *dentry, char *name,
                                         void *value, size_t size, int flags)
@@ -2457,17 +2473,11 @@ static int selinux_inode_listsecurity(st
 }
 
 /* file security operations */
-
-static int selinux_file_permission(struct file *file, int mask)
+static int do_selinux_file_permission(struct file *file, int mask)
 {
 	int rc;
 	struct inode *inode = file->f_path.dentry->d_inode;
 
-	if (!mask) {
-		/* No permission to check.  Existence test. */
-		return 0;
-	}
-
 	/* file_mask_to_av won't add FILE__WRITE if MAY_APPEND is set */
 	if ((file->f_flags & O_APPEND) && (mask & MAY_WRITE))
 		mask |= MAY_APPEND;
@@ -2480,6 +2490,53 @@ static int selinux_file_permission(struc
 	return selinux_netlbl_inode_permission(inode, mask);
 }
 
+static int selinux_file_permission(struct file *file, int mask)
+{
+
+	struct task_security_struct *tsec = current->security;
+	struct file_security_struct *fsec = file->f_security;
+	int rc;
+	u32 current_sid_serial;
+
+	if (!mask) {
+		/* No permission to check.  Existence test. */
+		return 0;
+	}
+
+	/*Check FS__USE*/
+	if (tsec->sid != fsec->sid) {
+		struct vfsmount *mnt = file->f_path.mnt;
+		struct dentry *dentry = file->f_path.dentry;
+		struct avc_audit_data ad;
+		AVC_AUDIT_DATA_INIT(&ad, FS);
+		ad.u.fs.mnt = mnt;
+		ad.u.fs.dentry = dentry;
+		rc = avc_has_perm(tsec->sid, fsec->sid,
+				  SECCLASS_FD,
+				  FD__USE,
+				  &ad);
+		if (rc)
+			return rc;
+	}
+
+	/*Skip permission check
+	  when sids are not changed after open*/
+	current_sid_serial = read_sid_serial();
+	if (fsec->sid_serial == current_sid_serial &&
+	    !(fsec->force_file_check))
+		return 0;
+
+	rc = do_selinux_file_permission(file, mask);
+	if (rc)
+		return rc;
+
+	fsec->sid_serial = current_sid_serial;
+	fsec->force_file_check = 0;
+
+	return 0;
+}
+
+
 static int selinux_file_alloc_security(struct file *file)
 {
 	return file_alloc_security(file);
@@ -4642,6 +4699,7 @@ static int selinux_setprocattr(struct ta
 	else
 		return -EINVAL;
 
+	sid_serial_incr();
 	return size;
 }
 
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/include/avc.h linux-2.6.22/security/selinux/include/avc.h
--- linux-2.6.22.orig/security/selinux/include/avc.h	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/include/avc.h	2007-09-03 09:05:47.000000000 +0900
@@ -127,6 +127,10 @@ int avc_add_callback(int (*callback)(u32
 
 /* Exported to selinuxfs */
 int avc_get_hash_stats(char *page);
+
+void sid_serial_incr();
+u32 read_sid_serial();
+
 extern unsigned int avc_cache_threshold;
 
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/include/objsec.h linux-2.6.22/security/selinux/include/objsec.h
--- linux-2.6.22.orig/security/selinux/include/objsec.h	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/include/objsec.h	2007-09-03 14:28:18.000000000 +0900
@@ -53,6 +53,8 @@ struct file_security_struct {
 	struct file *file;              /* back pointer to file object */
 	u32 sid;              /* SID of open file description */
 	u32 fown_sid;         /* SID of file owner (for SIGIO) */
+	u32 sid_serial;       /* sid_serial at open time*/
+	bool force_file_check; /* It is set when sid_serial returns zero*/
 };
 
 struct superblock_security_struct {
diff -purN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22.orig/security/selinux/selinuxfs.c linux-2.6.22/security/selinux/selinuxfs.c
--- linux-2.6.22.orig/security/selinux/selinuxfs.c	2007-07-09 08:32:17.000000000 +0900
+++ linux-2.6.22/security/selinux/selinuxfs.c	2007-09-03 09:10:38.000000000 +0900
@@ -294,6 +294,7 @@ static ssize_t sel_write_load(struct fil
 	audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 		"policy loaded auid=%u",
 		audit_get_loginuid(current->audit_context));
+	sid_serial_incr();
 out:
 	mutex_unlock(&sel_mutex);
 	vfree(data);
@@ -872,6 +873,8 @@ static ssize_t sel_write_bool(struct fil
 	bool_pending_values[inode->i_ino&SEL_INO_MASK] = new_value;
 	length = count;
 
+	sid_serial_incr();
+
 out:
 	mutex_unlock(&sel_mutex);
 	if (page)

Regards,
-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
