Subject: Re: [PATCH RETRY 2/3] Optionally expand neverallows
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com, jmowery@tresys.com
In-Reply-To: <1153944945.11769.194.camel@moss-spartans.epoch.ncsc.mil>
References: <1153937503.5393.6.camel@twoface>
	 <1153944945.11769.194.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 14:34:01 -0400
Message-Id: <1154025241.10023.3.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-07-26 at 16:15 -0400, Stephen Smalley wrote:

> I don't see any occurrences of AVRULE_AV by itself after this patch,
> so
> why wouldn't you just fold AVRULE_NEVERALLOW into it?  We don't need
> to
> preserve interface for static users of the library.

ok, applies on top of the prior patch

Index: trunk/libsepol/include/sepol/policydb/policydb.h
===================================================================
--- trunk/libsepol/include/sepol/policydb/policydb.h	(revision 1000)
+++ trunk/libsepol/include/sepol/policydb/policydb.h	(working copy)
@@ -194,12 +194,12 @@
 #define AVRULE_AUDITALLOW  2
 #define AVRULE_AUDITDENY   4
 #define AVRULE_DONTAUDIT   8
-#define AVRULE_AV         (AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_AUDITDENY | AVRULE_DONTAUDIT)
+#define AVRULE_NEVERALLOW 128
+#define AVRULE_AV         (AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_AUDITDENY | AVRULE_DONTAUDIT | AVRULE_NEVERALLOW)
 #define AVRULE_TRANSITION 16
 #define AVRULE_MEMBER     32
 #define AVRULE_CHANGE     64
 #define AVRULE_TYPE       (AVRULE_TRANSITION | AVRULE_MEMBER | AVRULE_CHANGE)
-#define AVRULE_NEVERALLOW 128
 	uint32_t specified;
 #define RULE_SELF 1
 	uint32_t flags;
Index: trunk/libsepol/src/expand.c
===================================================================
--- trunk/libsepol/src/expand.c	(revision 1000)
+++ trunk/libsepol/src/expand.c	(working copy)
@@ -1214,8 +1214,7 @@
 		if (!ebitmap_node_get_bit(snode, i))
 			continue;
 		if (source_rule->flags & RULE_SELF) {
-			if (source_rule->
-			    specified & (AVRULE_AV | AVRULE_NEVERALLOW)) {
+			if (source_rule->specified & (AVRULE_AV)) {
 				if ((retval =
 				     expand_avrule_helper(handle,
 							  source_rule->
@@ -1242,8 +1241,7 @@
 		ebitmap_for_each_bit(ttypes, tnode, j) {
 			if (!ebitmap_node_get_bit(tnode, j))
 				continue;
-			if (source_rule->
-			    specified & (AVRULE_AV | AVRULE_NEVERALLOW)) {
+			if (source_rule->specified & (AVRULE_AV)) {
 				if ((retval =
 				     expand_avrule_helper(handle,
 							  source_rule->
Index: trunk/libsepol/src/link.c
===================================================================
--- trunk/libsepol/src/link.c	(revision 951)
+++ trunk/libsepol/src/link.c	(working copy)
@@ -965,8 +965,7 @@
 			    module->map[SYM_CLASSES][cur_perm->class - 1];
 			assert(new_perm->class);
 
-			if (new_rule->
-			    specified & (AVRULE_AV | AVRULE_NEVERALLOW)) {
+			if (new_rule->specified & (AVRULE_AV)) {
 				for (i = 0;
 				     i <
 				     module->perm_map_len[cur_perm->class - 1];


> Hmm...do you want alwaysexpand = 1 for the do_neverallow case?
> Otherwise, type attributes might not get expanded.  Does
> expand_avtab_insert need to know about AVTAB_NEVERALLOW?

No, apol doesn't always want the attributes expanded out, it knows how
to deal with attributes.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
