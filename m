From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol, libselinux,
 audit2allow: teach audit2why about type bounds failures
Date: Tue, 29 Nov 2016 15:56:27 -0500
Message-Id: <1480452987-10340-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Teach audit2why to recognize type bounds failures.  This required
updating libsepol sepol_compute_av_reason() to identify bounds
failures, and updating libsepol context_struct_compute_av() to
include the type bounds logic from the kernel.

This could potentially be further augmented to provide more detailed
reporting via the reason buffer to include information similar to
what security_dump_masked_av() reports in the kernel.  However, it
is unclear if this is needed.  It is already possible to get type
bounds checking at policy build time by enabling expand-check=1
in /etc/selinux/semanage.conf (or by default when compiling
monolithic policy).

Before:
type=AVC msg=audit(1480451925.038:3225): avc:  denied  { getattr } for  pid=7118 comm="chmod" path="/home/sds/selinux-testsuite/tests/bounds/bounds_file_blue" dev="dm-2" ino=23337697 scontext=unconfined_u:unconfined_r:test_bounds_child_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_bounds_file_blue_t:s0 tclass=file permissive=0

	Was caused by:
		Unknown - would be allowed by active policy
		Possible mismatch between this policy and the one under which the audit message was generated.

		Possible mismatch between current in-memory boolean settings vs. permanent ones.

After:
type=AVC msg=audit(1480451925.038:3225): avc:  denied  { getattr } for  pid=7118 comm="chmod" path="/home/sds/selinux-testsuite/tests/bounds/bounds_file_blue" dev="dm-2" ino=23337697 scontext=unconfined_u:unconfined_r:test_bounds_child_t:s0-s0:c0.c1023 tcontext=unconfined_u:object_r:test_bounds_file_blue_t:s0 tclass=file permissive=0
        Was caused by:
                Typebounds violation.

                Add an allow rule for the parent type.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/audit2why.c                 |  5 ++
 libsepol/include/sepol/policydb/services.h |  7 +--
 libsepol/src/services.c                    | 77 ++++++++++++++++++++++++++++--
 python/audit2allow/audit2allow             |  5 ++
 4 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 3d312a1..3135eed 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -28,6 +28,7 @@
 #define BOOLEAN 3
 #define CONSTRAINT 4
 #define RBAC 5
