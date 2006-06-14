Subject: [PATCH] keys: restrict /proc/keys and /proc/key-users
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, dhowells@redhat.com, sds@tycho.nsa.gov,
        jmorris@redhat.com
Content-Type: text/plain
Date: Wed, 14 Jun 2006 14:23:13 -0400
Message-Id: <1150309393.3309.3.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David,

I've updated this patch so that it doesn't check the discretionary permissions on
keys when listing them in /proc/keys.  Instead, it directly invokes the LSM (SELinux)
hook, to check the mandatory controls.  This will ensure that our mandatory controls
are not violated, while still allowing you to perform whatever debugging you need by
running SELinux in permissive mode or creating a policy that is loose enough for you
to view the required keys.  I hope this is a reasonable compromise.

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Restrict /proc/keys, so that only those keys that LSM permits the current task
to view are presented.  Restrict /proc/key-users, so that ordinary users are
only allowed to view their own statistics.  However, still permit the
superuser to view the statistics for all users.  Update the documentation
to reflect these changes.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

---

 Documentation/keys.txt |   13 +++++++++----
 security/Kconfig       |   26 +++++++++++++++++++++-----
 security/keys/proc.c   |   41 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 64 insertions(+), 16 deletions(-)

diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/Documentation/keys.txt linux-2.6.17-rc6-mm2.prockeys/Documentation/keys.txt
--- linux-2.6.17-rc6-mm2.orig/Documentation/keys.txt	2006-06-13 09:14:59.000000000 -0400
+++ linux-2.6.17-rc6-mm2.prockeys/Documentation/keys.txt	2006-06-14 13:57:10.000000000 -0400
@@ -270,9 +270,12 @@ about the status of the key service:
 
  (*) /proc/keys
 
-     This lists all the keys on the system, giving information about their
-     type, description and permissions. The payload of the key is not available
-     this way:
+     This lists all the keys that are currently accessible to the task querying
+     the file, giving information about their type, description and
+     permissions. Only mandatory permissions checks are performed, using the
+     LSM hooks. The discretionary checks are NOT performed, so this file still
+     presents a security risk. The payload of the key is not available this
+     way:
 
 	SERIAL   FLAGS  USAGE EXPY PERM     UID   GID   TYPE      DESCRIPTION: SUMMARY
 	00000001 I-----    39 perm 1f3f0000     0     0 keyring   _uid_ses.0: 1/4
@@ -300,7 +303,9 @@ about the status of the key service:
  (*) /proc/key-users
 
      This file lists the tracking data for each user that has at least one key
-     on the system. Such data includes quota information and statistics:
+     on the system. The superuser will be presented with data for all users on
+     the system, while ordinary users will only be allowed to view their own
+     data.  Such data includes quota information and statistics:
 
 	[root@andromeda root]# cat /proc/key-users
 	0:     46 45/45 1/100 13/10000
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/Kconfig linux-2.6.17-rc6-mm2.prockeys/security/Kconfig
--- linux-2.6.17-rc6-mm2.orig/security/Kconfig	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc6-mm2.prockeys/security/Kconfig	2006-06-14 14:11:35.000000000 -0400
@@ -26,12 +26,28 @@ config KEYS_DEBUG_PROC_KEYS
 	depends on KEYS
 	help
 	  This option turns on support for the /proc/keys file through which
-	  all the keys on the system can be listed.
+	  key attributes can be listed.
 
-	  This option is a slight security risk in that it makes it possible
-	  for anyone to see all the keys on the system. Normally the manager
-	  pretends keys that are inaccessible to a process don't exist as far
-	  as that process is concerned.
+	  System security checks are still performed, unless configured
+	  otherwise, and may remove some keys from the listing if the current
+	  task is not authorized to view those keys.  Note, however, that the
+	  discretionary permissions checks that are normally performed on
+	  keys are not performed here.  Key attributes are listed, but key
+	  payloads are not included.
+
+	  This option presents a security risk in that it bypasses the normal
+	  discretionary permissions checks on keys.
+
+	  If you are unsure as to whether this is required, answer N.
+
+config KEYS_PROC_KEY_USERS
+	bool "Enable the /proc/key-users file by which all keys may be viewed"
+	depends on KEYS
+	help
+	  This option turns on support for the /proc/key-users file through
+	  which user statistics, such as quota information, can be listed.
+
+	  If you are unsure as to whether this is required, answer N.
 
 config SECURITY
 	bool "Enable different security models"
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/keys/proc.c linux-2.6.17-rc6-mm2.prockeys/security/keys/proc.c
--- linux-2.6.17-rc6-mm2.orig/security/keys/proc.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc6-mm2.prockeys/security/keys/proc.c	2006-06-14 14:11:08.000000000 -0400
@@ -18,6 +18,7 @@
 #include <linux/seq_file.h>
 #include <asm/errno.h>
 #include "internal.h"
