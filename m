Subject: [PATCH] selinux:  fix sleeping allocation in
	security_context_to_sid (Was: + selinux-dopey-hack.patch added to -mm tree)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: akpm@linux-foundation.org
Cc: selinux@tycho.nsa.gov, jmorris@namei.org,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <200805130810.m4D8ACbM032389@imap1.linux-foundation.org>
References: <200805130810.m4D8ACbM032389@imap1.linux-foundation.org>
Content-Type: text/plain
Date: Tue, 13 May 2008 10:26:44 -0400
Message-Id: <1210688804.6206.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-05-13 at 01:10 -0700, akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> BUG: sleeping function called from invalid context at mm/slab.c:3052
> in_atomic():1, irqs_disabled():0
> 3 locks held by S99local/2391:
>  #0:  (&type->i_mutex_dir_key#4){--..}, at: [<c017973c>] do_lookup+0x72/0x146
>  #1:  (&isec->lock){--..}, at: [<c01cc3e5>] inode_doinit_with_dentry+0x35/0x52f
>  #2:  (policy_rwlock){..-?}, at: [<c01d7f89>] security_context_to_sid_core+0x5e/0x157
> Pid: 2391, comm: S99local Not tainted 2.6.26-rc2 #1
>  [<c011863c>] __might_sleep+0xde/0xe5
>  [<c01706e5>] __kmalloc+0x52/0xd5
>  [<c01d7d9f>] string_to_context_struct+0x2e/0x1ba
>  [<c01d7fa3>] security_context_to_sid_core+0x78/0x157
>  [<c01d80a5>] security_context_to_sid_default+0x10/0x12
>  [<c01cc609>] inode_doinit_with_dentry+0x259/0x52f
>  [<c01cc8f1>] selinux_d_instantiate+0x12/0x14

Please use this patch instead.

Fix a sleeping function called from invalid context bug introduced by 
the deferred mapping of contexts support, which restructured the code 
into a helper and moved the locking to the caller.  Always use GFP_ATOMIC 
for allocating copies of the context  and remove the gfp_flags argument as it
is no longer used.  These allocations are generally small and transient.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c            |    3 +--
 security/selinux/include/security.h |    2 +-
 security/selinux/ss/services.c      |   23 ++++++++++-------------
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 59c6e98..9684270 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1194,8 +1194,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			rc = 0;
 		} else {
 			rc = security_context_to_sid_default(context, rc, &sid,
-							     sbsec->def_sid,
-							     GFP_NOFS);
+							     sbsec->def_sid);
 			if (rc) {
 				printk(KERN_WARNING "SELinux: %s:  context_to_sid(%s) "
 				       "returned %d for dev=%s ino=%ld\n",
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 7c54300..e8e24a2 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -99,7 +99,7 @@ int security_context_to_sid(const char *scontext, u32 scontext_len,
 	u32 *out_sid);
 
 int security_context_to_sid_default(const char *scontext, u32 scontext_len,
-				    u32 *out_sid, u32 def_sid, gfp_t gfp_flags);
+				    u32 *out_sid, u32 def_sid);
 
 int security_context_to_sid_force(const char *scontext, u32 scontext_len,
 				  u32 *sid);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b86ac9d..498b084 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -735,8 +735,7 @@ static int string_to_context_struct(struct policydb *pol,
 				    const char *scontext,
 				    u32 scontext_len,
 				    struct context *ctx,
-				    u32 def_sid,
-				    gfp_t gfp_flags)
+				    u32 def_sid)
 {
 	char *scontext2 = NULL;
 	struct role_datum *role;
@@ -748,7 +747,7 @@ static int string_to_context_struct(struct policydb *pol,
 	context_init(ctx);
 
 	/* Copy the string so that we can modify the copy as we parse it. */
-	scontext2 = kmalloc(scontext_len+1, gfp_flags);
+	scontext2 = kmalloc(scontext_len+1, GFP_ATOMIC);
 	if (!scontext2) {
 		rc = -ENOMEM;
 		goto out;
@@ -827,8 +826,7 @@ out:
 }
 
 static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
-					u32 *sid, u32 def_sid, gfp_t gfp_flags,
-					int force)
+					u32 *sid, u32 def_sid, int force)
 {
 	struct context context;
 	int rc = 0;
@@ -850,9 +848,9 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 	POLICY_RDLOCK;
 	rc = string_to_context_struct(&policydb, &sidtab,
 				      scontext, scontext_len,
-				      &context, def_sid, gfp_flags);
+				      &context, def_sid);
 	if (rc == -EINVAL && force) {
-		context.str = kmalloc(scontext_len+1, gfp_flags);
+		context.str = kmalloc(scontext_len+1, GFP_ATOMIC);
 		if (!context.str) {
 			rc = -ENOMEM;
 			goto out;
@@ -884,7 +882,7 @@ out:
 int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
-					    sid, SECSID_NULL, GFP_KERNEL, 0);
+					    sid, SECSID_NULL, 0);
 }
 
 /**
@@ -906,17 +904,17 @@ int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
  * memory is available, or 0 on success.
  */
 int security_context_to_sid_default(const char *scontext, u32 scontext_len,
-				    u32 *sid, u32 def_sid, gfp_t gfp_flags)
+				    u32 *sid, u32 def_sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
-					    sid, def_sid, gfp_flags, 1);
+					    sid, def_sid, 1);
 }
 
 int security_context_to_sid_force(const char *scontext, u32 scontext_len,
 				  u32 *sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
-					    sid, SECSID_NULL, GFP_KERNEL, 1);
+					    sid, SECSID_NULL, 1);
 }
 
 static int compute_sid_handle_invalid_context(
@@ -1340,8 +1338,7 @@ static int convert_context(u32 key,
 	if (c->str) {
 		struct context ctx;
 		rc = string_to_context_struct(args->newp, NULL, c->str,
-					      c->len, &ctx, SECSID_NULL,
-					      GFP_KERNEL);
+					      c->len, &ctx, SECSID_NULL);
 		if (!rc) {
 			printk(KERN_INFO
 		       "SELinux:  Context %s became valid (mapped).\n",


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
