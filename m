Message-ID: <44C908FD.3090208@tresys.com>
Date: Thu, 27 Jul 2006 14:42:05 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: Re: [PATCH RETRY 2/3] Optionally expand neverallows
References: <1153937503.5393.6.camel@twoface> <1153944945.11769.194.camel@moss-spartans.epoch.ncsc.mil> <1154005763.27604.58.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1154005763.27604.58.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>
>
> Also, suppose hypothetically that one of these policydbs with expanded
> neverallow rules is passed along to one of the other libsepol functions.
> What behavior do you want?  Seems like avtab_write_item() would happily
> write it out, but avtab_read_item() would choke on it (no match in
> spec_order, so set == 0).  Do you want to be able to save these as
> binary policy images and use them later for analysis?
>
Right, there is no intention to store out these policydbs. This patch is 
similar to one I already added for access control hooks in libsepol. It 
marks policies as invalid when you do unsupported things to them, and 
also skips assertion and hierarchy checking.

Index: trunk/libsepol/include/sepol/policydb/policydb.h
===================================================================
--- trunk/libsepol/include/sepol/policydb/policydb.h	(revision 951)
+++ trunk/libsepol/include/sepol/policydb/policydb.h	(working copy)
@@ -366,6 +366,7 @@
 	uint32_t policy_type;
 	char *name;
 	char *version;
+	int invalid;
 
 	/* Whether this policydb is mls, should always be set */
 	int mls;
Index: trunk/libsepol/src/expand.c
===================================================================
--- trunk/libsepol/src/expand.c	(revision 997)
+++ trunk/libsepol/src/expand.c	(working copy)
@@ -1904,7 +1904,7 @@
 	return -1;
 }
 
-static int expand_avrule_decls(expand_state_t * state)
+static int copy_and_expand_avrule_block(expand_state_t * state)
 {
 	avrule_block_t *curblock;
 	int retval = -1;
@@ -1936,6 +1936,9 @@
 					ERR(state->handle,
 					    "Error while copying neverallow.");
 			} else {
+				if (cur_avrule->specified & AVRULE_NEVERALLOW) {
+					state->out->invalid = 1;
+				}
 				if (convert_and_expand_rule
 				    (state->handle, state->out, state->typemap,
 				     cur_avrule, &state->out->te_avtab, NULL,
@@ -1974,7 +1977,7 @@
 	state.verbose = verbose;
 	state.expand_neverallow = expand_neverallow;
 
-	return expand_avrule_decls(&state);
+	return copy_and_expand_avrule_block(&state);
 }
 
 /* Linking should always be done before calling expand, even if
@@ -2108,7 +2111,7 @@
 
 	}
 
-	if (expand_avrule_decls(&state) < 0) {
+	if (copy_and_expand_avrule_block(&state) < 0) {
 		ERR(handle, "Error during expand");
 		goto cleanup;
 	}
@@ -2156,7 +2159,7 @@
 		goto cleanup;
 	hashtab_map_remove_on_error(state.out->p_types.table,
 				    type_attr_remove, type_destroy, state.out);
-	if (check) {
+	if (check && !(out->invalid)) {
 		if (hierarchy_check_constraints(handle, state.out))
 			goto cleanup;
 
Index: trunk/libsepol/src/write.c
===================================================================
--- trunk/libsepol/src/write.c	(revision 951)
+++ trunk/libsepol/src/write.c	(working copy)
@@ -1411,6 +1411,9 @@
 	struct policy_data pd;
 	char *policydb_str;
 
+	if (p->invalid)
+		return -1;
+
 	pd.fp = fp;
 	pd.p = p;
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
