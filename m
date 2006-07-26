Subject: [PATCH 3/2] comments and format fixes
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Content-Type: text/plain
Date: Wed, 26 Jul 2006 10:59:57 -0400
Message-Id: <1153925997.21910.4.camel@twoface>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch applies on the previous 2 and adds comments and fixes some
formatting as discussed on list. BTW, I've never heard any authoritative
style preferences for this repository. While I agree with these
particular changes (* going with var rather than type) clearly not
everyone does (such as the original author of that code) and I'd prefer
not to make subjective/arbitrary style changes without some input on
what the upstream preferred style is.

Index: libsepol/include/sepol/handle.h
===================================================================
--- trunk/libsepol/include/sepol/handle.h	(revision 951)
+++ trunk/libsepol/include/sepol/handle.h	(working copy)
@@ -3,7 +3,7 @@
 
 struct sepol_handle;
 typedef struct sepol_handle sepol_handle_t;
-typedef void (*sepol_handle_callback_fn_t) (void* varg, sepol_handle_t* handle, const char* fmt, ...);
+typedef void (*sepol_handle_callback_fn_t) (void *varg, sepol_handle_t *handle, const char *fmt, ...);
 
 /* Create and return a sepol handle. */
 extern sepol_handle_t *sepol_handle_create(void);
@@ -12,13 +12,13 @@
 extern void sepol_handle_set_callback(sepol_handle_t *h, sepol_handle_callback_fn_t fn, void *varg);
 
 /* Call the callback for a sepol handle */
-extern void sepol_handle_do_callback(sepol_handle_t* handle, const char* fmt, ...);
+extern void sepol_handle_do_callback(sepol_handle_t *handle, const char *fmt, ...);
 
 /* Get the severity level of the last message */
 extern int sepol_handle_get_level(sepol_handle_t *h);
 
 /* Destroy a sepol handle. */
-extern void sepol_handle_destroy(sepol_handle_t *);
+extern void sepol_handle_destroy(sepol_handle_t *h);
 
 
 #endif
Index: libsepol/include/sepol/policydb/expand.h
===================================================================
--- trunk/libsepol/include/sepol/policydb/expand.h	(revision 952)
+++ trunk/libsepol/include/sepol/policydb/expand.h	(working copy)
@@ -29,29 +29,42 @@
 #include <sepol/handle.h>
 #include <sepol/policydb/conditional.h>
 
+/*
+ * Expand only the avrules for a module (optionally including
+ * neverallow rules). It is valid for this function to expand
+ * base into itself (i.e. base == out); the typemap for this
+ * special case should map type[i] to i+1. No assertion or 
+ * hierarchy checking is performed.
+ */
 extern int expand_module_avrules(sepol_handle_t *handle, policydb_t *base,
 				policydb_t *out, uint32_t *typemap, 
 				int verbose, int expand_neverallow);
-extern int expand_module(sepol_handle_t * handle,
-			 policydb_t * base, policydb_t * out,
+/*
+ * Expand all parts of a module. Neverallow rules are not
+ * expanded (only copied). It is not valid to expand base
+ * into itself. If check is non-zero, performs hierarchy
+ * and assertion checking.
+ */
+extern int expand_module(sepol_handle_t *handle,
+			 policydb_t *base, policydb_t *out,
 			 int verbose, int check);
-extern int convert_type_ebitmap(ebitmap_t * src, ebitmap_t * dst,
-				uint32_t * typemap);
-extern int expand_convert_type_set(policydb_t * p, uint32_t * typemap,
-				   type_set_t * set, ebitmap_t * types,
+extern int convert_type_ebitmap(ebitmap_t *src, ebitmap_t *dst,
+				uint32_t *typemap);
+extern int expand_convert_type_set(policydb_t *p, uint32_t *typemap,
+				   type_set_t *set, ebitmap_t *types,
 				   unsigned char alwaysexpand);
-extern int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
+extern int type_set_expand(type_set_t * set, ebitmap_t *t, policydb_t *p,
 			   unsigned char alwaysexpand);
-extern int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p);
-extern int expand_rule(sepol_handle_t * handle,
-		       policydb_t * source_pol,
-		       avrule_t * source_rule, avtab_t * dest_avtab,
-		       cond_av_list_t ** cond, cond_av_list_t ** other,
+extern int role_set_expand(role_set_t *x, ebitmap_t *r, policydb_t *p);
+extern int expand_rule(sepol_handle_t *handle,
+		       policydb_t *source_pol,
+		       avrule_t *source_rule, avtab_t *dest_avtab,
+		       cond_av_list_t **cond, cond_av_list_t **other,
 		       int enabled);
 
-extern int expand_avtab(policydb_t * p, avtab_t * a, avtab_t * expa);
+extern int expand_avtab(policydb_t *p, avtab_t *a, avtab_t *expa);
 
-extern int expand_cond_av_list(policydb_t * p, cond_av_list_t * l,
-			       cond_av_list_t ** newl, avtab_t * expa);
+extern int expand_cond_av_list(policydb_t *p, cond_av_list_t *l,
+			       cond_av_list_t **newl, avtab_t *expa);
 
 #endif



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
