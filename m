Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i97JiFrT016968
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 15:44:16 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i97Jh7nr027013
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 19:43:07 GMT
Subject: Re: libsepol+mls compile failure
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1097111576.31497.6.camel@chris.pebenito.net>
References: <1097111576.31497.6.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1097178086.13339.214.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 07 Oct 2004 15:41:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-06 at 21:12, Chris PeBenito wrote:
> I was going to try out MLS, but I get the following compile failure in
> libsepol:
> 
> mls.c: In function `mls_compute_av':
> mls.c:36: error: `policydb' undeclared (first use in this function)
> mls.c:36: error: (Each undeclared identifier is reported only once
> mls.c:36: error: for each function it appears in.)
> mls.c: In function `mls_compute_context_len':
> mls.c:84: error: `policydb' undeclared (first use in this function)
> mls.c: In function `mls_sid_to_context':
> mls.c:114: error: `policydb' undeclared (first use in this function)
> mls.c: In function `mls_context_to_sid':
> mls.c:230: error: `policydb' undeclared (first use in this function)

Compile-tested only.

Index: libsepol/include/sepol/mls.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/mls.h,v
retrieving revision 1.1
diff -u -r1.1 mls.h
--- libsepol/include/sepol/mls.h	9 Aug 2004 15:25:49 -0000	1.1
+++ libsepol/include/sepol/mls.h	7 Oct 2004 19:37:17 -0000
@@ -15,19 +15,23 @@
 
 #ifdef CONFIG_SECURITY_SELINUX_MLS
 
