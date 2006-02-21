Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1M00SL8014466
	for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2006 19:00:28 -0500
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1M00PSL024026
	for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2006 00:00:25 GMT
Message-ID: <43FBA962.5090904@trustedcs.com>
Date: Tue, 21 Feb 2006 17:59:30 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        Dustin Kirkland <dustin.kirkland@us.ibm.com>,
        Amy Griffis <amy.griffis@hp.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH] context based audit filtering (take 3)
References: <43F49805.2000109@trustedcs.com> <43FB86DD.2020708@trustedcs.com>
In-Reply-To: <43FB86DD.2020708@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:
...snip...
> The outstanding things I can think of are:
> 
> 1) Add role <, >, <=, and >= operations.
> 2) Implement the callback function in the audit code.  I have a functional
>   version that does not follow proper locking - I just need to get that
>   cleaned up.
> 3) Update Dustin's work to the latest API.  I already did this along with
>   my start at #2.  I'll post that all in a follow-up.

The updated version of Dustin's patch I referred to is below.  The changes are
are follows:

- Add the se_str char * to the audit_field.  This stores a copy of the string
  target that the rule is based on.  This is needed for the audit_compare_rule
  addition (below).  It will also be used in the callback for policy reloads
  (also below).  This is managed along with the se_rule field.  This also gets
  rid of a memory leak where the unpacked string was not being freed.
- printk a warning and ignore invalid selinux rules (but still hang on to them
  so they may be activated with a later policy reload).
- Change audit_compare_rule to compare the string values of the selinux rules
  to see if the rule exists.  Previously, it thought that any selinux filters
  based on equal length string were equal.
- Change audit_krule_to_data to put in the string target of the rule for the
  selinux filters.  This will hopefully allow the display of the type, level,
  etc. when dumping rules via AUDIT_LIST_RULES (I'll test tommorrow).
- Add a selinux callback for re-initializing the se_rule field when there is
  a policy reload.  THIS NEEDS WORK - It doesn't obey proper locking yet, but
  it is functional.  I need to get my head around the locking of the audit
  structures a little better - I'll also take suggestions ;)
- Obtain the sid of the task in audit_filter_rules instead of the callers
  obtaining it and passing it in.


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
index 3712295..306e941 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/netlink.h>
+#include <linux/selinux.h>
 #include "audit.h"
 
 /* There are three lists of rules -- one to search at task creation
@@ -50,6 +51,12 @@ static inline void audit_free_watch(stru
 
 static inline void audit_free_rule(struct audit_entry *e)
 {
+	int i;
+	for (i = 0; i < e->rule.field_count; i++) {
+		struct audit_field *f = &e->rule.fields[i];
+		kfree(f->se_str);
+		selinux_audit_rule_free(f->se_rule);
+	}
 	kfree(e->rule.fields);
 	kfree(e);
 }
@@ -222,7 +229,7 @@ static struct audit_entry *audit_data_to
 	void *bufp;
 	size_t remain = datasz - sizeof(struct audit_rule_data);
 	int i;
-	char *path;
+	char *str;
 
 	entry = audit_to_entry_common((struct audit_rule *)data);
 	if (IS_ERR(entry))
@@ -241,16 +248,40 @@ static struct audit_entry *audit_data_to
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
@@ -333,6 +364,15 @@ static struct audit_rule_data *audit_kru
 			data->buflen += data->values[i] =
 				audit_pack_string(&bufp, krule->watch->path);
 			break;
+		case AUDIT_SE_USER:
+		case AUDIT_SE_ROLE:
+		case AUDIT_SE_TYPE:
+		case AUDIT_SE_SEN:
+		case AUDIT_SE_CLR:
+			data->buflen += data->values[i] =
+				audit_pack_string(&bufp,
+				                  krule->fields[i].se_str);
+			break;
 		default:
 			data->values[i] = f->val;
 		}
@@ -370,6 +410,14 @@ static int audit_compare_rule(struct aud
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
@@ -640,6 +688,9 @@ int audit_comparator(const u32 left, con
 	default:
 		return -EINVAL;
 	}
+	/* should NEVER get here */
+	BUG();
+	return 0;
 }
 
 
@@ -726,3 +777,45 @@ unlock_and_return:
 	rcu_read_unlock();
 	return result;
 }
+
+static int selinux_callback(void)
+{
+	struct audit_entry *entry;
+	int i, j, err = 0;
+
+	/* TODO: add proper locking. */
+	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
+		list_for_each_entry(entry, &audit_filter_list[i], list) {
+			for (j = 0; j < entry->rule.field_count; j++) {
+				struct audit_field *f = &entry->rule.fields[j];
+				switch (f->type) {
+				case AUDIT_SE_USER:
+				case AUDIT_SE_ROLE:
+				case AUDIT_SE_TYPE:
+				case AUDIT_SE_SEN:
+				case AUDIT_SE_CLR:
+					selinux_audit_rule_free(f->se_rule);
+					err = selinux_audit_rule_init(f->type,
+					         f->op, f->se_str, &f->se_rule);
+					if (err == -EINVAL) {
+						printk(KERN_WARNING "selinux audit rule for item %s is invalid\n", f->se_str);
+						err = 0;
+					}
+					if (err)
+						goto out;
+				}
+			}
+		}
+	}
+
+out:
+	return err;
+}
+
+static int __init register_selinux_callback(void)
+{
+	selinux_audit_set_callback(&selinux_callback);
+	return 0;
+}
+__initcall(register_selinux_callback);
+
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index cd83289..c52c80a 100644
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
@@ -258,6 +262,18 @@ static int audit_filter_rules(struct tas
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
+			   may be wanted. */
+			result = selinux_audit_rule_match(sid, f->type, f->op,
+			                                  f->se_rule);
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
