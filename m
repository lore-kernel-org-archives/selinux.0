Message-ID: <43FF8805.2050606@trustedcs.com>
Date: Fri, 24 Feb 2006 16:26:13 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: Dustin Kirkland <dustin.kirkland@us.ibm.com>,
        Amy Griffis <amy.griffis@hp.com>, Steve Grubb <sgrubb@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Linux Audit Discussion <linux-audit@redhat.com>
Subject: Re: [PATCH] support for context based audit filtering
References: <43F49805.2000109@trustedcs.com>	 <43FB86DD.2020708@trustedcs.com>		<1140619592.31467.218.camel@moss-spartans.epoch.ncsc.mil>		<43FDF3EC.7000303@trustedcs.com>	<1140787657.21179.143.camel@moss-spartans.epoch.ncsc.mil> <43FF7E25.5040002@trustedcs.com>
In-Reply-To: <43FF7E25.5040002@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:
<snip>
> The following patch provides selinux interfaces that will allow the audit
> system to perform filtering based on the process context (user, role, type,
> sensitivity, and clearance).  These interfaces will allow the selinux
> module to perform efficient matches based on lower level selinux 
> constructs,
> rather than relying on context retrievals and string comparisons within
> the audit module.  It also allows for dominance checks on the mls portion
> of the contexts that are impossible with only string comparisons.
> 

I have updated the audit portion of the patch to match up with this latest selinux
patch.

The last update to that patch was here:
http://marc.theaimsgroup.com/?l=selinux&m=114056729028852&w=2

I have also reworked the update procedure of the se_rule fields to hopefully be
in line with the requirement of RCU.  Consider this portion of the patch for
*testing only*.  The other portions of the patch seem good to me so far.

--

diff --git a/kernel/audit.h b/kernel/audit.h
index eb33354..3ffc70a 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -59,9 +59,11 @@ struct audit_watch {
 };
 
 struct audit_field {
-	u32			type;
-	u32			val;
-	u32			op;
+	u32				type;
+	u32				val;
+	u32				op;
+	char				*se_str;
+	struct selinux_audit_rule	*se_rule;
 };
 
 struct audit_krule {
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 3712295..752e2bb 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/netlink.h>
+#include <linux/selinux.h>
 #include "audit.h"
 
 /* There are three lists of rules -- one to search at task creation
@@ -50,6 +51,13 @@ static inline void audit_free_watch(stru
 
 static inline void audit_free_rule(struct audit_entry *e)
 {
+	int i;
+	if (e->rule.fields)
+		for (i = 0; i < e->rule.field_count; i++) {
+			struct audit_field *f = &e->rule.fields[i];
+			kfree(f->se_str);
+			selinux_audit_rule_free(f->se_rule);
+		}
 	kfree(e->rule.fields);
 	kfree(e);
 }
@@ -192,7 +200,12 @@ static struct audit_entry *audit_rule_to
 		f->val = rule->values[i];
 
 		if (f->type & AUDIT_UNUSED_BITS ||
-		    f->type == AUDIT_WATCH) {
+		    f->type == AUDIT_WATCH ||
+		    f->type == AUDIT_SE_USER ||
+		    f->type == AUDIT_SE_ROLE ||
+		    f->type == AUDIT_SE_TYPE ||
+		    f->type == AUDIT_SE_SEN ||
+		    f->type == AUDIT_SE_CLR) {
 			err = -EINVAL;
 			goto exit_free;
 		}
@@ -222,7 +235,7 @@ static struct audit_entry *audit_data_to
 	void *bufp;
 	size_t remain = datasz - sizeof(struct audit_rule_data);
 	int i;
-	char *path;
+	char *str;
 
 	entry = audit_to_entry_common((struct audit_rule *)data);
 	if (IS_ERR(entry))
@@ -241,16 +254,42 @@ static struct audit_entry *audit_data_to
 		f->op = data->fieldflags[i] & AUDIT_OPERATORS;
 		f->type = data->fields[i];
 		f->val = data->values[i];
+		f->se_str = NULL;
+		f->se_rule = NULL;
 		switch(f->type) {
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			str = audit_unpack_string(&bufp, &remain, f->val);
+			if (IS_ERR(str))
+				goto exit_free;
+			entry->rule.buflen += f->val;
+
+			err = selinux_audit_rule_init(f->type, f->op, str,
+			                              &f->se_rule);
+			/* Keep currently invalid fields around in case they
+			   become valid after a policy reload. */
+			if (err == -EINVAL) {
+				printk(KERN_WARNING "selinux audit rule for item %s is invalid\n", str);
+				err = 0;
+			}
+			if (err) {
+				kfree(str);
+				goto exit_free;
+			} else
+				f->se_str = str;
+			break;
 		case AUDIT_WATCH:
-			path = audit_unpack_string(&bufp, &remain, f->val);
-			if (IS_ERR(path))
+			str = audit_unpack_string(&bufp, &remain, f->val);
+			if (IS_ERR(str))
 				goto exit_free;
 			entry->rule.buflen += f->val;
 
-			err = audit_to_watch(path, &entry->rule, i);
+			err = audit_to_watch(str, &entry->rule, i);
 			if (err) {
-				kfree(path);
+				kfree(str);
 				goto exit_free;
 			}
 			break;
@@ -333,6 +372,14 @@ static struct audit_rule_data *audit_kru
 			data->buflen += data->values[i] =
 				audit_pack_string(&bufp, krule->watch->path);
 			break;
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			data->buflen += data->values[i] =
+				audit_pack_string(&bufp, f->se_str);
+			break;
 		default:
 			data->values[i] = f->val;
 		}
