Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0EFptIi002718
	for <selinux@tycho.nsa.gov>; Fri, 14 Jan 2005 10:51:56 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0EFnsiL013266
	for <selinux@tycho.nsa.gov>; Fri, 14 Jan 2005 15:49:59 GMT
Subject: [PATCH][SELINUX] Fix setting of loaded policy version
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
   Chris Wright <chrisw@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
   selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1105717544.26366.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 14 Jan 2005 10:45:44 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch against 2.6.11-rc1-mm1 fixes a different bug in the code for
SELinux policy loading.  It ensures that the loaded policy version
number is not updated until the new policy is successfully committed. 
It also fixes the type on the loaded policy version.  Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

 security/selinux/hooks.c       |    2 +-
 security/selinux/ss/policydb.c |   17 +++++++----------
 security/selinux/ss/policydb.h |    2 ++
 security/selinux/ss/services.c |    5 +++--
 4 files changed, 13 insertions(+), 13 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.11-rc1-mm1/security/selinux/hooks.c linux-2.6.11-rc1-mm1-sel/security/selinux/hooks.c
--- linux-2.6.11-rc1-mm1/security/selinux/hooks.c	2005-01-14 10:29:40.110036280 -0500
+++ linux-2.6.11-rc1-mm1-sel/security/selinux/hooks.c	2005-01-14 10:32:44.203049888 -0500
@@ -73,7 +73,7 @@
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
 
-extern int policydb_loaded_version;
+extern unsigned int policydb_loaded_version;
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
diff -X /home/sds/dontdiff -rup linux-2.6.11-rc1-mm1/security/selinux/ss/policydb.c linux-2.6.11-rc1-mm1-sel/security/selinux/ss/policydb.c
--- linux-2.6.11-rc1-mm1/security/selinux/ss/policydb.c	2005-01-14 10:29:40.113035824 -0500
+++ linux-2.6.11-rc1-mm1-sel/security/selinux/ss/policydb.c	2005-01-14 10:32:44.206049432 -0500
@@ -38,8 +38,6 @@ static char *symtab_name[SYM_NUM] = {
 };
 #endif
 
-int policydb_loaded_version;
-
 static unsigned int symtab_sizes[SYM_NUM] = {
 	2,
 	32,
@@ -1100,7 +1098,7 @@ int policydb_read(struct policydb *p, vo
 	struct role_trans *tr, *ltr;
 	struct ocontext *l, *c, *newc;
 	struct genfs *genfs_p, *genfs, *newgenfs;
-	int i, j, rc, r_policyvers = 0;
+	int i, j, rc;
 	u32 buf[8], len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
@@ -1165,9 +1163,9 @@ int policydb_read(struct policydb *p, vo
 	for (i = 0; i < 4; i++)
 		buf[i] = le32_to_cpu(buf[i]);
 
-	r_policyvers = buf[0];
-	if (r_policyvers < POLICYDB_VERSION_MIN ||
-	    r_policyvers > POLICYDB_VERSION_MAX) {
+	p->policyvers = buf[0];
+	if (p->policyvers < POLICYDB_VERSION_MIN ||
+	    p->policyvers > POLICYDB_VERSION_MAX) {
 	    	printk(KERN_ERR "security:  policydb version %d does not match "
 	    	       "my version range %d-%d\n",
 	    	       buf[0], POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
@@ -1183,10 +1181,10 @@ int policydb_read(struct policydb *p, vo
 	}
 
 
-	info = policydb_lookup_compat(r_policyvers);
+	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
 		printk(KERN_ERR "security:  unable to find policy compat info "
-		       "for version %d\n", r_policyvers);
+		       "for version %d\n", p->policyvers);
 		goto bad;
 	}
 
@@ -1220,7 +1218,7 @@ int policydb_read(struct policydb *p, vo
 	if (rc)
 		goto bad;
 
-	if (r_policyvers >= POLICYDB_VERSION_BOOL) {
+	if (p->policyvers >= POLICYDB_VERSION_BOOL) {
 		rc = cond_read_list(p, fp);
 		if (rc)
 			goto bad;
@@ -1507,7 +1505,6 @@ int policydb_read(struct policydb *p, vo
 	
 	rc = 0;
 out:
-	policydb_loaded_version = r_policyvers;
 	return rc;
 bad_newc:
 	ocontext_destroy(newc,OCON_FSUSE);
diff -X /home/sds/dontdiff -rup linux-2.6.11-rc1-mm1/security/selinux/ss/policydb.h linux-2.6.11-rc1-mm1-sel/security/selinux/ss/policydb.h
--- linux-2.6.11-rc1-mm1/security/selinux/ss/policydb.h	2005-01-14 10:29:40.114035672 -0500
+++ linux-2.6.11-rc1-mm1-sel/security/selinux/ss/policydb.h	2005-01-14 10:32:44.207049280 -0500
@@ -246,6 +246,8 @@ struct policydb {
 	struct ebitmap trustedwriters;
 	struct ebitmap trustedobjects;
 #endif
+
+	unsigned int policyvers;
 };
 
 extern int policydb_init(struct policydb *p);
diff -X /home/sds/dontdiff -rup linux-2.6.11-rc1-mm1/security/selinux/ss/services.c linux-2.6.11-rc1-mm1-sel/security/selinux/ss/services.c
--- linux-2.6.11-rc1-mm1/security/selinux/ss/services.c	2005-01-14 10:29:40.118035064 -0500
+++ linux-2.6.11-rc1-mm1-sel/security/selinux/ss/services.c	2005-01-14 10:32:44.211048672 -0500
@@ -40,7 +40,7 @@
 #include "mls.h"
 
 extern void selnl_notify_policyload(u32 seqno);
-extern int policydb_loaded_version;
+unsigned int policydb_loaded_version;
 
 static DEFINE_RWLOCK(policy_rwlock);
 #define POLICY_RDLOCK read_lock(&policy_rwlock)
@@ -1047,6 +1047,7 @@ int security_load_policy(void *data, siz
 			avtab_cache_destroy();
 			return -EINVAL;
 		}
+		policydb_loaded_version = policydb.policyvers;
 		ss_initialized = 1;
 
 		LOAD_UNLOCK;
@@ -1095,7 +1096,7 @@ int security_load_policy(void *data, siz
 	memcpy(&policydb, &newpolicydb, sizeof policydb);
 	sidtab_set(&sidtab, &newsidtab);
 	seqno = ++latest_granting;
-
+	policydb_loaded_version = policydb.policyvers;
 	POLICY_WRUNLOCK;
 	LOAD_UNLOCK;
 


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
