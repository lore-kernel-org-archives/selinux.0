Message-ID: <43DFBDCD.8010506@tresys.com>
Date: Tue, 31 Jan 2006 14:43:09 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/2] - use common av_to_string implementation
Content-Type: multipart/mixed;
 boundary="------------000104050104070509010709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000104050104070509010709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

While debugging the last problem I found that dispol/dismod av rendering
was not working correctly. Since we moved av_to_string into libsepol
(statically) a while back for assertions we should use it for apps like
dispol/dismod that link statically against libsepol. This changes it to
sepol_av_to_string, moves it to util.c and removes the redundant code
from dismod and dispol.



--------------000104050104070509010709
Content-Type: text/x-patch;
 name="2-common-av_to_string.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2-common-av_to_string.diff"

diff -purN -x.svn checkpolicy/test/dismod.c checkpolicy/test/dismod.c
--- checkpolicy/test/dismod.c	2005-10-25 13:15:27.000000000 -0400
+++ checkpolicy/test/dismod.c	2006-01-31 16:32:46.000000000 -0500
@@ -60,62 +60,24 @@ void usage(char *progname)
 	exit(1);
 }
 
-/* borrowed from checkpolicy.c */
-static int find_perm(hashtab_key_t key, hashtab_datum_t datum, void *p)
-{
-	unsigned int *valuep;
-	perm_datum_t *perdatum;
-
-	valuep = (unsigned int *) p;
-	perdatum = (perm_datum_t *) datum;
-
-	if (*valuep == perdatum->value)
-		return (int) key;
-
-	return 0;
-}
-
 static void render_access_mask(uint32_t mask, uint32_t class, policydb_t *p, FILE *fp)
 {
-	unsigned int i;
-	class_datum_t *cladatum;
 	char *perm;
-	cladatum = p->class_val_to_struct[class - 1];
 	fprintf(fp, "{");
-	for (i = 1; i <= sizeof(mask) * 8; i++) {
-		if (mask & (1 << (i - 1))) {
-			perm = (char *) hashtab_map(cladatum->permissions.table,
-				  find_perm, &i);
-
-			if (!perm && cladatum->comdatum) {
-				perm = (char *) hashtab_map(cladatum->comdatum->permissions.table,
-				  find_perm, &i);
-			}
-			if (perm)
-				fprintf(fp, " %s", perm);
-		}
-	}
-	fprintf(fp, " }");
+	perm = sepol_av_to_string(p, class, mask);
+	if (perm)
+		fprintf(fp, "%s ", perm);
+	fprintf(fp, "}");
 }
 
 static void render_access_bitmap(ebitmap_t *map, uint32_t class, policydb_t *p, FILE *fp)
 {
 	unsigned int i;
-        uint32_t perm_value;
-	class_datum_t *cladatum;
 	char *perm;
-	cladatum = p->class_val_to_struct[class - 1];
 	fprintf(fp, "{");
         for (i = ebitmap_startbit(map); i < ebitmap_length(map); i++) {
                 if (ebitmap_get_bit(map, i)) {
-                        perm_value = i + 1;
-			perm = (char *) hashtab_map(cladatum->permissions.table,
-				  find_perm, &perm_value);
-
-			if (!perm && cladatum->comdatum) {
-				perm = (char *) hashtab_map(cladatum->comdatum->permissions.table,
-				  find_perm, &perm_value);
-			}
+			perm = sepol_av_to_string(p, class, 1 << i);
 			if (perm)
 				fprintf(fp, " %s", perm);
 		}
@@ -303,11 +265,11 @@ int display_avrule(avrule_t *avrule, uin
 		fprintf(fp, " }");
 	fprintf(fp, " ");
 
-	if( avrule->specified & AVRULE_AV) {
+	if( avrule->specified & (AVRULE_AV | AVRULE_NEVERALLOW)) { 
 		render_access_mask(avrule->perms->data, avrule->perms->class, policy, fp);
 	} else if ( avrule->specified & AVRULE_TYPE) {
                 display_id(policy, fp, SYM_TYPES, avrule->perms->data - 1, "");
-	}
+	} 
 
 	fprintf(fp, ";\n");
 
diff -purN -x.svn checkpolicy/test/dispol.c checkpolicy/test/dispol.c
--- checkpolicy/test/dispol.c	2005-10-11 15:02:49.000000000 -0400
+++ checkpolicy/test/dispol.c	2006-01-31 15:51:35.000000000 -0500
@@ -41,42 +41,14 @@ void usage(char *progname)
 	exit(1);
 }
 
-/* borrowed from checkpolicy.c */
-static int find_perm(hashtab_key_t key, hashtab_datum_t datum, void *p)
-{
-	unsigned int *valuep;
-	perm_datum_t *perdatum;
-
-	valuep = (unsigned int *) p;
-	perdatum = (perm_datum_t *) datum;
-
-	if (*valuep == perdatum->value)
-		return (int) key;
-
-	return 0;
-}
-
 int render_access_mask(uint32_t mask, avtab_key_t *key, policydb_t *p, FILE *fp)
 {
-	unsigned int i;
-	class_datum_t *cladatum;
 	char *perm;
-	cladatum = p->class_val_to_struct[key->target_class -1];
 	fprintf(fp, "{");
-	for (i = 1; i <= sizeof(mask) * 8; i++) {
-		if (mask & (1 << (i - 1))) {
-			perm = (char *) hashtab_map(cladatum->permissions.table,
-				  find_perm, &i);
-
-			if (!perm && cladatum->comdatum) {
-				perm = (char *) hashtab_map(cladatum->comdatum->permissions.table,
-				  find_perm, &i);
-			}
-			if (perm)
-				fprintf(fp, " %s", perm);
-		}
-	}
-	fprintf(fp, " }");
+	perm = sepol_av_to_string(p, key->target_class, mask);
+	if (perm)
+		fprintf(fp, "%s ", perm);
+	fprintf(fp, "}");
 	return 0;
 }
 
diff -purN -x.svn libsepol/include/sepol/policydb/policydb.h libsepol/include/sepol/policydb/policydb.h
--- libsepol/include/sepol/policydb/policydb.h	2006-01-23 13:47:25.000000000 -0500
+++ libsepol/include/sepol/policydb/policydb.h	2006-01-31 15:22:56.000000000 -0500
@@ -509,6 +509,9 @@ extern int symtab_insert(policydb_t *x, 
                   uint32_t scope, uint32_t avrule_decl_id,
                   uint32_t *value);
 
+extern char *sepol_av_to_string(policydb_t *policydbp, uint32_t tclass, 
+			 sepol_access_vector_t av);
+
 /* A policy "file" may be a memory region referenced by a (data, len) pair
    or a file referenced by a FILE pointer. */
 typedef struct policy_file {
diff -purN -x.svn libsepol/src/assertion.c libsepol/src/assertion.c
--- libsepol/src/assertion.c	2006-01-23 13:47:26.000000000 -0500
+++ libsepol/src/assertion.c	2006-01-31 15:18:16.000000000 -0500
@@ -26,65 +26,6 @@
 
 #include "debug.h"
 
-/* This isn't exactly the best place to put this but it will do 
-   until something else needs it */
-struct val_to_name {
-	unsigned int val;
-	char *name;
-};
-
-static int perm_name(hashtab_key_t key, hashtab_datum_t datum, void *data)
-{       
-        struct val_to_name *v = data;
-        perm_datum_t *perdatum;
-                
-        perdatum = (perm_datum_t *) datum;
-
-        if (v->val == perdatum->value) {
-                v->name = key;
-                return 1;
-        }       
-        
-        return 0;
-}       
-   
-static char *av_to_string(policydb_t *policydbp, uint32_t tclass, sepol_access_vector_t av)
-{               
-        struct val_to_name v;
-        static char avbuf[1024];
-        class_datum_t *cladatum;
-        char *perm = NULL, *p;
-        unsigned int i;
-        int rc; 
-        int avlen = 0, len;
-                
-        cladatum = policydbp->class_val_to_struct[tclass-1];
-        p = avbuf;
-        for (i = 0; i < cladatum->permissions.nprim; i++) {
-                if (av & (1 << i)) {
-                        v.val = i+1;
-                        rc = hashtab_map(cladatum->permissions.table,
-                                         perm_name, &v);
-                        if (!rc && cladatum->comdatum) {
-                                rc = hashtab_map(
-                                        cladatum->comdatum->permissions.table,
-                                        perm_name, &v);
-                        }
-                        if (rc)
-                                perm = v.name;
-                        if (perm) {
-				len = snprintf(p, sizeof(avbuf) - avlen, " %s", perm);
-				if (len < 0 || (size_t) len >= (sizeof(avbuf) - avlen))
-					return NULL;
-				p += len;
-				avlen += len;
-                        }
-                }
-        }
-
-        return avbuf;
-}
-
 static int check_assertion_helper(sepol_handle_t *handle,
 				  policydb_t *p, 
 				  avtab_t *te_avtab, avtab_t *te_cond_avtab,
@@ -120,7 +61,7 @@ err:
 	ERR(handle, "assertion on line %lu violated by allow %s %s:%s {%s };",
 	    line, p->p_type_val_to_name[stype], p->p_type_val_to_name[ttype],
 	    p->p_class_val_to_name[curperm->class - 1],
-	    av_to_string(p, curperm->class, node->datum.data & curperm->data));
+	    sepol_av_to_string(p, curperm->class, node->datum.data & curperm->data));
 	return -1;
 }
 
diff -purN -x.svn libsepol/src/util.c libsepol/src/util.c
--- libsepol/src/util.c	2005-10-20 14:50:05.000000000 -0400
+++ libsepol/src/util.c	2006-01-31 15:24:15.000000000 -0500
@@ -28,6 +28,11 @@
 #include <sepol/policydb/flask_types.h>
 #include <sepol/policydb/policydb.h>
 
+static struct val_to_name {
+	unsigned int val;
+	char *name;
+};
+
 /* Add an unsigned integer to a dynamically reallocated array.  *cnt
  * is a reference pointer to the number of values already within array
  * *a; it will be incremented upon successfully appending i.  If *a is
@@ -235,3 +240,54 @@ int symtab_insert(policydb_t *pol, uint3
         return retval;
 }
 
+static int perm_name(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{       
+        struct val_to_name *v = data;
+        perm_datum_t *perdatum;
+                
+        perdatum = (perm_datum_t *) datum;
+
+        if (v->val == perdatum->value) {
+                v->name = key;
+                return 1;
+        }       
+        
+        return 0;
+}       
+   
+char *sepol_av_to_string(policydb_t *policydbp, uint32_t tclass, sepol_access_vector_t av)
+{               
+        struct val_to_name v;
+        static char avbuf[1024];
+        class_datum_t *cladatum;
+        char *perm = NULL, *p;
+        unsigned int i;
+        int rc; 
+        int avlen = 0, len;
+                
+        cladatum = policydbp->class_val_to_struct[tclass-1];
+        p = avbuf;
+        for (i = 0; i < cladatum->permissions.nprim; i++) {
+                if (av & (1 << i)) {
+                        v.val = i+1;
+                        rc = hashtab_map(cladatum->permissions.table,
+                                         perm_name, &v);
+                        if (!rc && cladatum->comdatum) {
+                                rc = hashtab_map(
+                                        cladatum->comdatum->permissions.table,
+                                        perm_name, &v);
+                        }
+                        if (rc)
+                                perm = v.name;
+                        if (perm) {
+				len = snprintf(p, sizeof(avbuf) - avlen, " %s", perm);
+				if (len < 0 || (size_t) len >= (sizeof(avbuf) - avlen))
+					return NULL;
+				p += len;
+				avlen += len;
+                        }
+                }
+        }
+
+        return avbuf;
+}


--------------000104050104070509010709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