+#include <linux/security.h>
 
 #ifdef CONFIG_KEYS_DEBUG_PROC_KEYS
 static int proc_keys_open(struct inode *inode, struct file *file);
@@ -41,6 +42,7 @@ static struct file_operations proc_keys_
 };
 #endif
 
+#ifdef CONFIG_KEYS_PROC_KEY_USERS
 static int proc_key_users_open(struct inode *inode, struct file *file);
 static void *proc_key_users_start(struct seq_file *p, loff_t *_pos);
 static void *proc_key_users_next(struct seq_file *p, void *v, loff_t *_pos);
@@ -60,6 +62,7 @@ static struct file_operations proc_key_u
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
+#endif
 
 /*****************************************************************************/
 /*
@@ -67,21 +70,25 @@ static struct file_operations proc_key_u
  */
 static int __init key_proc_init(void)
 {
-	struct proc_dir_entry *p;
+#ifdef CONFIG_KEYS_PROC_KEY_USERS
+	struct proc_dir_entry *pku;
+#endif
 
 #ifdef CONFIG_KEYS_DEBUG_PROC_KEYS
-	p = create_proc_entry("keys", 0, NULL);
-	if (!p)
+	struct proc_dir_entry *pk = create_proc_entry("keys", 0, NULL);
+	if (!pk)
 		panic("Cannot create /proc/keys\n");
 
-	p->proc_fops = &proc_keys_fops;
+	pk->proc_fops = &proc_keys_fops;
 #endif
 
-	p = create_proc_entry("key-users", 0, NULL);
-	if (!p)
+#ifdef CONFIG_KEYS_PROC_KEY_USERS
+	pku = create_proc_entry("key-users", 0, NULL);
+	if (!pku)
 		panic("Cannot create /proc/key-users\n");
 
-	p->proc_fops = &proc_key_users_fops;
+	pku->proc_fops = &proc_key_users_fops;
+#endif
 
 	return 0;
 
@@ -137,6 +144,16 @@ static int proc_keys_show(struct seq_fil
 	struct timespec now;
 	unsigned long timo;
 	char xbuf[12];
+	key_ref_t key_ref;
+	int rc;
+
+	key_ref = make_key_ref(key, 0);
+
+	/* check whether LSM permits the current task
+	   to view the key */
+	rc = security_key_permission(key_ref, current, KEY_VIEW);
+	if (rc < 0)
+		return 0;
 
 	now = current_kernel_time();
 
@@ -196,6 +213,8 @@ static int proc_keys_show(struct seq_fil
 
 #endif /* CONFIG_KEYS_DEBUG_PROC_KEYS */
 
+#ifdef CONFIG_KEYS_PROC_KEY_USERS
+
 /*****************************************************************************/
 /*
  * implement "/proc/key-users" to provides a list of the key users
@@ -240,6 +259,12 @@ static int proc_key_users_show(struct se
 	struct rb_node *_p = v;
 	struct key_user *user = rb_entry(_p, struct key_user, node);
 
+	/* allow the superuser to view all statistics;
+	   allow other users to only view their own statistics */
+	if (!capable(CAP_SYS_ADMIN) &&
+	    (current->user->uid != user->uid))
+		return 0;
+
 	seq_printf(m, "%5u: %5d %d/%d %d/%d %d/%d\n",
 		   user->uid,
 		   atomic_read(&user->usage),
@@ -254,3 +279,5 @@ static int proc_key_users_show(struct se
 	return 0;
 
 }
+
+#endif /* CONFIG_KEYS_PROC_KEY_USERS */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
