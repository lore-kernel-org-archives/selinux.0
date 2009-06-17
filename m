Message-ID: <4A38727F.7090705@ak.jp.nec.com>
Date: Wed, 17 Jun 2009 13:35:11 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Steve Grubb <sgrubb@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, jdennis@redhat.com
Subject: Re: type bounds audit messages
References: <1244730288.10762.120.camel@localhost.localdomain>	 <200906161040.52279.sgrubb@redhat.com>	 <1245164133.2848.12.camel@localhost.localdomain>	 <200906161123.52932.sgrubb@redhat.com> <1245166869.2848.21.camel@localhost.localdomain>
In-Reply-To: <1245166869.2848.21.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Summary of opinions:
- SELINUX_INFO is good, because it is a new audit message type (Eric).
  But it is not unclear whether the most descriptive type name, or not (Steve).
- The { ... } style is not preferable, comma separated permissions list
  is better (Eric).
- The <name>=<value> style is more excellent (Dan).
- The quoted strung should be limited to describe untrusted strings (Steve).
- AVC denials also should use SELINUX_INFO with new style (Dan).
  - It describes an internal inconsistency within the policy, not AVC (Stephen).

Please tell me, if I missed your opinions.

I fixed the message format as follows:
("UNKNOWN[1418]" is AUDIT_SELINUX_INFO newly defined.)

  type=UNKNOWN[1418] msg=audit(1245207615.589:70):      \
      op=security_compute_av masked=bounds              \
      scontext=system_u:system_r:user_webapp_t:s0       \
      tcontext=system_u:object_r:shadow_t:s0:c0         \
      tclass=file perms=getattr,open

However, I think Stephen pointed out a significant thing.

Some of permissions are masked at runtime during security_compute_av()
due to RBAC, Constraint, MLS and Type bounds, although TE allows them.
It's not clear for me whether it should be considered as an error
(SELINUX_ERR) because of an internal inconsistency within the policy,
or should be considered as just an information (SELINUX_INFO) from
the kernel.

--------
[PATCH] Add audit messages for masked SELinux permissions

The following patch adds a few audit messages,
 1. when a multithread process switch its performing domain to unbounded
    one, and the hardwired rule prevent it.

  type=SELINUX_ERR msg=audit(1245207506.618:62):        \
      security_bounded_transition: denied for           \
      oldcontext=system_u:system_r:httpd_t:s0           \
      newcontext=system_u:system_r:guest_webapp_t:s0

 2. when RBAC, MLS/Constraints and Type bounds masks permissions allowed
    with TE rules on security_compute_av().

  * BRAC prevent domain transition
  type=UNKNOWN[1418] msg=audit(1245207539.227:67):      \
      op=security_compute_av masked=rbac                \
      scontext=unconfined_u:unconfined_r:unconfined_t:s0    \
      tcontext=staff_u:staff_r:staff_t:s0               \
      tclass=process perms=transition

  * MCS prevent accesses to *:s0:c0 by *:s0
  type=UNKNOWN[1418] msg=audit(1245212024.689:39):      \
      op=security_compute_av masked=constraint          \
      scontext=system_u:system_r:user_webapp_t:s0       \
      tcontext=system_u:object_r:shadow_t:s0:c0         \
      tclass=file perms=ioctl,read,write,create,setattr,lock,append,unlink,link,rename

  * Then, type bounds prevents accesses to shadow_t
  type=UNKNOWN[1418] msg=audit(1245212024.689:39):      \
      op=security_compute_av masked=bounds              \
      scontext=system_u:system_r:user_webapp_t:s0       \
      tcontext=system_u:object_r:shadow_t:s0:c0         \
      tclass=file perms=getattr,open

 Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
--
 include/linux/audit.h          |    1 +
 security/selinux/avc.c         |    2 +-
 security/selinux/include/avc.h |    3 -
 security/selinux/ss/services.c |  161 ++++++++++++++++++++++++++++++++++------
 4 files changed, 141 insertions(+), 26 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 4fa2810..6de6ef3 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -121,6 +121,7 @@
 #define AUDIT_MAC_IPSEC_EVENT	1415	/* Audit an IPSec event */
 #define AUDIT_MAC_UNLBL_STCADD	1416	/* NetLabel: add a static label */
 #define AUDIT_MAC_UNLBL_STCDEL	1417	/* NetLabel: del a static label */
