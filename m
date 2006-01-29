Message-ID: <43DC0E2E.7030804@cornell.edu>
Date: Sat, 28 Jan 2006 17:37:02 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEPOL] Fix overflow bugs on athlon 64
Content-Type: multipart/mixed;
 boundary="------------070900020101090109080501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070900020101090109080501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix overflow bugs of two kinds, visible on my athlon64:

- find perm should not abuse the integer (4 byte) return value to put an 
8-byte char* in it.
- Use %ul to print size_t, %u will overflow.

Also, someone should take a look into this:

==31626== Syscall param write(buf) points to uninitialised byte(s)
==31626==    at 0x37E2EBBC60: __write_nocancel (in /lib64/libc-2.3.90.so)
==31626==    by 0x37E2E66812: _IO_file_write@@GLIBC_2.2.5 (in 
/lib64/libc-2.3.90.so)
==31626==    by 0x37E2E66725: _IO_do_write@@GLIBC_2.2.5 (in 
/lib64/libc-2.3.90.so)
==31626==    by 0x37E2E67B48: _IO_file_xsputn@@GLIBC_2.2.5 (in 
/lib64/libc-2.3.90.so)
==31626==    by 0x37E2E5DB59: fwrite (in /lib64/libc-2.3.90.so)
==31626==    by 0x4A913D0: put_entry (private.h:69)
==31626==    by 0x4A93088: class_write (write.c:816)
==31626==    by 0x4A747D4: hashtab_map (hashtab.c:236)
==31626==    by 0x4A950EE: policydb_write (write.c:1483)
==31626==    by 0x4A81713: sepol_module_package_write (module.c:573)
==31626==    by 0x4BBD39F: semanage_write_module (in 
/lib64/libsemanage.so.1)
==31626==    by 0x4BBD76C: semanage_direct_commit (in 
/lib64/libsemanage.so.1)

One suspicious thing is passing the 8-byte size_t values len/len2 into 
cpu_to_le32, but I couldn't completely track this down, so I leave it to 
someone else for now :)


--------------070900020101090109080501
Content-Type: text/x-patch;
 name="libsepol.fix_overflow.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.fix_overflow.diff"

