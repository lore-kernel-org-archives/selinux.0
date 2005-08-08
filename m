Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
   Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
In-Reply-To: <1123172051.13654.80.camel@moss-spartans.epoch.ncsc.mil>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
	 <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com>
	 <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
	 <1123159932.13654.17.camel@moss-spartans.epoch.ncsc.mil>
	 <1123172051.13654.80.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 14:42:35 -0400
Message-Id: <1123526555.13654.343.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-08-04 at 12:14 -0400, Stephen Smalley wrote:
> On Thu, 2005-08-04 at 08:52 -0400, Stephen Smalley wrote:
> > This patch modifies the assertion checking code to expand the avtabs
> > prior to checking the assertions, leveraging the expand_avtab function
> > that was added by the prior patch to provide compatibility support for
> > writing older binary policy versions.  This appears to eliminate the
> > performance penalty introduced by the earlier patches for assertion
> > checking.
> 
> The above patch is also available from
> http://www.cs.utah.edu/~sds/libsepol-assert.patch
> 
> I've also now converted over most users of ebitmaps in libsepol and
> checkpolicy to using the new inline operators, and added a
> ebitmap_for_each_bit macro to simplify the code.  Those patches are
> available from http://www.cs.utah.edu/~sds/libsepol-ebitmap.patch and
> http://www.cs.utah.edu/~sds/checkpolicy-ebitmap.patch.
> 
> Next step is to similarly convert the users of ebitmaps in the kernel.

The kernel patch for converting ebitmap users to the new inline
operators is below, and also available from http://www.cs.utah.edu/~sds.
This patch is relative to the two avtab memory optimization patches
(reduce node size, reduce number of nodes) previously posted and also
available from that URL.  I chose to kill the unused arguments from the
ebitmap operators for the kernel patch, and went back and removed them
from libsepol/checkpolicy as well.  Patches for that are also available
from the above URL, along with fully patched tarballs of
libsepol/checkpolicy for convenience, as the number of individual
patches is becoming unwieldy for them.  

