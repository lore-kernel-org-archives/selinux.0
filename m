From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: guido@trentalancia.net, richard_c_haines@btinternet.com,
 paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: Define extended_socket_class policy capability
Date: Thu,  8 Dec 2016 09:19:40 -0500
Message-Id: <1481206780-731-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Define the extended_socket_class policy capability used to enable
the use of separate socket security classes for all network address
families rather than the generic socket class. This also enables
separate security classes for ICMP and SCTP sockets, which were previously
mapped to the rawip_socket class.

The legacy redhat1 policy capability that was only ever used in testing
within Fedora for ptrace_child is reclaimed for this purpose; as far as
I can tell, this policy capability is not enabled in any supported distro
policy.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/include/sepol/policydb/polcaps.h | 2 +-
 libsepol/src/polcaps.c                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 53d7994..c9e40f6 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -9,7 +9,7 @@ extern "C" {
 enum {
 	POLICYDB_CAPABILITY_NETPEER,
 	POLICYDB_CAPABILITY_OPENPERM,
-	POLICYDB_CAPABILITY_REDHAT1, /* reserved for RH testing of ptrace_child */
+	POLICYDB_CAPABILITY_EXTSOCKCLASS,
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	__POLICYDB_CAPABILITY_MAX
 };
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 43a71a7..3924cb8 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -8,7 +8,7 @@
 static const char *polcap_names[] = {
 	"network_peer_controls",	/* POLICYDB_CAPABILITY_NETPEER */
 	"open_perms",			/* POLICYDB_CAPABILITY_OPENPERM */
-	"redhat1",			/* POLICYDB_CAPABILITY_REDHAT1, aka ptrace_child */
+	"extended_socket_class",	/* POLICYDB_CAPABILITY_EXTSOCKCLASS */
 	"always_check_network",		/* POLICYDB_CAPABILITY_ALWAYSNETWORK */
 	NULL
 };
-- 
2.7.4