@@ -370,6 +417,14 @@ static int audit_compare_rule(struct aud
 			if (audit_compare_watch(a->watch, b->watch))
 				return 1;
 			break;
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			if (strcmp(a->fields[i].se_str, b->fields[i].se_str))
+				return 1;
+			break;
 		default:
 			if (a->fields[i].val != b->fields[i].val)
 				return 1;
@@ -640,6 +695,9 @@ int audit_comparator(const u32 left, con
 	default:
 		return -EINVAL;
 	}
+	/* should NEVER get here */
+	BUG();
+	return 0;
 }
 
 
@@ -726,3 +784,143 @@ unlock_and_return:
 	rcu_read_unlock();
 	return result;
 }
+
+/* Check to see if the rule contains any selinux fields.  Returns 1 if there
+   are selinux fields specified in the rule, 0 otherwise. */
+static inline int audit_rule_has_selinux(struct audit_krule *rule)
+{
+	int i;
+
+	for (i = 0; i < rule->field_count; i++) {
+		struct audit_field *f = &rule->fields[i];
+		switch (f->type) {
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/* Make a copy of src in dest.  This will be a deep copy with the exception
+   of the watch - that pointer is carried over.  The selinux specific fields
+   will be updated in the copy.  The point is to be able to replace the src
+   rule with the dest rule in the list, then free the dest rule. */
+static inline int selinux_audit_rule_update_helper(struct audit_krule *dest,
+                                                   struct audit_krule *src)
+{
+	int i, err = 0;
+
+	dest->vers_ops = src->vers_ops;
+	dest->flags = src->flags;
+	dest->listnr = src->listnr;
+	dest->action = src->action;
+	for (i = 0; i < AUDIT_BITMASK_SIZE; i++)
+		dest->mask[i] = src->mask[i];
+	dest->buflen = src->buflen;
+	dest->field_count = src->field_count;
+
+	/* deep copy this information, updating the se_rule fields, because
+	   the originals will all be freed when the old rule is freed. */
+	dest->fields = kzalloc(sizeof(struct audit_field) * dest->field_count,
+	                       GFP_ATOMIC);
+	if (!dest->fields)
+		return -ENOMEM;
+	memcpy(dest->fields, src->fields,
+	       sizeof(struct audit_field) * dest->field_count);
+	for (i = 0; i < dest->field_count; i++) {
+		struct audit_field *df = &dest->fields[i];
+		struct audit_field *sf = &src->fields[i];
+		switch (df->type) {
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			/* our own copy of se_str */
+			df->se_str = kstrdup(sf->se_str, GFP_ATOMIC);
+			/* our own (refreshed) copy of se_rule */
+			err = selinux_audit_rule_init(df->type, df->op,
+			                              df->se_str, &df->se_rule);
+			/* Keep currently invalid fields around in case they
+			   become valid after a policy reload. */
+			if (err == -EINVAL) {
+				printk(KERN_WARNING "selinux audit rule for item %s is invalid\n", df->se_str);
+				err = 0;
+			}
+			if (err)
+				return err;
+		}
+	}
+
+	/* we can shallow copy the watch because we will not be freeing it via
+	   selinux_audit_rule_update (and we do nto modify it) */
+	dest->watch = src->watch;
+	dest->rlist = src->rlist;
+
+	return 0;
+}
+
+/* This function will re-initialize the se_rule field of all applicable rules.
+   It will traverse the filter lists serarching for rules that contain selinux
+   specific filter fields.  When such a rule is found, it is copied, the
+   selinux field is re-initialized, and the old rule is replaced with the
+   updated rule. */
+/* XXX: is the error handling below appropriate */
+static int selinux_audit_rule_update(void)
+{
+	struct audit_entry *entry, *nentry;
+	int i, err = 0, tmperr;
+
+	/* audit_netlink_sem synchronizes the writers */
+	down(&audit_netlink_sem);
+
+	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
+		list_for_each_entry(entry, &audit_filter_list[i], list) {
+			if (!audit_rule_has_selinux(&entry->rule))
+				continue;
+
+			nentry = kmalloc(sizeof(*entry), GFP_ATOMIC);
+			if (!nentry) {
+				/* save the first error encountered for the
+				   return value */
+				if (!err)
+					err = -ENOMEM;
+				audit_panic("error updating selinux filters");
+				continue;
+			}
+
+			tmperr = selinux_audit_rule_update_helper(&nentry->rule,
+			                                          &entry->rule);
+			if (!nentry) {
+				/* save the first error encountered for the
+				   return value */
+				if (!err)
+					err = -ENOMEM;
+				audit_free_rule(nentry);
+				audit_panic("error updating selinux filters");
+				continue;
+			}
+			list_replace_rcu(&entry->list, &nentry->list);
+			call_rcu(&entry->rcu, audit_free_rule_rcu);
+		}
+	}
+
+	up(&audit_netlink_sem);
+
+	return err;
+}
+
+/* Register the callback with selinux.  This callback will be invoked when a
+   new policy is loaded. */
+static int __init register_selinux_update_callback(void)
+{
+	selinux_audit_set_callback(&selinux_audit_rule_update);
+	return 0;
+}
+__initcall(register_selinux_update_callback);
+
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index cd83289..f117563 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -58,6 +58,7 @@
 #include <linux/security.h>
 #include <linux/list.h>
 #include <linux/tty.h>
+#include <linux/selinux.h>
 
 #include "audit.h"
 
@@ -168,6 +169,9 @@ static int audit_filter_rules(struct tas
 			      enum audit_state *state)
 {
 	int i, j;
+	u32 sid;
+
+	selinux_task_ctxid(tsk, &sid);
 
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
@@ -258,6 +262,22 @@ static int audit_filter_rules(struct tas
 			if (ctx)
 				result = audit_comparator(ctx->loginuid, f->op, f->val);
 			break;
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			/* NOTE: this may return negative values indicating
+			   a temporary error.  We simply treat this as a
+			   match for now to avoid losing information that
+			   may be wanted.   An error message will also be
+			   logged upon error */
+			if (f->se_rule)
+				result = selinux_audit_rule_match(sid, f->type,
+				                                  f->op,
+				                                  f->se_rule,
+				                                  ctx);
+			break;
 		case AUDIT_ARG0:
 		case AUDIT_ARG1:
 		case AUDIT_ARG2:


-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
