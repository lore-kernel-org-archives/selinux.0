Subject: [PATCH] libsepol: add new file setsuid_perms policy capability
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, method@manicmethod.com
Content-Type: text/plain
Date: Fri, 17 Oct 2008 11:46:17 -0400
Message-Id: <1224258377.3189.32.camel@paris-laptop>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds the new policy capability called setsuid to libsepol.
This is needed to support the file permission setsuid.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

diff -Naupr libsepol-2.0.32/include/sepol/policydb/polcaps.h libsepol-2.0.32.new/include/sepol/policydb/polcaps.h
--- libsepol-2.0.32/include/sepol/policydb/polcaps.h	2008-07-07 13:50:29.000000000 -0400
+++ libsepol-2.0.32.new/include/sepol/policydb/polcaps.h	2008-10-16 15:42:07.476360377 -0400
@@ -5,6 +5,7 @@
 enum {
 	POLICYDB_CAPABILITY_NETPEER,
 	POLICYDB_CAPABILITY_OPENPERM,
+	POLICYDB_CAPABILITY_SETSUIDPERM,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff -Naupr libsepol-2.0.32/src/polcaps.c libsepol-2.0.32.new/src/polcaps.c
--- libsepol-2.0.32/src/polcaps.c	2008-07-07 13:50:29.000000000 -0400
+++ libsepol-2.0.32.new/src/polcaps.c	2008-10-16 15:41:23.367264184 -0400
@@ -8,6 +8,7 @@
 static const char *polcap_names[] = {
 	"network_peer_controls",	/* POLICYDB_CAPABILITY_NETPEER */
 	"open_perms",			/* POLICYDB_CAPABILITY_OPENPERM */
+	"setsuid_perms",		/* POLICYDB_CAPABILITY_SUIDPERM */
 	NULL
 };
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
