Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076019CC1C
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334639; cv=none; b=Tbd6e9GWuer4c7rn2lheMiiS1FrTsXDzW92Yf9jXSVTIs1OuTKng6Wotgm0w2syxzCHSuDw6J518ImugrCsBL89N5cIEnRLddaCJa9Nf+yAmGg1eQqr8f10eq93M2dYe6vUnP3/AO3aoMLHRescOsu6LeM4YP0eGazuigwrFKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334639; c=relaxed/simple;
	bh=1X03f+9L+vzbXLJZtoh2MidKApsrBPodzAkncP52Sec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PlS0WFUSDhfxtv6oPON0+qWFUC86sQ35g5JAx/GrL92a5XTHUQagsn3XH5wUzEpe1+TUGPvH0hzuetrYpAd8W1+nvPhq5C+AzTJppfXA49upHMvF/b+t24MMS+5uJ5CwteoOE4xgLA+qNRGqwrN5d22LEoc4PLHce03kiQGI0Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=fail (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=pAk5E/H/ reason="signature verification failed"; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="pAk5E/H/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334632;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JNirH6qf+NsaeWmfLbDZ7chPPC2Q8CnabZQAWs5p1p0=;
	b=pAk5E/H/L26ZtPdqurq6kWxvl3bTSW7JdgQEJTVv4NU88b+EMMo4VY5/8BhTxlurCHnOSm
	VO9OF97Hl0xv+EYyPqy5PdXfWlo/XXC1R8vOa3NkGGlXV7Cem+Ejbun2hyCQQP3x1P89aG
	il8UrYyd9wei+oq5y92qOtq/fMWeLnZBfnE4clFPjDN+GRF2h2x+ONPQSKAO/GSYZW3pQS
	aSrZHm2YjomWDGNcsfbfp+MShXfUqclIs7678KxQTQl2s+r2fMiHijkR3X3xuRUjh04Kgs
	MQ/L4s5UZmzyap4bKsk431mFfkNXQCRzzOoayOWeUIRDbTsKpgj3w57jPi0crg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 01/47] libsemanage: white space cleanup
Date: Mon, 11 Nov 2024 15:16:20 +0100
Message-ID: <20241111141706.38039-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Avoid unrelated changes in followup patches.

No functional change.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/LICENSE                           | 20 ++---
 libsemanage/Makefile                          |  8 +-
 libsemanage/example/test_fcontext.c           |  2 +-
 libsemanage/include/semanage/debug.h          |  4 +-
 libsemanage/include/semanage/handle.h         | 12 +--
 libsemanage/include/semanage/modules.h        |  6 +-
 libsemanage/include/semanage/semanage.h       |  2 +-
 libsemanage/man/man3/semanage_bool.3          | 18 ++---
 .../man/man3/semanage_bool_set_active.3       | 16 ++--
 libsemanage/man/man3/semanage_count.3         |  6 +-
 libsemanage/man/man3/semanage_del.3           | 18 ++---
 libsemanage/man/man3/semanage_exists.3        | 14 ++--
 libsemanage/man/man3/semanage_fcontext.3      | 20 ++---
 libsemanage/man/man3/semanage_iface.3         | 24 +++---
 libsemanage/man/man3/semanage_iterate.3       | 14 ++--
 libsemanage/man/man3/semanage_list.3          | 12 +--
 libsemanage/man/man3/semanage_modify.3        | 14 ++--
 libsemanage/man/man3/semanage_node.3          | 32 ++++----
 libsemanage/man/man3/semanage_port.3          | 18 ++---
 libsemanage/man/man3/semanage_query.3         | 16 ++--
 libsemanage/man/man3/semanage_seuser.3        | 26 +++----
 libsemanage/man/man3/semanage_user.3          | 26 +++----
 libsemanage/man/man5/semanage.conf.5          | 10 +--
 libsemanage/src/Makefile                      | 14 ++--
 libsemanage/src/booleans_activedb.c           |  2 +-
 libsemanage/src/conf-parse.y                  |  6 +-
 libsemanage/src/database.h                    | 24 +++---
 libsemanage/src/database_activedb.c           |  4 +-
 libsemanage/src/database_file.c               |  4 +-
 libsemanage/src/database_join.c               |  6 +-
 libsemanage/src/database_policydb.c           |  2 +-
 libsemanage/src/database_policydb.h           |  2 +-
 libsemanage/src/debug.c                       |  2 +-
 libsemanage/src/direct_api.c                  | 15 ++--
 libsemanage/src/genhomedircon.c               |  4 +-
 libsemanage/src/handle.c                      |  6 +-
 libsemanage/src/handle.h                      |  2 +-
 libsemanage/src/parse_utils.h                 |  4 +-
 libsemanage/src/policy_components.c           |  2 +-
 libsemanage/src/ports_file.c                  |  2 +-
 libsemanage/src/ports_local.c                 |  6 +-
 libsemanage/src/semanage_store.c              | 50 ++++++-------
 libsemanage/src/semanageswig.i                |  2 +-
 libsemanage/src/semanageswig_python.i         | 74 +++++++++----------
 libsemanage/src/semanageswig_ruby.i           |  2 +-
 libsemanage/src/seuser_record.c               |  2 +-
 libsemanage/src/seusers_local.c               |  2 +-
 libsemanage/src/user_record.c                 |  2 +-
 libsemanage/src/utilities.c                   |  2 +-
 libsemanage/tests/Makefile                    |  4 +-
 libsemanage/tests/README                      | 12 +--
 libsemanage/tests/test_semanage_store.c       |  2 +-
 52 files changed, 299 insertions(+), 300 deletions(-)

diff --git a/libsemanage/LICENSE b/libsemanage/LICENSE
index 8add30ad..148d531c 100644
--- a/libsemanage/LICENSE
+++ b/libsemanage/LICENSE
@@ -55,7 +55,7 @@ modified by someone else and passed on, the recipients should know
 that what they have is not the original version, so that the original
 author's reputation will not be affected by problems that might be
 introduced by others.
-
+
   Finally, software patents pose a constant threat to the existence of
 any free program.  We wish to make sure that a company cannot
 effectively restrict the users of a free program by obtaining a
@@ -111,7 +111,7 @@ modification follow.  Pay close attention to the difference between a
 "work based on the library" and a "work that uses the library".  The
 former contains code derived from the library, whereas the latter must
 be combined with the library in order to run.
-
+
 		  GNU LESSER GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
@@ -146,7 +146,7 @@ such a program is covered only if its contents constitute a work based
 on the Library (independent of the use of the Library in a tool for
 writing it).  Whether that is true depends on what the Library does
 and what the program that uses the Library does.
-  
+
   1. You may copy and distribute verbatim copies of the Library's
 complete source code as you receive it, in any medium, provided that
 you conspicuously and appropriately publish on each copy an
@@ -158,7 +158,7 @@ Library.
   You may charge a fee for the physical act of transferring a copy,
 and you may at your option offer warranty protection in exchange for a
 fee.
-
+
   2. You may modify your copy or copies of the Library or any portion
 of it, thus forming a work based on the Library, and copy and
 distribute such modifications or work under the terms of Section 1
@@ -216,7 +216,7 @@ instead of to this License.  (If a newer version than version 2 of the
 ordinary GNU General Public License has appeared, then you can specify
 that version instead if you wish.)  Do not make any other change in
 these notices.
-
+
   Once this change is made in a given copy, it is irreversible for
 that copy, so the ordinary GNU General Public License applies to all
 subsequent copies and derivative works made from that copy.
@@ -267,7 +267,7 @@ Library will still fall under Section 6.)
 distribute the object code for the work under the terms of Section 6.
 Any executables containing that work also fall under Section 6,
 whether or not they are linked directly with the Library itself.
-
+
   6. As an exception to the Sections above, you may also combine or
 link a "work that uses the Library" with the Library to produce a
 work containing portions of the Library, and distribute that work
@@ -329,7 +329,7 @@ restrictions of other proprietary libraries that do not normally
 accompany the operating system.  Such a contradiction means you cannot
 use both them and the Library together in an executable that you
 distribute.
-
+
   7. You may place library facilities that are a work based on the
 Library side-by-side in a single library together with other library
 facilities not covered by this License, and distribute such a combined
@@ -370,7 +370,7 @@ subject to these terms and conditions.  You may not impose any further
 restrictions on the recipients' exercise of the rights granted herein.
 You are not responsible for enforcing compliance by third parties with
 this License.
