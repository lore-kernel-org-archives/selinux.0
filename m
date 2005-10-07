Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-rb6ifKb7KsXShiJqONPC"
Date: Fri, 07 Oct 2005 14:30:56 -0400
Message-Id: <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-rb6ifKb7KsXShiJqONPC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-10-07 at 11:52 -0400, Stephen Smalley wrote:
> On Fri, 2005-10-07 at 10:30 -0400, Stephen Smalley wrote:
> > Ok, I've made a first cut at the changes to libsepol and updated it and
> > checkpolicy to build again, and am starting to work through libsemanage.
> > As an example of what to expect, the diff below to database_direct.[ch]
> > was needed to get it to compile again.
> 
> A more interesting example - conversion of direct_api.c.

Still more interesting example - conversion of semanage_store.c.
This brings in the expand/link interfaces.  A few things to note,
primarily directed at the Tresys folks since this was their code:
- AFAICS the calls to policydb_index* were unneeded; they are already
called as appropriate by the libsepol functions to update the indices.
Possibly legacy of earlier versions of the libsepol code?
- Enabling of the global branch moved into sepol_expand_module based on
a new parameter, so that libsemanage and other callers don't need access
to the policydb definition.  Not sure how you plan to selectively enable
in the future.
- expand_module already set the output type, so we only need to adjust
the version here (and I changed it to use the kernel's policyvers if
available instead of the config, as that is what will be loaded by
load_policy now).
- AFAICS the calls to load_isids were bogus/unneeded, unless you were
trying to use their error checking as a side effect, in which case we
should do that as part of expand_module.

-- 
Stephen Smalley
National Security Agency

--=-rb6ifKb7KsXShiJqONPC
Content-Disposition: attachment; filename=store.patch
Content-Type: text/x-patch; name=store.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsemanage/src/semanage_store.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/semanage_store.c,v
retrieving revision 1.3
diff -u -p -r1.3 semanage_store.c
--- libsemanage/src/semanage_store.c	30 Sep 2005 19:23:36 -0000	1.3
+++ libsemanage/src/semanage_store.c	7 Oct 2005 18:15:29 -0000
@@ -29,8 +29,6 @@
 #include <selinux/selinux.h>
 #include <sepol/module.h>
 #include <sepol/sepol.h>
-#include <sepol/link.h>
-#include <sepol/expand.h>
 
 #include <assert.h>
 #include <ctype.h>