diff -Naurp --exclude-from excludes old/libsepol/src/link.c new/libsepol/src/link.c
--- old/libsepol/src/link.c	2005-10-18 08:08:39.000000000 -0600
+++ new/libsepol/src/link.c	2006-01-28 17:07:41.000000000 -0700
@@ -1358,16 +1358,24 @@ static int copy_module(link_state_t *sta
 /***** functions that check requirements and enable blocks in a module ******/
 
 /* borrowed from checkpolicy.c */
-static int find_perm(hashtab_key_t key, hashtab_datum_t datum, void *p)
-{
-	unsigned int *valuep;
-	perm_datum_t *perdatum;
-
-	valuep = (unsigned int *) p;
-	perdatum = (perm_datum_t *) datum;
 
-	if (*valuep == perdatum->value)
-		return (int) key;
+struct find_perm_arg {
+	unsigned int valuep;
+	hashtab_key_t key;
+};
+
+static int find_perm(
+	hashtab_key_t key, 
+	hashtab_datum_t datum, 
+	void *varg) {
+
+	struct find_perm_arg* arg = varg;
+
+	perm_datum_t* perdatum = (perm_datum_t *) datum;
+	if (arg->valuep == perdatum->value) {
+		arg->key = key;
+		return 1;
+	}
 
 	return 0;
 }
@@ -1424,8 +1432,12 @@ static int is_decl_requires_met(link_sta
         }
         /* check that all classes and permissions have been satisfied */
         for (i = 0; i < decl->required.class_perms_len; i++) {
+
                 bitmap = decl->required.class_perms_map + i;
 		ebitmap_for_each_bit(bitmap, node, j) {
+
+                        struct find_perm_arg fparg;
+
                         class_datum_t *cladatum;
                         uint32_t perm_value = j + 1;
                         if (!ebitmap_node_get_bit(node, j)) {
@@ -1433,10 +1445,15 @@ static int is_decl_requires_met(link_sta
                         }
                         id = pol->p_class_val_to_name[i];
                         cladatum = pol->class_val_to_struct[i];
-                        perm_id = (char *) hashtab_map(cladatum->permissions.table, find_perm, &perm_value);
-                        if (perm_id == NULL && cladatum->comdatum != NULL) {
-                                perm_id = (char *) hashtab_map(cladatum->comdatum->permissions.table, find_perm, &perm_value);
-                        }
+		
+			fparg.valuep = perm_value;
+			fparg.key = NULL;
+			
+                        hashtab_map(cladatum->permissions.table, find_perm, &fparg);
+                        if (fparg.key == NULL && cladatum->comdatum != NULL)
+                               hashtab_map(cladatum->comdatum->permissions.table, find_perm, &fparg);
+                        perm_id = fparg.key;
+
                         assert(perm_id != NULL);
                         if (!is_perm_enabled(id, perm_id, state->base)) {
                                 if (req != NULL) {
@@ -1523,14 +1540,21 @@ static int verify_module_requirements(li
                 module_global->enabled = 0;
                 if (!is_decl_requires_met(state, module_global, &req)) {
                         if (req.symbol_type == SYM_CLASSES) {
+	
+                                struct find_perm_arg fparg;
+
                                 class_datum_t *cladatum;
                                 cladatum = p->class_val_to_struct[req.symbol_value - 1];
-                                char *perm_id = (char *)hashtab_map(cladatum->permissions.table, find_perm, &req.perm_value);
+
+                                fparg.valuep = req.perm_value;
+                                fparg.key = NULL;
+                                hashtab_map(cladatum->permissions.table, find_perm, &fparg);
+
                                 ERR(state->handle,
                                             "Module %s's global requirements were not met: class %s, permission %s",
                                             mod_name,
                                             p->p_class_val_to_name[req.symbol_value - 1],
-                                            perm_id);
+                                            fparg.key);
                                 return -1;
                         }
                         else {
diff -Naurp --exclude-from excludes old/libsepol/src/module.c new/libsepol/src/module.c
--- old/libsepol/src/module.c	2005-11-15 06:06:55.000000000 -0700
+++ new/libsepol/src/module.c	2006-01-28 16:50:02.000000000 -0700
@@ -274,7 +274,8 @@ static int module_package_read_offsets(s
 	for (i = 0; i < mod->num_sections; i++) {
 		(*offsets)[i] = le32_to_cpu(buf[i]);
 		if (i && (*offsets)[i] < (*offsets)[i - 1]) {
-			ERR(file->handle, "offsets are not increasing (at %u, offset %u->%u)", i, (*offsets)[i-1], (*offsets)[i]);
+			ERR(file->handle, "offsets are not increasing (at %u, "
+				"offset %lu -> %lu)", i, (*offsets)[i-1], (*offsets)[i]);
 			return -1;
 		}
 	}
@@ -304,14 +305,16 @@ int sepol_module_package_read(sepol_modu
 	for (i = 0; i < mod->num_sections; i++ ) {
 	
 		if (policy_file_seek(file, offsets[i])) {
-			ERR(file->handle, "error seeking to offset %u for module package section %u", offsets[i], i);
+			ERR(file->handle, "error seeking to offset %lu for "
+				"module package section %u", offsets[i], i);
 			goto cleanup;
 		}
 
 		len = offsets[i + 1] - offsets[i];
 
 		if (len < sizeof(uint32_t)) {
-			ERR(file->handle, "module package section %u has too small length %u", i, len);
+			ERR(file->handle, "module package section %u "
+				"has too small length %lu", i, len);
 			goto cleanup;
 		}
 
@@ -397,7 +400,8 @@ int sepol_module_package_info(struct sep
 	for (i = 0; i < mod->num_sections; i++ ) {
 	
 		if (policy_file_seek(file, offsets[i])) {
-			ERR(file->handle, "error seeking to offset %u for module package section %u", offsets[i], i);
+			ERR(file->handle, "error seeking to offset "
+				"%lu for module package section %u", offsets[i], i);
 			goto cleanup;
 		}
 

--------------070900020101090109080501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
