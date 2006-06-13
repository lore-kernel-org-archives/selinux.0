Subject: [PATCH] keys: restrict /proc/keys and /proc/key-users
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, dhowells@redhat.com, sds@tycho.nsa.gov,
        jmorris@redhat.com
Content-Type: text/plain
Date: Tue, 13 Jun 2006 13:10:05 -0400
Message-Id: <1150218605.3488.25.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David,

I expect that this patch will be slightly controversial, but I'd like to
at least discuss it.  I think that /proc/keys is actually useful to have,
in case the user wants a quick summary of what keys the kernel is keeping
for them.  However, they obviously should not be able to access information
about keys that they are prohibited from viewing.  The following patch
adds a simple permission check to ensure that this doesn't occur.

It also restricts the /proc/key-users file, so that ordinary users can only
view information on their own keys, while allowing the super-user to view
information about all the keys belonging to all users.  This file is still
problematic, as it, too could be used to form a covert channel based on the
quota used by each user, but this patch should at least be a step in the
right direction.  On a high-security system, all access to this file should
probably be prevented.  Actually, do you think we should expand the #ifdef
that surrounds /proc/keys so that it also encompasses key-users?  Or perhaps
we should add a separate kernel option?

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Restrict /proc/keys, so that only those keys the current task is permitted
to view are presented.  Restrict /proc/key-users, so that ordinary users are
only allowed to view their own statistics.  However, still permit the
superuser to view the statistics for all users.  Update the documentation
to reflect these changes.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

---

 Documentation/keys.txt |   10 ++++++----
 security/keys/proc.c   |   15 +++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/Documentation/keys.txt linux-2.6.17-rc6-mm2.prockeys/Documentation/keys.txt
--- linux-2.6.17-rc6-mm2.orig/Documentation/keys.txt	2006-06-13 09:14:59.000000000 -0400
+++ linux-2.6.17-rc6-mm2.prockeys/Documentation/keys.txt	2006-06-13 12:56:26.000000000 -0400
@@ -270,9 +270,9 @@ about the status of the key service:
 
  (*) /proc/keys
 
-     This lists all the keys on the system, giving information about their
-     type, description and permissions. The payload of the key is not available
-     this way:
+     This lists all the keys that are currently accessible to the task querying
+     the file, giving information about their type, description and
+     permissions. The payload of the key is not available this way:
 
 	SERIAL   FLAGS  USAGE EXPY PERM     UID   GID   TYPE      DESCRIPTION: SUMMARY
 	00000001 I-----    39 perm 1f3f0000     0     0 keyring   _uid_ses.0: 1/4
@@ -300,7 +300,9 @@ about the status of the key service:
  (*) /proc/key-users
 
      This file lists the tracking data for each user that has at least one key
-     on the system. Such data includes quota information and statistics:
+     on the system. The superuser will be presented with data for all users on
+     the system, while ordinary users will only be allowed to view their own
+     data.  Such data includes quota information and statistics:
 
 	[root@andromeda root]# cat /proc/key-users
 	0:     46 45/45 1/100 13/10000
diff -uprN -X linux-2.6.17-rc6-mm2.orig/Documentation/dontdiff linux-2.6.17-rc6-mm2.orig/security/keys/proc.c linux-2.6.17-rc6-mm2.prockeys/security/keys/proc.c
--- linux-2.6.17-rc6-mm2.orig/security/keys/proc.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc6-mm2.prockeys/security/keys/proc.c	2006-06-13 10:07:07.000000000 -0400
@@ -134,9 +134,18 @@ static int proc_keys_show(struct seq_fil
 {
 	struct rb_node *_p = v;
 	struct key *key = rb_entry(_p, struct key, serial_node);
+	key_ref_t key_ref;
 	struct timespec now;
 	unsigned long timo;
 	char xbuf[12];
+	int rc;
+
+	/* check whether the current task is allowed
+	   to view the key */
+	key_ref = make_key_ref(key, is_key_possessed(key));
+	rc = key_task_permission(key_ref, current, KEY_VIEW);
+	if (rc < 0)
+		return 0;
 
 	now = current_kernel_time();
 
@@ -240,6 +249,12 @@ static int proc_key_users_show(struct se
 	struct rb_node *_p = v;
 	struct key_user *user = rb_entry(_p, struct key_user, node);
 
+	/* allow the superuser to view all statistics;
+	   allow other users to only view their own statistics */
+	if ((current->user->uid != 0) &&
+	    (current->user->uid != user->uid))
+		return 0;
+
 	seq_printf(m, "%5u: %5d %d/%d %d/%d %d/%d\n",
 		   user->uid,
 		   atomic_read(&user->usage),



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
