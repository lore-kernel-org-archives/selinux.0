Message-ID: <49D2C633.3000406@ak.jp.nec.com>
Date: Wed, 01 Apr 2009 10:41:07 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: method@manicmethod.com
CC: jmorris@namei.org, Eric Paris <eparis@parisplace.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Permissive domain in userspace object manager
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com>	 <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com>	 <49CB3CEB.1070505@ak.jp.nec.com> <49CD8E68.9090004@tycho.nsa.gov>	 <49D034B9.9080406@ak.jp.nec.com>  <49D175C6.2050001@ak.jp.nec.com> <1238517993.2484.123.camel@localhost.localdomain> <49D2BE6D.4030708@ak.jp.nec.com>
In-Reply-To: <49D2BE6D.4030708@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------030201080006030300040106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030201080006030300040106
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The attached patch is for libselinux.
Most of part is unchanged from the previous one, expect for manpage.

KaiGai Kohei wrote:
> This patch enables applications to handle permissive domain correctly.
> 
> Since the v2.6.26 kernel, SELinux has supported an idea of permissive
> domain which allows certain processes to work as if permissive mode,
> even if the global setting is enforcing mode.
> However, we don't have an application program interface to inform
> what domains are permissive one, and what domains are not.
> It means applications focuses on SELinux (XACE/SELinux, SE-PostgreSQL
> and so on) cannot handle permissive domain correctly.
> 
> This patch add the sixth field (flags) on the reply of the /selinux/access
> interface which is used to make an access control decision from userspace.
> If the first bit of the flags field is positive, it means the required
> access control decision is on permissive domain, so application should
> allow any required actions, as the kernel doing.
> 
> This patch also has a side benefit. The av_decision.flags is set at
> context_struct_compute_av(). It enables to check required permissions
> without read_lock(&policy_rwlock).
> 
>  Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
> --
>  security/selinux/avc.c              |    2 +-
>  security/selinux/include/security.h |    4 +++-
>  security/selinux/selinuxfs.c        |    4 ++--
>  security/selinux/ss/services.c      |   30 +++++-------------------------
>  4 files changed, 11 insertions(+), 29 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 7f9b5fa..b2ab608 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -927,7 +927,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  	if (denied) {
>  		if (flags & AVC_STRICT)
>  			rc = -EACCES;
> -		else if (!selinux_enforcing || security_permissive_sid(ssid))
> +		else if (!selinux_enforcing || (avd->flags & AVD_FLAGS_PERMISSIVE))
>  			avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
>  					tsid, tclass, avd->seqno);
>  		else
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 5c3434f..a7be3f0 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -91,9 +91,11 @@ struct av_decision {
>  	u32 auditallow;
>  	u32 auditdeny;
>  	u32 seqno;
> +	u32 flags;
>  };
> 
> -int security_permissive_sid(u32 sid);
> +/* definitions of av_decision.flags */
> +#define AVD_FLAGS_PERMISSIVE	0x0001
> 
>  int security_compute_av(u32 ssid, u32 tsid,
>  	u16 tclass, u32 requested,
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index d3c8b98..4d56ab1 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -594,10 +594,10 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
>  		goto out2;
> 
>  	length = scnprintf(buf, SIMPLE_TRANSACTION_LIMIT,
> -			  "%x %x %x %x %u",
> +			  "%x %x %x %x %u %x",
>  			  avd.allowed, 0xffffffff,
>  			  avd.auditallow, avd.auditdeny,
> -			  avd.seqno);
> +			  avd.seqno, avd.flags);
>  out2:
>  	kfree(tcon);
>  out:
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index deeec6c..500e6f7 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -410,6 +410,7 @@ static int context_struct_compute_av(struct context *scontext,
>  	avd->auditallow = 0;
>  	avd->auditdeny = 0xffffffff;
>  	avd->seqno = latest_granting;
> +	avd->flags = 0;
> 
>  	/*
>  	 * Check for all the invalid cases.
> @@ -528,31 +529,6 @@ inval_class:
>  	return 0;
>  }
> 
> -/*
> - * Given a sid find if the type has the permissive flag set
> - */
> -int security_permissive_sid(u32 sid)
> -{
> -	struct context *context;
> -	u32 type;
> -	int rc;
> -
> -	read_lock(&policy_rwlock);
> -
> -	context = sidtab_search(&sidtab, sid);
> -	BUG_ON(!context);
> -
> -	type = context->type;
> -	/*
> -	 * we are intentionally using type here, not type-1, the 0th bit may
> -	 * someday indicate that we are globally setting permissive in policy.
> -	 */
> -	rc = ebitmap_get_bit(&policydb.permissive_map, type);
> -
> -	read_unlock(&policy_rwlock);
> -	return rc;
> -}
> -
>  static int security_validtrans_handle_fail(struct context *ocontext,
>  					   struct context *ncontext,
>  					   struct context *tcontext,
> @@ -767,6 +743,10 @@ int security_compute_av(u32 ssid,
> 
>  	rc = context_struct_compute_av(scontext, tcontext, tclass,
>  				       requested, avd);
> +
> +	/* permissive domain? */
> +	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
> +	    avd->flags |= AVD_FLAGS_PERMISSIVE;
>  out:
>  	read_unlock(&policy_rwlock);
>  	return rc;
> 
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------030201080006030300040106
Content-Type: text/x-patch;
 name="libselinux-userspace-permissive-domain.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-userspace-permissive-domain.2.patch"

 Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 libselinux/include/selinux/selinux.h            |   15 ++++
 libselinux/man/man3/security_compute_av.3       |   23 ++++++-
 libselinux/man/man3/security_compute_av_flags.3 |    1 +
 libselinux/src/avc.c                            |   22 +++--
 libselinux/src/compute_av.c                     |   90 +++++++++++++++++++----
 libselinux/src/selinux_internal.h               |    2 +
 6 files changed, 128 insertions(+), 25 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index fab083e..7030f38 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -130,8 +130,12 @@ struct av_decision {
 	access_vector_t auditallow;
 	access_vector_t auditdeny;
 	unsigned int seqno;
+	unsigned int flags;
 };
 
+/* Definitions of av_decision.flags */
+#define SELINUX_AVD_FLAGS_PERMISSIVE	0x0001
+
 /* Structure for passing options, used by AVC and label subsystems */
 struct selinux_opt {
 	int type;
@@ -180,6 +184,17 @@ extern int security_compute_av_raw(security_context_t scon,
 				   access_vector_t requested,
 				   struct av_decision *avd);
 
+extern int security_compute_av_flags(security_context_t scon,
+				     security_context_t tcon,
+				     security_class_t tclass,
+				     access_vector_t requested,
+				     struct av_decision *avd);
+extern int security_compute_av_flags_raw(security_context_t scon,
+					 security_context_t tcon,
+					 security_class_t tclass,
+					 access_vector_t requested,
+					 struct av_decision *avd);
+
 /* Compute a labeling decision and set *newcon to refer to it.
    Caller must free via freecon. */
 extern int security_compute_create(security_context_t scon,
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index 885719f..e759c4b 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -1,6 +1,6 @@
 .TH "security_compute_av" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
 .SH "NAME"
-security_compute_av, security_compute_create, security_compute_relabel,
+security_compute_av, security_compute_av_flags, security_compute_create, security_compute_relabel,
 security_compute_member, security_compute_user, security_get_initial_context \- query
 the SELinux policy database in the kernel.
 
@@ -11,6 +11,8 @@ the SELinux policy database in the kernel.
 .sp
 .BI "int security_compute_av(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
+.BI "int security_compute_av_flags(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.sp
 .BI "int security_compute_create(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
 .sp
 .BI "int security_compute_relabel(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
@@ -35,6 +37,25 @@ via class
 with the
 .B requested
 access vector. See the cron source for a usage example.
+Please note that it does not set up the
+.B flags
+of
+.B av_decision
+because of binary compatibility.
+
+.B security_compute_av_flags
+provides identical functionality with
+.B security_compute_av
+expect for the
+.B flags
+of
+.B av_decision
+to be set correctly.
+Now we have only a flag:
+.B SELINUX_AVD_FLAGS_PERMISSIVE
+which means the returned
+.B av_decision
+is computed on permissive domain.
 
 .B security_compute_create
 is used to compute a context to use for labeling a new object in a particular
diff --git a/libselinux/man/man3/security_compute_av_flags.3 b/libselinux/man/man3/security_compute_av_flags.3
index e69de29..a60bca4 100644
--- a/libselinux/man/man3/security_compute_av_flags.3
+++ b/libselinux/man/man3/security_compute_av_flags.3
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 1545dd3..f0e2d33 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -849,9 +849,9 @@ int avc_has_perm_noaudit(security_id_t ssid,
 				rc = -1;
 				goto out;
 			}
-			rc = security_compute_av_raw(ssid->ctx, tsid->ctx,
-						     tclass, requested,
-						     &entry.avd);
+			rc = security_compute_av_flags_raw(ssid->ctx, tsid->ctx,
+							   tclass, requested,
+							   &entry.avd);
 			if (rc)
 				goto out;
 			rc = avc_insert(ssid, tsid, tclass, &entry, aeref);
@@ -867,11 +867,13 @@ int avc_has_perm_noaudit(security_id_t ssid,
 	denied = requested & ~(ae->avd.allowed);
 
 	if (!requested || denied) {
-		if (avc_enforcing) {
+		if (!avc_enforcing ||
+		    (ae->avd.flags & SELINUX_AVD_FLAGS_PERMISSIVE))
+			ae->avd.allowed |= requested;
+		else {
 			errno = EACCES;
 			rc = -1;
-		} else
-			ae->avd.allowed |= requested;
+		}
 	}
 
       out:
@@ -885,9 +887,11 @@ int avc_has_perm(security_id_t ssid, security_id_t tsid,
 		 security_class_t tclass, access_vector_t requested,
 		 struct avc_entry_ref *aeref, void *auditdata)
 {
-	struct av_decision avd = { 0, 0, 0, 0, 0 };
+	struct av_decision avd;
 	int errsave, rc;
 
+	memset(&avd, 0, sizeof(avd));
+
 	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, aeref, &avd);
 	errsave = errno;
 	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
@@ -917,8 +921,8 @@ int avc_compute_create(security_id_t ssid,  security_id_t tsid,
 	rc = avc_lookup(ssid, tsid, tclass, 0, &aeref);
 	if (rc) {
 		/* need to make a cache entry for this tuple */
-		rc = security_compute_av_raw(ssid->ctx, tsid->ctx,
-					     tclass, 0, &entry.avd);
+		rc = security_compute_av_flags_raw(ssid->ctx, tsid->ctx,
+						   tclass, 0, &entry.avd);
 		if (rc)
 			goto out;
 		rc = avc_insert(ssid, tsid, tclass, &entry, &aeref);
diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
index 45cd0db..a821d17 100644
--- a/libselinux/src/compute_av.c
+++ b/libselinux/src/compute_av.c
@@ -10,10 +10,11 @@
 #include "policy.h"
 #include "mapping.h"
 
-int security_compute_av_raw(security_context_t scon,
-			    security_context_t tcon,
-			    security_class_t tclass,
-			    access_vector_t requested, struct av_decision *avd)
+int security_compute_av_flags_raw(security_context_t scon,
+				  security_context_t tcon,
+				  security_class_t tclass,
+				  access_vector_t requested,
+				  struct av_decision *avd)
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -49,12 +50,15 @@ int security_compute_av_raw(security_context_t scon,
 	if (ret < 0)
 		goto out2;
 
-	if (sscanf(buf, "%x %x %x %x %u", &avd->allowed,
-		   &avd->decided, &avd->auditallow, &avd->auditdeny,
-		   &avd->seqno) != 5) {
+	ret = sscanf(buf, "%x %x %x %x %u %x",
+		     &avd->allowed, &avd->decided,
+		     &avd->auditallow, &avd->auditdeny,
+		     &avd->seqno, &avd->flags);
+	if (ret < 5) {
 		ret = -1;
 		goto out2;
-	}
+	} else if (ret < 6)
+		avd->flags = 0;
 
 	map_decision(tclass, avd);
 
@@ -66,16 +70,44 @@ int security_compute_av_raw(security_context_t scon,
 	return ret;
 }
 
-hidden_def(security_compute_av_raw)
+hidden_def(security_compute_av_flags_raw)
 
-int security_compute_av(security_context_t scon,
-			security_context_t tcon,
-			security_class_t tclass,
-			access_vector_t requested, struct av_decision *avd)
+int security_compute_av_raw(security_context_t scon,
+			    security_context_t tcon,
+			    security_class_t tclass,
+			    access_vector_t requested,
+			    struct av_decision *avd)
 {
+	struct av_decision lavd;
 	int ret;
+
+	ret = security_compute_av_flags_raw(scon, tcon, tclass,
+					    requested, &lavd);
+	if (ret == 0) {
+		avd->allowed = lavd.allowed;
+		avd->decided = lavd.decided;
+		avd->auditallow = lavd.auditallow;
+		avd->auditdeny = lavd.auditdeny;
+		avd->seqno = lavd.seqno;
+		/* NOTE:
+		 * We should not return avd->flags via the interface
+		 * due to the binary compatibility.
+		 */
+	}
+	return ret;
+}
+
+hidden_def(security_compute_av_raw)
+
+int security_compute_av_flags(security_context_t scon,
+			      security_context_t tcon,
+			      security_class_t tclass,
+			      access_vector_t requested,
+			      struct av_decision *avd)
+{
 	security_context_t rscon = scon;
 	security_context_t rtcon = tcon;
+	int ret;
 
 	if (selinux_trans_to_raw_context(scon, &rscon))
 		return -1;
@@ -83,8 +115,8 @@ int security_compute_av(security_context_t scon,
 		freecon(rscon);
 		return -1;
 	}
-
-	ret = security_compute_av_raw(rscon, rtcon, tclass, requested, avd);
+	ret = security_compute_av_flags_raw(rscon, rtcon, tclass,
+					    requested, avd);
 
 	freecon(rscon);
 	freecon(rtcon);
@@ -92,4 +124,32 @@ int security_compute_av(security_context_t scon,
 	return ret;
 }
 
+hidden_def(security_compute_av_flags)
+
+int security_compute_av(security_context_t scon,
+			security_context_t tcon,
+			security_class_t tclass,
+			access_vector_t requested, struct av_decision *avd)
+{
+	struct av_decision lavd;
+	int ret;
+
+	ret = security_compute_av_flags(scon, tcon, tclass,
+					requested, &lavd);
+	if (ret == 0)
+	{
+		avd->allowed = lavd.allowed;
+		avd->decided = lavd.decided;
+		avd->auditallow = lavd.auditallow;
+		avd->auditdeny = lavd.auditdeny;
+		avd->seqno = lavd.seqno;
+		/* NOTE:
+		 * We should not return avd->flags via the interface
+		 * due to the binary compatibility.
+		 */
+	}
+
+	return ret;
+}
+
 hidden_def(security_compute_av)
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 8b4c6d4..cfb18a5 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -16,6 +16,8 @@ hidden_proto(selinux_mkload_policy)
     hidden_proto(security_canonicalize_context_raw)
     hidden_proto(security_compute_av)
     hidden_proto(security_compute_av_raw)
+    hidden_proto(security_compute_av_flags)
+    hidden_proto(security_compute_av_flags_raw)
     hidden_proto(security_compute_user)
     hidden_proto(security_compute_user_raw)
     hidden_proto(security_compute_create)

--------------030201080006030300040106--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
