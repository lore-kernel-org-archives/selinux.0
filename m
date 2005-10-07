Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-Jip0gFXwVolxDBO5xtl1"
Date: Fri, 07 Oct 2005 11:52:38 -0400
Message-Id: <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Jip0gFXwVolxDBO5xtl1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-10-07 at 10:30 -0400, Stephen Smalley wrote:
> Ok, I've made a first cut at the changes to libsepol and updated it and
> checkpolicy to build again, and am starting to work through libsemanage.
> As an example of what to expect, the diff below to database_direct.[ch]
> was needed to get it to compile again.

A more interesting example - conversion of direct_api.c.

Note that I dropped sepol_set_policyvers() entirely from libsepol.  The
write function now propagate the policydb down as needed and use its
policy_type and policyvers fields to determine appropriate behavior.
policydb_init (not exported by the shared libsepol, but still used
internally and called by sepol_policydb_create) initializes the version
to the maximum supported for the specified policy type.  Thus, by
default, a newly created policydb will be written with the latest
version by functions that ultimately call policydb_write, while a
policydb created via policydb_read (not exported by the shared libsepol,
but still used internally and called by sepol_policydb_from_image) will
be written with its original version presrved by functions that
ultimately call policydb_write.  We'll still need a function to allow
selection of a non-default output version, but it will be per-policydb
now.
 
-- 
Stephen Smalley
National Security Agency