-
+
   11. If, as a consequence of a court judgment or allegation of patent
 infringement or for any other reason (not limited to patent issues),
 conditions are imposed on you (whether by court order, agreement or
@@ -422,7 +422,7 @@ conditions either of that version or of any later version published by
 the Free Software Foundation.  If the Library does not specify a
 license version number, you may choose any version ever published by
 the Free Software Foundation.
-
+
   14. If you wish to incorporate parts of the Library into other free
 programs whose distribution conditions are incompatible with these,
 write to the author to ask for permission.  For software which is
@@ -456,7 +456,7 @@ SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
 DAMAGES.
 
 		     END OF TERMS AND CONDITIONS
-
+
            How to Apply These Terms to Your New Libraries
 
   If you develop a new library, and you want it to be of the greatest
diff --git a/libsemanage/Makefile b/libsemanage/Makefile
index 390176fe..dbd240da 100644
--- a/libsemanage/Makefile
+++ b/libsemanage/Makefile
@@ -1,22 +1,22 @@
-all: 
+all:
 	$(MAKE) -C src all
 
 swigify:
 	$(MAKE) -C src swigify
 
-pywrap: 
+pywrap:
 	$(MAKE) -C src pywrap
 
 rubywrap:
 	$(MAKE) -C src rubywrap
 
-install: 
+install:
 	$(MAKE) -C include install
 	$(MAKE) -C src install
 	$(MAKE) -C man install
 	$(MAKE) -C utils install
 
-install-pywrap: 
+install-pywrap:
 	$(MAKE) -C src install-pywrap
 
 install-rubywrap:
diff --git a/libsemanage/example/test_fcontext.c b/libsemanage/example/test_fcontext.c
index c2ffcab8..abf41e3c 100644
--- a/libsemanage/example/test_fcontext.c
+++ b/libsemanage/example/test_fcontext.c
@@ -15,7 +15,7 @@ int main(const int argc, const char **argv) {
 
 	int exist = 0;
 	sh = semanage_handle_create();
-	if (sh == NULL) { 
+	if (sh == NULL) {
 		perror("Can't create semanage handle\n");
 		return -1;
 	}
diff --git a/libsemanage/include/semanage/debug.h b/libsemanage/include/semanage/debug.h
index effc24ad..ad79beca 100644
--- a/libsemanage/include/semanage/debug.h
+++ b/libsemanage/include/semanage/debug.h
@@ -35,9 +35,9 @@ extern const char *semanage_msg_get_channel(semanage_handle_t * handle);
 
 extern const char *semanage_msg_get_fname(semanage_handle_t * handle);
 
-/* Set the messaging callback. 
+/* Set the messaging callback.
  * By the default, the callback will print
- * the message on standard output, in a 
+ * the message on standard output, in a
  * particular format. Passing NULL here
  * indicates that messaging should be suppressed */
 extern void semanage_msg_set_callback(semanage_handle_t * handle,
diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index 4cf30815..41db000f 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -25,7 +25,7 @@
 
 /* All accesses with semanage are through a "semanage_handle".  The
  * handle may ultimately reference local config files,
- * the binary policy file, a module store, or a policy management server. 
+ * the binary policy file, a module store, or a policy management server.
  */
 struct semanage_handle;
 typedef struct semanage_handle semanage_handle_t;
@@ -48,7 +48,7 @@ enum semanage_connect_type {
 };
 
 /* This function allows you to specify the store to  connect to.
- * It must be called after semanage_handle_create but before 
+ * It must be called after semanage_handle_create but before
  * semanage_connect. The argument should be the full path to the store.
  */
 extern void semanage_select_store(semanage_handle_t * handle, char *path,
@@ -76,8 +76,8 @@ extern void semanage_set_check_ext_changes(semanage_handle_t * handle, int do_ch
  * Upon success returns 0, -1 on error. */
 extern int semanage_get_hll_compiler_path(semanage_handle_t *sh, char *lang_ext, char **compiler_path);
 
-/* create the store if it does not exist, this only has an effect on 
- * direct connections and must be called before semanage_connect 
+/* create the store if it does not exist, this only has an effect on
+ * direct connections and must be called before semanage_connect
  * 1 for yes, 0 for no (default) */
 extern void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
@@ -103,9 +103,9 @@ extern int semanage_set_default_priority(semanage_handle_t *sh, uint16_t priorit
  */
 extern int semanage_is_managed(semanage_handle_t *);
 
-/* "Connect" to a manager based on the configuration and 
+/* "Connect" to a manager based on the configuration and
  * associate the provided handle with the connection.
- * If the connect fails then this function returns a negative value, 
+ * If the connect fails then this function returns a negative value,
  * else it returns zero.
  */
 extern int semanage_connect(semanage_handle_t *);
diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
index 14666f6d..0d482dae 100644
--- a/libsemanage/include/semanage/modules.h
+++ b/libsemanage/include/semanage/modules.h
@@ -29,7 +29,7 @@
 typedef struct semanage_module_key semanage_module_key_t;
 
 /* High level module management functions. These are all part of
- * a transaction  
+ * a transaction
  */
 
 extern int semanage_module_install(semanage_handle_t *,
@@ -222,7 +222,7 @@ extern int semanage_module_set_enabled(semanage_handle_t *sh,
 
 /* Lookup @modinfo by @modkey. Caller should use
  * semanage_module_info_destroy and free on @modinfo.
- * 
+ *
  * Returns 0 on success and -1 on error.
  */
 extern int semanage_module_get_module_info(semanage_handle_t *sh,
@@ -242,7 +242,7 @@ extern int semanage_module_list_all(semanage_handle_t *sh,
 				    semanage_module_info_t **modinfos,
 				    int *modinfos_len);
 
-/* Install the module indicated by @modinfo with input data from 
+/* Install the module indicated by @modinfo with input data from
  * @module_data with length @data_len.
  *
  * @modinfo must have all values filled in.
diff --git a/libsemanage/include/semanage/semanage.h b/libsemanage/include/semanage/semanage.h
index 04890148..9a55d110 100644
--- a/libsemanage/include/semanage/semanage.h
+++ b/libsemanage/include/semanage/semanage.h
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2005 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat, Inc.
- * 
+ *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
  *  License as published by the Free Software Foundation; either
diff --git a/libsemanage/man/man3/semanage_bool.3 b/libsemanage/man/man3/semanage_bool.3
index 67da6325..806fc187 100644
--- a/libsemanage/man/man3/semanage_bool.3
+++ b/libsemanage/man/man3/semanage_bool.3
@@ -1,6 +1,6 @@
 .TH semanage_bool 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_bool \- SELinux Policy Booleans Management API
 
 .SH "SYNOPSIS"
@@ -20,8 +20,8 @@ For details on a specific function, see its manual page.
 
 .SH "Record API Overview"
 
-.HP 
-.BR semanage_bool_create "(3)" \- 
+.HP
+.BR semanage_bool_create "(3)" \-
 .br
 create a boolean
 
@@ -41,17 +41,17 @@ create a key, which can be used to identify a boolean
 release resources for this boolean key
 
 .HP
-.BR semanage_bool_key_extract "(3)" \- 
+.BR semanage_bool_key_extract "(3)" \-
 .br
 create a key matching this boolean
 
 .HP
-.BR semanage_bool_clone "(3)" \- 
+.BR semanage_bool_clone "(3)" \-
 .br
 create an identical boolean (deep-copy clone)
 
 .HP
-.BR semanage_bool_compare "(3)" \- 
+.BR semanage_bool_compare "(3)" \-
 .br
 compare this boolean to the provided key
 
@@ -87,7 +87,7 @@ set the value of this boolean
 .SH "Record Store API Overview"
 
 .HP
-.BR semanage_bool_modify_local "(3)" \- 
+.BR semanage_bool_modify_local "(3)" \-
 .br
 add or update a boolean in the local store
 
@@ -122,7 +122,7 @@ check if a boolean is defined in the currently active policy
 query a boolean in the persistent policy
 
 .HP
-.BR semanage_bool_query_local "(3)" \- 
+.BR semanage_bool_query_local "(3)" \-
 .br
 query a boolean in the local store
 
@@ -174,4 +174,4 @@ return an array containing all booleans in the local store
 .HP
 .BR semanage_bool_list_active "(3)" \-
 .br
-return an array containing all booleans in the currently active policy 
+return an array containing all booleans in the currently active policy
diff --git a/libsemanage/man/man3/semanage_bool_set_active.3 b/libsemanage/man/man3/semanage_bool_set_active.3
index d868fe86..2b6150a1 100644
--- a/libsemanage/man/man3/semanage_bool_set_active.3
+++ b/libsemanage/man/man3/semanage_bool_set_active.3
@@ -17,25 +17,25 @@ semanage_bool_set_active \- update an existing SELinux boolean in the currently
 .SH "DESCRIPTION"
 .TP
 .B Behavior:
-The set function will fail if no matching key is found in the local store. Otherwise, the provided object will replace the current one. When 
-.BR semanage_commit "(3)" 
-is invoked, changes will be written permanently into the local store, and will be loaded into policy. Validity of the object being added is checked at commit time. 
+The set function will fail if no matching key is found in the local store. Otherwise, the provided object will replace the current one. When
+.BR semanage_commit "(3)"
+is invoked, changes will be written permanently into the local store, and will be loaded into policy. Validity of the object being added is checked at commit time.
 
 .TP
 .B Parameters:
-The 
+The
 .I handle
 is used to track persistent state across semanage calls, and for error reporting. The
-.I key 
-identifies the 
+.I key
+identifies the
 .I data
 object, which will be written into the store. The key are data are properties of the caller, and are not stored or modified internally.
 
 .TP
 .B Requirements:
-This function requires an semanage connection to be established (see 
+This function requires an semanage connection to be established (see
 .BR semanage_connect "(3)"
-), and must be executed in a transaction (see 
+), and must be executed in a transaction (see
 .BR semanage_begin_transaction "(3)"
 ).
 
diff --git a/libsemanage/man/man3/semanage_count.3 b/libsemanage/man/man3/semanage_count.3
index 6ff89be3..27696981 100644
--- a/libsemanage/man/man3/semanage_count.3
+++ b/libsemanage/man/man3/semanage_count.3
@@ -1,6 +1,6 @@
 .TH semanage_count 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_count \- SELinux Management API
 
 .SH "SYNOPSIS"
@@ -21,14 +21,14 @@ The count function will return the number of all objects in the selected locatio
 
 .TP
 .B Parameters:
-The 
+The
 .I handle
 is used to track persistent state across semanage calls, and for error reporting. The number of objects will be stored at the location pointed by
 .I response.
 
 .TP
 .B Requirements:
-This function requires an semanage connection to be established (see 
+This function requires an semanage connection to be established (see
 .BR semanage_connect "(3)"
 )
 
diff --git a/libsemanage/man/man3/semanage_del.3 b/libsemanage/man/man3/semanage_del.3
index 4dd0a771..7e6da477 100644
--- a/libsemanage/man/man3/semanage_del.3
+++ b/libsemanage/man/man3/semanage_del.3
@@ -1,6 +1,6 @@
 .TH semanage_del 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_del \- SELinux Management API
 
 .SH "SYNOPSIS"
@@ -17,25 +17,25 @@ Replace the function and object name as necessary.
 .SH "DESCRIPTION"
 .TP
 .B Behavior:
-The delete function will remove the object corresponding to the provided key from the local store. If no match is found, no action is taken. Changes will become permanent when  
-.BR semanage_commit "(3)" 
-is invoked. Additional checks may be performed at that time to ensure the system is left in a valid state. 
+The delete function will remove the object corresponding to the provided key from the local store. If no match is found, no action is taken. Changes will become permanent when
+.BR semanage_commit "(3)"
+is invoked. Additional checks may be performed at that time to ensure the system is left in a valid state.
 
 .TP
 .B Parameters:
-The 
+The
 .I handle
 is used to track persistent state across semanage calls, and for error reporting. The
-.I key 
-identifies the 
+.I key
+identifies the
 .I data
 object, which will be deleted from the local store. The key is a property of the caller, and will not be stored or modified internally.
 
 .TP
 .B Requirements:
-This function requires an semanage connection to be established (see 
+This function requires an semanage connection to be established (see
 .BR semanage_connect "(3)"
-), and must be executed in a transaction (see 
+), and must be executed in a transaction (see
 .BR semanage_begin_transaction "(3)"
 ).
 
diff --git a/libsemanage/man/man3/semanage_exists.3 b/libsemanage/man/man3/semanage_exists.3
index 6d68c76e..a272a0b3 100644
--- a/libsemanage/man/man3/semanage_exists.3
+++ b/libsemanage/man/man3/semanage_exists.3
@@ -1,6 +1,6 @@
 .TH semanage_exists 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_exists \- SELinux Management API
 
 .SH "SYNOPSIS"
@@ -19,21 +19,21 @@ Replace the function and object name as necessary.
 .SH "DESCRIPTION"
 .TP
 .B Behavior:
-The exists function will return 0 if a matching key is not found, and 1 otherwise. 
+The exists function will return 0 if a matching key is not found, and 1 otherwise.
 
 .TP
 .B Parameters:
-The 
+The
 .I handle
 is used to track persistent state across semanage calls, and for error reporting. The
-.I key 
-identifies the object being checked. The result of the test will be stored in the address pointed by 
+.I key
+identifies the object being checked. The result of the test will be stored in the address pointed by
 .I response
-The key is a property of the caller, and will not be stored or modified internally. 
+The key is a property of the caller, and will not be stored or modified internally.
 
 .TP
 .B Requirements:
-This function requires an semanage connection to be established (see 
+This function requires an semanage connection to be established (see
 .BR semanage_connect "(3)"
 )
 
diff --git a/libsemanage/man/man3/semanage_fcontext.3 b/libsemanage/man/man3/semanage_fcontext.3
index 1f0bf320..96e300bf 100644
--- a/libsemanage/man/man3/semanage_fcontext.3
+++ b/libsemanage/man/man3/semanage_fcontext.3
@@ -1,6 +1,6 @@
 .TH semanage_fcontext 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_fcontext \- SELinux File Context Management API
 
 .SH "SYNOPSIS"
@@ -18,15 +18,15 @@ For details on a specific function, see its manual page.
 
 .SH "Record API Overview"
 
-.HP 
-.BR semanage_fcontext_create "(3)" \- 
+.HP
+.BR semanage_fcontext_create "(3)" \-
 .br
 create a file context spec
 
 .HP
 .BR semanage_fcontext_free "(3)" \-
 .br
-release resources for this file context spec 
+release resources for this file context spec
 
 .HP
 .BR semanage_fcontext_key_create "(3)" \-
@@ -39,17 +39,17 @@ create a key, which can be used to identify a file context spec
 release resources for this file context spec key
 
 .HP
-.BR semanage_fcontext_key_extract "(3)" \- 
+.BR semanage_fcontext_key_extract "(3)" \-
 .br
-create a key matching this file context spec 
+create a key matching this file context spec
 
 .HP
-.BR semanage_fcontext_clone "(3)" \- 
+.BR semanage_fcontext_clone "(3)" \-
 .br
 create an identical file context spec (deep-copy clone)
 
 .HP
-.BR semanage_fcontext_compare "(3)" \- 
+.BR semanage_fcontext_compare "(3)" \-
 .br
 compare this file context spec to the provided key
 
@@ -100,7 +100,7 @@ set the SELinux context for this file context spec
 .SH "Record Store API Overview"
 
 .HP
-.BR semanage_fcontext_modify_local "(3)" \- 
+.BR semanage_fcontext_modify_local "(3)" \-
 .br
 add or update a file context spec in the local store
 
@@ -125,7 +125,7 @@ check if a file context spec is defined in the local store
 query a file context spec in the persistent policy
 
 .HP
-.BR semanage_fcontext_query_local "(3)" \- 
+.BR semanage_fcontext_query_local "(3)" \-
 .br
 query a file context spec in the local store
 
diff --git a/libsemanage/man/man3/semanage_iface.3 b/libsemanage/man/man3/semanage_iface.3
index 90af8b45..8a8437fd 100644
--- a/libsemanage/man/man3/semanage_iface.3
+++ b/libsemanage/man/man3/semanage_iface.3
@@ -1,6 +1,6 @@
 .TH semanage_iface 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_iface \- SELinux Network Interfaces Management API
 
 .SH "SYNOPSIS"
@@ -11,15 +11,15 @@ semanage_iface \- SELinux Network Interfaces Management API
 .B #include <semanage/interfaces_local.h>
 
 .PP
-This object contains properties associated with a network interface. 
+This object contains properties associated with a network interface.
 
 .PP
 For details on a specific function, see its manual page.
 
 .SH "Record API Overview"
 
-.HP 
-.BR semanage_iface_create "(3)" \- 
+.HP
+.BR semanage_iface_create "(3)" \-
 .br
 create an interface
 
@@ -39,17 +39,17 @@ create a key, which can be used to identify an interface
 release resources for this interface key
 
 .HP
-.BR semanage_iface_key_extract "(3)" \- 
+.BR semanage_iface_key_extract "(3)" \-
 .br
 create a key matching this interface
 
 .HP
-.BR semanage_iface_clone "(3)" \- 
+.BR semanage_iface_clone "(3)" \-
 .br
 create an identical interface (deep-copy clone)
 
 .HP
-.BR semanage_iface_compare "(3)" \- 
+.BR semanage_iface_compare "(3)" \-
 .br
 compare this interface to the provided key
 
@@ -61,14 +61,14 @@ compare this interface to another
 .SH "Properties API Overview"
 
 .HP
-.BR semanage_iface_get_name "(3)" \- 
+.BR semanage_iface_get_name "(3)" \-
 .br
-return the name of this interface 
+return the name of this interface
 
 .HP
 .BR semanage_iface_set_name "(3)" \-
 .br
-set the name of this interface 
+set the name of this interface
 
 .HP
 .BR semanage_iface_get_ifcon "(3)" \-
@@ -93,7 +93,7 @@ set the SELinux context associated with packets sent over this interface
 .SH "Record Store API Overview"
 
 .HP
-.BR semanage_iface_modify_local "(3)" \- 
+.BR semanage_iface_modify_local "(3)" \-
 .br
 add or update an interface in the local store
 
@@ -118,7 +118,7 @@ check if an interface is defined in the local store
 query an interface in the persistent policy
 
 .HP
-.BR semanage_iface_query_local "(3)" \- 
+.BR semanage_iface_query_local "(3)" \-
 .br
 query an interface in the local store
 
diff --git a/libsemanage/man/man3/semanage_iterate.3 b/libsemanage/man/man3/semanage_iterate.3
index 15281647..d45c43f0 100644
--- a/libsemanage/man/man3/semanage_iterate.3
+++ b/libsemanage/man/man3/semanage_iterate.3
@@ -1,6 +1,6 @@
 .TH semanage_iterate 3 "15 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_iterate \- SELinux Management API
 
 .SH "SYNOPSIS"
@@ -23,10 +23,10 @@ Replace the function and object name as necessary.
 .SH "DESCRIPTION"
 .TP
 .B Behavior:
-The iterate function will execute the specified handler over all objects in the selected location. An arbitrary argument can be passed into the handler function along with each object. 
+The iterate function will execute the specified handler over all objects in the selected location. An arbitrary argument can be passed into the handler function along with each object.
 
-The object passed in is property of the libsemanage library, and may not be modified or preserved - use 
-.B semanage_OBJECT_clone 
+The object passed in is property of the libsemanage library, and may not be modified or preserved - use
+.B semanage_OBJECT_clone
 if that is necessary.
 
 The handler code may not invoke any semanage write requests for the same object type (i.e. modifying the underlying store is not allowed). The iterate function is reentrant only while inside a transaction (see
@@ -35,17 +35,17 @@ The handler code may not invoke any semanage write requests for the same object
 
 .TP
 .B Parameters:
-The 
+The
 .I handle
 is used to track persistent state across semanage calls, and for error reporting. The
 .I handler
-is the function to execute, with 
+is the function to execute, with
 .I handler_arg
 as its second parameter, and each object as its first parameter.
 
 .TP
 .B Requirements:
-This function requires an semanage connection to be established (see 
+This function requires an semanage connection to be established (see
 .BR semanage_connect "(3)"
 )
 
diff --git a/libsemanage/man/man3/semanage_list.3 b/libsemanage/man/man3/semanage_list.3
index 0e1ca7b4..9f0414e2 100644
--- a/libsemanage/man/man3/semanage_list.3
+++ b/libsemanage/man/man3/semanage_list.3
@@ -1,6 +1,6 @@
 .TH semanage_list 3 "16 March 2006" "ivg2@cornell.edu" "SELinux managent API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_list \- SELinux Lists Management API
 
 .SH "SYNOPSIS"
@@ -23,18 +23,18 @@ The list function will return an array of all the objects in the selected locati
 
 .TP
 .B Parameters:
-The 
+The
 .I handle
 is used to track persistent state across semanage calls, and for error reporting. The function will allocate and populate the array of objects, and store it at the location pointed by
 .I objects.
-It will write the number of objects at the location pointed by 
+It will write the number of objects at the location pointed by
 .I count.
-The array, and all its objects become property of the caller. Each object must be freed with 
-.B semanage_OBJECT_free. 
+The array, and all its objects become property of the caller. Each object must be freed with
+.B semanage_OBJECT_free.
 
 .TP
 .B Requirements:
-This function requires an semanage connection to be established (see 
+This function requires an semanage connection to be established (see
 .BR semanage_connect "(3)"
 )
 
diff --git a/libsemanage/man/man3/semanage_modify.3 b/libsemanage/man/man3/semanage_modify.3
index ee239009..abcdce1c 100644
--- a/libsemanage/man/man3/semanage_modify.3
+++ b/libsemanage/man/man3/semanage_modify.3
@@ -1,6 +1,6 @@
 .TH semanage_modify 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_modify \- SELinux Management API
 
 .SH "SYNOPSIS"
@@ -20,24 +20,24 @@ Replace the function and object name as necessary.
 .TP
 .B Behavior:
 If a matching key is found in the local store, the provided object will replace the current one. Otherwise, it will be added to the store. When
-.BR semanage_commit "(3)" 
+.BR semanage_commit "(3)"
 is invoked, changes will be permanently written into the local store, and then loaded into policy. Validity of the object being added is checked at commit time. Adding new objects with respect to policy is allowed, except in the case of booleans. Attempt to add new booleans with respect to policy will fail at commit time.
 
 .TP
 .B Parameters:
-The 
+The
 .I handle
 is used to track persistent state across semanage calls, and for error reporting. The
-.I key 
-identifies the 
+.I key
+identifies the
 .I data
 object, which will be written into the store. The key are data are properties of the caller, and are not stored or modified internally.
 
 .TP
 .B Requirements:
-This function requires an semanage connection to be established (see 
+This function requires an semanage connection to be established (see
 .BR semanage_connect "(3)"
-), and must be executed in a transaction (see 
+), and must be executed in a transaction (see
 .BR semanage_begin_transaction "(3)"
 ).
 
diff --git a/libsemanage/man/man3/semanage_node.3 b/libsemanage/man/man3/semanage_node.3
index 2df7a914..29be96e0 100644
--- a/libsemanage/man/man3/semanage_node.3
+++ b/libsemanage/man/man3/semanage_node.3
@@ -1,6 +1,6 @@
 .TH semanage_node 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_node \- SELinux Network Nodes Management API
 
 .SH "SYNOPSIS"
@@ -11,27 +11,27 @@ semanage_node \- SELinux Network Nodes Management API
 .B #include <semanage/nodes_local.h>
 
 .PP
-This object contains properties associated with a network node. 
+This object contains properties associated with a network node.
 
 .PP
 For details on a specific function, see its manual page.
 
 .SH "Record API Overview"
 
-.HP 
-.BR semanage_node_create "(3)" \- 
+.HP
+.BR semanage_node_create "(3)" \-
 .br
-create a node 
+create a node
 
 .HP
 .BR semanage_node_free "(3)" \-
 .br
-release resources for this node 
+release resources for this node
 
 .HP
 .BR semanage_node_key_create "(3)" \-
 .br
-create a key, which can be used to identify a node 
+create a key, which can be used to identify a node
 
 .HP
 .BR semanage_node_key_free "(3)" \-
@@ -39,17 +39,17 @@ create a key, which can be used to identify a node
 release resources for this node key
 
 .HP
-.BR semanage_node_key_extract "(3)" \- 
+.BR semanage_node_key_extract "(3)" \-
 .br
-create a key matching this node 
+create a key matching this node
 
 .HP
-.BR semanage_node_clone "(3)" \- 
+.BR semanage_node_clone "(3)" \-
 .br
 create an identical node (deep-copy clone)
 
 .HP
-.BR semanage_node_compare "(3)" \- 
+.BR semanage_node_compare "(3)" \-
 .br
 compare this node to the provided key
 
@@ -61,7 +61,7 @@ compare this node to another
 .SH "Properties API Overview"
 
 .HP
-.BR semanage_node_get_addr "(3)" \- 
+.BR semanage_node_get_addr "(3)" \-
 .br
 return the IP address of this node in string representation
 
@@ -118,17 +118,17 @@ set the IP protocol version for this node
 .HP
 .BR semanage_node_get_con "(3)" \-
 .br
-return the SELinux context associated with this node 
+return the SELinux context associated with this node
 
 .HP
 .BR semanage_node_set_con "(3)" \-
 .br
-set the SELinux context associated with this node 
+set the SELinux context associated with this node
 
 .SH "Record Store API Overview"
 
 .HP
-.BR semanage_node_modify_local "(3)" \- 
+.BR semanage_node_modify_local "(3)" \-
 .br
 add or update an interface in the local store
 
@@ -153,7 +153,7 @@ check if an interface is defined in the local store
 query an interface in the persistent policy
 
 .HP
-.BR semanage_node_query_local "(3)" \- 
+.BR semanage_node_query_local "(3)" \-
 .br
 query an interface in the local store
 
diff --git a/libsemanage/man/man3/semanage_port.3 b/libsemanage/man/man3/semanage_port.3
index 3a4e6265..a8977d7e 100644
--- a/libsemanage/man/man3/semanage_port.3
+++ b/libsemanage/man/man3/semanage_port.3
@@ -1,6 +1,6 @@
 .TH semanage_port 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_port \- SELinux Network Ports Management API
 
 .SH "SYNOPSIS"
@@ -18,8 +18,8 @@ For details on a specific function, see its manual page.
 
 .SH "Record API Overview"
 
-.HP 
-.BR semanage_port_create "(3)" \- 
+.HP
+.BR semanage_port_create "(3)" \-
 .br
 create a port range
 
@@ -39,17 +39,17 @@ create a key, which can be used to identify a port range
 release resources for this port range key
 
 .HP
-.BR semanage_port_key_extract "(3)" \- 
+.BR semanage_port_key_extract "(3)" \-
 .br
 create a key matching this port range
 
 .HP
-.BR semanage_port_clone "(3)" \- 
+.BR semanage_port_clone "(3)" \-
 .br
 create an identical port range (deep-copy clone)
 
 .HP
-.BR semanage_port_compare "(3)" \- 
+.BR semanage_port_compare "(3)" \-
 .br
 compare this port range to the provided key
 
@@ -109,7 +109,7 @@ set the SELinux context for this port range
 .SH "Record Store API Overview"
 
 .HP
-.BR semanage_port_modify_local "(3)" \- 
+.BR semanage_port_modify_local "(3)" \-
 .br
 add or update a port range in the local store
 
@@ -134,7 +134,7 @@ check if a port range is defined in the local store
 query a port range in the persistent policy
 
 .HP
-.BR semanage_port_query_local "(3)" \- 
+.BR semanage_port_query_local "(3)" \-
 .br
 query a port range in the local store
 
@@ -166,4 +166,4 @@ return an array containing all port ranges in the persistent policy
 .HP
 .BR semanage_port_list_local "(3)" \-
 .br
-return an array containing all port ranges in the local store 
+return an array containing all port ranges in the local store
diff --git a/libsemanage/man/man3/semanage_query.3 b/libsemanage/man/man3/semanage_query.3
index e61c8b8b..4e77870b 100644
--- a/libsemanage/man/man3/semanage_query.3
+++ b/libsemanage/man/man3/semanage_query.3
@@ -1,6 +1,6 @@
 .TH semanage_query 3 "15 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_query \- SELinux Management API
 
 .SH "SYNOPSIS"
@@ -19,22 +19,22 @@ Replace the function and object name as necessary.
 .SH "DESCRIPTION"
 .TP
 .B Behavior:
-The query function will fail if a matching key is not found. Otherwise, the corresponding object is returned. 
+The query function will fail if a matching key is not found. Otherwise, the corresponding object is returned.
 
 .TP
 .B Parameters:
-The 
+The
 .I handle
 is used to track persistent state across semanage calls, and for error reporting. The
-.I key 
-identifies the object being queried, which will be stored in the address pointed by 
+.I key
+identifies the object being queried, which will be stored in the address pointed by
 .I response
-The key is a property of the caller, and will not be stored or modified internally. The object returned becomes a property of the caller, and must be freed with 
-.B semanage_OBJECT_free. 
+The key is a property of the caller, and will not be stored or modified internally. The object returned becomes a property of the caller, and must be freed with
+.B semanage_OBJECT_free.
 
 .TP
 .B Requirements:
-This function requires an semanage connection to be established (see 
+This function requires an semanage connection to be established (see
 .BR semanage_connect "(3)"
 )
 
diff --git a/libsemanage/man/man3/semanage_seuser.3 b/libsemanage/man/man3/semanage_seuser.3
index be0fa687..9e00b024 100644
--- a/libsemanage/man/man3/semanage_seuser.3
+++ b/libsemanage/man/man3/semanage_seuser.3
@@ -1,6 +1,6 @@
 .TH semanage_seuser 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_seuser \- Linux UID to SELinux User Management API
 
 .SH "SYNOPSIS"
@@ -11,17 +11,17 @@ semanage_seuser \- Linux UID to SELinux User Management API
 .B #include <semanage/seusers_local.h>
 
 .PP
-This object contains properties associated with a Unix user. Typically many Unix users are mapped to the same SELinux user. See 
+This object contains properties associated with a Unix user. Typically many Unix users are mapped to the same SELinux user. See
 .BR semanage_user "(3)"
-for overview of the SELinux user API. 
+for overview of the SELinux user API.
 
 .PP
 For details on a specific function, see its manual page.
 
 .SH "Record API Overview"
 
-.HP 
-.BR semanage_seuser_create "(3)" \- 
+.HP
+.BR semanage_seuser_create "(3)" \-
 .br
 create a seuser
 
@@ -33,7 +33,7 @@ release resources for this seuser
 .HP
 .BR semanage_seuser_key_create "(3)" \-
 .br
-create a key, which can be used to identify a seuser 
+create a key, which can be used to identify a seuser
 
 .HP
 .BR semanage_seuser_key_free "(3)" \-
@@ -41,17 +41,17 @@ create a key, which can be used to identify a seuser
 release resources for this seuser key
 
 .HP
-.BR semanage_seuser_key_extract "(3)" \- 
+.BR semanage_seuser_key_extract "(3)" \-
 .br
-create a key matching this seuser 
+create a key matching this seuser
 
 .HP
-.BR semanage_seuser_clone "(3)" \- 
+.BR semanage_seuser_clone "(3)" \-
 .br
 create an identical seuser (deep-copy clone)
 
 .HP
-.BR semanage_seuser_compare "(3)" \- 
+.BR semanage_seuser_compare "(3)" \-
 .br
 compare this seuser to the provided key
 
@@ -63,7 +63,7 @@ compare this seuser to another
 .SH "Properties API Overview"
 
 .HP
-.BR semanage_seuser_get_name "(3)" \- 
+.BR semanage_seuser_get_name "(3)" \-
 .br
 return the name of this seuser
 
@@ -95,7 +95,7 @@ set the range of valid MLS sensitivities and categories for this user
 .SH "Record Store API Overview"
 
 .HP
-.BR semanage_seuser_modify_local "(3)" \- 
+.BR semanage_seuser_modify_local "(3)" \-
 .br
 add or update a seuser in the local store
 
@@ -120,7 +120,7 @@ check if a seuser is defined in the local store
 query a seuser in the persistent policy
 
 .HP
-.BR semanage_seuser_query_local "(3)" \- 
+.BR semanage_seuser_query_local "(3)" \-
 .br
 query a seuser in the local store
 
diff --git a/libsemanage/man/man3/semanage_user.3 b/libsemanage/man/man3/semanage_user.3
index 6102dd5b..1304f0fa 100644
--- a/libsemanage/man/man3/semanage_user.3
+++ b/libsemanage/man/man3/semanage_user.3
@@ -1,6 +1,6 @@
 .TH semanage_user 3 "16 March 2006" "ivg2@cornell.edu" "Libsemanage API documentation"
 
-.SH "NAME" 
+.SH "NAME"
 semanage_user \- SELinux User Management API
 
 .SH "SYNOPSIS"
@@ -11,20 +11,20 @@ semanage_user \- SELinux User Management API
 .B #include <semanage/users_local.h>
 
 .PP
-This object contains properties associated with a SELinux user. 
-Typically many Unix users are mapped to the same SELinux user. See 
+This object contains properties associated with a SELinux user.
+Typically many Unix users are mapped to the same SELinux user. See
 .BR semanage_seuser "(3)"
-for overview of the Unix user API. 
+for overview of the Unix user API.
 
 .PP
 For details on a specific function, see its manual page.
 
 .SH "Record API Overview"
 
-.HP 
-.BR semanage_user_create "(3)" \- 
+.HP
+.BR semanage_user_create "(3)" \-
 .br
-create a user 
+create a user
 
 .HP
 .BR semanage_user_free "(3)" \-
@@ -42,17 +42,17 @@ create a key, which can be used to identify a user
 release resources for this user key
 
 .HP
-.BR semanage_user_key_extract "(3)" \- 
+.BR semanage_user_key_extract "(3)" \-
 .br
 create a key matching this user
 
 .HP
-.BR semanage_user_clone "(3)" \- 
+.BR semanage_user_clone "(3)" \-
 .br
 create an identical user (deep-copy clone)
 
 .HP
-.BR semanage_user_compare "(3)" \- 
+.BR semanage_user_compare "(3)" \-
 .br
 compare this user to the provided key
 
@@ -64,7 +64,7 @@ compare this user to another
 .SH "Properties API Overview"
 
 .HP
-.BR semanage_user_get_name "(3)" \- 
+.BR semanage_user_get_name "(3)" \-
 .br
 return the name of this user
 
@@ -135,7 +135,7 @@ set the roles for this user
 .SH "Record Store API Overview"
 
 .HP
-.BR semanage_user_modify_local "(3)" \- 
+.BR semanage_user_modify_local "(3)" \-
 .br
 add or update a user in the local store
 
@@ -160,7 +160,7 @@ check if a user is defined in the local store
 query a user in the persistent policy
 
 .HP
-.BR semanage_user_query_local "(3)" \- 
+.BR semanage_user_query_local "(3)" \-
 .br
 query a user in the local store
 
diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 380b58be..e6e8e27a 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -17,7 +17,7 @@ The following parameters are allowed:
 
 .RS
 .TP
-.B module-store 
+.B module-store
 Specify how the SELinux Management library should interact with the SELinux policy store. When set to "direct", the SELinux
 Management library writes to the SELinux policy module store directly (this is the default setting).
 Otherwise a socket path or a server name can be used for the argument.
@@ -45,7 +45,7 @@ Whether or not to ignore the cache of CIL modules compiled from HLL. It can be s
 If the cache is ignored, then all CIL modules are recompiled from their HLL modules.
 
 .TP
-.B policy-version 
+.B policy-version
 When generating the policy, by default
 .BR semanage
 will set the policy version to POLICYDB_VERSION_MAX, as defined in <sepol/policydb/policydb.h>. Change this setting if a different
@@ -78,11 +78,11 @@ It can be set to either "true" or "false" and by default it is set to "false" (t
 
 .TP
 .B ignoredirs
-List, separated by ";",  of directories to ignore when setting up users homedirs. 
-Some distributions use this to stop labeling /root as a homedir. 
+List, separated by ";",  of directories to ignore when setting up users homedirs.
+Some distributions use this to stop labeling /root as a homedir.
 
 .TP
-.B usepasswd 
+.B usepasswd
 Whether or not to enable the use getpwent() to obtain a list of home directories to label. It can be set to either "true" or "false".
 By default it is set to "true".
 
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index d5259967..8dfbd762 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -43,9 +43,9 @@ SWIGRUBYIF= semanageswig_ruby.i
 SWIGCOUT= semanageswig_wrap.c
 SWIGRUBYCOUT= semanageswig_ruby_wrap.c
 SWIGLOBJ:= $(patsubst %.c,$(PYPREFIX)%.lo,$(SWIGCOUT))
-SWIGRUBYLOBJ:= $(patsubst %.c,$(RUBYPREFIX)%.lo,$(SWIGRUBYCOUT)) 
+SWIGRUBYLOBJ:= $(patsubst %.c,$(RUBYPREFIX)%.lo,$(SWIGRUBYCOUT))
 SWIGSO=$(PYPREFIX)_semanage.so
-SWIGFILES=$(SWIGSO) semanage.py 
+SWIGFILES=$(SWIGSO) semanage.py
 SWIGRUBYSO=$(RUBYPREFIX)_semanage.so
 LIBSO=$(TARGET).$(LIBVERSION)
 
@@ -107,7 +107,7 @@ conf-parse.c: conf-parse.y
 
 conf-parse.h: conf-parse.c
 
-%.o:  %.c 
+%.o:  %.c
 	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
 
 %.lo:  %.c
@@ -134,7 +134,7 @@ $(SWIGRUBYCOUT): $(SWIGRUBYIF)
 swigify: $(SWIGIF)
 	$(SWIG) $<
 
-install: all 
+install: all
 	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
 	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
 	install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
@@ -143,20 +143,20 @@ install: all
 	test -f $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION)
 	cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
-install-pywrap: pywrap 
+install-pywrap: pywrap
 	test -d $(DESTDIR)$(PYTHONLIBDIR) || install -m 755 -d $(DESTDIR)$(PYTHONLIBDIR)
 	install -m 755 $(SWIGSO) $(DESTDIR)$(PYTHONLIBDIR)/_semanage$(PYCEXT)
 	install -m 644 semanage.py $(DESTDIR)$(PYTHONLIBDIR)
 
 
 install-rubywrap: rubywrap
-	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL) 
+	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL)
 	install -m 755 $(SWIGRUBYSO) $(DESTDIR)$(RUBYINSTALL)/semanage.so
 
 relabel:
 	/sbin/restorecon $(DESTDIR)$(LIBDIR)/$(LIBSO)
 
-clean: 
+clean:
 	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(SWIGRUBYSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c *.o *.lo *~
 
 distclean: clean
diff --git a/libsemanage/src/booleans_activedb.c b/libsemanage/src/booleans_activedb.c
index 9bcc9d71..6ebb520b 100644
--- a/libsemanage/src/booleans_activedb.c
+++ b/libsemanage/src/booleans_activedb.c
@@ -106,7 +106,7 @@ static int bool_commit_list(semanage_handle_t * handle,
 	for (i = 0; i < count; i++) {
 		name = semanage_bool_get_name(booleans[i]);
 		if (!name)
-			goto omem;	
+			goto omem;
 		newvalue = semanage_bool_get_value(booleans[i]);
 		curvalue = security_get_boolean_active(name);
 		if (newvalue == curvalue)
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index eac91344..8cfbd580 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -177,7 +177,7 @@ save_previous:    SAVE_PREVIOUS '=' ARG {
 	                if (strcasecmp($3, "true") == 0)
 		                current_conf->save_previous = 1;
 			else if (strcasecmp($3, "false") == 0)
-				current_conf->save_previous = 0;		
+				current_conf->save_previous = 0;
 			else {
 				yyerror("save-previous can only be 'true' or 'false'");
 			}
@@ -190,7 +190,7 @@ save_linked:    SAVE_LINKED '=' ARG {
 	                if (strcasecmp($3, "true") == 0)
 		                current_conf->save_linked = 1;
 			else if (strcasecmp($3, "false") == 0)
-				current_conf->save_linked = 0;		
+				current_conf->save_linked = 0;
 			else {
 				yyerror("save-linked can only be 'true' or 'false'");
 			}
@@ -280,7 +280,7 @@ optimize_policy:  OPTIMIZE_POLICY '=' ARG {
 	free($3);
 }
 
-command_block: 
+command_block:
                 command_start external_opts BLOCK_END  {
                         if (new_external->path == NULL) {
                                 parse_errors++;
diff --git a/libsemanage/src/database.h b/libsemanage/src/database.h
index a1cd32b8..8bd894df 100644
--- a/libsemanage/src/database.h
+++ b/libsemanage/src/database.h
@@ -30,7 +30,7 @@ typedef struct record_table {
 	/* Free record key */
 	void (*key_free) (record_key_t * key);
 
-	/* Return 0 if the record matches the key, 
+	/* Return 0 if the record matches the key,
 	 * -1 if the key represents a record that should
 	 * be ordered before this record, and 1 if vice-versa */
 	int (*compare) (const record_t * rec, const record_key_t * key);
@@ -60,7 +60,7 @@ typedef struct dbase_table {
 	/* --------------- Database Functionality ----------- */
 
 	/* Note: In all the functions below, the key is property
-	 * of the caller, and will not be modified by the database. 
+	 * of the caller, and will not be modified by the database.
 	 * In add/set/modify, the data is also property of the caller */
 
 	/* Add the specified record to
@@ -69,8 +69,8 @@ typedef struct dbase_table {
 		    dbase_t * dbase,
 		    const record_key_t * key, const record_t * data);
 
-	/* Add the specified record to the  
-	 * database if it not present. 
+	/* Add the specified record to the
+	 * database if it not present.
 	 * If it's present, replace it
 	 */
 	int (*modify) (struct semanage_handle * handle,
@@ -89,12 +89,12 @@ typedef struct dbase_table {
 		    dbase_t * dbase, const record_key_t * key);
 
 	/* Clear all records, and leave the database in
-	 * cached, modified state. This function does 
+	 * cached, modified state. This function does
 	 * not require a call to cache() */
 	int (*clear) (struct semanage_handle * handle, dbase_t * dbase);
 
-	/* Retrieve a record 
-	 * 
+	/* Retrieve a record
+	 *
 	 * Note: the resultant record
 	 * becomes property of the caller, and
 	 * must be freed accordingly */
@@ -112,17 +112,17 @@ typedef struct dbase_table {
 	int (*count) (struct semanage_handle * handle,
 		      dbase_t * dbase, unsigned int *response);
 
-	/* Execute the specified handler over 
+	/* Execute the specified handler over
 	 * the records of this database. The handler
 	 * can signal a successful exit by returning 1,
 	 * an error exit by returning -1, and continue by
 	 * returning 0
-	 * 
+	 *
 	 * Note: The record passed into the iterate handler
 	 * may or may not persist after the handler invocation,
 	 * and writing to it has unspecified behavior. It *must*
 	 * be cloned if modified, or preserved.
-	 * 
+	 *
 	 * Note: The iterate handler may not invoke any other
 	 * semanage read functions outside a transaction. It is only
 	 * reentrant while in transaction. The iterate handler may
@@ -134,9 +134,9 @@ typedef struct dbase_table {
 				   void *varg), void *fn_arg);
 
 	/* Construct a list of all records in this database
-	 * 
+	 *
 	 * Note: The list returned becomes property of the caller,
-	 * and must be freed accordingly. 
+	 * and must be freed accordingly.
 	 */
 	int (*list) (struct semanage_handle * handle,
 		     dbase_t * dbase,
diff --git a/libsemanage/src/database_activedb.c b/libsemanage/src/database_activedb.c
index 1cce0b82..fa6b6105 100644
--- a/libsemanage/src/database_activedb.c
+++ b/libsemanage/src/database_activedb.c
@@ -1,7 +1,7 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
 /* Object: dbase_activedb_t (Active/Kernel)
- * Extends: dbase_llist_t (Linked List) 
+ * Extends: dbase_llist_t (Linked List)
  * Implements: dbase_t (Database)
  */
 
@@ -20,7 +20,7 @@ typedef struct dbase_activedb dbase_t;
 /* ACTIVEDB dbase */
 struct dbase_activedb {
 
-	/* Parent object - must always be 
+	/* Parent object - must always be
 	 * the first field - here we are using
 	 * a linked list to store the records */
 	dbase_llist_t llist;
diff --git a/libsemanage/src/database_file.c b/libsemanage/src/database_file.c
index a51269e7..a7773fb5 100644
--- a/libsemanage/src/database_file.c
+++ b/libsemanage/src/database_file.c
@@ -1,7 +1,7 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
 /* Object: dbase_file_t (File)
- * Extends: dbase_llist_t (Linked List) 
+ * Extends: dbase_llist_t (Linked List)
  * Implements: dbase_t (Database)
  */
 
@@ -25,7 +25,7 @@ typedef struct dbase_file dbase_t;
 /* FILE dbase */
 struct dbase_file {
 
-	/* Parent object - must always be 
+	/* Parent object - must always be
 	 * the first field - here we are using
 	 * a linked list to store the records */
 	dbase_llist_t llist;
diff --git a/libsemanage/src/database_join.c b/libsemanage/src/database_join.c
index a49a6226..2a2008e8 100644
--- a/libsemanage/src/database_join.c
+++ b/libsemanage/src/database_join.c
@@ -1,7 +1,7 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
 /* Object: dbase_join_t (Join)
- * Extends: dbase_llist_t (Linked List) 
+ * Extends: dbase_llist_t (Linked List)
  * Implements: dbase_t (Database)
  */
 
@@ -20,7 +20,7 @@ typedef struct dbase_join dbase_t;
 /* JOIN dbase */
 struct dbase_join {
 
-	/* Parent object - must always be 
+	/* Parent object - must always be
 	 * the first field - here we are using
 	 * a linked list to store the records */
 	dbase_llist_t llist;
@@ -194,7 +194,7 @@ static int dbase_join_flush(semanage_handle_t * handle, dbase_join_t * dbase)
 
 	/* Then clear all records from the cache.
 	 * This is *not* the same as dropping the cache - it's an explicit
-	 * request to delete all current records. We need to do 
+	 * request to delete all current records. We need to do
 	 * this because we don't store delete deltas for the join,
 	 * so we must re-add all records from scratch */
 	if (dtable1->clear(handle, dbase1) < 0)
diff --git a/libsemanage/src/database_policydb.c b/libsemanage/src/database_policydb.c
index 748a6ed6..95418365 100644
--- a/libsemanage/src/database_policydb.c
+++ b/libsemanage/src/database_policydb.c
@@ -109,7 +109,7 @@ static int dbase_policydb_cache(semanage_handle_t * handle,
 		goto err;
 	}
 
-	/* Try opening file 
+	/* Try opening file
 	 * ENOENT is not fatal - we just create an empty policydb */
 	fp = fopen(fname, "rb");
 	if (fp == NULL && errno != ENOENT) {
diff --git a/libsemanage/src/database_policydb.h b/libsemanage/src/database_policydb.h
index f782e0d5..8cb66f71 100644
--- a/libsemanage/src/database_policydb.h
+++ b/libsemanage/src/database_policydb.h
@@ -68,7 +68,7 @@ typedef int (*record_policydb_table_iterate_t) (sepol_handle_t * h,
 typedef struct record_policydb_table {
 	/* Add policy record */
 	record_policydb_table_add_t add;
-	/* Modify policy record, or add if 
+	/* Modify policy record, or add if
 	 * the key isn't found */
 	record_policydb_table_modify_t modify;
 	/* Set policy record */
diff --git a/libsemanage/src/debug.c b/libsemanage/src/debug.c
index 3c345462..902ab5a5 100644
--- a/libsemanage/src/debug.c
+++ b/libsemanage/src/debug.c
@@ -1,6 +1,6 @@
 /* Author: Joshua Brindle <jbrindle@tresys.co
  *         Jason Tang     <jtang@tresys.com>
- *         Ivan Gyurdiev  <ivg2@cornell.edu> 
+ *         Ivan Gyurdiev  <ivg2@cornell.edu>
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat Inc.
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 7631c7bf..84c31399 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2004-2006 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat, Inc.
- * 
+ *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
  *  License as published by the Free Software Foundation; either
@@ -514,7 +514,7 @@ static int semanage_direct_update_user_extra(semanage_handle_t * sh, cil_db_t *c
 			goto cleanup;
 
 		pusers_extra->dtable->drop_cache(pusers_extra->dbase);
-		
+
 	} else {
 		retval =  pusers_extra->dtable->clear(sh, pusers_extra->dbase);
 	}
@@ -1509,8 +1509,8 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	/* ======= Post-process: Validate non-policydb components ===== */
 
 	/* Validate local modifications to file contexts.
-	 * Note: those are still cached, even though they've been 
-	 * merged into the main file_contexts. We won't check the 
+	 * Note: those are still cached, even though they've been
+	 * merged into the main file_contexts. We won't check the
 	 * large file_contexts - checked at compile time */
 	if (do_rebuild || fcontexts_modified) {
 		retval = semanage_fcontext_validate_local(sh, out);
@@ -1603,7 +1603,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
                                See /etc/selinux/semanage.conf if you need to enable it.");
         }
 
-	/* free out, if we don't free it before calling semanage_install_sandbox 
+	/* free out, if we don't free it before calling semanage_install_sandbox
 	 * then fork() may fail on low memory machines */
 	sepol_policydb_free(out);
 	out = NULL;
@@ -2735,7 +2735,7 @@ cleanup:
 		if (modinfos != NULL) {
 			for (i = 0; i < *modinfos_len; i++) {
 				semanage_module_info_destroy(
-						sh, 
+						sh,
 						&(*modinfos)[i]);
 			}
 			free(*modinfos);
@@ -2846,7 +2846,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 		status = -3;
 		goto cleanup;
 	}
-	
+
 	/* if this is an HLL, delete the CIL cache if it exists so it will get recompiled */
 	if (type == SEMANAGE_MODULE_PATH_HLL) {
 		ret = semanage_module_get_path(
@@ -2992,4 +2992,3 @@ cleanup:
 
 	return status;
 }
-
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index ecb34fc7..ede2d67d 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -145,7 +145,7 @@ static void ignore_free(void) {
 
 static int ignore_setup(char *ignoredirs) {
 	char *tok;
-	ignoredir_t *ptr = NULL; 
+	ignoredir_t *ptr = NULL;
 
 	tok = strtok(ignoredirs, ";");
 	while(tok) {
@@ -1372,7 +1372,7 @@ done:
 
 int semanage_genhomedircon(semanage_handle_t * sh,
 			   sepol_policydb_t * policydb,
-			   int usepasswd, 
+			   int usepasswd,
 			   char *ignoredirs)
 {
 	genhomedircon_settings_t s;
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index b2201ee3..c489a75f 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat, Inc.
- * 
+ *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
  *  License as published by the Free Software Foundation; either
@@ -207,7 +207,7 @@ int semanage_get_disable_dontaudit(semanage_handle_t * sh)
 void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudit)
 {
 	assert(sh != NULL);
-	
+
 	sepol_set_disable_dontaudit(sh->sepolh, disable_dontaudit);
 	return;
 }
@@ -279,7 +279,7 @@ void semanage_select_store(semanage_handle_t * sh, char *storename,
 
 	assert(sh != NULL);
 
-	/* This just sets the storename to what the user requests, no 
+	/* This just sets the storename to what the user requests, no
 	   verification of existence will be done until connect */
 	free(sh->conf->store_path);
 	sh->conf->store_path = strdup(storename);
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index c7f4e903..2853ca39 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -1,7 +1,7 @@
 /* Author: Joshua Brindle <jbrindle@tresys.com>
  *         Jason Tang     <jtang@tresys.com>
  *         Ivan Gyurdiev  <ivg2@cornell.edu>
- *           
+ *
  * Copyright (C) 2005 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat Inc.
  *
diff --git a/libsemanage/src/parse_utils.h b/libsemanage/src/parse_utils.h
index 3e44aca1..52408373 100644
--- a/libsemanage/src/parse_utils.h
+++ b/libsemanage/src/parse_utils.h
@@ -45,12 +45,12 @@ extern int parse_assert_noeof(semanage_handle_t * handle, parse_info_t * info);
  * otherwise eat the whitespace */
 extern int parse_assert_space(semanage_handle_t * handle, parse_info_t * info);
 
-/* Throw an error if the specified character 
+/* Throw an error if the specified character
  * does not follow, otherwise eat that character */
 extern int parse_assert_ch(semanage_handle_t * handle,
 			   parse_info_t * info, const char ch);
 
-/* Throw an error if the specified string 
+/* Throw an error if the specified string
  * does not follow is not found, otherwise
  * eat the string */
 extern int parse_assert_str(semanage_handle_t * handle,
diff --git a/libsemanage/src/policy_components.c b/libsemanage/src/policy_components.c
index 896ac512..69835550 100644
--- a/libsemanage/src/policy_components.c
+++ b/libsemanage/src/policy_components.c
@@ -113,7 +113,7 @@ int semanage_base_merge_components(semanage_handle_t * handle)
 	int rc = STATUS_SUCCESS;
 
 	/* Order is important here - change things carefully.
-	 * System components first, local next. Verify runs with 
+	 * System components first, local next. Verify runs with
 	 * mutual dependencies are ran after everything is merged */
 	load_table_t components[] = {
 
diff --git a/libsemanage/src/ports_file.c b/libsemanage/src/ports_file.c
index 1356021a..90909eb4 100644
--- a/libsemanage/src/ports_file.c
+++ b/libsemanage/src/ports_file.c
@@ -101,7 +101,7 @@ static int port_parse(semanage_handle_t * handle,
 	if (parse_fetch_int(handle, info, &low, '-') < 0)
 		goto err;
 
-	/* If range (-) does not follow immediately, require a space 
+	/* If range (-) does not follow immediately, require a space
 	 * In other words, the space here is optional, but only
 	 * in the ranged case, not in the single port case,
 	 * so do a custom test */
diff --git a/libsemanage/src/ports_local.c b/libsemanage/src/ports_local.c
index e7e9bdbf..0261b07f 100644
--- a/libsemanage/src/ports_local.c
+++ b/libsemanage/src/ports_local.c
@@ -97,7 +97,7 @@ int semanage_port_validate_local(semanage_handle_t * handle)
 		const char *proto_str2;
 		int proto2, low2, high2;
 
-		/* Find the first port with matching 
+		/* Find the first port with matching
 		   protocol to compare against */
 		do {
 			if (j == nports - 1)
@@ -119,8 +119,8 @@ int semanage_port_validate_local(semanage_handle_t * handle)
 		}
 
 		/* If closest port of matching protocol doesn't overlap with
-		 * test port, neither do the rest of them, because that's 
-		 * how the sort function works on ports - lower bound 
+		 * test port, neither do the rest of them, because that's
+		 * how the sort function works on ports - lower bound
 		 * ports come first */
 	      next:
 		i++;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 0ac2e5b2..aa5f4961 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -187,7 +187,7 @@ static int semanage_init_paths(const char *root)
 	return 0;
 }
 
-/* This initializes the paths inside the stores, this is only necessary 
+/* This initializes the paths inside the stores, this is only necessary
  * when directly accessing the store
  */
 static int semanage_init_store_paths(const char *root)
@@ -649,7 +649,7 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 }
 
 /* returns <0 if the active store cannot be read or doesn't exist
- * 0 if the store exists but the lock file cannot be accessed 
+ * 0 if the store exists but the lock file cannot be accessed
  * SEMANAGE_CAN_READ if the store can be read and the lock file used
  * SEMANAGE_CAN_WRITE if the modules directory and binary policy dir can be written to
  */
@@ -732,7 +732,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
 
 	if (!mode)
 		mode = S_IRUSR | S_IWUSR;
-	
+
 	mask = umask(0);
 	if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, mode)) == -1) {
 		umask(mask);
@@ -1496,7 +1496,7 @@ static int semanage_exec_prog(semanage_handle_t * sh,
 	return WEXITSTATUS(status);
 }
 
-/* reloads the policy pointed to by the handle, used locally by install 
+/* reloads the policy pointed to by the handle, used locally by install
  * and exported for user reload requests */
 int semanage_reload_policy(semanage_handle_t * sh)
 {
@@ -2106,8 +2106,8 @@ int semanage_load_files(semanage_handle_t * sh, cil_db_t *cildb, char **filename
 	return 0;
 }
 
-/* 
- * Expands the policy contained within *base 
+/*
+ * Expands the policy contained within *base
  */
 
 /**
@@ -2291,7 +2291,7 @@ static void semanage_fc_node_list_destroy(semanage_file_context_node_t * x)
 	}
 }
 
-/* Free the linked list of buckets (and their node lists) 
+/* Free the linked list of buckets (and their node lists)
  * starting at the given bucket. */
 static void semanage_fc_bucket_list_destroy(semanage_file_context_bucket_t * x)
 {
@@ -2319,7 +2319,7 @@ static void semanage_fc_bucket_list_destroy(semanage_file_context_bucket_t * x)
  *      -> a is less specific than b.
  *     If a does not have a specified type and b does not,
  *      -> a is less specific than b.
- * FIXME: These heuristics are imperfect, but good enough for 
+ * FIXME: These heuristics are imperfect, but good enough for
  * now.  A proper comparison would determine which (if either)
  * regular expression is a subset of the other.
  */
@@ -2357,13 +2357,13 @@ static int semanage_fc_compare(semanage_file_context_node_t * a,
 	if (!b->file_type && a->file_type)
 		return 1;
 
-	/* If none of the above conditions were satisfied, 
+	/* If none of the above conditions were satisfied,
 	 * then a and b are equally specific. */
 	return 0;
 }
 
 /* Merges two sorted file context linked lists into a single sorted one.
- * The left list is assumed to represent nodes that came first in the original ordering. 
+ * The left list is assumed to represent nodes that came first in the original ordering.
  * The final sorted list is returned.
  */
 static semanage_file_context_node_t
@@ -2415,9 +2415,9 @@ static semanage_file_context_node_t
  *  This is a stable implementation of an iterative merge sort.
  *  Each bucket initially has a linked list of file contexts
  *   that are 1 node long.
- *  Each pass, buckets (and the nodes they contain) are merged 
+ *  Each pass, buckets (and the nodes they contain) are merged
  *   two at time.
- *  Buckets are merged until there is only one bucket left, 
+ *  Buckets are merged until there is only one bucket left,
  *   containing the list of file contexts, sorted.
  */
 static void semanage_fc_merge_sort(semanage_file_context_bucket_t * main)
@@ -2430,9 +2430,9 @@ static void semanage_fc_merge_sort(semanage_file_context_bucket_t * main)
 	while (main->next) {
 		current = main;
 
-		/* Merge buckets two-by-two. 
-		 * If there is an odd number of buckets, the last 
-		 * bucket will be left alone, which corresponds 
+		/* Merge buckets two-by-two.
+		 * If there is an odd number of buckets, the last
+		 * bucket will be left alone, which corresponds
 		 * to the operation of merging it with an empty bucket. */
 		while (current) {
 			if (current->next) {
@@ -2444,7 +2444,7 @@ static void semanage_fc_merge_sort(semanage_file_context_bucket_t * main)
 
 				/* Free the (now empty) second bucket.
 				 * (This does not touch the node list
-				 * in the bucket because it has been 
+				 * in the bucket because it has been
 				 * shifted over to the first bucket. */
 				free(temp);
 			}
@@ -2453,8 +2453,8 @@ static void semanage_fc_merge_sort(semanage_file_context_bucket_t * main)
 	}
 }
 
-/* Compute the location of the first regular expression 
- *   meta character in the path of the given node, if it exists. 
+/* Compute the location of the first regular expression
+ *   meta character in the path of the given node, if it exists.
  * On return:
  *     fc_node->meta = position of meta character, if it exists
  *			(-1 corresponds to no character)
@@ -2515,7 +2515,7 @@ static char *semanage_strnchr(const char *buf, size_t buf_len, char c)
 }
 
 /* Returns a pointer to the end of line character in the given buffer.
- * Used in the context of a file context char buffer that we will be 
+ * Used in the context of a file context char buffer that we will be
  * parsing and sorting.
  */
 static char *semanage_get_line_end(const char *buf, size_t buf_len)
@@ -2540,7 +2540,7 @@ static char *semanage_get_line_end(const char *buf, size_t buf_len)
  *  Returns 0 on success, -1 on failure.
  *  Allocates a buffer pointed to by sorted_buf that contains the sorted lines.
  *  sorted_buf_len is set to the size of this buffer.
- *  This buffer is guaranteed to have a final \0 character. 
+ *  This buffer is guaranteed to have a final \0 character.
  *  This buffer must be released by the caller.
  */
 int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
@@ -2573,7 +2573,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 		return -1;
 	}
 
-	/* Initialize the head of the linked list 
+	/* Initialize the head of the linked list
 	 * that will contain a node for each file context line. */
 	head = current =
 	    (semanage_file_context_node_t *) calloc(1,
@@ -2643,7 +2643,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 					escape_chars++;
 					just_saw_escape = 1;
 				} else {
-					/* We're looking at an escaped 
+					/* We're looking at an escaped
 					   escape. Reset our flag. */
 					just_saw_escape = 0;
 				}
@@ -2792,7 +2792,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 	/* Sort the bucket list. */
 	semanage_fc_merge_sort(main);
 
-	/* First, calculate how much space we'll need for 
+	/* First, calculate how much space we'll need for
 	 * the newly sorted block of data.  (We don't just
 	 * use buf_len for this because we have extracted
 	 * comments and whitespace.) */
@@ -2880,7 +2880,7 @@ static void semanage_nc_destroy_ruletab(semanage_netfilter_context_node_t *
  *  Returns 0 on success, -1 on failure.
  *  Allocates a buffer pointed to by sorted_buf that contains the sorted lines.
  *  sorted_buf_len is set to the size of this buffer.
- *  This buffer is guaranteed to have a final \0 character. 
+ *  This buffer is guaranteed to have a final \0 character.
  *  This buffer must be released by the caller.
  */
 int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
@@ -2994,7 +2994,7 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 		line_buf = line_end + 1;
 	}
 
-	/* First, calculate how much space we'll need for 
+	/* First, calculate how much space we'll need for
 	 * the newly sorted block of data.  (We don't just
 	 * use buf_len for this because we have extracted
 	 * comments and whitespace.)  Start at 1 for trailing \0 */
diff --git a/libsemanage/src/semanageswig.i b/libsemanage/src/semanageswig.i
index ebf39cfb..9c198e5a 100644
--- a/libsemanage/src/semanageswig.i
+++ b/libsemanage/src/semanageswig.i
@@ -2,7 +2,7 @@
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
  * Copyright (C) 2006 Red Hat, Inc.
- * 
+ *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
  *  License as published by the Free Software Foundation; either
diff --git a/libsemanage/src/semanageswig_python.i b/libsemanage/src/semanageswig_python.i
index 0e27424f..0ca09763 100644
--- a/libsemanage/src/semanageswig_python.i
+++ b/libsemanage/src/semanageswig_python.i
@@ -2,7 +2,7 @@
  *
  * Copyright (C) 2004-2005 Tresys Technology, LLC
  * Copyright (C) 2006 Red Hat, Inc
- *  
+ *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
  *  License as published by the Free Software Foundation; either
@@ -36,34 +36,34 @@
 
 	/* There are two ways to call this function:
 	 * One is with a valid swig_type and destructor.
-	 * Two is with a NULL swig_type and NULL destructor. 
-	 * 
+	 * Two is with a NULL swig_type and NULL destructor.
+	 *
 	 * In the first mode, the function converts
-	 * an array of *cloned* objects [of the given pointer swig type] 
-	 * into a PyList, and destroys the array in the process 
+	 * an array of *cloned* objects [of the given pointer swig type]
+	 * into a PyList, and destroys the array in the process
 	 * (the objects pointers are preserved).
 	 *
 	 * In the second mode, the function converts
 	 * an array of *constant* strings into a PyList, and destroys
-	 * the array in the process 
+	 * the array in the process
 	 * (the strings are copied, originals not freed). */
 
 	static int semanage_array2plist(
 		semanage_handle_t* handle,
-		void** arr, 
-		unsigned int asize, 
+		void** arr,
+		unsigned int asize,
 		swig_type_info* swig_type,
-		void (*destructor) (void*),	
+		void (*destructor) (void*),
 		PyObject** result) {
-		
+
 		PyObject* plist = PyList_New(0);
 		unsigned int i;
 
-		if (!plist) 
+		if (!plist)
 			goto err;
-	
+
 		for (i = 0; i < asize; i++)  {
-			
+
 			PyObject* obj = NULL;
 
 			/* NULL indicates string conversion,
@@ -71,31 +71,31 @@
 			if (!swig_type)
 				obj = SWIG_FromCharPtr(arr[i]);
 			else
-				obj = SWIG_NewPointerObj(arr[i], swig_type, 0);				 
+				obj = SWIG_NewPointerObj(arr[i], swig_type, 0);
 
-			if (!obj) 
+			if (!obj)
 				goto err;
 
-			if (PyList_Append(plist, obj) < 0) 
+			if (PyList_Append(plist, obj) < 0)
 				goto err;
 		}
 
 		free(arr);
-		
-		*result = plist;		
+
+		*result = plist;
 		return STATUS_SUCCESS;
 
 		err:
-		for (i = 0; i < asize; i++) 
+		for (i = 0; i < asize; i++)
 			if (destructor)
 				destructor(arr[i]);
 		free(arr);
 		return STATUS_ERR;
 	}
-%} 
+%}
 /* a few helpful typemaps are available in this library */
 %include <typemaps.i>
-/* wrap all int*'s so they can be used for results 
+/* wrap all int*'s so they can be used for results
    if it becomes necessary to send in data this should be changed to INOUT */
 %apply int *OUTPUT { int * };
 %apply int *OUTPUT { size_t * };
@@ -122,10 +122,10 @@
 %typemap(argout) (
  	semanage_handle_t* handle,
 	const semanage_user_t* user,
-	const char*** roles_arr, 
+	const char*** roles_arr,
 	unsigned int* num_roles) {
 
-	if ($result) {	
+	if ($result) {
 		int value;
 		SWIG_AsVal_int($result, &value);
 		if (value >= 0) {
@@ -185,10 +185,10 @@
 
 %typemap(argout) (
  	semanage_handle_t* handle,
-	semanage_bool_t*** records, 
+	semanage_bool_t*** records,
 	unsigned int* count) {
 
-	if ($result) {	
+	if ($result) {
 		int value;
 		SWIG_AsVal_int($result, &value);
 		if (value >= 0) {
@@ -228,10 +228,10 @@
 
 %typemap(argout) (
  	semanage_handle_t* handle,
-	semanage_fcontext_t*** records, 
+	semanage_fcontext_t*** records,
 	unsigned int* count) {
 
-	if ($result) {	
+	if ($result) {
 		int value;
 		SWIG_AsVal_int($result, &value);
 		if (value >= 0) {
@@ -272,10 +272,10 @@
 
 %typemap(argout) (
  	semanage_handle_t* handle,
-	semanage_iface_t*** records, 
+	semanage_iface_t*** records,
 	unsigned int* count) {
 
-	if ($result) {	
+	if ($result) {
 		int value;
 		SWIG_AsVal_int($result, &value);
 		if (value >= 0) {
@@ -316,10 +316,10 @@
 
 %typemap(argout) (
  	semanage_handle_t* handle,
-	semanage_seuser_t*** records, 
+	semanage_seuser_t*** records,
 	unsigned int* count) {
 
-	if ($result) {	
+	if ($result) {
 		int value;
 		SWIG_AsVal_int($result, &value);
 		if (value >= 0) {
@@ -359,10 +359,10 @@
 
 %typemap(argout) (
  	semanage_handle_t* handle,
-	semanage_user_t*** records, 
+	semanage_user_t*** records,
 	unsigned int* count) {
 
-	if ($result) {	
+	if ($result) {
 		int value;
 		SWIG_AsVal_int($result, &value);
 		if (value >= 0) {
@@ -402,10 +402,10 @@
 
 %typemap(argout) (
  	semanage_handle_t* handle,
-	semanage_port_t*** records, 
+	semanage_port_t*** records,
 	unsigned int* count) {
 
-	if ($result) {	
+	if ($result) {
 		int value;
 		SWIG_AsVal_int($result, &value);
 		if (value >= 0) {
@@ -531,10 +531,10 @@
 
 %typemap(argout) (
  	semanage_handle_t* handle,
-	semanage_node_t*** records, 
+	semanage_node_t*** records,
 	unsigned int* count) {
 
-	if ($result) {	
+	if ($result) {
 		int value;
 		SWIG_AsVal_int($result, &value);
 		if (value >= 0) {
diff --git a/libsemanage/src/semanageswig_ruby.i b/libsemanage/src/semanageswig_ruby.i
index 9010b545..18ea6841 100644
--- a/libsemanage/src/semanageswig_ruby.i
+++ b/libsemanage/src/semanageswig_ruby.i
@@ -12,7 +12,7 @@
 /* a few helpful typemaps are available in this library */
 %include <typemaps.i>
 
-/* wrap all int*'s so they can be used for results 
+/* wrap all int*'s so they can be used for results
    if it becomes necessary to send in data this should be changed to INOUT */
 %apply int *OUTPUT { int * };
 %apply int *OUTPUT { size_t * };
diff --git a/libsemanage/src/seuser_record.c b/libsemanage/src/seuser_record.c
index 44a54758..69ebea51 100644
--- a/libsemanage/src/seuser_record.c
+++ b/libsemanage/src/seuser_record.c
@@ -23,7 +23,7 @@ struct semanage_seuser {
 	/* This user's name */
 	char *name;
 
-	/* This user's corresponding 
+	/* This user's corresponding
 	 * seuser ("role set") */
 	char *sename;
 
diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
index 795a33d6..ec7bfb08 100644
--- a/libsemanage/src/seusers_local.c
+++ b/libsemanage/src/seusers_local.c
@@ -316,7 +316,7 @@ static int validate_handler(const semanage_seuser_t * seuser, void *varg)
 	return -1;
 }
 
-/* This function may not be called outside a transaction, or 
+/* This function may not be called outside a transaction, or
  * it will (1) deadlock, because iterate is not reentrant outside
  * a transaction, and (2) be racy, because it makes multiple dbase calls */
 
diff --git a/libsemanage/src/user_record.c b/libsemanage/src/user_record.c
index bb8f4de1..b22c5c1c 100644
--- a/libsemanage/src/user_record.c
+++ b/libsemanage/src/user_record.c
@@ -301,7 +301,7 @@ void semanage_user_free(semanage_user_t * user)
 	if (!tmp_user)
 		goto omem;
 
-	/* Set the shared name from one of the records 
+	/* Set the shared name from one of the records
 	 * (at least one is available) */
 	if (record1 == NULL)
 		name = semanage_user_extra_get_name(record2);
diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index fdbb8ad6..24284d65 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -318,7 +318,7 @@ semanage_list_t *semanage_slurp_file_filter(FILE * file,
 		if (pred(line)) {
 			semanage_rtrim(line, '\n');
 			current = list_addafter_controlmem(current, line);
-			if (!current) 
+			if (!current)
 				break;
 			line = NULL;
 			buff_len = 0;
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 69f49a36..b0869558 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -20,9 +20,9 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 %.policy: %.cil
 	../../secilc/secilc $*.cil -o $*.policy -f /dev/null
 
-clean distclean: 
+clean distclean:
 	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE)
 
-test: all 
+test: all
 	./$(EXECUTABLE)
 
diff --git a/libsemanage/tests/README b/libsemanage/tests/README
index 424970cf..396591cb 100644
--- a/libsemanage/tests/README
+++ b/libsemanage/tests/README
@@ -5,7 +5,7 @@ read-only filesystem by using DAC permissions. Consequently, these tests
 will fail if run as root, as root can override DAC permissions.
 
 
-How to add and use unit tests 
+How to add and use unit tests
 =============================
 
 We are using the CUnit unit testing framework.  This framework--and the
@@ -22,13 +22,13 @@ add unit tests for your code:
    semanage_store.c.   Your new .h/.c files represent a suite of related
    tests.
 
-2. Write or add new tests to a suite.  Tests are simply functions that 
+2. Write or add new tests to a suite.  Tests are simply functions that
    take the form:
 
 	void test_my_function(void)
 
    These tests are where you will make calls to the CUnit assertions.
- 
+
    If you are making a new test suite, also add the suite init/cleanup
    functions.  These take the form:
 
@@ -51,9 +51,9 @@ add unit tests for your code:
 6. Run your tests.  Rejoice or despair, as appropriate.
 
 
-A note on the the utilities.c: Add functions that can be commonly used 
-here.  For example, it is handy to have a dummy message callback 
-function to silence error messages produced by libsemanage and keep 
+A note on the the utilities.c: Add functions that can be commonly used
+here.  For example, it is handy to have a dummy message callback
+function to silence error messages produced by libsemanage and keep
 your output pretty.  To do this, include utilities.h and specify the
 callback like so:
 
diff --git a/libsemanage/tests/test_semanage_store.c b/libsemanage/tests/test_semanage_store.c
index 92085361..2e6c38e1 100644
--- a/libsemanage/tests/test_semanage_store.c
+++ b/libsemanage/tests/test_semanage_store.c
@@ -124,7 +124,7 @@ int semanage_store_test_cleanup(void)
 	return 0;
 }
 
-/* Adds all the tests needed for this suite. 
+/* Adds all the tests needed for this suite.
  */
 int semanage_store_add_tests(CU_pSuite suite)
 {
-- 
2.45.2

