Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l03G13pB032178
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 11:01:03 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l03G1lDt019613
	for <selinux@tycho.nsa.gov>; Wed, 3 Jan 2007 16:01:48 GMT
Message-ID: <459BD355.600@mentalrootkit.com>
Date: Wed, 03 Jan 2007 11:01:25 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] correct return value handling in libsemanage
References: <458B10CE.6000201@mentalrootkit.com> <459BA16D.8090300@tresys.com>
In-Reply-To: <459BA16D.8090300@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Karl MacMillan wrote:
>> The function semanage_direct_commit in libsemanage:direct_api.c does 
>> not correctly propagate error codes. This patch fixes that.
>>
>> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
>>
> Acked-By: Joshua Brindle <jbrindle@tresys.com>

The patch I sent was against the rawhide CVS - turns out it doesn't 
apply cleanly to current upstream. This updated patch applies cleanly 
and makes all of the returns in that function consisten.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r 46ccd195a21c libsemanage/src/direct_api.c
--- a/libsemanage/src/direct_api.c	Tue Dec 12 22:38:43 2006 -0500
+++ b/libsemanage/src/direct_api.c	Wed Jan 03 09:38:47 2007 -0500
@@ -467,9 +467,11 @@ static int semanage_direct_commit(semana

  	/* Before we do anything else, flush the join to its component parts.
  	 * This *does not* flush to disk automatically */
-	if (users->dtable->is_modified(users->dbase) &&
-	    users->dtable->flush(sh, users->dbase) < 0)
-		goto cleanup;
+	if (users->dtable->is_modified(users->dbase)) {
+		retval = users->dtable->flush(sh, users->dbase);
+		if (retval < 0)
+			goto cleanup;
+	}

  	/* Decide if anything was modified */
  	fcontexts_modified = fcontexts->dtable->is_modified(fcontexts->dbase);
@@ -497,85 +499,97 @@ static int semanage_direct_commit(semana
  		/* =================== Module expansion =============== */

  		/* link all modules in the sandbox to the base module */
-		if (semanage_get_modules_names
-		    (sh, &mod_filenames, &num_modfiles) != 0
-		    || semanage_verify_modules(sh, mod_filenames,
-					       num_modfiles) == -1
-		    || semanage_link_sandbox(sh, &base) < 0) {
-			goto cleanup;
-		}
+		retval = semanage_get_modules_names(sh, &mod_filenames, &num_modfiles);
+		if (retval < 0)
+			goto cleanup;
+		retval = semanage_verify_modules(sh, mod_filenames, num_modfiles);
+		if (retval < 0)
+			goto cleanup;
+		retval = semanage_link_sandbox(sh, &base);
+		if (retval < 0)
+			goto cleanup;

  		/* write the linked base */
-		if ((linked_filename =
-		     semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED)) == NULL
-		    || semanage_write_module(sh, linked_filename, base) == -1
-		    || semanage_verify_linked(sh) != 0) {
-			goto cleanup;
-		}
+		linked_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
+		if (linked_filename == NULL) {
+			retval = -1;
+			goto cleanup;
+		}
+		retval = semanage_write_module(sh, linked_filename, base);
+		if (retval < 0)
+			goto cleanup;
+		retval = semanage_verify_linked(sh);
+		if (retval < 0)
+			goto cleanup;

  		/* ==================== File-backed ================== */

  		/* File Contexts */
  		/* Sort the file contexts. */
-		if (semanage_fc_sort
-		    (sh, sepol_module_package_get_file_contexts(base),
-		     sepol_module_package_get_file_contexts_len(base),
-		     &sorted_fc_buffer, &sorted_fc_buffer_len) == -1) {
-			goto cleanup;
-		}
+		retval = semanage_fc_sort(sh, 
sepol_module_package_get_file_contexts(base),
+					  sepol_module_package_get_file_contexts_len(base),
+					  &sorted_fc_buffer, &sorted_fc_buffer_len);
+		if (retval < 0)
+			goto cleanup;

  		/* Write the contexts (including template contexts) to a single file.
  		 * The buffer returned by the sort function has a trailing \0 character,
  		 * which we do NOT want to write out to disk, so we pass 
sorted_fc_buffer_len-1. */
-		if ((ofilename =
-		     semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL)) == NULL
-		    || write_file(sh, ofilename, sorted_fc_buffer,
-				  sorted_fc_buffer_len - 1) == -1) {
-			goto cleanup;
-		}
+		ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL);
+		if (ofilename == NULL) {
+			retval = -1;
+			goto cleanup;
+		}
+		retval = write_file(sh, ofilename, sorted_fc_buffer,
+				    sorted_fc_buffer_len - 1);
+		if (retval < 0)
+			goto cleanup;

  		/* Split complete and template file contexts into their separate 
files. */
-		if (semanage_split_fc(sh))
+		retval = semanage_split_fc(sh);
+		if (retval < 0)
  			goto cleanup;

  		pfcontexts->dtable->drop_cache(pfcontexts->dbase);

  		/* Seusers */
  		if (sepol_module_package_get_seusers_len(base)) {
-			if ((ofilename =
-			     semanage_path(SEMANAGE_TMP,
-					   SEMANAGE_SEUSERS)) == NULL
-			    || write_file(sh, ofilename,
-					  sepol_module_package_get_seusers
-					  (base),
-					  sepol_module_package_get_seusers_len
-					  (base)) == -1) {
+			ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS);
+			if (ofilename == NULL) {
+				retval = -1;
  				goto cleanup;
  			}
+			retval = write_file(sh, ofilename,
+					    sepol_module_package_get_seusers(base),
+					    sepol_module_package_get_seusers_len(base));
+			if (retval < 0)
+				goto cleanup;
+
  			pseusers->dtable->drop_cache(pseusers->dbase);

  		} else {
-			if (pseusers->dtable->clear(sh, pseusers->dbase) < 0)
+			retval = pseusers->dtable->clear(sh, pseusers->dbase);
+			if (retval < 0)
  				goto cleanup;
  		}

  		/* Users_extra */
  		if (sepol_module_package_get_user_extra_len(base)) {
-			if ((ofilename =
-			     semanage_path(SEMANAGE_TMP,
-					   SEMANAGE_USERS_EXTRA)) == NULL
-			    || write_file(sh, ofilename,
-					  sepol_module_package_get_user_extra
-					  (base),
-					  sepol_module_package_get_user_extra_len
-					  (base)) == -1) {
+			ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA);
+			if (ofilename == NULL) {
+				retval = -1;
  				goto cleanup;
  			}
+			retval = write_file(sh, ofilename,
+					    sepol_module_package_get_user_extra(base),
+					    sepol_module_package_get_user_extra_len(base));
+			if (retval < 0)
+				goto cleanup;
  			pusers_extra->dtable->drop_cache(pusers_extra->dbase);

  		} else {
-			if (pusers_extra->dtable->
-			    clear(sh, pusers_extra->dbase) < 0)
+			retval = pusers_extra->dtable->clear(sh, pusers_extra->dbase);
+			if (retval < 0)
  				goto cleanup;
  		}

