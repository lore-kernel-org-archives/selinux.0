From: Chris PeBenito <cpebenito@tresys.com>
To: <SELinux@tycho.nsa.gov>
CC: Chris PeBenito <cpebenito@tresys.com>
Subject: [PATCH 1/2] Add SELinux policy capability for always checking packet class.
Date: Wed, 6 Jun 2012 13:28:50 -0400
Message-ID: <1339003731-6743-1-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently the packet class in SELinux is not checked if there are no
SECMARK rules in the security or mangle netfilter tables.  Some systems
prefer that packets are always checked, for example, to protect the system
should the netfilter rules fail to load or if the nefilter rules
were maliciously flushed.

Add the always_check_network policy capability which, when enabled, treats
SECMARK as enabled, even if there are no netfilter SECMARK rules.

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
---
 security/selinux/hooks.c            |    8 ++++++--
 security/selinux/include/security.h |    2 ++
 security/selinux/selinuxfs.c        |    3 ++-
 security/selinux/ss/services.c      |    3 +++
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 372ec65..ec7151b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -137,12 +137,16 @@ static struct kmem_cache *sel_inode_cache;
  * This function checks the SECMARK reference counter to see if any SECMARK
  * targets are currently configured, if the reference counter is greater than
  * zero SECMARK is considered to be enabled.  Returns true (1) if SECMARK is
- * enabled, false (0) if SECMARK is disabled.
+ * enabled, false (0) if SECMARK is disabled.  If the always_check_network
+ * policy capability is enabled, SECMARK is always considered enabled.
  *
  */
 static int selinux_secmark_enabled(void)
 {
-	return (atomic_read(&selinux_secmark_refcount) > 0);
+	if (selinux_policycap_alwaysnetwork)
+		return 1;
+	else
+		return (atomic_read(&selinux_secmark_refcount) > 0);
 }
 
 /*
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index dde2005..981c4ac 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -68,12 +68,14 @@ extern int selinux_enabled;
 enum {
 	POLICYDB_CAPABILITY_NETPEER,
 	POLICYDB_CAPABILITY_OPENPERM,
+	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
 
 extern int selinux_policycap_netpeer;
 extern int selinux_policycap_openperm;
+extern int selinux_policycap_alwaysnetwork;
 
 /*
  * type_datum properties
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 3ad2902..cb893f9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -44,7 +44,8 @@
 /* Policy capability filenames */
 static char *policycap_names[] = {
 	"network_peer_controls",
-	"open_perms"
+	"open_perms",
+	"always_check_network"
 };
 
 unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4321b8f..e124d8f 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -72,6 +72,7 @@
 
 int selinux_policycap_netpeer;
 int selinux_policycap_openperm;
+int selinux_policycap_alwaysnetwork;
 
 static DEFINE_RWLOCK(policy_rwlock);
 
@@ -1812,6 +1813,8 @@ static void security_load_policycaps(void)
 						  POLICYDB_CAPABILITY_NETPEER);
 	selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
 						  POLICYDB_CAPABILITY_OPENPERM);
+	selinux_policycap_alwaysnetwork = ebitmap_get_bit(&policydb.policycaps,
+						  POLICYDB_CAPABILITY_ALWAYSNETWORK);
 }
 
 static int security_preserve_bools(struct policydb *p);
-- 
1.7.8.6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