--=-Jip0gFXwVolxDBO5xtl1
Content-Disposition: attachment; filename=dapi.patch
Content-Type: text/x-patch; name=dapi.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsemanage/src/direct_api.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/direct_api.c,v
retrieving revision 1.4
diff -u -p -r1.4 direct_api.c
--- libsemanage/src/direct_api.c	4 Oct 2005 12:16:17 -0000	1.4
+++ libsemanage/src/direct_api.c	7 Oct 2005 15:27:30 -0000
@@ -22,6 +22,8 @@
 #include <assert.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -121,22 +123,26 @@ static int semanage_direct_begintrans(se
 static int parse_module_headers(semanage_handle_t *sh, char *module_data,
 				size_t data_len, char **module_name,
 				char **version, char **filename) {
-	struct policy_file pf;
+	struct sepol_policy_file *pf;
 	int file_type;
 	const char *module_path;
 	*module_name = *version = *filename = NULL;
-	pf.type = PF_USE_MEMORY;
-	pf.data = module_data;
-	pf.len = data_len;
-	pf.fp = NULL;
+	
+	if (sepol_policy_file_create(&pf)) {
+		semanage_write_error(sh, "Out of memory!");
+		return -1;
+	}
+	sepol_policy_file_set_mem(pf, module_data, data_len);
 	if (module_data == NULL ||
 	    data_len == 0 ||
-	    sepol_module_package_info(&pf, &file_type, module_name,
+	    sepol_module_package_info(pf, &file_type, module_name,
 				      version) == -1) {
+		sepol_policy_file_free(pf);
 		semanage_write_error(sh, "Could not parse module data.");
 		return -2;
 	}
-	if (file_type != POLICY_MOD) {
+	sepol_policy_file_free(pf);
+	if (file_type != SEPOL_POLICY_MOD) {
 		semanage_write_error(sh, "Data did not represent a module.");
 		return -2;
 	}
@@ -156,23 +162,27 @@ static int parse_module_headers(semanage
  */
 static int parse_base_headers(semanage_handle_t *sh,
 			      char *module_data, size_t data_len) {
-	struct policy_file pf;
+	struct sepol_policy_file *pf;
 	char *module_name = NULL, *version = NULL;
 	int file_type;
-	pf.type = PF_USE_MEMORY;
-	pf.data = module_data;
-	pf.len = data_len;
-	pf.fp = NULL;
+
+	if (sepol_policy_file_create(&pf)) {
+		semanage_write_error(sh, "Out of memory!");
+		return -1;
+	}
+	sepol_policy_file_set_mem(pf, module_data, data_len);
 	if (module_data == NULL ||
 	    data_len == 0 ||
-	    sepol_module_package_info(&pf, &file_type,
+	    sepol_module_package_info(pf, &file_type,
 				      &module_name, &version) == -1) {
+		sepol_policy_file_free(pf);
 		semanage_write_error(sh, "Could not parse base module data.");
 		return -2;
 	}
+	sepol_policy_file_free(pf);
 	free(module_name);
 	free(version);
-	if (file_type != POLICY_BASE) {
+	if (file_type != SEPOL_POLICY_BASE) {
 		semanage_write_error(sh, "Data did not represent a module.");
 		return -2;
 	}
@@ -201,22 +211,22 @@ static int write_file(semanage_handle_t 
  * 'filename'.	Returns 0 on success, -1 if file could not be written.
  */
 static int semanage_write_module(semanage_handle_t *sh,
-				 const char *filename, sepol_module_package_t *package,
-				 uint32_t policy_type) {
-	struct policy_file pf;
+				 const char *filename, sepol_module_package_t *package)
+{
+	struct sepol_policy_file *pf;
 	FILE *outfile;
 	int retval;
-	if (sepol_set_policyvers(policy_type, MOD_POLICYDB_VERSION_MAX) != 0) {
-		semanage_write_error(sh, "Unknown/Invalid policy version %d.", sh->conf->policyvers);
+	if (sepol_policy_file_create(&pf)) {
+		semanage_write_error(sh, "Out of memory!");
 		return -1;
 	}
 	if ((outfile = fopen(filename, "wb")) == NULL) {
+		sepol_policy_file_free(pf);
 		semanage_write_error(sh, "Could not open %s for writing.", filename);
 		return -1;
 	}
-	pf.type = PF_USE_STDIO;
-	pf.fp = outfile;
-	retval = sepol_module_package_write(package, &pf);
+	sepol_policy_file_set_fp(pf, outfile);
+	retval = sepol_module_package_write(package, pf);
 	fclose(outfile);
 	if (retval == -1) {
 		semanage_write_error(sh, "Error while writing module to %s.", filename);
@@ -247,7 +257,7 @@ static int semanage_direct_commit(semana
 
 	/* write the linked base */
 	if ((linked_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED)) == NULL ||
-	    semanage_write_module(sh, linked_filename, base, POLICY_BASE) == -1 ||
+	    semanage_write_module(sh, linked_filename, base) == -1 ||
 	    semanage_verify_linked(sh) != 0) {
 		goto cleanup;
 	}
@@ -271,7 +281,7 @@ static int semanage_direct_commit(semana
 		free(mod_filenames[i]);
 	}
 	free(mod_filenames);
-	sepol_module_package_destroy(base);
+	sepol_module_package_free(base);
 	semanage_release_trans_lock(sh);
 
 	/* regardless if the commit was successful or not, remove the
@@ -434,6 +444,7 @@ static int semanage_direct_remove(semana
  */
 static int semanage_direct_list(semanage_handle_t *sh,
 				semanage_module_info_t **modinfo, int *num_modules) {
+	struct sepol_policy_file *pf;
 	int i, retval = -1;
 	char **module_filenames = NULL;
 	int num_mod_files;
@@ -450,28 +461,35 @@ static int semanage_direct_list(semanage
 		retval = semanage_get_commit_number(sh);
 		goto cleanup;
 	}
+
+	if (sepol_policy_file_create(&pf)) {
+		semanage_write_error(sh, "Out of memory!");
+		goto cleanup;
+	}
+	
 	if ((*modinfo = calloc(num_mod_files, sizeof(**modinfo))) == NULL) {
 		semanage_write_error(sh, "Out of memory!");
 		goto cleanup;
 	}
+	
 	for (i = 0; i < num_mod_files; i++) {
+		FILE *fp;
 		char *name = NULL, *version = NULL;
-		struct policy_file pf;
 		int type;
-		if ((pf.fp = fopen(module_filenames[i], "rb")) == NULL) {
+		if ((fp = fopen(module_filenames[i], "rb")) == NULL) {
 			/* could not open this module file, so don't
 			 * report it */
 			continue;
 		}
-		pf.type = PF_USE_STDIO;
-		if (sepol_module_package_info(&pf, &type, &name, &version)) {
-			fclose(pf.fp);
+		sepol_policy_file_set_fp(pf, fp);
+		if (sepol_module_package_info(pf, &type, &name, &version)) {
+			fclose(fp);
 			free(name);
 			free(version);
 			continue;
 		}
-		fclose(pf.fp);
-		if (type == POLICY_MOD) {
+		fclose(fp);
+		if (type == SEPOL_POLICY_MOD) {
 			(*modinfo)[*num_modules].name = name;
 			(*modinfo)[*num_modules].version = version;
 			(*num_modules)++;
@@ -485,6 +503,7 @@ static int semanage_direct_list(semanage
 	retval = semanage_get_commit_number(sh);
 	
  cleanup:
+	sepol_policy_file_free(pf);
 	for (i = 0; module_filenames != NULL && i < num_mod_files; i++) {
 		free(module_filenames[i]);
 	}

--=-Jip0gFXwVolxDBO5xtl1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