-void mls_compute_av(context_struct_t * scontext,
+void mls_compute_av(policydb_t *policydb,
+		    context_struct_t * scontext,
 		    context_struct_t * tcontext,
 		    class_datum_t * tclass,
 		    access_vector_t * allowed);
 
-int mls_compute_context_len(context_struct_t * context);
+int mls_compute_context_len(policydb_t *policydb,
+			    context_struct_t * context);
 
-int mls_sid_to_context(context_struct_t * context,
+int mls_sid_to_context(policydb_t *policydb,
+		       context_struct_t * context,
 		       char **scontext);
 
 int mls_context_isvalid(policydb_t *p, context_struct_t * c);
 
-int mls_context_to_sid(char oldc,
+int mls_context_to_sid(policydb_t *policydb,
+		       char oldc,
 	               char **scontext,
 		       context_struct_t * context);
 
@@ -35,7 +39,8 @@
 			policydb_t * newp,
 			context_struct_t * context);
 
-int mls_compute_sid(context_struct_t *scontext,
+int mls_compute_sid(policydb_t *policydb,
+		    context_struct_t *scontext,
 		    context_struct_t *tcontext,
 		    security_class_t tclass,
 		    uint32_t specified,
@@ -45,8 +50,8 @@
 int cat_index(hashtab_key_t key, hashtab_datum_t datum, void *datap);
 int sens_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
 int cat_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
-int sens_read(policydb_t * p, hashtab_t h, void * fp);
-int cat_read(policydb_t * p, hashtab_t h, void * fp);
+int sens_read(policydb_t * p, hashtab_t h, struct policy_file *fp);
+int cat_read(policydb_t * p, hashtab_t h, struct policy_file *fp);
 
 #define mls_for_user_ranges(user, usercon) { \
 mls_range_list_t *__ranges; \
@@ -75,13 +80,13 @@
 
 #else
 
-#define	mls_compute_av(scontext, tcontext, tclass_datum, allowed)
-#define mls_compute_context_len(context) 0
-#define	mls_sid_to_context(context, scontextpp)
+#define	mls_compute_av(policydb, scontext, tcontext, tclass_datum, allowed)
+#define mls_compute_context_len(policydb, context) 0
+#define	mls_sid_to_context(policydb, context, scontextpp)
 #define mls_context_isvalid(p, c) 1
-#define	mls_context_to_sid(oldc, context_str, context) 0
+#define	mls_context_to_sid(policydb, oldc, context_str, context) 0
 #define mls_convert_context(oldp, newp, c) 0
-#define mls_compute_sid(scontext, tcontext, tclass, specified, newcontextp) 0
+#define mls_compute_sid(policydb, scontext, tcontext, tclass, specified, newcontextp) 0
 #define mls_for_user_ranges(user, usercon) 
 #define mls_end_user_ranges
 #define mls_symtab_names
Index: libsepol/src/mls.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/mls.c,v
retrieving revision 1.2
diff -u -r1.2 mls.c
--- libsepol/src/mls.c	11 Aug 2004 13:35:42 -0000	1.2
+++ libsepol/src/mls.c	7 Oct 2004 19:37:42 -0000
@@ -13,13 +13,16 @@
 #include <sepol/policydb.h>
 #include <sepol/services.h>
 
+#include <stdlib.h>
+
 #include "private.h"
 
 /*
  * Remove any permissions from `allowed' that are
  * denied by the MLS policy.
  */
-void mls_compute_av(context_struct_t * scontext,
+void mls_compute_av(policydb_t *policydb,
+		    context_struct_t * scontext,
 		    context_struct_t * tcontext,
 		    class_datum_t * tclass,
 		    access_vector_t * allowed)
@@ -33,14 +36,14 @@
 
 	if (rel[1] != MLS_RELATION_EQ) {
 		if (rel[1] != MLS_RELATION_DOM &&
-		    !ebitmap_get_bit(&policydb.trustedreaders, scontext->type - 1) &&
-		    !ebitmap_get_bit(&policydb.trustedobjects, tcontext->type - 1)) {
+		    !ebitmap_get_bit(&policydb->trustedreaders, scontext->type - 1) &&
+		    !ebitmap_get_bit(&policydb->trustedobjects, tcontext->type - 1)) {
 			/* read(s,t) = (s.high >= t.high) = False */
 			*allowed = (*allowed) & ~(tclass->mlsperms.read);
 		}
 		if (rel[1] != MLS_RELATION_DOMBY &&
-		    !ebitmap_get_bit(&policydb.trustedreaders, tcontext->type - 1) &&
-		    !ebitmap_get_bit(&policydb.trustedobjects, scontext->type - 1)) {
+		    !ebitmap_get_bit(&policydb->trustedreaders, tcontext->type - 1) &&
+		    !ebitmap_get_bit(&policydb->trustedobjects, scontext->type - 1)) {
 			/* readby(s,t) = read(t,s) = False */
 			*allowed = (*allowed) & ~(tclass->mlsperms.readby);
 		}
@@ -49,8 +52,8 @@
 	    ((!mls_level_eq(tcontext->range.level[0],
 			    tcontext->range.level[1])) &&
 	     (rel[1] != MLS_RELATION_DOM && rel[1] != MLS_RELATION_EQ))) &&
-	    !ebitmap_get_bit(&policydb.trustedwriters, scontext->type - 1) &&
-	    !ebitmap_get_bit(&policydb.trustedobjects, tcontext->type - 1)) {
+	    !ebitmap_get_bit(&policydb->trustedwriters, scontext->type - 1) &&
+	    !ebitmap_get_bit(&policydb->trustedobjects, tcontext->type - 1)) {
 		/*
 		 * write(s,t) = ((s.low <= t.low = t.high) or (s.low
 		 * <= t.low <= t.high <= s.high)) = False
@@ -62,8 +65,8 @@
 	    ((!mls_level_eq(scontext->range.level[0],
 			    scontext->range.level[1])) &&
 	     (rel[1] != MLS_RELATION_DOMBY && rel[1] != MLS_RELATION_EQ))) &&
-	    !ebitmap_get_bit(&policydb.trustedwriters, tcontext->type - 1) &&
-	    !ebitmap_get_bit(&policydb.trustedobjects, scontext->type - 1)) {
+	    !ebitmap_get_bit(&policydb->trustedwriters, tcontext->type - 1) &&
+	    !ebitmap_get_bit(&policydb->trustedobjects, scontext->type - 1)) {
 		/* writeby(s,t) = write(t,s) = False */
 		*allowed = (*allowed) & ~(tclass->mlsperms.writeby);
 	}
@@ -74,18 +77,18 @@
  * Return the length in bytes for the MLS fields of the
  * security context string representation of `context'.
  */
-int mls_compute_context_len(context_struct_t * context)
+int mls_compute_context_len(policydb_t *policydb, context_struct_t * context)
 {
 	int i, l, len;
 
 
 	len = 0;
 	for (l = 0; l < 2; l++) {
-		len += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]) + 1;
+		len += strlen(policydb->p_sens_val_to_name[context->range.level[l].sens - 1]) + 1;
 
 		for (i = 1; i <= ebitmap_length(&context->range.level[l].cat); i++)
 			if (ebitmap_get_bit(&context->range.level[l].cat, i - 1))
-				len += strlen(policydb.p_cat_val_to_name[i - 1]) + 1;
+				len += strlen(policydb->p_cat_val_to_name[i - 1]) + 1;
 
 		if (mls_level_relation(context->range.level[0], context->range.level[1]) == MLS_RELATION_EQ)
 			break;
@@ -100,7 +103,8 @@
  * the MLS fields of `context' into the string `*scontext'.
  * Update `*scontext' to point to the end of the MLS fields.
  */
-int mls_sid_to_context(context_struct_t * context,
+int mls_sid_to_context(policydb_t *policydb,
+		       context_struct_t * context,
 		       char **scontext)
 {
 	char *scontextp;
@@ -111,14 +115,14 @@
 
 	for (l = 0; l < 2; l++) {
 		strcpy(scontextp,
-		       policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
-		scontextp += strlen(policydb.p_sens_val_to_name[context->range.level[l].sens - 1]);
+		       policydb->p_sens_val_to_name[context->range.level[l].sens - 1]);
+		scontextp += strlen(policydb->p_sens_val_to_name[context->range.level[l].sens - 1]);
 		*scontextp = ':';
 		scontextp++;
 		for (i = 1; i <= ebitmap_length(&context->range.level[l].cat); i++)
 			if (ebitmap_get_bit(&context->range.level[l].cat, i - 1)) {
-				strcpy(scontextp, policydb.p_cat_val_to_name[i - 1]);
-				scontextp += strlen(policydb.p_cat_val_to_name[i - 1]);
+				strcpy(scontextp, policydb->p_cat_val_to_name[i - 1]);
+				scontextp += strlen(policydb->p_cat_val_to_name[i - 1]);
 				*scontextp = ',';
 				scontextp++;
 			}
@@ -213,7 +217,8 @@
  * This function modifies the string in place, inserting
  * NULL characters to terminate the MLS fields. 
  */
-int mls_context_to_sid(char oldc,
+int mls_context_to_sid(policydb_t *policydb,
+		       char oldc,
 		       char **scontext,
 		       context_struct_t * context)
 {
@@ -227,7 +232,7 @@
 	if (!oldc) {
 		/* No MLS component to the security context.  Try
 		   to use a default 'unclassified' value. */
-		levdatum = (level_datum_t *) hashtab_search(policydb.p_levels.table,
+		levdatum = (level_datum_t *) hashtab_search(policydb->p_levels.table,
 							    (hashtab_key_t) "unclassified");
 		
 		if (!levdatum)
@@ -248,7 +253,7 @@
 		*p++ = 0;
 
 	for (l = 0; l < 2; l++) {
-		levdatum = (level_datum_t *) hashtab_search(policydb.p_levels.table,
+		levdatum = (level_datum_t *) hashtab_search(policydb->p_levels.table,
 					      (hashtab_key_t) scontextp);
 
 		if (!levdatum)
@@ -266,7 +271,7 @@
 				if (delim != 0)
 					*p++ = 0;
 
-				catdatum = (cat_datum_t *) hashtab_search(policydb.p_cats.table,
+				catdatum = (cat_datum_t *) hashtab_search(policydb->p_cats.table,
 					      (hashtab_key_t) scontextp);
 
 				if (!catdatum)
@@ -373,7 +378,8 @@
 	return 0;
 }
 
-int mls_compute_sid(context_struct_t *scontext,
+int mls_compute_sid(policydb_t *policydb,
+		    context_struct_t *scontext,
 		    context_struct_t *tcontext,
 		    security_class_t tclass,
 		    uint32_t specified,
@@ -655,7 +661,7 @@
 	return 0;
 }
 
-int sens_read(policydb_t * p, hashtab_t h, void * fp)
+int sens_read(policydb_t * p, hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	level_datum_t *levdatum;
@@ -697,7 +703,7 @@
 }
 
 
-int cat_read(policydb_t * p, hashtab_t h, void * fp)
+int cat_read(policydb_t * p, hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	cat_datum_t *catdatum;
Index: libsepol/src/services.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/services.c,v
retrieving revision 1.6
diff -u -r1.6 services.c
--- libsepol/src/services.c	20 Aug 2004 19:02:11 -0000	1.6
+++ libsepol/src/services.c	7 Oct 2004 19:35:22 -0000
@@ -260,7 +260,7 @@
 	/*
 	 * Remove any permissions prohibited by the MLS policy.
 	 */
-	mls_compute_av(scontext, tcontext, tclass_datum, &avd->allowed);
+	mls_compute_av(policydb, scontext, tcontext, tclass_datum, &avd->allowed);
 
 	/* 
 	 * Remove any permissions prohibited by a constraint.
@@ -345,7 +345,7 @@
 	*scontext_len += strlen(policydb->p_user_val_to_name[context->user - 1]) + 1;
 	*scontext_len += strlen(policydb->p_role_val_to_name[context->role - 1]) + 1;
 	*scontext_len += strlen(policydb->p_type_val_to_name[context->type - 1]) + 1;
-	*scontext_len += mls_compute_context_len(context);
+	*scontext_len += mls_compute_context_len(policydb, context);
 
 	/* Allocate space for the context; caller must free this space. */
 	scontextp = malloc(*scontext_len+1);
@@ -363,7 +363,7 @@
 		policydb->p_type_val_to_name[context->type - 1]);
 	scontextp += strlen(policydb->p_user_val_to_name[context->user - 1]) + 1 + strlen(policydb->p_role_val_to_name[context->role - 1]) + 1 + strlen(policydb->p_type_val_to_name[context->type - 1]) + 1;
 
-	mls_sid_to_context(context, &scontextp);
+	mls_sid_to_context(policydb, context, &scontextp);
 
 	scontextp--;
 	*scontextp = 0;
@@ -484,7 +484,7 @@
 
 	context.type = typdatum->value;
 
-	rc = mls_context_to_sid(oldc, &p, &context);
+	rc = mls_context_to_sid(policydb, oldc, &p, &context);
 	if (rc)
 		goto out;
 
@@ -664,7 +664,7 @@
 
 	/* Set the MLS attributes.
 	   This is done last because it may allocate memory. */
-	rc = mls_compute_sid(scontext, tcontext, tclass, specified, &newcontext);
+	rc = mls_compute_sid(policydb, scontext, tcontext, tclass, specified, &newcontext);
 	if (rc) 
 		goto out;
 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
