From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH] libsepol: introduce new policy capability ptrace_child
Date: Fri, 30 Mar 2012 16:31:33 -0400
Message-Id: <1333139493-3004-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

policy capabilities need to be listed in lisepol to do the name to
number mapping.  Make it so.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libsepol/include/sepol/policydb/polcaps.h |    1 +
 libsepol/src/polcaps.c                    |    1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 40c0a48..0ac2a1d 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -5,6 +5,7 @@
 enum {
 	POLICYDB_CAPABILITY_NETPEER,
 	POLICYDB_CAPABILITY_OPENPERM,
+	POLICYDB_CAPABILITY_PTRACE_CHILD,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 71970b1..e003bc7 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -8,6 +8,7 @@
 static const char *polcap_names[] = {
 	"network_peer_controls",	/* POLICYDB_CAPABILITY_NETPEER */
 	"open_perms",			/* POLICYDB_CAPABILITY_OPENPERM */
+	"ptrace_child",			/* POLICYDB_CAPABILITY_PTRACE_CHILD */
 	NULL
 };
 
-- 
1.7.9.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
