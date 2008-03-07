Subject: [PATCH] SELinux: introduce permissive types
From: Eric Paris <eparis@redhat.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 14:44:03 -0500
Message-Id: <1204919043.2891.50.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Introduce the concept of a permissive type.  A new ebitmap is introduced
to the policy database which indicates is a given type has the
permissive bit set or not.  This bit is tested for the scontext of any
policy denial.  Thus the bit if meaningless on types which only appear
as the target of a decision (such such as typically a file type).  A
domain running with a permissive type will be allowed to perform any
action similarly to when the system is globally set permissive.

When going through the kernel to find out where the scontext is not that
of a domain I found FILESYSTEM__ASSOCIATE and any number of networking
permissions.  Can Paul or anyone comment on if the permissive bit on the
scontext of the access decisions make sense?  My understanding is
that ?most?all? of these sids will naturally flow from the executing
domain (and if people use set_socket_con they know enough to fix it
themselves).  So the permissive bit makes sense and should be allowed.

The permissive bit on a type used for files would allow it to associate
with any FS.  Is this an issue?  Should I not check permissive on such
operations?

If we do want further restrictions on what operations should be affected
by the permissive bit and what should I believe just about anything is
possible, but it starts getting unmaintainable pretty quickly.  Maybe we
just want to enforce convention in the toolchain that all types which
are labeled permissive must have the 'domain' attribute or something
like that. If you can load a policy with random bits set you win anyway
so is kernel enforcement of permissive bits on non-domains an issue?

Signed-off-by: Eric Paris <eparis@redhat.com>

---

Testing basically subsisted of adding a new policy module which turned
an existing type into a permissive type.  In my case I made ntpd_t
permissive and then ran programs as runcon -t ntpd_t 'script'  We would
get a log message only one time just like is seen with the global
non-enforcing.  Removing that policy module would reset the AVC and
would subsequently deny the decision.

Patches for libsepol and checkpolicy will be forthcoming as soon as I
get them cleaned up to the point where they don't look like I just threw
up in the code base and out popped permissive domains.

 security/selinux/avc.c              |    9 ++++++++-
 security/selinux/include/security.h |    5 ++++-
 security/selinux/ss/policydb.c      |   11 +++++++++++
 security/selinux/ss/policydb.h      |    2 ++
 security/selinux/ss/services.c      |   15 +++++++++++++++
 5 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 187964e..3eb5d69 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -891,8 +891,15 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	denied = requested & ~(p_ae->avd.allowed);
 
 	if (!requested || denied) {
-		if (selinux_enforcing || (flags & AVC_STRICT))
+		if (flags & AVC_STRICT)
 			rc = -EACCES;
+		else if (selinux_enforcing)
+			if (unlikely(security_permissive_sid(ssid) &&
+				     requested && node))
+				avc_update_node(AVC_CALLBACK_GRANT,requested,
+						ssid,tsid,tclass);
+			else
+				rc = -EACCES;
 		else
 			if (node)
 				avc_update_node(AVC_CALLBACK_GRANT,requested,
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index f7d2f03..fde8690 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -26,13 +26,14 @@
 #define POLICYDB_VERSION_AVTAB		20
 #define POLICYDB_VERSION_RANGETRANS	21
 #define POLICYDB_VERSION_POLCAP		22
+#define POLICYDB_VERSION_PERMISSIVE	23
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
 #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
 #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
 #else
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_POLCAP
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_PERMISSIVE
 #endif
 
 #define CONTEXT_MNT	0x01
@@ -67,6 +68,8 @@ struct av_decision {
 	u32 seqno;
 };
 
+int security_permissive_sid(u32 sid);
+
 int security_compute_av(u32 ssid, u32 tsid,
 	u16 tclass, u32 requested,
 	struct av_decision *avd);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index bd7d6a0..84dbab9 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -111,6 +111,11 @@ static struct policydb_compat_info policydb_compat[] = {
 		.version	= POLICYDB_VERSION_POLCAP,
 		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NUM,
+	},
+	{
+		.version	= POLICYDB_VERSION_PERMISSIVE,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
 	}
 };
 
@@ -194,6 +199,7 @@ static int policydb_init(struct policydb *p)
 		goto out_free_symtab;
 
 	ebitmap_init(&p->policycaps);
+	ebitmap_init(&p->permissive_map);
 
 out:
 	return rc;
@@ -687,6 +693,7 @@ void policydb_destroy(struct policydb *p)
 	kfree(p->type_attr_map);
 	kfree(p->undefined_perms);
 	ebitmap_destroy(&p->policycaps);
+	ebitmap_destroy(&p->permissive_map);
 
 	return;
 }
@@ -1570,6 +1577,10 @@ int policydb_read(struct policydb *p, void *fp)
 	    ebitmap_read(&p->policycaps, fp) != 0)
 		goto bad;
 
+	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE &&
+	    ebitmap_read(&p->permissive_map, fp) != 0)
+		goto bad;
+
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
 		printk(KERN_ERR "security:  unable to find policy compat info "
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index c4ce996..ba593a3 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -243,6 +243,8 @@ struct policydb {
 
 	struct ebitmap policycaps;
 
+	struct ebitmap permissive_map;
+
 	unsigned int policyvers;
 
 	unsigned int reject_unknown : 1;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f374186..97b4453 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -416,6 +416,21 @@ inval_class:
 	return -EINVAL;
 }
 
+/*
+ * Given a sid find if the type has the permissive flag set
+ */
+int security_permissive_sid(u32 sid)
+{
+	struct context *context;
+	u32 type;
+
+	context = sidtab_search(&sidtab, sid);
+	BUG_ON(!context);
+
+	type = context->type;
+	return ebitmap_get_bit(&policydb.permissive_map, type);
+}
+
 static int security_validtrans_handle_fail(struct context *ocontext,
                                            struct context *ncontext,
                                            struct context *tcontext,



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