+#define AUDIT_SELINUX_INFO	1418	/* Notifications from SE Linux */

 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 7f9b5fa..4bf5d08 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -137,7 +137,7 @@ static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
  * @tclass: target security class
  * @av: access vector
  */
-void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
+static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
 {
 	const char **common_pts = NULL;
 	u32 common_base = 0;
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index d12ff1a..46a940d 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -127,9 +127,6 @@ int avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
 		     u32 events, u32 ssid, u32 tsid,
 		     u16 tclass, u32 perms);

-/* Shows permission in human readable form */
-void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av);
-
 /* Exported to selinuxfs */
 int avc_get_hash_stats(char *page);
 extern unsigned int avc_cache_threshold;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index deeec6c..5b19fd3 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -22,6 +22,11 @@
  *
  *  Added validation of kernel classes and permissions
  *
+ * Updated: KaiGai Kohei <kaigai@ak.jp.nec.com>
+ *
+ *  Added support for bounds domain and audit messaged on masked permissions
+ *
+ * Copyright (C) 2008, 2009 NEC Corporation
  * Copyright (C) 2006, 2007 Hewlett-Packard Development Company, L.P.
  * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2004, 2006 Tresys Technology, LLC
@@ -279,6 +284,98 @@ mls_ops:
 }

 /*
+ * security_dump_masked_av - dumps masked permissions during
+ * security_compute_av due to RBAC, MLS/Constraint and Type bounds.
+ */
+static int dump_masked_av_helper(void *k, void *d, void *args)
+{
+	struct perm_datum *pdatum = d;
+	char **permission_names = args;
+
+	BUG_ON(pdatum->value < 1 || pdatum->value > 32);
+
+	permission_names[pdatum->value - 1] = (char *)k;
+
+	return 0;
+}
+
+static void security_dump_masked_av(struct context *scontext,
+				    struct context *tcontext,
+				    u16 tclass,
+				    u32 permissions,
+				    const char *reason)
+{
+	struct common_datum *common_dat;
+	struct class_datum *tclass_dat;
+	struct audit_buffer *ab;
+	char *tclass_name;
+	char *scontext_name;
+	char *tcontext_name;
+	char *permission_names[32];
+	int index, length;
+	bool need_comma = false;
+
+	if (!permissions)
+		return;
+
+	tclass_name = policydb.p_class_val_to_name[tclass - 1];
+	tclass_dat = policydb.class_val_to_struct[tclass - 1];
+	common_dat = tclass_dat->comdatum;
+
+	/* init permission_names */
+	if (common_dat) {
+		if (hashtab_map(common_dat->permissions.table,
+				dump_masked_av_helper, permission_names) < 0)
+			goto out0;
+	}
+	if (hashtab_map(tclass_dat->permissions.table,
+			dump_masked_av_helper, permission_names) < 0)
+		goto out0;
+
+	/* get scontext/tcontext in text form */
+	if (context_struct_to_string(scontext,
+				     &scontext_name, &length) < 0)
+		goto out0;
+
+	if (context_struct_to_string(tcontext,
+				     &tcontext_name, &length) < 0)
+		goto out1;
+
+	/* audit a message */
+	ab = audit_log_start(current->audit_context,
+			     GFP_ATOMIC, AUDIT_SELINUX_INFO);
+	if (!ab)
+		goto out2;
+
+	audit_log_format(ab,
+			 "op=security_compute_av masked=%s "
+			 "scontext=%s tcontext=%s tclass=%s perms=",
+			 reason, scontext_name, tcontext_name, tclass_name);
+
+	for (index = 0; index < 32; index++) {
+		u32 mask = (1 << index);
+
+		if ((mask & permissions) == 0)
+			continue;
+
+		audit_log_format(ab, "%s%s",
+				 need_comma ? "," : "",
+				 permission_names[index]
+				 ? permission_names[index] : "????");
+		need_comma = true;
+	}
+	audit_log_end(ab);
+
+	/* release scontext/tcontext */
+out2:
+	kfree(tcontext_name);
+out1:
+	kfree(scontext_name);
+out0:
+	return;
+}
+
+/*
  * security_boundary_permission - drops violated permissions
  * on boundary constraint.
  */