+#define BOUNDS 6
 
 struct boolean_t {
 	char *name;
@@ -425,6 +426,9 @@ static PyObject *analyze(PyObject *self __attribute__((unused)) , PyObject *args
 	if (reason & SEPOL_COMPUTEAV_RBAC)
 		RETURN(RBAC)
 
+	if (reason & SEPOL_COMPUTEAV_BOUNDS)
+		RETURN(BOUNDS)
+
         RETURN(BADCOMPUTE)
 }
 
@@ -481,6 +485,7 @@ PyMODINIT_FUNC initaudit2why(void)
 	PyModule_AddIntConstant(m,"BOOLEAN", BOOLEAN);
 	PyModule_AddIntConstant(m,"CONSTRAINT", CONSTRAINT);
 	PyModule_AddIntConstant(m,"RBAC", RBAC);
+	PyModule_AddIntConstant(m,"BOUNDS", BOUNDS);
 
 #if PY_MAJOR_VERSION >= 3
 	return m;
diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index 29f57cf..9162149 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -52,9 +52,10 @@ extern int sepol_compute_av(sepol_security_id_t ssid,	/* IN */
 
 /* Same as above, but also return the reason(s) for any
    denials of the requested permissions. */
-#define SEPOL_COMPUTEAV_TE   1
-#define SEPOL_COMPUTEAV_CONS 2
-#define SEPOL_COMPUTEAV_RBAC 4
+#define SEPOL_COMPUTEAV_TE     0x1U
+#define SEPOL_COMPUTEAV_CONS   0x2U
+#define SEPOL_COMPUTEAV_RBAC   0x4U
+#define SEPOL_COMPUTEAV_BOUNDS 0x8U
 extern int sepol_compute_av_reason(sepol_security_id_t ssid,
 				   sepol_security_id_t tsid,
 				   sepol_security_class_t tclass,
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 068759d..03fb120 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -824,6 +824,67 @@ out:
 	return rc;
 }
 
+/* Forward declaration */
+static int context_struct_compute_av(context_struct_t * scontext,
+				     context_struct_t * tcontext,
+				     sepol_security_class_t tclass,
+				     sepol_access_vector_t requested,
+				     struct sepol_av_decision *avd,
+				     unsigned int *reason,
+				     char **r_buf,
+				     unsigned int flags);
+
+static void type_attribute_bounds_av(context_struct_t *scontext,
+				     context_struct_t *tcontext,
+				     sepol_security_class_t tclass,
+				     sepol_access_vector_t requested,
+				     struct sepol_av_decision *avd,
+				     unsigned int *reason)
+{
+	context_struct_t lo_scontext;
+	context_struct_t lo_tcontext, *tcontextp = tcontext;
+	struct sepol_av_decision lo_avd;
+	type_datum_t *source;
+	type_datum_t *target;
+	sepol_access_vector_t masked = 0;
+
+	source = policydb->type_val_to_struct[scontext->type - 1];
+	if (!source->bounds)
+		return;
+
+	target = policydb->type_val_to_struct[tcontext->type - 1];
+
+	memset(&lo_avd, 0, sizeof(lo_avd));
+
+	memcpy(&lo_scontext, scontext, sizeof(lo_scontext));
+	lo_scontext.type = source->bounds;
+
+	if (target->bounds) {
+		memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
+		lo_tcontext.type = target->bounds;
+		tcontextp = &lo_tcontext;
+	}
+
+	context_struct_compute_av(&lo_scontext,
+				  tcontextp,
+				  tclass,
+				  requested,
+				  &lo_avd,
+				  NULL, /* reason intentionally omitted */
+				  NULL,
+				  0);
+
+	masked = ~lo_avd.allowed & avd->allowed;
+
+	if (!masked)
+		return;		/* no masked permission */
+
+	/* mask violated permissions */
+	avd->allowed &= ~masked;
+
+	*reason |= SEPOL_COMPUTEAV_BOUNDS;
+}
+
 /*
  * Compute access vectors based on a context structure pair for
  * the permissions in a particular class.
@@ -835,7 +896,7 @@ static int context_struct_compute_av(context_struct_t * scontext,
 				     struct sepol_av_decision *avd,
 				     unsigned int *reason,
 				     char **r_buf,
-					 unsigned int flags)
+				     unsigned int flags)
 {
 	constraint_node_t *constraint;
 	struct role_allow *ra;
@@ -860,7 +921,8 @@ static int context_struct_compute_av(context_struct_t * scontext,
 	avd->auditallow = 0;
 	avd->auditdeny = 0xffffffff;
 	avd->seqno = latest_granting;
-	*reason = 0;
+	if (reason)
+		*reason = 0;
 
 	/*
 	 * If a specific type enforcement rule was defined for
@@ -899,7 +961,8 @@ static int context_struct_compute_av(context_struct_t * scontext,
 	}
 
 	if (requested & ~avd->allowed) {
-		*reason |= SEPOL_COMPUTEAV_TE;
+		if (reason)
+			*reason |= SEPOL_COMPUTEAV_TE;
 		requested &= avd->allowed;
 	}
 
@@ -919,7 +982,8 @@ static int context_struct_compute_av(context_struct_t * scontext,
 	}
 
 	if (requested & ~avd->allowed) {
-		*reason |= SEPOL_COMPUTEAV_CONS;
+		if (reason)
+			*reason |= SEPOL_COMPUTEAV_CONS;
 		requested &= avd->allowed;
 	}
 
@@ -942,10 +1006,13 @@ static int context_struct_compute_av(context_struct_t * scontext,
 	}
 
 	if (requested & ~avd->allowed) {
-		*reason |= SEPOL_COMPUTEAV_RBAC;
+		if (reason)
+			*reason |= SEPOL_COMPUTEAV_RBAC;
 		requested &= avd->allowed;
 	}
 
+	type_attribute_bounds_av(scontext, tcontext, tclass, requested, avd,
+				 reason);
 	return 0;
 }
 
diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2allow
index 4b50c5b..37ab23a 100644
--- a/python/audit2allow/audit2allow
+++ b/python/audit2allow/audit2allow
@@ -285,6 +285,11 @@ class AuditToPolicy:
                 print("\t\tAdd an allow rule for the role pair.\n")
                 continue
 
+            if rc == audit2why.BOUNDS:
+                print("\t\tTypebounds violation.\n")
+                print("\t\tAdd an allow rule for the parent type.\n")
+                continue
+
         audit2why.finish()
         return
 
-- 
2.7.4
