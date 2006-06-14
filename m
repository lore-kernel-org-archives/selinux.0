Subject: [PATCH] selinux: restrict /proc/keys and /proc/key-users
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, dhowells@redhat.com, sds@tycho.nsa.gov,
        jmorris@redhat.com
Content-Type: text/plain
Date: Wed, 14 Jun 2006 15:09:20 -0400
Message-Id: <1150312160.3287.8.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David,

I've decided to restrict my patch so that it discards the /proc/key-users
enhancements, since those aren't specifically related to SELinux.
If you decide to use the discarded portions in some later patch,
make sure you reverse the order of the boolean condition:

       if (!capable(CAP_SYS_ADMIN) &&
           (current->user->uid != user->uid))
               return 0;

As follows:

       if ((current->user->uid != user->uid) &&
           !capable(CAP_SYS_ADMIN))
               return 0;

Steve pointed out offline that the former ordering will produce excessive
auditing output, something I had previously overlooked.

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Restrict /proc/keys, so that only those keys that LSM permits the current task
to view are presented.  Update the documentation to reflect the change.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

---

 Documentation/keys.txt |    9 ++++++---
 security/Kconfig       |   16 +++++++++++-----
 security/keys/proc.c   |   11 +++++++++++
 3 files changed, 28 insertions(+), 8 deletions(-)

diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/Documentation/keys.txt linux-2.6.17-rc6-mm2.prockeys/Documentation/keys.txt
--- linux-2.6.17-rc6-mm2.orig/Documentation/keys.txt	2006-06-13 09:14:59.000000000 -0400
+++ linux-2.6.17-rc6-mm2.prockeys/Documentation/keys.txt	2006-06-14 15:00:06.000000000 -0400
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
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/Kconfig linux-2.6.17-rc6-mm2.prockeys/security/Kconfig
--- linux-2.6.17-rc6-mm2.orig/security/Kconfig	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc6-mm2.prockeys/security/Kconfig	2006-06-14 14:51:26.000000000 -0400
@@ -26,12 +26,18 @@ config KEYS_DEBUG_PROC_KEYS
 	depends on KEYS
 	help
 	  This option turns on support for the /proc/keys file through which
-	  all the keys on the system can be listed.
+	  key attributes can be listed.
 
-	  This option is a slight security risk in that it makes it possible
-	  for anyone to see all the keys on the system. Normally the manager
-	  pretends keys that are inaccessible to a process don't exist as far
-	  as that process is concerned.
+	  LSM security checks are still performed, and may remove some keys
+	  from the listing if the current task is not authorized to view
+	  those keys.  Note, however, that the discretionary permissions
+	  checks that are normally performed on keys are not performed here.
+	  Key attributes are listed, but key payloads are not included.
+
+	  This option presents a security risk in that it bypasses the normal
+	  discretionary permissions checks on keys.
+
+	  If you are unsure as to whether this is required, answer N.
 
 config SECURITY
 	bool "Enable different security models"
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/keys/proc.c linux-2.6.17-rc6-mm2.prockeys/security/keys/proc.c
--- linux-2.6.17-rc6-mm2.orig/security/keys/proc.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc6-mm2.prockeys/security/keys/proc.c	2006-06-14 14:48:18.000000000 -0400
@@ -18,6 +18,7 @@
 #include <linux/seq_file.h>
 #include <asm/errno.h>
 #include "internal.h"
+#include <linux/security.h>
 
 #ifdef CONFIG_KEYS_DEBUG_PROC_KEYS
 static int proc_keys_open(struct inode *inode, struct file *file);
@@ -137,6 +138,16 @@ static int proc_keys_show(struct seq_fil
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
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