@@ -603,7 +617,8 @@ static int semanage_direct_commit(semana

  		/* Create new policy object, then attach to policy databases
  		 * that work with a policydb */
-		if (semanage_expand_sandbox(sh, base, &out) < 0)
+		retval = semanage_expand_sandbox(sh, base, &out);
+		if (retval < 0)
  			goto cleanup;

  		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase,
@@ -615,13 +630,16 @@ static int semanage_direct_commit(semana

  		/* ============= Apply changes, and verify  =============== */

-		if (semanage_base_merge_components(sh) < 0)
-			goto cleanup;
-
-		if (semanage_write_policydb(sh, out) < 0)
-			goto cleanup;
-
-		if (semanage_verify_kernel(sh) != 0)
+		retval = semanage_base_merge_components(sh);
+		if (retval < 0)
+			goto cleanup;
+
+		retval = semanage_write_policydb(sh, out);
+		if (retval < 0)
+			goto cleanup;
+
+		retval = semanage_verify_kernel(sh);
+		if (retval < 0)
  			goto cleanup;
  	}

@@ -635,26 +653,30 @@ static int semanage_direct_commit(semana
  	 * merged into the main file_contexts. We won't check the
  	 * large file_contexts - checked at compile time */
  	if (sh->do_rebuild || modified || fcontexts_modified) {
-		if (semanage_fcontext_validate_local(sh, out) < 0)
+		retval = semanage_fcontext_validate_local(sh, out);
+		if (retval < 0)
  			goto cleanup;
  	}

  	/* Validate local seusers against policy */
  	if (sh->do_rebuild || modified || seusers_modified) {
-		if (semanage_seuser_validate_local(sh, out) < 0)
+		retval = semanage_seuser_validate_local(sh, out);
+		if (retval < 0)
  			goto cleanup;
  	}

  	/* Validate local ports for overlap */
  	if (sh->do_rebuild || ports_modified) {
-		if (semanage_port_validate_local(sh) < 0)
+		retval = semanage_port_validate_local(sh);
+		if (retval < 0)
  			goto cleanup;
  	}

  	/* ================== Write non-policydb components ========= */

  	/* Commit changes to components */
-	if (semanage_commit_components(sh) < 0)
+	retval = semanage_commit_components(sh);
+	if (retval < 0)
  		goto cleanup;

  	retval = semanage_install_sandbox(sh);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
