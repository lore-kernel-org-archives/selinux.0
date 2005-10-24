Subject: [PATCH 3/4] features/fixes for rawhide and refpolicy
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-M7fclVF8ZIiKt1EuCnFB"
Date: Mon, 24 Oct 2005 13:04:00 -0400
Message-Id: <1130173440.15661.33.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-M7fclVF8ZIiKt1EuCnFB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

libsepol changes:

bug fix for null dereference in expander
module package format changed (sectioned and versioned)

Joshua Brindle

--=-M7fclVF8ZIiKt1EuCnFB
Content-Disposition: attachment; filename=3-libsepol.diff
Content-Type: text/x-patch; name=3-libsepol.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn libsepol/src/expand.c libsepol/src/expand.c
--- libsepol/src/expand.c	2005-10-20 14:28:24.000000000 -0400
+++ libsepol/src/expand.c	2005-10-22 18:00:04.000000000 -0400
@@ -1563,7 +1563,8 @@ int type_set_expand(type_set_t *set, ebi
         ebitmap_init(&neg_types);
 	ebitmap_for_each_bit(&set->negset, tnode, i) {
                 if (ebitmap_node_get_bit(tnode, i)) {
-                        if (p->type_val_to_struct[i]->isattr) {
+                        if (p->type_val_to_struct[i] && 
+			    p->type_val_to_struct[i]->isattr) {
                                 if (ebitmap_union(&neg_types, &p->type_val_to_struct[i]->types)) {
                                         return -1;
                                 }
@@ -1580,7 +1581,8 @@ int type_set_expand(type_set_t *set, ebi
                 for (i = 0; i < p->p_types.nprim; i++) {
                         if (ebitmap_get_bit(&neg_types, i))
                                 continue;
-                        if (p->type_val_to_struct[i]->isattr)
+                        if (p->type_val_to_struct[i] &&
+			    p->type_val_to_struct[i]->isattr)
                                 continue;
                         if (ebitmap_set_bit(t, i, 1))
                                 return -1;
@@ -1596,7 +1598,8 @@ int type_set_expand(type_set_t *set, ebi
 
         if (set->flags & TYPE_COMP) {
                 for(i = 0; i < p->p_types.nprim; i++) {
-                        if (p->type_val_to_struct[i]->isattr) {
+                        if (p->type_val_to_struct[i] &&
+			    p->type_val_to_struct[i]->isattr) {
                                 assert(!ebitmap_get_bit(t, i));
                                 continue;
                         }
diff -purN -x .svn libsepol/src/module.c libsepol/src/module.c
--- libsepol/src/module.c	2005-10-20 14:28:24.000000000 -0400
+++ libsepol/src/module.c	2005-10-24 08:12:26.000000000 -0400
@@ -18,6 +18,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+
 #include <sepol/policydb/link.h>
 #include <sepol/policydb/expand.h>
 #include <sepol/policydb/module.h>
@@ -27,11 +28,52 @@
 #include <stdio.h>
 #include <stdlib.h>
 
+#define SEPOL_PACKAGE_SECTION_FC 0xf97cff90
+
+static int policy_file_seek(struct policy_file *fp, long offset) 
+{
+	switch (fp->type) {
+	case PF_USE_STDIO:
+		return fseek(fp->fp, offset, SEEK_SET);
+	case PF_USE_MEMORY:
+		if (offset > fp->size) {
+			errno = EFAULT;
+			return -1;
+		}
+		fp->data -= fp->size - fp->len;
+		fp->data += offset; 
+		fp->len = fp->size - offset;
+		return 0;	
+	default:
+		return 0;		 
+	}
+}
+
+static size_t policy_file_length(struct policy_file *fp)
+{
+	long prev_offset, end_offset;
+	switch (fp->type) {
+	case PF_USE_STDIO:
+		prev_offset = ftell(fp->fp);
+		fseek(fp->fp, 0L, SEEK_END);
+		end_offset = ftell(fp->fp);
+		fseek(fp->fp, prev_offset, SEEK_SET);
+		return end_offset;
+	case PF_USE_MEMORY:
+		return fp->size;
+	default:
+		return 0;
+	}
+}
+			
 int sepol_module_package_init(sepol_module_package_t *p)
 {
 	memset(p, 0, sizeof(sepol_module_package_t));
 	if (sepol_policydb_create(&p->policy))
 		return -1;
+
+	p->num_sections = 0;
+	p->version = 1;
 	return 0;
 }
 
@@ -181,159 +223,245 @@ static int read_helper(char *buf, struct
 	return 0;
 }
 
-int sepol_module_package_read(sepol_module_package_t *mod, 
-			      struct sepol_policy_file *spf, int verbose)
+/* Get the section offsets from a package file, offsets will be malloc'd to
+ * the appropriate size and the caller must free() them */
+static int sepol_module_package_read_offsets(sepol_module_package_t *mod, 
+				struct policy_file *file, long **offsets)
 {
-	struct policy_file *file= &spf->pf;
 	uint32_t *buf;
-        int retval;
+	int i;
 
-	buf = next_entry(file, sizeof(uint32_t) * 2);
+	buf = next_entry(file, sizeof(uint32_t) * 3);
 	if (!buf)
 		return -1;
 	if (le32_to_cpu(buf[0]) != SEPOL_MODULE_PACKAGE_MAGIC) {
 		return -1;	
 	}
-	mod->file_contexts_len = le32_to_cpu(buf[1]);
 	
-	if (mod->file_contexts_len) {		
-		mod->file_contexts = (char *)malloc(mod->file_contexts_len);
-		if (!mod->file_contexts) {
-			return -1;	
+	mod->version = le32_to_cpu(buf[1]);
+	mod->num_sections = le32_to_cpu(buf[2]);
+
+	*offsets = (long *)malloc((mod->num_sections + 1) * sizeof(long));
+	if (!*offsets)
+		return -1;
+
+	buf = next_entry(file, sizeof(uint32_t) * mod->num_sections);
+	if (!buf)
+		return -1;
+
+	for (i = 0; i < mod->num_sections; i++)
+		(*offsets)[i] = buf[i];
+
+	(*offsets)[mod->num_sections] = policy_file_length(file);
+	return 0;
+}
+
+int sepol_module_package_read(sepol_module_package_t *mod, 
+			      struct sepol_policy_file *spf, int verbose)
+{
+	struct policy_file *file= &spf->pf;
+	uint32_t *buf;
+	long *offsets;
+	size_t len;
+        int retval = -1, i;
+
+
+	if (sepol_module_package_read_offsets(mod, file, &offsets))
+		return -1;
+
+	/* we know the section offsets, seek to them and read in the data */
+
+	for (i = 0; i < mod->num_sections; i++ ) {
+	
+		if (policy_file_seek(file, offsets[i]))
+			goto cleanup;
+
+		len = offsets[i + 1] - offsets[i];
+
+		/* read the magic number, so that we know which function to call */
+		buf = next_entry(file, sizeof(uint32_t));
+		if (!buf)
+			goto cleanup;
+
+		switch(buf[0]) {
+		case SEPOL_PACKAGE_SECTION_FC:
+			mod->file_contexts_len = len - 4;
+			mod->file_contexts = (char *)malloc(len);
+			if (!mod->file_contexts) {
+				goto cleanup;
+			}
+			if (read_helper(mod->file_contexts, file, mod->file_contexts_len)) {
+                        	free(mod->file_contexts);
+	                        mod->file_contexts = NULL;
+				goto cleanup;
+        	        }
+			break;
+		case POLICYDB_MOD_MAGIC:
+			/* seek back to where the magic number was */
+			if (policy_file_seek(file, offsets[i])) 
+				goto cleanup;
+
+			retval = policydb_read(&mod->policy->p, file, verbose);
+		        if (retval < 0) {
+		                /* don't destroy the policy -- policydb did that already */
+		                free(mod->policy);
+		                mod->policy = NULL;
+		        }
+			break;
+		default:
+			/* unknown section, ignore */	
+			break;
 		}
-		if (read_helper(mod->file_contexts, file, mod->file_contexts_len)) {
-                        free(mod->file_contexts);
-                        mod->file_contexts = NULL;
-			return -1;
-                }
 	}
 
-	retval = policydb_read(&mod->policy->p, file, verbose);
-        if (retval < 0) {
-                /* don't destroy the policy -- policydb did that already */
-                free(mod->policy);
-                mod->policy = NULL;
-        }
+	free(offsets);
+	return 0;
 
+cleanup:
+	free(offsets);
         return retval;
 }
 
 int sepol_module_package_info(struct sepol_policy_file *spf, int *type, char **name, char **version)
 {
 	struct policy_file *file = &spf->pf;
-	uint32_t *buf, *buf2, len;
+	sepol_module_package_t *mod;
+	uint32_t *buf, len;
+	long *offsets;
+	int i;
 
-	buf = next_entry(file, sizeof(uint32_t) * 2);
-	if (!buf)
+	if (sepol_module_package_create(&mod))
 		return -1;
-	if (le32_to_cpu(buf[0]) != SEPOL_MODULE_PACKAGE_MAGIC) {
-		return -1;	
-	}
-	
-	/* skip file contexts */
-	len = le32_to_cpu(buf[1]);
-	if (len) {
-		buf2 = malloc(len);
-		if (!buf2) {
-			return -1;	
-		}
-		if (read_helper((char*)buf2, file, len)) {
-                        free(buf2);
-			return -1;
-                }
-		free(buf2);
-	}
-	
-	buf = next_entry(file, sizeof(uint32_t)* 2);
-	if (!buf) {
-		return -1;
-	}
-        if (le32_to_cpu(buf[0]) != POLICYDB_MOD_MAGIC) {
-                return -1;
-        }
 
-	len = le32_to_cpu(buf[1]);
-	if (len != strlen(POLICYDB_MOD_STRING)) {
+	if (sepol_module_package_read_offsets(mod, file, &offsets))
 		return -1;
-	}
+
+	for (i = 0; i < mod->num_sections; i++ ) {
 	
-	/* skip id */
-	buf = next_entry(file, len);
-	if (!buf) {
-		return -1;
-	}
+		if (policy_file_seek(file, offsets[i]))
+			goto cleanup;
+
+		len = offsets[i + 1] - offsets[i];
+
+		/* read the magic number, so that we know which function to call */
+		buf = next_entry(file, sizeof(uint32_t) * 2);
+		if (!buf)
+			goto cleanup;
+
+		switch(buf[0]) {
+		case SEPOL_PACKAGE_SECTION_FC:
+		/* skip file contexts */
+			break;
+		case POLICYDB_MOD_MAGIC:
+			len = le32_to_cpu(buf[1]);
+			if (len != strlen(POLICYDB_MOD_STRING)) {
+				goto cleanup;
+			}
 	
-	buf = next_entry(file, sizeof(uint32_t)* 5);
-	if (!buf)
-		return -1;
+			/* skip id */
+			buf = next_entry(file, len);
+			if (!buf) {
+				goto cleanup;
+			}
 	
-	*type = le32_to_cpu(buf[0]);
-	/* if base - we're done */
-	if (*type == POLICY_BASE) {
-		*name = NULL;
-		*version = NULL;
-		return 0;
-	} else if (*type != POLICY_MOD) {
-		return -1;	
-	}
+			buf = next_entry(file, sizeof(uint32_t)* 5);
+			if (!buf)
+				goto cleanup;
 	
-	/* read the name and version */
-	buf = next_entry(file, sizeof(uint32_t));
-        if (!buf)
-                return -1;
-        len = le32_to_cpu(buf[0]);
-        buf = next_entry(file, len);
-        if (!buf)
-                return -1;
-        *name = malloc(len + 1);
-        if (!*name) {
-                return -1;
-        }
-        memcpy(*name, buf, len);
-        (*name)[len] = '\0';
-        buf = next_entry(file, sizeof(uint32_t));
-        if (!buf)
-                return -1;
-        len = le32_to_cpu(buf[0]);
-        buf = next_entry(file, len);
-        if (!buf)
-                return -1;
-        *version = malloc(len + 1);
-        if (!*version)
-                return -1;
-        memcpy(*version, buf, len);
-        (*version)[len] = '\0';
+			*type = le32_to_cpu(buf[0]);
+			/* if base - we're done */
+			if (*type == POLICY_BASE) {
+				*name = NULL;
+				*version = NULL;
+				return 0;
+			} else if (*type != POLICY_MOD) {
+				goto cleanup;	
+			}
+	
+			/* read the name and version */
+			buf = next_entry(file, sizeof(uint32_t));
+		        if (!buf)
+                		goto cleanup;
+		        len = le32_to_cpu(buf[0]);
+		        buf = next_entry(file, len);
+		        if (!buf)
+		                goto cleanup;
+		        *name = malloc(len + 1);
+		        if (!*name) {
+		                goto cleanup;
+		        }
+		        memcpy(*name, buf, len);
+		        (*name)[len] = '\0';
+		        buf = next_entry(file, sizeof(uint32_t));
+		        if (!buf)
+		                goto cleanup;
+		        len = le32_to_cpu(buf[0]);
+		        buf = next_entry(file, len);
+		        if (!buf)
+		                goto cleanup;
+		        *version = malloc(len + 1);
+		        if (!*version)
+		                goto cleanup;
+		        memcpy(*version, buf, len);
+		        (*version)[len] = '\0';
+			break;
+		default:
+			break;
+		}
+
+	}
+	free(offsets);
 	return 0;
+
+cleanup:
+	free(offsets);
+	return -1;
 }
 
 int sepol_module_package_write(sepol_module_package_t *p, 
 			       struct sepol_policy_file *spf)
 {
 	struct policy_file *file = &spf->pf;
-	uint32_t buf[1], len, len2, index;
+	uint32_t buf[3], offsets[2], len, len2, idx;
 	int rc;
 
+	if (p->policy)
+		p->num_sections++;
+
+	if (p->file_contexts)
+		p->num_sections++;
+
 	buf[0] = cpu_to_le32(SEPOL_MODULE_PACKAGE_MAGIC);
-	if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
+	buf[1] = cpu_to_le32(p->version);
+	buf[2] = cpu_to_le32(p->num_sections);
+	if (put_entry(buf, sizeof(uint32_t), 3, file) != 3)
 		return -1;
-		
-	buf[0] = cpu_to_le32(p->file_contexts_len);
+
+	/* first section offset (file_contexts) */
+	offsets[0] = (p->num_sections + 3) * sizeof(uint32_t);
+	/* second section (module data) offset is file_contexts + fc_magic_num */	
+	offsets[1] = offsets[0] + sizeof(uint32_t) + p->file_contexts_len;
+	buf[0] = cpu_to_le32(offsets[0]);
+	buf[1] = cpu_to_le32(offsets[1]);
+	if (put_entry(buf, sizeof(uint32_t), 2, file) != 2)
+		return -1;
+	
+	buf[0] = cpu_to_le32(SEPOL_PACKAGE_SECTION_FC);
 	if (put_entry(buf, sizeof(uint32_t), 1, file) != 1)
 		return -1;
-		
+	idx = 0;
 	len = p->file_contexts_len;
-	index = 0;
 	while (len) {
 		if (len > BUFSIZ)
 			len2 = BUFSIZ;
 		else
 			len2 = len;
 
-		if (put_entry(&p->file_contexts[index], 1, len2, file) != len2) {
+		if (put_entry(&p->file_contexts[idx], 1, len2, file) != len2) {
 			return -1;
 		}
 		len -= len2;
-		index += len2;
+		idx += len2;
 	}
 	
 	rc = policydb_write(&p->policy->p, file);
diff -purN -x .svn libsepol/src/policydb_public.c libsepol/src/policydb_public.c
--- libsepol/src/policydb_public.c	2005-10-18 11:07:00.000000000 -0400
+++ libsepol/src/policydb_public.c	2005-10-24 08:12:26.000000000 -0400
@@ -26,6 +26,7 @@ void sepol_policy_file_set_mem(sepol_pol
 	pf->type = PF_USE_MEMORY;
 	pf->data = data;
 	pf->len = len;
+	pf->size = len;
 	return;
 }
 
diff -purN -x .svn libsepol/include/sepol/policydb/module.h libsepol/include/sepol/policydb/module.h
--- libsepol/include/sepol/policydb/module.h	2005-10-20 14:28:01.000000000 -0400
+++ libsepol/include/sepol/policydb/module.h	2005-10-24 08:12:26.000000000 -0400
@@ -28,11 +28,13 @@
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/conditional.h>
 
-#define SEPOL_MODULE_PACKAGE_MAGIC 0xf97cff8e
+#define SEPOL_MODULE_PACKAGE_MAGIC 0xf97cff8f
 
 struct sepol_module_package {
 	sepol_policydb_t *policy;
-	char 		*file_contexts;
+	int		 version;
+	int		 num_sections;
+	char 		 *file_contexts;
 	size_t	         file_contexts_len;
 };
 
diff -purN -x .svn libsepol/include/sepol/policydb/policydb.h libsepol/include/sepol/policydb/policydb.h
--- libsepol/include/sepol/policydb/policydb.h	2005-10-20 14:28:01.000000000 -0400
+++ libsepol/include/sepol/policydb/policydb.h	2005-10-24 08:12:26.000000000 -0400
@@ -519,6 +519,7 @@ typedef struct policy_file {
 	unsigned type;
 	char *data;
 	size_t len;
+	size_t size;
 	FILE *fp;
 	struct sepol_handle *handle;
         unsigned char buffer[BUFSIZ];

--=-M7fclVF8ZIiKt1EuCnFB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
