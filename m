Subject: [PATCH] SELinux: one little, two little, three little whitespaces,
	the avc.c saga.
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Thu, 17 Apr 2008 14:42:10 -0400
Message-Id: <1208457730.2985.39.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc.c was bad.  It had whitespace and syntax issues which are against
our coding style.  I have had a little chat with it and the result of
that conversation looked like this patch.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/avc.c |   56 ++++++++++++++++++++++++------------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index a628e11..1d69f66 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -2,16 +2,16 @@
  * Implementation of the kernel access vector cache (AVC).
  *
  * Authors:  Stephen Smalley, <sds@epoch.ncsc.mil>
- *           James Morris <jmorris@redhat.com>
+ *	     James Morris <jmorris@redhat.com>
  *
  * Update:   KaiGai, Kohei <kaigai@ak.jp.nec.com>
- *     Replaced the avc_lock spinlock by RCU.
+ *	Replaced the avc_lock spinlock by RCU.
  *
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License version 2,
- *      as published by the Free Software Foundation.
+ *	as published by the Free Software Foundation.
  */
 #include <linux/types.h>
 #include <linux/stddef.h>
@@ -44,7 +44,7 @@ static const char *class_to_string[] = {
 #undef S_
 };
 
-#define TB_(s) static const char * s [] = {
+#define TB_(s) static const char *s[] = {
 #define TE_(s) };
 #define S_(s) s,
 #include "common_perm_to_string.h"
@@ -72,7 +72,7 @@ const struct selinux_class_perm selinux_class_perm = {
 #define AVC_CACHE_RECLAIM		16
 
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
-#define avc_cache_stats_incr(field) 				\
+#define avc_cache_stats_incr(field)				\
 do {								\
 	per_cpu(avc_cache_stats, get_cpu()).field++;		\
 	put_cpu();						\
@@ -92,7 +92,7 @@ struct avc_entry {
 struct avc_node {
 	struct avc_entry	ae;
 	struct list_head	list;
-	struct rcu_head         rhead;
+	struct rcu_head		rhead;
 };
 
 struct avc_cache {
@@ -105,8 +105,8 @@ struct avc_cache {
 
 struct avc_callback_node {
 	int (*callback) (u32 event, u32 ssid, u32 tsid,
-	                 u16 tclass, u32 perms,
-	                 u32 *out_retained);
+			 u16 tclass, u32 perms,
+			 u32 *out_retained);
 	u32 events;
 	u32 ssid;
 	u32 tsid;
@@ -202,7 +202,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
 	char *scontext;
 	u32 scontext_len;
 
- 	rc = security_sid_to_context(ssid, &scontext, &scontext_len);
+	rc = security_sid_to_context(ssid, &scontext, &scontext_len);
 	if (rc)
 		audit_log_format(ab, "ssid=%d", ssid);
 	else {
@@ -306,7 +306,7 @@ static inline int avc_reclaim_node(void)
 	int hvalue, try, ecx;
 	unsigned long flags;
 
-	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++ ) {
+	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++) {
 		hvalue = atomic_inc_return(&avc_cache.lru_hint) & (AVC_CACHE_SLOTS - 1);
 
 		if (!spin_trylock_irqsave(&avc_cache.slots_lock[hvalue], flags))
@@ -475,7 +475,7 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct avc_en
 			if (pos->ae.ssid == ssid &&
 			    pos->ae.tsid == tsid &&
 			    pos->ae.tclass == tclass) {
-			    	avc_node_replace(node, pos);
+				avc_node_replace(node, pos);
 				goto found;
 			}
 		}
@@ -526,8 +526,8 @@ static inline void avc_print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
  * before calling the auditing code.
  */
 void avc_audit(u32 ssid, u32 tsid,
-               u16 tclass, u32 requested,
-               struct av_decision *avd, int result, struct avc_audit_data *a)
+	       u16 tclass, u32 requested,
+	       struct av_decision *avd, int result, struct avc_audit_data *a)
 {
 	struct task_struct *tsk = current;
 	struct inode *inode = NULL;
@@ -541,7 +541,7 @@ void avc_audit(u32 ssid, u32 tsid,
 			return;
 	} else if (result) {
 		audited = denied = requested;
-        } else {
+	} else {
 		audited = requested;
 		if (!(audited & avd->auditallow))
 			return;
@@ -551,7 +551,7 @@ void avc_audit(u32 ssid, u32 tsid,
 	if (!ab)
 		return;		/* audit_panic has been called */
 	audit_log_format(ab, "avc:  %s ", denied ? "denied" : "granted");
-	avc_dump_av(ab, tclass,audited);
+	avc_dump_av(ab, tclass, audited);
 	audit_log_format(ab, " for ");
 	if (a && a->tsk)
 		tsk = a->tsk;
@@ -647,7 +647,7 @@ void avc_audit(u32 ssid, u32 tsid,
 					break;
 				}
 			}
-			
+
 			switch (a->u.net.family) {
 			case AF_INET:
 				avc_print_ipv4_addr(ab, a->u.net.v4info.saddr,
@@ -702,10 +702,10 @@ void avc_audit(u32 ssid, u32 tsid,
  * -%ENOMEM if insufficient memory exists to add the callback.
  */
 int avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
-                                     u16 tclass, u32 perms,
-                                     u32 *out_retained),
-                     u32 events, u32 ssid, u32 tsid,
-                     u16 tclass, u32 perms)
+				     u16 tclass, u32 perms,
+				     u32 *out_retained),
+		     u32 events, u32 ssid, u32 tsid,
+		     u16 tclass, u32 perms)
 {
 	struct avc_callback_node *c;
 	int rc = 0;
@@ -759,10 +759,10 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass)
 	hvalue = avc_hash(ssid, tsid, tclass);
 	spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
 
-	list_for_each_entry(pos, &avc_cache.slots[hvalue], list){
-		if ( ssid==pos->ae.ssid &&
-		     tsid==pos->ae.tsid &&
-		     tclass==pos->ae.tclass ){
+	list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {
+		if (ssid == pos->ae.ssid &&
+		    tsid == pos->ae.tsid &&
+		    tclass == pos->ae.tclass){
 			orig = pos;
 			break;
 		}
@@ -829,7 +829,7 @@ int avc_ss_reset(u32 seqno)
 	for (c = avc_callbacks; c; c = c->next) {
 		if (c->events & AVC_CALLBACK_RESET) {
 			tmprc = c->callback(AVC_CALLBACK_RESET,
-			                    0, 0, 0, 0, NULL);
+					    0, 0, 0, 0, NULL);
 			/* save the first error encountered for the return
 			   value and continue processing the callbacks */
 			if (!rc)
@@ -878,11 +878,11 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	node = avc_lookup(ssid, tsid, tclass, requested);
 	if (!node) {
 		rcu_read_unlock();
-		rc = security_compute_av(ssid,tsid,tclass,requested,&entry.avd);
+		rc = security_compute_av(ssid, tsid, tclass, requested, &entry.avd);
 		if (rc)
 			goto out;
 		rcu_read_lock();
-		node = avc_insert(ssid,tsid,tclass,&entry);
+		node = avc_insert(ssid, tsid, tclass, &entry);
 	}
 
 	p_ae = node ? &node->ae : &entry;
@@ -924,7 +924,7 @@ out:
  * another -errno upon other errors.
  */
 int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
-                 u32 requested, struct avc_audit_data *auditdata)
+		 u32 requested, struct avc_audit_data *auditdata)
 {
 	struct av_decision avd;
 	int rc;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