diff -X /home/sds/dontdiff -rup linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/ebitmap.h linux-2.6.13-rc3-mm1-avtab3/security/selinux/ss/ebitmap.h
--- linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/ebitmap.h	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc3-mm1-avtab3/security/selinux/ss/ebitmap.h	2005-08-04 12:27:07.000000000 -0400
@@ -32,11 +32,41 @@ struct ebitmap {
 #define ebitmap_length(e) ((e)->highbit)
 #define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
 
+static inline unsigned int ebitmap_start(struct ebitmap *e, 
+					 struct ebitmap_node **n) 
+{
+	*n = e->node;
+	return ebitmap_startbit(e);
+}
+
 static inline void ebitmap_init(struct ebitmap *e)
 {
 	memset(e, 0, sizeof(*e));
 }
 
+static inline unsigned int ebitmap_next(struct ebitmap_node **n,
+					unsigned int bit)
+{
+	if ((bit == ((*n)->startbit + MAPSIZE - 1)) &&
+	    (*n)->next) {
+		*n = (*n)->next;
+		return (*n)->startbit;
+	}
+
+	return (bit+1);
+}
+
+static inline int ebitmap_node_get_bit(struct ebitmap_node * n, 
+				       unsigned int bit)
+{
+	if (n->map & (MAPBIT << (bit - n->startbit)))
+		return 1;
+	return 0;
+}
+
+#define ebitmap_for_each_bit(e, n, bit) \
+	for (bit = ebitmap_start(e, &n); bit < ebitmap_length(e); bit = ebitmap_next(&n, bit)) \
+
 int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
 int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2);
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/mls.c linux-2.6.13-rc3-mm1-avtab3/security/selinux/ss/mls.c
--- linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/mls.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc3-mm1-avtab3/security/selinux/ss/mls.c	2005-08-04 12:27:50.000000000 -0400
@@ -26,6 +26,7 @@
 int mls_compute_context_len(struct context * context)
 {
 	int i, l, len, range;
+	struct ebitmap_node *node;
 
 	if (!selinux_mls_enabled)
 		return 0;
@@ -35,24 +36,24 @@ int mls_compute_context_len(struct conte
 		range = 0;
 		len += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
 
-		for (i = 1; i <= ebitmap_length(&context->range.level[l].cat); i++) {
-			if (ebitmap_get_bit(&context->range.level[l].cat, i - 1)) {
+		ebitmap_for_each_bit(&context->range.level[l].cat, node, i) {
+			if (ebitmap_node_get_bit(node, i)) {
 				if (range) {
 					range++;
 					continue;
 				}
 
-				len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
+				len += strlen(policydb.p_cat_val_to_name[i]) + 1;
 				range++;
 			} else {
 				if (range > 1)
-					len += strlen(policydb.p_cat_val_to_name[i - 2]) + 1;
+					len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
 				range = 0;
 			}
 		}
 		/* Handle case where last category is the end of range */
 		if (range > 1)
-			len += strlen(policydb.p_cat_val_to_name[i - 2]) + 1;
+			len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
 
 		if (l == 0) {
 			if (mls_level_eq(&context->range.level[0],
@@ -76,6 +77,7 @@ void mls_sid_to_context(struct context *
 {
 	char *scontextp;
 	int i, l, range, wrote_sep;
+	struct ebitmap_node *node;
 
 	if (!selinux_mls_enabled)
 		return;
@@ -93,8 +95,8 @@ void mls_sid_to_context(struct context *
 		scontextp += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
 
 		/* categories */
-		for (i = 1; i <= ebitmap_length(&context->range.level[l].cat); i++) {
-			if (ebitmap_get_bit(&context->range.level[l].cat, i - 1)) {
+		ebitmap_for_each_bit(&context->range.level[l].cat, node, i) {
+			if (ebitmap_node_get_bit(node, i)) {
 				if (range) {
 					range++;
 					continue;
@@ -105,8 +107,8 @@ void mls_sid_to_context(struct context *
 					wrote_sep = 1;
 				} else
 					*scontextp++ = ',';
-				strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
-				scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
+				strcpy(scontextp, policydb.p_cat_val_to_name[i]);
+				scontextp += strlen(policydb.p_cat_val_to_name[i]);
 				range++;
 			} else {
 				if (range > 1) {
@@ -115,8 +117,8 @@ void mls_sid_to_context(struct context *
 					else
 						*scontextp++ = ',';
 
-					strcpy(scontextp, policydb.p_cat_val_to_name[i - 2]);
-					scontextp += strlen(policydb.p_cat_val_to_name[i - 2]);
+					strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
+					scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
 				}
 				range = 0;
 			}
@@ -129,8 +131,8 @@ void mls_sid_to_context(struct context *
 			else
 				*scontextp++ = ',';
 
-			strcpy(scontextp, policydb.p_cat_val_to_name[i - 2]);
-			scontextp += strlen(policydb.p_cat_val_to_name[i - 2]);
+			strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
+			scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
 		}
 
 		if (l == 0) {
@@ -156,6 +158,7 @@ int mls_context_isvalid(struct policydb 
 {
 	struct level_datum *levdatum;
 	struct user_datum *usrdatum;
+	struct ebitmap_node *node;
 	int i, l;
 
 	if (!selinux_mls_enabled)
@@ -178,11 +181,11 @@ int mls_context_isvalid(struct policydb 
 		if (!levdatum)
 			return 0;
 
-		for (i = 1; i <= ebitmap_length(&c->range.level[l].cat); i++) {
-			if (ebitmap_get_bit(&c->range.level[l].cat, i - 1)) {
+		ebitmap_for_each_bit(&c->range.level[l].cat, node, i) {
+			if (ebitmap_node_get_bit(node, i)) {
 				if (i > p->p_cats.nprim)
 					return 0;
-				if (!ebitmap_get_bit(&levdatum->level->cat, i - 1))
+				if (!ebitmap_get_bit(&levdatum->level->cat, i))
 					/*
 					 * Category may not be associated with
 					 * sensitivity in low level.
@@ -443,6 +446,7 @@ int mls_convert_context(struct policydb 
 	struct level_datum *levdatum;
 	struct cat_datum *catdatum;
 	struct ebitmap bitmap;
+	struct ebitmap_node *node;
 	int l, i;
 
 	if (!selinux_mls_enabled)
@@ -457,12 +461,12 @@ int mls_convert_context(struct policydb 
 		c->range.level[l].sens = levdatum->level->sens;
 
 		ebitmap_init(&bitmap);
-		for (i = 1; i <= ebitmap_length(&c->range.level[l].cat); i++) {
-			if (ebitmap_get_bit(&c->range.level[l].cat, i - 1)) {
+		ebitmap_for_each_bit(&c->range.level[l].cat, node, i) {
+			if (ebitmap_node_get_bit(node, i)) {
 				int rc;
 
 				catdatum = hashtab_search(newp->p_cats.table,
-				         	oldp->p_cat_val_to_name[i - 1]);
+				         	oldp->p_cat_val_to_name[i]);
 				if (!catdatum)
 					return -EINVAL;
 				rc = ebitmap_set_bit(&bitmap, catdatum->value - 1, 1);
diff -X /home/sds/dontdiff -rup linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/services.c linux-2.6.13-rc3-mm1-avtab3/security/selinux/ss/services.c
--- linux-2.6.13-rc3-mm1-avtab2/security/selinux/ss/services.c	2005-07-29 09:21:01.000000000 -0400
+++ linux-2.6.13-rc3-mm1-avtab3/security/selinux/ss/services.c	2005-08-04 12:19:02.000000000 -0400
@@ -269,6 +269,7 @@ static int context_struct_compute_av(str
 	struct avtab_node *node;
 	struct class_datum *tclass_datum;
 	struct ebitmap *sattr, *tattr;
+	struct ebitmap_node *snode, *tnode;
 	unsigned int i, j;
 
 	/*
@@ -306,13 +307,11 @@ static int context_struct_compute_av(str
 	avkey.specified = AVTAB_AV;
 	sattr = &policydb.type_attr_map[scontext->type - 1];
 	tattr = &policydb.type_attr_map[tcontext->type - 1];
-	for (i = ebitmap_startbit(sattr); 
-	     i < ebitmap_length(sattr); i++) {
-		if (!ebitmap_get_bit(sattr, i))
-		    continue;
-		for (j = ebitmap_startbit(tattr); 
-		     j < ebitmap_length(tattr); j++) {
-			if (!ebitmap_get_bit(tattr, j))
+	ebitmap_for_each_bit(sattr, snode, i) {
+		if (!ebitmap_node_get_bit(snode, i))
+			continue;
+		ebitmap_for_each_bit(tattr, tnode, j) {
+			if (!ebitmap_node_get_bit(tnode, j))
 				continue;
 			avkey.source_type = i + 1;
 			avkey.target_type = j + 1;
@@ -1479,6 +1478,7 @@ int security_get_user_sids(u32 fromsid,
 	struct user_datum *user;
 	struct role_datum *role;
 	struct av_decision avd;
+	struct ebitmap_node *rnode, *tnode;
 	int rc = 0, i, j;
 
 	if (!ss_initialized) {
@@ -1509,13 +1509,13 @@ int security_get_user_sids(u32 fromsid,
 	}
 	memset(mysids, 0, maxnel*sizeof(*mysids));
 
-	for (i = ebitmap_startbit(&user->roles); i < ebitmap_length(&user->roles); i++) {
-		if (!ebitmap_get_bit(&user->roles, i))
+	ebitmap_for_each_bit(&user->roles, rnode, i) {
+		if (!ebitmap_node_get_bit(rnode, i))
 			continue;
 		role = policydb.role_val_to_struct[i];
 		usercon.role = i+1;
-		for (j = ebitmap_startbit(&role->types); j < ebitmap_length(&role->types); j++) {
-			if (!ebitmap_get_bit(&role->types, j))
+		ebitmap_for_each_bit(&role->types, tnode, j) {
+			if (!ebitmap_node_get_bit(tnode, j))
 				continue;
 			usercon.type = j+1;
 


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
