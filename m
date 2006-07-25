Subject: [PATCH 1/2] Conditionally expand neverallows
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 25 Jul 2006 10:55:28 -0400
Message-Id: <1153839328.19259.16.camel@twoface>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The setools team would like to be able to optionally expand neverallow
rules for analysis purposes.  This patch leaves the current behavior
unchanged, but allows a new state variable for the expander to indicate
whether neverallow rules should get expanded, and creates an init
function for the expand_state struct.

diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' -x '*.o' -x '*.lo' ../../../trunk/libsepol/include/sepol/policydb/avtab.h ./include/sepol/policydb/avtab.h
--- trunk/libsepol/include/sepol/policydb/avtab.h	2006-07-13 10:19:14.000000000 -0400
+++ trunk/libsepol/include/sepol/policydb/avtab.h	2006-07-13 10:46:33.000000000 -0400
@@ -45,6 +45,7 @@ typedef struct avtab_key {
 #define AVTAB_ALLOWED     1
 #define AVTAB_AUDITALLOW  2
 #define AVTAB_AUDITDENY   4
+#define AVTAB_NEVERALLOW 128
 #define AVTAB_AV         (AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
 #define AVTAB_TRANSITION 16
 #define AVTAB_MEMBER     32
diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' -x '*.o' -x '*.lo' ../../../trunk/libsepol/src/expand.c ./src/expand.c
--- trunk/libsepol/src/expand.c	2006-07-13 13:57:39.000000000 -0400
+++ trunk/libsepol/src/expand.c	2006-07-19 13:04:06.000000000 -0400
@@ -41,8 +41,14 @@ typedef struct expand_state {
 	policydb_t *base;
 	policydb_t *out;
 	sepol_handle_t *handle;
+	int expand_neverallow;
 } expand_state_t;
 
+static void expand_state_init(expand_state_t *state)
+{
+	memset(state, 0, sizeof(expand_state_t));
+}
+
 static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			      void *data)
 {
@@ -1137,6 +1143,8 @@ static int expand_avrule_helper(sepol_ha
 		spec = AVTAB_AUDITDENY;
 	} else if (specified & AVRULE_DONTAUDIT) {
 		spec = AVTAB_AUDITDENY;
+	} else if (specified & AVRULE_NEVERALLOW) {
+		spec = AVTAB_NEVERALLOW;
 	} else {
 		assert(0);	/* unreachable */
 	}
@@ -1162,6 +1170,8 @@ static int expand_avrule_helper(sepol_ha
 			avdatump->data |= cur->data;
 		} else if (specified & AVRULE_AUDITALLOW) {
 			avdatump->data |= cur->data;
+		} else if (specified & AVRULE_NEVERALLOW) {
+			avdatump->data |= cur->data;
 		} else if (specified & AVRULE_AUDITDENY) {
 			/* Since a '0' in an auditdeny mask represents
 			 * a permission we do NOT want to audit
@@ -1200,7 +1210,7 @@ static int expand_rule_helper(sepol_hand
 		if (!ebitmap_node_get_bit(snode, i))
 			continue;
 		if (source_rule->flags & RULE_SELF) {
-			if (source_rule->specified & AVRULE_AV) {
+			if (source_rule->specified & (AVRULE_AV|AVRULE_NEVERALLOW)) {
 				if ((retval =
 				     expand_avrule_helper(handle,
 							  source_rule->
@@ -1227,7 +1237,7 @@ static int expand_rule_helper(sepol_hand
 		ebitmap_for_each_bit(ttypes, tnode, j) {
 			if (!ebitmap_node_get_bit(tnode, j))
 				continue;
-			if (source_rule->specified & AVRULE_AV) {
+			if (source_rule->specified & (AVRULE_AV|AVRULE_NEVERALLOW)) {
 				if ((retval =
 				     expand_avrule_helper(handle,
 							  source_rule->
@@ -1264,13 +1274,14 @@ static int convert_and_expand_rule(sepol
 				   policydb_t * dest_pol, uint32_t * typemap,
 				   avrule_t * source_rule, avtab_t * dest_avtab,
 				   cond_av_list_t ** cond,
-				   cond_av_list_t ** other, int enabled)
+				   cond_av_list_t ** other, int enabled,
+				   int do_neverallow)
 {
 	int retval;
 	ebitmap_t stypes, ttypes;
 	unsigned char alwaysexpand;
 
-	if (source_rule->specified & AVRULE_NEVERALLOW)
+	if (!do_neverallow && source_rule->specified & AVRULE_NEVERALLOW)
 		return 1;
 
 	ebitmap_init(&stypes);
@@ -1306,7 +1317,7 @@ static int cond_avrule_list_copy(policyd
 	while (cur) {
 		if (convert_and_expand_rule(state->handle, dest_pol,
 					    typemap, cur, dest_avtab,
-					    list, other, enabled) != 1) {
+					    list, other, enabled, 0) != 1) {
 			return -1;
 		}
 
@@ -1897,6 +1908,8 @@ int expand_module(sepol_handle_t * handl
 	expand_state_t state;
 	avrule_block_t *curblock;
 
+	expand_state_init(&state);
+
 	state.verbose = verbose;
 	state.typemap = NULL;
 	state.base = base;
@@ -2033,7 +2046,7 @@ int expand_module(sepol_handle_t * handl
 		/* copy rules */
 		cur_avrule = decl->avrules;
 		while (cur_avrule != NULL) {
-			if (cur_avrule->specified & AVRULE_NEVERALLOW) {
+			if (!(state->expand_neverallow) && cur_avrule->specified & AVRULE_NEVERALLOW) {
 				/* copy this over directly so that assertions are checked later */
 				if (copy_neverallow
 				    (out, state.typemap, cur_avrule))
@@ -2043,7 +2056,7 @@ int expand_module(sepol_handle_t * handl
 				if (convert_and_expand_rule
 				    (state.handle, out, state.typemap,
 				     cur_avrule, &out->te_avtab, NULL, NULL,
-				     0) != 1) {
+				     0, state->expand_neverallow) != 1) {
 					goto cleanup;
 				}
 			}



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
