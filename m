From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: cefrodrigues@gmail.com, jwcart2@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/2] libsemanage: revert "Skip policy module re-link when only
 setting booleans."
Date: Mon, 10 Apr 2017 11:11:48 -0400
Message-Id: <20170410151148.11958-2-sds@tycho.nsa.gov>
In-Reply-To: <20170410151148.11958-1-sds@tycho.nsa.gov>
References: <20170410151148.11958-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

commit e5aaa01f81afa278cce79bd59ebfdb80a32e4e5a ("Skip policy module
re-link when only setting booleans.") can lead to duplicate entries
(e.g. portcon entries) being added into the kernel policy because the
existing linked policy already includes the local customizations.
Revert this commit until we can come up with an approach that handles
this properly.  This means that setsebool -P triggers a full policy
rebuild.

>From the original bug report:
I've noticed a strange interaction with custom ports and booleans.
After setting a boolean, the list of ports for a particular type
(which has been customized) shows duplicate entries.

Example:

    $ semanage port -a -t http_port_t -p tcp 12345
    $ semanage port -l | grep http_port_t
    http_port_t                    tcp      12345, 80, 81, ...
    $ setsebool -P zebra_write_config false
    $ semanage port -l | grep http_port_t
    http_port_t                    tcp      12345, 12345, 80, 81, ...
    $ setsebool -P zebra_write_config false
    $ semanage port -l | grep http_port_t
    http_port_t                    tcp      12345, 12345, 12345, 80, 81, ...

As can be seen, each time a boolean is set persistently (it doesn't
matter which boolean or which state), the custom port 12345 is
duplicated. Running "semodule -B" clears the duplicates.

However, if only the local customizations are listed, the port is
always listed only once:

    $ semanage port -l -C
    SELinux Port Type              Proto    Port Number
    http_port_t                    tcp      12345

Resolves: https://github.com/SELinuxProject/selinux/issues/50
Reported-by: Carlos Rodrigues <cefrodrigues@gmail.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsemanage/src/direct_api.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 5687323..ee2f9e7 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1104,8 +1104,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	/* Declare some variables */
 	int modified = 0, fcontexts_modified, ports_modified,
 	    seusers_modified, users_extra_modified, dontaudit_modified,
-	    preserve_tunables_modified, bools_modified = 0,
-		disable_dontaudit, preserve_tunables;
+	    preserve_tunables_modified, disable_dontaudit, preserve_tunables;
 	dbase_config_t *users = semanage_user_dbase_local(sh);
 	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
 	dbase_config_t *pusers_base = semanage_user_base_dbase_policy(sh);
@@ -1186,13 +1185,13 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	users_extra_modified =
 	    users_extra->dtable->is_modified(users_extra->dbase);
 	ports_modified = ports->dtable->is_modified(ports->dbase);
-	bools_modified = bools->dtable->is_modified(bools->dbase);
 
 	modified = sh->modules_modified;
 	modified |= seusers_modified;
 	modified |= users_extra_modified;
 	modified |= ports_modified;
 	modified |= users->dtable->is_modified(users_base->dbase);
+	modified |= bools->dtable->is_modified(bools->dbase);
 	modified |= ifaces->dtable->is_modified(ifaces->dbase);
 	modified |= nodes->dtable->is_modified(nodes->dbase);
 	modified |= dontaudit_modified;
@@ -1316,19 +1315,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 			goto cleanup;
 
 		cil_db_destroy(&cildb);
-	
-	} else {
-		/* Load already linked policy */
-		retval = sepol_policydb_create(&out);
-		if (retval < 0)
-			goto cleanup;
-
-		retval = semanage_read_policydb(sh, out);
-		if (retval < 0)
-			goto cleanup;
-	}
 
-	if (sh->do_rebuild || modified || bools_modified) {
 		/* Attach to policy databases that work with a policydb. */
 		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase, out);
 		dbase_policydb_attach((dbase_policydb_t *) pports->dbase, out);
@@ -1350,6 +1337,15 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		if (retval < 0)
 			goto cleanup;
 	} else {
+		/* Load already linked policy */
+		retval = sepol_policydb_create(&out);
+		if (retval < 0)
+			goto cleanup;
+
+		retval = semanage_read_policydb(sh, out);
+		if (retval < 0)
+			goto cleanup;
+
 		retval = semanage_base_merge_components(sh);
 		if (retval < 0)
 			goto cleanup;
@@ -1444,7 +1440,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	sepol_policydb_free(out);
 	out = NULL;
 
-	if (sh->do_rebuild || modified || bools_modified || fcontexts_modified) {
+	if (sh->do_rebuild || modified || fcontexts_modified) {
 		retval = semanage_install_sandbox(sh);
 	}
 
@@ -1458,7 +1454,7 @@ cleanup:
 		free(mod_filenames[i]);
 	}
 
-	if (modified || bools_modified) {
+	if (modified) {
 		/* Detach from policydb, so it can be freed */
 		dbase_policydb_detach((dbase_policydb_t *) pusers_base->dbase);
 		dbase_policydb_detach((dbase_policydb_t *) pports->dbase);
-- 
2.9.3
