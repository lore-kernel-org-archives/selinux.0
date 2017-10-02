From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, jmorris@namei.org, Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon,  2 Oct 2017 11:58:20 -0400
Message-Id: <20171002155825.28620-6-sds@tycho.nsa.gov>
In-Reply-To: <20171002155825.28620-1-sds@tycho.nsa.gov>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
Subject: [RFC 05/10] selinux: support per-task/cred selinux namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Extend the task security structure to include a reference to
the associated selinux namespace, and to also contain a
pointer to the cred in the parent namespace.  The current selinux
namespace is changed to the per-task/cred selinux namespace
for the current task/cred.

This change makes it possible to support per-cred selinux namespaces,
but does not yet introduce a mechanism for unsharing of the selinux
namespace.  Thus, by itself, this change does not alter the existing
situation with respect to all processes still using a single init
selinux namespace.

An alternative would be to hang the selinux namespace off of the
user namespace, which itself is associated with the cred.  This
seems undesirable however since DAC and MAC are orthogonal, and
there appear to be real use cases where one will want to use selinux
namespaces without user namespaces and vice versa. However, one
advantage of hanging off the user namespace would be that it is already
associated with other namespaces, such as the network namespace, thus
potentially facilitating looking up the relevant selinux namespace from
the network input/forward hooks.  In most cases however, it appears that
we could instead copy a reference to the creating task selinux namespace
to sock security structures and use that in those hooks.

Introduce a task_security() helper to obtain the correct task/cred
security structure from the hooks, and update the hooks to use it.
This returns a pointer to the security structure for the task in
the same selinux namespace as the caller, or if there is none, a
fake security structure with the well-defined unlabeled SIDs.  This
ensures that we return a valid result that can be used for permission
checks and for returning contexts from e.g. reading /proc/pid/attr files.

I am not signing off on this or most subsequent patches as I am not
yet convinced that this is the right approach.

Not-signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c            | 34 ++++++++++++++++++++++++++++++++--
 security/selinux/include/objsec.h   |  9 ---------
 security/selinux/include/security.h | 13 ++++++++++++-
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 25f5147..f9c1e2c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -213,6 +213,7 @@ static void cred_init_security(void)
 		panic("SELinux:  Failed to initialize initial task.\n");
 
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
+	tsec->ns = get_selinux_ns(init_selinux_ns);
 	cred->security = tsec;
 }
 
@@ -227,15 +228,35 @@ static inline u32 cred_sid(const struct cred *cred)
 	return tsec->sid;
 }
 
+static struct task_security_struct unlabeled_task_security = {
+	.osid = SECINITSID_UNLABELED,
+	.sid = SECINITSID_UNLABELED,
+};
+
+static const struct task_security_struct *task_security(
+	const struct task_struct *p)
+{
+	const struct task_security_struct *tsec;
+
+	tsec = __task_cred(p)->security;
+	while (tsec->ns != current_selinux_ns && tsec->parent_cred)
+		tsec = tsec->parent_cred->security;
+	if (tsec->ns != current_selinux_ns)
+		return &unlabeled_task_security;
+	return tsec;
+}
+
 /*
  * get the objective security ID of a task
  */
 static inline u32 task_sid(const struct task_struct *task)
 {
+	const struct task_security_struct *tsec;
 	u32 sid;
 
 	rcu_read_lock();
-	sid = cred_sid(__task_cred(task));
+	tsec = task_security(task);
+	sid = tsec->sid;
 	rcu_read_unlock();
 	return sid;
 }
@@ -3900,6 +3921,9 @@ static void selinux_cred_free(struct cred *cred)
 	 */
 	BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
 	cred->security = (void *) 0x7UL;
+	put_selinux_ns(tsec->ns);
+	if (tsec->parent_cred)
+		put_cred(tsec->parent_cred);
 	kfree(tsec);
 }
 
@@ -3918,6 +3942,9 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 	if (!tsec)
 		return -ENOMEM;
 
+	tsec->ns = get_selinux_ns(old_tsec->ns);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 	new->security = tsec;
 	return 0;
 }
@@ -3931,6 +3958,9 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 	struct task_security_struct *tsec = new->security;
 
 	*tsec = *old_tsec;
+	tsec->ns = get_selinux_ns(old_tsec->ns);
+	if (old_tsec->parent_cred)
+		tsec->parent_cred = get_cred(old_tsec->parent_cred);
 }
 
 /*
@@ -6054,7 +6084,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	unsigned len;
 
 	rcu_read_lock();
-	__tsec = __task_cred(p)->security;
+	__tsec = task_security(p);
 
 	if (current != p) {
 		error = avc_has_perm(current_selinux_ns,
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 42d2dbb..051b804 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -29,15 +29,6 @@
 #include "flask.h"
 #include "avc.h"
 
-struct task_security_struct {
-	u32 osid;		/* SID prior to last execve */
-	u32 sid;		/* current SID */
-	u32 exec_sid;		/* exec SID */
-	u32 create_sid;		/* fscreate SID */
-	u32 keycreate_sid;	/* keycreate SID */
-	u32 sockcreate_sid;	/* fscreate SID */
-};
-
 /*
  * get the subjective security ID of the current task
  */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 77d977c..246f9de 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -133,7 +133,18 @@ static inline struct selinux_ns *get_selinux_ns(struct selinux_ns *ns)
 
 extern struct selinux_ns *init_selinux_ns;
 
-#define current_selinux_ns (init_selinux_ns)
+struct task_security_struct {
+	u32 osid;		/* SID prior to last execve */
+	u32 sid;		/* current SID */
+	u32 exec_sid;		/* exec SID */
+	u32 create_sid;		/* fscreate SID */
+	u32 keycreate_sid;	/* keycreate SID */
+	u32 sockcreate_sid;	/* fscreate SID */
+	struct selinux_ns *ns;  /* selinux namespace */
+	const struct cred *parent_cred; /* cred in parent ns */
+};
+
+#define current_selinux_ns (((struct task_security_struct *)current_security())->ns)
 
 #define ss_initialized (current_selinux_ns->initialized)
 
-- 
2.9.5