@@ -1065,44 +1063,38 @@ int semanage_get_commit_number(semanage_
  */
 static int semanage_load_module(semanage_handle_t *sh, const char *filename, sepol_module_package_t **package) {
 	int retval = 0;
-	struct policy_file pf;
+	FILE *fp;
+	struct sepol_policy_file *pf = NULL;
 
-	if ((*package = (sepol_module_package_t*) malloc(sizeof(**package))) == NULL) {
+	*package = NULL;
+	if (sepol_module_package_create(package) == -1) {
 		semanage_write_error(sh, "Out of memory!");
 		return -1;
 	}
-	if (sepol_module_package_init(*package) == -1) {
+
+	if (sepol_policy_file_create(&pf)) {
 		semanage_write_error(sh, "Out of memory!");
-		sepol_module_package_destroy(*package);
-		*package = NULL;
-		return -1;
+		goto cleanup;
 	}
 
-	if ((pf.fp = fopen(filename, "rb")) == NULL) {
+	if ((fp = fopen(filename, "rb")) == NULL) {
 		semanage_write_error(sh, "Could not open module file %s for reading.", filename);
-		sepol_module_package_destroy(*package);
-		*package = NULL;
-		return -1;
+		goto cleanup;
 	}
-	pf.type = PF_USE_STDIO;
-	if (sepol_module_package_read(*package, &pf, 0) == -1) {
+	sepol_policy_file_set_fp(pf, fp);
+	if (sepol_module_package_read(*package, pf, 0) == -1) {
 		semanage_write_error(sh, "Error while reading from module file %s.", filename);
-		fclose(pf.fp);
-		sepol_module_package_destroy(*package);
-		*package = NULL;
-		return -1;
-	}
-	fclose(pf.fp);
-	if ((*package)->policy->policy_type == POLICY_MOD) {
-		if (policydb_index_classes((*package)->policy) ||
-		    policydb_index_others((*package)->policy, 0)) {
-			semanage_write_error(sh, "Out of memory!");
-			sepol_module_package_destroy(*package);
-			*package = NULL;
-			return -1;
-		}
+		fclose(fp);
+		goto cleanup;
 	}
+	fclose(fp);
 	return retval;
+
+cleanup:
+	sepol_module_package_free(*package);
+	*package = NULL;
+	sepol_policy_file_free(pf);
+	return -1;
 }
 
 /* Links all of the modules within the sandbox into the base module.
@@ -1165,7 +1157,7 @@ int semanage_link_sandbox(semanage_handl
 	}
 	free(module_filenames);
 	for (i = 0; mods != NULL && i < num_modules; i++) {
-		sepol_module_package_destroy(mods[i]);
+		sepol_module_package_free(mods[i]);
 	}
 	free(mods);
 	return retval;
@@ -1176,31 +1168,24 @@ int semanage_link_sandbox(semanage_handl
  * error.
  */
 int semanage_expand_sandbox(semanage_handle_t *sh, sepol_module_package_t *base) {
-	policydb_t out;
+	struct sepol_policydb *out;
 	int retval = -1;
 	const char *kernel_filename = NULL;
-	sidtab_t sidtab;
-	struct policy_file pf;
+	struct sepol_policy_file *pf;
+	int policyvers = security_policyvers();
 	FILE *outfile = NULL;
 
-	memset(&out, 0, sizeof(out));
+	if (policyvers < 0)
+		policyvers = sh->conf->policyvers;
 
-	/* activate the global branch before expansion */
-	base->policy->global->branch_list->enabled = 1;
-	base->policy->global->enabled = base->policy->global->branch_list;
-	if (expand_module(base->policy, &out, 0,
-			  sh->err_buf, SEMANAGE_ERRBUFSZ) == -1) {
-		goto cleanup;
-	}
-	if (policydb_load_isids(&out, &sidtab) == -1) {
-		semanage_write_error(sh, "Error while loading initial SIDs.");
-		goto cleanup;
+	if (sepol_policydb_create(&out)) {
+		return -1;
 	}
-	if (policydb_index_others(&out, 0) == -1) {
-		semanage_write_error(sh, "Out of memory!");
+	if (sepol_expand_module(base->policy, out, 1, 0,
+			  sh->err_buf, SEMANAGE_ERRBUFSZ) == -1) {
 		goto cleanup;
 	}
-	if (sepol_set_policyvers(POLICY_KERN, sh->conf->policyvers)) {
+	if (sepol_policydb_set_vers(base->policy, policyvers)) {
 		semanage_write_error(sh, "Unknown/Invalid policy version %d.", sh->conf->policyvers);
 		goto cleanup;
 	}
@@ -1211,9 +1196,12 @@ int semanage_expand_sandbox(semanage_han
 		semanage_write_error(sh, "Could not open kernel policy %s for writing.", kernel_filename);
 		goto cleanup;
 	}
-	pf.type = PF_USE_STDIO;
-	pf.fp = outfile;
-	if (policydb_write(&out, &pf) == -1) {
+	if (sepol_policy_file_create(&pf)) {
+		semanage_write_error(sh, "Out of memory!");
+		goto cleanup;
+	}
+	sepol_policy_file_set_fp(pf, outfile);
+	if (sepol_policydb_write(out, pf) == -1) {
 		semanage_write_error(sh, "Error while writing kernel policy to %s.", kernel_filename);
 		goto cleanup;
 	}
@@ -1223,8 +1211,8 @@ int semanage_expand_sandbox(semanage_han
 	if (outfile != NULL) {
 		fclose(outfile);
 	}
-	policydb_destroy(&out);
-	sepol_sidtab_destroy(&sidtab);
+	sepol_policydb_free(out);
+	sepol_policy_file_free(pf);
 	return retval;
 }
 

--=-rb6ifKb7KsXShiJqONPC--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