@@ -347,28 +444,12 @@ static void type_attribute_bounds_av(struct context *scontext,
 	}

 	if (masked) {
-		struct audit_buffer *ab;
-		char *stype_name
-			= policydb.p_type_val_to_name[source->value - 1];
-		char *ttype_name
-			= policydb.p_type_val_to_name[target->value - 1];
-		char *tclass_name
-			= policydb.p_class_val_to_name[tclass - 1];
-
 		/* mask violated permissions */
 		avd->allowed &= ~masked;

-		/* notice to userspace via audit message */
-		ab = audit_log_start(current->audit_context,
-				     GFP_ATOMIC, AUDIT_SELINUX_ERR);
-		if (!ab)
-			return;
-
-		audit_log_format(ab, "av boundary violation: "
-				 "source=%s target=%s tclass=%s",
-				 stype_name, ttype_name, tclass_name);
-		avc_dump_av(ab, tclass, masked);
-		audit_log_end(ab);
+		/* audit masked permissions */
+		security_dump_masked_av(scontext, tcontext,
+					tclass, masked, "bounds");
 	}
 }

@@ -391,6 +472,7 @@ static int context_struct_compute_av(struct context *scontext,
 	struct ebitmap_node *snode, *tnode;
 	const struct selinux_class_perm *kdefs = &selinux_class_perm;
 	unsigned int i, j;
+	u32 masked;

 	/*
 	 * Remap extended Netlink classes for old policy versions.
@@ -475,15 +557,20 @@ static int context_struct_compute_av(struct context *scontext,
 	 * the MLS policy).
 	 */
 	constraint = tclass_datum->constraints;
+	masked = 0;
 	while (constraint) {
 		if ((constraint->permissions & (avd->allowed)) &&
 		    !constraint_expr_eval(scontext, tcontext, NULL,
 					  constraint->expr)) {
+			masked |= (avd->allowed & constraint->permissions);
 			avd->allowed = (avd->allowed) & ~(constraint->permissions);
 		}
 		constraint = constraint->next;
 	}

+	if (masked)
+		security_dump_masked_av(scontext, tcontext,
+					tclass, masked, "constraint");
 	/*
 	 * If checking process transition permission and the
 	 * role is changing, then check the (current_role, new_role)
@@ -497,9 +584,15 @@ static int context_struct_compute_av(struct context *scontext,
 			    tcontext->role == ra->new_role)
 				break;
 		}
-		if (!ra)
-			avd->allowed = (avd->allowed) & ~(PROCESS__TRANSITION |
-							PROCESS__DYNTRANSITION);
+		if (!ra) {
+			masked = avd->allowed & (PROCESS__TRANSITION |
+						 PROCESS__DYNTRANSITION);
+			avd->allowed &= ~(PROCESS__TRANSITION |
+					  PROCESS__DYNTRANSITION);
+			if (masked)
+				security_dump_masked_av(scontext, tcontext,
+							tclass, masked, "rbac");
+		}
 	}

 	/*
@@ -711,6 +804,30 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 		}
 		index = type->bounds;
 	}
+
+	if (rc) {
+		char *old_name;
+		char *new_name;
+		int length;
+
+		if (context_struct_to_string(old_context,
+					     &old_name, &length) < 0)
+			goto out;
+		if (context_struct_to_string(new_context,
+					     &new_name, &length) < 0) {
+			kfree(old_name);
+			goto out;
+		}
+
+		audit_log(current->audit_context,
+			  GFP_ATOMIC, AUDIT_SELINUX_ERR,
+			  "security_bounded_transition: denied for "
+			  "oldcontext=%s newcontext=%s",
+			  old_name, new_name);
+
+		kfree(new_name);
+		kfree(old_name);
+	}
 out:
 	read_unlock(&policy_rwlock);


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
