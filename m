Message-ID: <44CA2956.8050609@trustedcs.com>
Date: Fri, 28 Jul 2006 10:12:22 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH 1/2] kernel support for new range_transition statements
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch introduces support for policy version 21.  This version of the
binary kernel policy allows for defining range transitions on security
classes other than the process security class.  As always, backwards
compatibility for older formats is retained.  The security class is read in as
specified when using the new format, while the "process" security class is
assumed when using an older policy format.

Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>

 include/security.h |    3 ++-
 ss/mls.c           |   21 ++++++++++-----------
 ss/policydb.c      |   27 ++++++++++++++++++++-------
 ss/policydb.h      |    7 ++++---
 4 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 063af47..389078e 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -24,10 +24,11 @@ #define POLICYDB_VERSION_NLCLASS	18
 #define POLICYDB_VERSION_VALIDATETRANS	19
 #define POLICYDB_VERSION_MLS		19
 #define POLICYDB_VERSION_AVTAB		20
+#define POLICYDB_VERSION_RANGETRANS	21
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_AVTAB
+#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_RANGETRANS
 
 extern int selinux_enabled;
 extern int selinux_mls_enabled;
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 7bc5b64..df2540c 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -543,22 +543,21 @@ int mls_compute_sid(struct context *scon
 		    u32 specified,
 		    struct context *newcontext)
 {
+	struct range_trans *rtr;
+
 	if (!selinux_mls_enabled)
 		return 0;
 
 	switch (specified) {
 	case AVTAB_TRANSITION:
-		if (tclass == SECCLASS_PROCESS) {
-			struct range_trans *rangetr;
-			/* Look for a range transition rule. */
-			for (rangetr = policydb.range_tr; rangetr;
-			     rangetr = rangetr->next) {
-				if (rangetr->dom == scontext->type &&
-				    rangetr->type == tcontext->type) {
-					/* Set the range from the rule */
-					return mls_range_set(newcontext,
-					                     &rangetr->range);
-				}
+		/* Look for a range transition rule. */
+		for (rtr = policydb.range_tr; rtr; rtr = rtr->next) {
+			if (rtr->source_type == scontext->type &&
+			    rtr->target_type == tcontext->type &&
+			    rtr->target_class == tclass) {
+				/* Set the range from the rule */
+				return mls_range_set(newcontext,
+				                     &rtr->target_range);
 			}
 		}
 		/* Fallthrough */
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f03960e..b188953 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -96,6 +96,11 @@ static struct policydb_compat_info polic
 		.sym_num        = SYM_NUM,
 		.ocon_num       = OCON_NUM,
 	},
+	{
+		.version        = POLICYDB_VERSION_RANGETRANS,
+		.sym_num        = SYM_NUM,
+		.ocon_num       = OCON_NUM,
+	},
 };
 
 static struct policydb_compat_info *policydb_lookup_compat(int version)
@@ -645,15 +650,15 @@ void policydb_destroy(struct policydb *p
 
 	for (rt = p->range_tr; rt; rt = rt -> next) {
 		if (lrt) {
-			ebitmap_destroy(&lrt->range.level[0].cat);
-			ebitmap_destroy(&lrt->range.level[1].cat);
+			ebitmap_destroy(&lrt->target_range.level[0].cat);
+			ebitmap_destroy(&lrt->target_range.level[1].cat);
 			kfree(lrt);
 		}
 		lrt = rt;
 	}
 	if (lrt) {
-		ebitmap_destroy(&lrt->range.level[0].cat);
-		ebitmap_destroy(&lrt->range.level[1].cat);
+		ebitmap_destroy(&lrt->target_range.level[0].cat);
+		ebitmap_destroy(&lrt->target_range.level[1].cat);
 		kfree(lrt);
 	}
 
@@ -1829,6 +1834,7 @@ int policydb_read(struct policydb *p, vo
 	}
 
 	if (p->policyvers >= POLICYDB_VERSION_MLS) {
+		int new_rangetr = p->policyvers >= POLICYDB_VERSION_RANGETRANS;
 		rc = next_entry(buf, fp, sizeof(u32));
 		if (rc < 0)
 			goto bad;
@@ -1847,9 +1853,16 @@ int policydb_read(struct policydb *p, vo
 			rc = next_entry(buf, fp, (sizeof(u32) * 2));
 			if (rc < 0)
 				goto bad;
-			rt->dom = le32_to_cpu(buf[0]);
-			rt->type = le32_to_cpu(buf[1]);
-			rc = mls_read_range_helper(&rt->range, fp);
+			rt->source_type = le32_to_cpu(buf[0]);
+			rt->target_type = le32_to_cpu(buf[1]);
+			if (new_rangetr) {
+				rc = next_entry(buf, fp, sizeof(u32));
+				if (rc < 0)
+					goto bad;
+				rt->target_class = le32_to_cpu(buf[0]);
+			} else
+				rt->target_class = SECCLASS_PROCESS;
+			rc = mls_read_range_helper(&rt->target_range, fp);
 			if (rc)
 				goto bad;
 			lrt = rt;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index b134071..8319d5f 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -106,9 +106,10 @@ struct cat_datum {
 };
 
 struct range_trans {
-	u32 dom;			/* current process domain */
-	u32 type;			/* program executable type */
-	struct mls_range range;		/* new range */
+	u32 source_type;
+	u32 target_type;
+	u32 target_class;
+	struct mls_range target_range;
 	struct range_trans *next;
 };
 

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
