Message-ID: <43765D20.9070200@cornell.edu>
Date: Sat, 12 Nov 2005 16:22:40 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL ] Add sepol_policydb_mls_enabled, organize map file
Content-Type: multipart/mixed;
 boundary="------------020708090202080307000609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020708090202080307000609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:

- adds new function to check if policydb is mls enabled (target is 
libsemanage: user/seuser/context parsers)

- marks sepol_module_package_init static (not used outside that file/not 
exported)
- removes sepol_ prefix on two module functions that are not exported 
(init, read_offsets)

- use wildcards in more places in the map file, to make it a bit more 
organized. Enforce "_" after suffix, and organize things by the objects 
being managed.

I like that the change makes it easy to see which functions are not 
following proper namespace/convention. Also, it's easy to see when API's 
being chaged (marked with sepol_). Also, makes names shorter (but if not 
marked static, this could be a namespace problem for static linking). 
Also, allows grep for exported functions for each object.

On the other hand, with wildcards things can be exported by mistake in 
the future - not sure if that's a significant problem. You could argue 
against this change, but then I don't understand why many functions were 
marked hidden in services.c. Either we should or should not use 
wildcards - I don't care which, but it should be consistent.

--------------020708090202080307000609
Content-Type: text/x-patch;
 name="libsepol.mls_enabled.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.mls_enabled.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/include/sepol/policydb.h new/libsepol/include/sepol/policydb.h
--- old/libsepol/include/sepol/policydb.h	2005-10-18 10:08:39.000000000 -0400
+++ new/libsepol/include/sepol/policydb.h	2005-11-12 15:42:20.000000000 -0500
@@ -123,6 +123,12 @@ extern int sepol_policydb_to_image(sepol
 				   sepol_policydb_t *p, 
 				   void **newdata, 
 				   size_t *newlen);
+/*
+ * Check if this policy is MLS-enabled. 
+ * Return 1 if enabled, 0 otherwise.
+ */
+extern int sepol_policydb_mls_enabled(
+	sepol_policydb_t *p);
 
 #endif
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/libsepol.map new/libsepol/src/libsepol.map
--- old/libsepol/src/libsepol.map	2005-11-08 12:10:25.000000000 -0500
+++ new/libsepol/src/libsepol.map	2005-11-12 15:46:04.000000000 -0500
@@ -1,26 +1,14 @@
 {
   global: 
-	sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers; sepol_debug; 
-	sepol_policy_file_create; sepol_policy_file_free;
-	sepol_policy_file_set_mem; sepol_policy_file_set_fp;
-	sepol_policy_file_get_len; sepol_policy_file_set_handle;
-	sepol_policydb_create; sepol_policydb_free;
-	sepol_policy_kern_vers_min; sepol_policy_kern_vers_max;
-	sepol_policydb_set_typesvers; sepol_policydb_set_vers;
-	sepol_policydb_read; sepol_policydb_write;
-	sepol_policydb_from_image; sepol_policydb_to_image;
-	sepol_module_package_create; sepol_module_package_free; 
-	sepol_module_package_get_file_contexts;
-	sepol_module_package_get_file_contexts_len;
-	sepol_module_package_set_file_contexts;	
-	sepol_module_package_get_policy;
-	sepol_link_packages; 
-	sepol_module_package_read; sepol_module_package_info;
-	sepol_module_package_write; 
-	sepol_link_modules; sepol_expand_module;
-	sepol_bool*; sepol_context*;
-	sepol_iface*; sepol_user*; 
-	sepol_set_delusers;
-	sepol_msg_*; sepol_handle_*;
+	sepol_module_package_*; sepol_link_modules; sepol_expand_module; sepol_link_packages;
+	sepol_bool_*; sepol_genbools*; 
+	sepol_context*; sepol_check_context;
+	sepol_iface_*; 
+	sepol_user_*; sepol_genusers; sepol_set_delusers;
+	sepol_msg_*; sepol_debug;
+	sepol_handle_*;
+	sepol_policydb_*; sepol_set_policydb_from_file; 
+	sepol_policy_kern_*;
+	sepol_policy_file_*;
   local: *;
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/module.c new/libsepol/src/module.c
--- old/libsepol/src/module.c	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/module.c	2005-11-12 15:39:04.000000000 -0500
@@ -72,7 +72,7 @@ static size_t policy_file_length(struct 
 	}
 }
 			
-int sepol_module_package_init(sepol_module_package_t *p)
+static int module_package_init(sepol_module_package_t *p)
 {
 	memset(p, 0, sizeof(sepol_module_package_t));
 	if (sepol_policydb_create(&p->policy))
@@ -88,7 +88,7 @@ int sepol_module_package_create(sepol_mo
 	*p = calloc(1, sizeof(sepol_module_package_t));
 	if (!(*p))
 		return -1;
-	return sepol_module_package_init(*p);
+	return module_package_init(*p);
 }
 hidden_def(sepol_module_package_create)
 
@@ -235,7 +235,7 @@ static int read_helper(char *buf, struct
 
 /* Get the section offsets from a package file, offsets will be malloc'd to
  * the appropriate size and the caller must free() them */
-static int sepol_module_package_read_offsets(sepol_module_package_t *mod, 
+static int module_package_read_offsets(sepol_module_package_t *mod, 
 				struct policy_file *file, size_t **offsets)
 {
 	uint32_t *buf;
@@ -296,7 +296,7 @@ int sepol_module_package_read(sepol_modu
         int retval = -1;
 	unsigned i, seen = 0;
 
-	if (sepol_module_package_read_offsets(mod, file, &offsets))
+	if (module_package_read_offsets(mod, file, &offsets))
 		return -1;
 
 	/* we know the section offsets, seek to them and read in the data */
@@ -390,7 +390,7 @@ int sepol_module_package_info(struct sep
 	if (sepol_module_package_create(&mod))
 		return -1;
 
-	if (sepol_module_package_read_offsets(mod, file, &offsets)) {
+	if (module_package_read_offsets(mod, file, &offsets)) {
 		goto cleanup;
 	}
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsepol/src/policydb_public.c new/libsepol/src/policydb_public.c
--- old/libsepol/src/policydb_public.c	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/policydb_public.c	2005-11-12 15:44:02.000000000 -0500
@@ -159,3 +159,9 @@ int sepol_policydb_to_image(sepol_handle
 	return policydb_to_image(handle, &p->p, newdata, newlen);
 }
 
+int sepol_policydb_mls_enabled(
+	sepol_policydb_t *p) {
+
+	return p->p.mls;
+}
+

--------------020708090202080307000609--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
