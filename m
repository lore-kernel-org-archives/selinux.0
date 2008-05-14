Subject: Re: [PATCH] selinux:  fix sleeping allocation in
	security_context_to_sid (Was: + selinux-dopey-hack.patch added to -mm tree)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <20080513114018.5bfa7fb0.akpm@linux-foundation.org>
References: <200805130810.m4D8ACbM032389@imap1.linux-foundation.org>
	 <1210688804.6206.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20080513092150.c819e1fc.akpm@linux-foundation.org>
	 <1210698106.6206.188.camel@moss-spartans.epoch.ncsc.mil>
	 <20080513114018.5bfa7fb0.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 14 May 2008 10:12:43 -0400
Message-Id: <1210774363.6206.344.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-05-13 at 11:40 -0700, Andrew Morton wrote:
> On Tue, 13 May 2008 13:01:46 -0400 Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > > > Fix a sleeping function called from invalid context bug introduced by 
> > > > the deferred mapping of contexts support, which restructured the code 
> > > > into a helper and moved the locking to the caller.  Always use GFP_ATOMIC 
> > > > for allocating copies of the context  and remove the gfp_flags argument as it
> > > > is no longer used.  These allocations are generally small and transient.
> > > > 
> > > 
> > > GFP_ATOMIC is bad.  It can fail and it drains page reserves for things
> > > which actually need to use it.
> > > 
> > > It seems particualrly bad to use an unreliable mechanism in something
> > > which is security-related.
> > > 
> > > Please reconsider.
> > 
> > I don't see a good alternative without replacing the policy rwlock with
> > a different locking scheme. 
> 
> There are, afacit, only two kmallocs there, and their sizes are both
> known before we do the POLICY_RDLOCK.
> 
> So can't we just perform those kmallocs before taking POLICY_RDLOCK? 
> That'll mean adding another arg to string_to_context_struct().

Ok, let's try this instead then.

Fix a sleeping function called from invalid context bug by moving allocation
to the callers prior to taking the policy rdlock.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/ss/services.c |   68 ++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b86ac9d..010f203 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -730,15 +730,16 @@ int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len)
 	return security_sid_to_context_core(sid, scontext, scontext_len, 1);
 }
 
+/*
+ * Caveat:  Mutates scontext.
+ */
 static int string_to_context_struct(struct policydb *pol,
 				    struct sidtab *sidtabp,
-				    const char *scontext,
+				    char *scontext,
 				    u32 scontext_len,
 				    struct context *ctx,
-				    u32 def_sid,
-				    gfp_t gfp_flags)
+				    u32 def_sid)
 {
-	char *scontext2 = NULL;
 	struct role_datum *role;
 	struct type_datum *typdatum;
 	struct user_datum *usrdatum;
@@ -747,19 +748,10 @@ static int string_to_context_struct(struct policydb *pol,
 
 	context_init(ctx);
 
-	/* Copy the string so that we can modify the copy as we parse it. */
-	scontext2 = kmalloc(scontext_len+1, gfp_flags);
-	if (!scontext2) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	memcpy(scontext2, scontext, scontext_len);
-	scontext2[scontext_len] = 0;
-
 	/* Parse the security context. */
 
 	rc = -EINVAL;
-	scontextp = (char *) scontext2;
+	scontextp = (char *) scontext;
 
 	/* Extract the user. */
 	p = scontextp;
@@ -809,7 +801,7 @@ static int string_to_context_struct(struct policydb *pol,
 	if (rc)
 		goto out;
 
-	if ((p - scontext2) < scontext_len) {
+	if ((p - scontext) < scontext_len) {
 		rc = -EINVAL;
 		goto out;
 	}
@@ -822,7 +814,6 @@ static int string_to_context_struct(struct policydb *pol,
 	}
 	rc = 0;
 out:
-	kfree(scontext2);
 	return rc;
 }
 
@@ -830,6 +821,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 					u32 *sid, u32 def_sid, gfp_t gfp_flags,
 					int force)
 {
+	char *scontext2, *str;
 	struct context context;
 	int rc = 0;
 
@@ -839,27 +831,36 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 		for (i = 1; i < SECINITSID_NUM; i++) {
 			if (!strcmp(initial_sid_to_string[i], scontext)) {
 				*sid = i;
-				goto out;
+				return 0;
 			}
 		}
 		*sid = SECINITSID_KERNEL;
-		goto out;
+		return 0;
 	}
 	*sid = SECSID_NULL;
 
+	/* Copy the string so that we can modify the copy as we parse it. */
+	scontext2 = kmalloc(scontext_len+1, gfp_flags);
+	if (!scontext2)
+		return -ENOMEM;
+	memcpy(scontext2, scontext, scontext_len);
+	scontext2[scontext_len] = 0;
+
+	/* And save another copy for possible storage in uninterpreted form */
+	str = kstrdup(scontext2, gfp_flags);
+	if (!str) {
+		kfree(scontext2);
+		return -ENOMEM;
+	}
+
 	POLICY_RDLOCK;
 	rc = string_to_context_struct(&policydb, &sidtab,
-				      scontext, scontext_len,
-				      &context, def_sid, gfp_flags);
+				      scontext2, scontext_len,
+				      &context, def_sid);
 	if (rc == -EINVAL && force) {
-		context.str = kmalloc(scontext_len+1, gfp_flags);
-		if (!context.str) {
-			rc = -ENOMEM;
-			goto out;
-		}
-		memcpy(context.str, scontext, scontext_len);
-		context.str[scontext_len] = 0;
+		context.str = str;
 		context.len = scontext_len;
+		str = NULL;
 	} else if (rc)
 		goto out;
 	rc = sidtab_context_to_sid(&sidtab, &context, sid);
@@ -867,6 +868,8 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 		context_destroy(&context);
 out:
 	POLICY_RDUNLOCK;
+	kfree(scontext2);
+	kfree(str);
 	return rc;
 }
 
@@ -1339,9 +1342,14 @@ static int convert_context(u32 key,
 
 	if (c->str) {
 		struct context ctx;
-		rc = string_to_context_struct(args->newp, NULL, c->str,
-					      c->len, &ctx, SECSID_NULL,
-					      GFP_KERNEL);
+		s = kstrdup(c->str, GFP_KERNEL);
+		if (!s) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		rc = string_to_context_struct(args->newp, NULL, s,
+					      c->len, &ctx, SECSID_NULL);
+		kfree(s);
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
