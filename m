Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB717C3DA7D
	for <selinux@archiver.kernel.org>; Thu,  5 Jan 2023 17:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjAERVj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Jan 2023 12:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjAERVB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Jan 2023 12:21:01 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFE51C10A
        for <selinux@vger.kernel.org>; Thu,  5 Jan 2023 09:13:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s5so53648446edc.12
        for <selinux@vger.kernel.org>; Thu, 05 Jan 2023 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFSU0dwceXPwtZ7nnxUcA1DAK203LEbXmRtXo3jywc4=;
        b=ELzMeybOhWGJVSQxlYXwb6Msp6mgLA1YUtk2KZDnYp0xR4Qn5i+E9rLW5KmorLt49X
         s+UdTfRITjMe3asWEh6Eh4SSkWMaV03coUWRezeUlajoGNObF0iCaBrea4Hz2QuF1kPE
         dJ7aj/QKj9UPCRYxxOQoYZ2oK/F8LsVkvXsIHBjb2OiAYscOm84Vd2t5ZlY62FLwvLV0
         X+YmoKWF4IRhIpSO+R/WXcBS8LMhRMaF2i818dJ7GN9Lr1vLrfx1kW99nJipL4y0DT6O
         RAyBZBfvNR/PU/iZxSaCmhK0F10dKg7dOkkEEMvD1uKGKHtndXCri/RfVpo1ylec4lai
         ImYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFSU0dwceXPwtZ7nnxUcA1DAK203LEbXmRtXo3jywc4=;
        b=1ORP13SNFOawxV8SFQBStA9h6Jvwc7VX06dSdC1A0ZDv9u/+KQC16/PlShpazCGTf3
         4QTNgmHJj4XnGb8sKWa/flB60hz/PV8PrwIDi4PXxb/QBTMmb7HQ3AC2NYzjjCW5VKXh
         kvZUX+Xei1sTluEx4DuS1ZQ0pUy5jMIY2fJvU8Kkt/uUmdHsNN/PPWUowvlUCBXTWEzL
         75hyr4iN4rCbdNjwveDAWd+FOy8+CpNv+Sa/5MNAogkyezDk2cH5CvFb4KoCzyHlnHSV
         KyCnpDOpXs01wP7CxWVO3HT+N2chU5OfyUjLF08PNSN97uuYgD7muqLrD0Q8k7k9rdoj
         na4A==
X-Gm-Message-State: AFqh2koxhYTfw+nHWJmFJ40rPa77BVWUWxGDn+J5bOC72Qf8E+cvXCA0
        8RsuVZWQ3DnqC99APPjdN93JkEEiuefr9w==
X-Google-Smtp-Source: AMrXdXtQ7/MpKK+6wNDiyootFqwQ9pvNyIsHoC+FPOJUboSWKK9pEgNVeIsHhJ1Da9lO17bDrxp75w==
X-Received: by 2002:a05:6402:550a:b0:47f:bc9b:46ec with SMTP id fi10-20020a056402550a00b0047fbc9b46ecmr38252988edb.7.1672938807583;
        Thu, 05 Jan 2023 09:13:27 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-153-041.77.10.pool.telefonica.de. [77.10.153.41])
        by smtp.gmail.com with ESMTPSA id g32-20020a056402322000b0048c85c5ad30sm6270886eda.83.2023.01.05.09.13.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:13:26 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] Correct misc typos
Date:   Thu,  5 Jan 2023 18:13:20 +0100
Message-Id: <20230105171320.18349-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by codespell(1) and typos[1].

[1]: https://github.com/crate-ci/typos

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_db.c                             | 2 +-
 libselinux/src/regex.c                                | 2 +-
 libselinux/src/sha1.c                                 | 2 +-
 libsepol/cil/src/cil_post.c                           | 2 +-
 libsepol/cil/src/cil_resolve_ast.c                    | 2 +-
 libsepol/src/module_to_cil.c                          | 2 +-
 libsepol/tests/policies/test-deps/base-metreq.conf    | 2 +-
 libsepol/tests/policies/test-deps/base-notmetreq.conf | 2 +-
 libsepol/tests/policies/test-deps/small-base.conf     | 2 +-
 libsepol/tests/policies/test-expander/alias-base.conf | 2 +-
 libsepol/tests/policies/test-expander/role-base.conf  | 2 +-
 libsepol/tests/policies/test-expander/small-base.conf | 2 +-
 libsepol/tests/policies/test-expander/user-base.conf  | 2 +-
 libsepol/tests/policies/test-hooks/cmp_policy.conf    | 2 +-
 libsepol/tests/policies/test-hooks/small-base.conf    | 2 +-
 libsepol/tests/policies/test-linker/small-base.conf   | 2 +-
 policycoreutils/newrole/newrole.c                     | 2 +-
 python/semanage/semanage                              | 2 +-
 python/sepolicy/sepolicy/manpage.py                   | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index bd73201c..3f803037 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -31,7 +31,7 @@
  * For example:
  * ----------------------------------------
  * #
- * # It is an example specfile for database obejcts
+ * # It is an example specfile for database objects
  * #
  * db_database  template1           system_u:object_r:sepgsql_db_t:s0
  *
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 149a7973..ae7ad690 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -167,7 +167,7 @@ int regex_writef(struct regex_data *regex, FILE *fp, int do_write_precompregex)
 	PCRE2_UCHAR *bytes = NULL;
 
 	if (do_write_precompregex) {
-		/* encode the patter for serialization */
+		/* encode the pattern for serialization */
 		rc = pcre2_serialize_encode((const pcre2_code **)&regex->regex,
 					    1, &bytes, &serialized_size, NULL);
 		if (rc != 1) {
diff --git a/libselinux/src/sha1.c b/libselinux/src/sha1.c
index a8484677..9d51e04a 100644
--- a/libselinux/src/sha1.c
+++ b/libselinux/src/sha1.c
@@ -11,7 +11,7 @@
 //  Modified to:
 //    - stop symbols being exported for libselinux shared library - October 2015
 //								       Richard Haines <richard_c_haines@btinternet.com>
-//    - Not cast the workspace from a byte array to a CHAR64LONG16 due to alignment isses.
+//    - Not cast the workspace from a byte array to a CHAR64LONG16 due to alignment issues.
 //      Fixes:
 //        sha1.c:73:33: error: cast from 'uint8_t *' (aka 'unsigned char *') to 'CHAR64LONG16 *' increases required alignment from 1 to 4 [-Werror,-Wcast-align]
 //             CHAR64LONG16*       block = (CHAR64LONG16*) workspace;
diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 11e572e2..a7c66ead 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1193,7 +1193,7 @@ static int __cil_cat_expr_range_to_bitmap_helper(struct cil_list_item *i1, struc
 	struct cil_cat *c2 = (struct cil_cat *)d2;
 
 	if (n1->flavor == CIL_CATSET || n2->flavor == CIL_CATSET) {
-		cil_log(CIL_ERR, "Category sets cannont be used in a category range\n");
+		cil_log(CIL_ERR, "Category sets cannot be used in a category range\n");
 		goto exit;
 	}
 
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index f5e22c97..d2bfdc81 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -778,7 +778,7 @@ int cil_resolve_classcommon(struct cil_tree_node *current, void *extra_args)
 	class = (struct cil_class *)class_datum;
 	common = (struct cil_class *)common_datum;
 	if (class->common != NULL) {
-		cil_log(CIL_ERR, "class cannot be associeated with more than one common\n");
+		cil_log(CIL_ERR, "class cannot be associated with more than one common\n");
 		rc = SEPOL_ERR;
 		goto exit;
 	}
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index b900290a..2b24d33e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2330,7 +2330,7 @@ static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *bl
 	}
 
 	if (block->flags & AVRULE_OPTIONAL) {
-		// sensitivites in user statements in optionals do not have the
+		// sensitivities in user statements in optionals do not have the
 		// standard -1 offset
 		sens_offset = 0;
 	}
diff --git a/libsepol/tests/policies/test-deps/base-metreq.conf b/libsepol/tests/policies/test-deps/base-metreq.conf
index b7528dde..d8e1f40b 100644
--- a/libsepol/tests/policies/test-deps/base-metreq.conf
+++ b/libsepol/tests/policies/test-deps/base-metreq.conf
@@ -33,7 +33,7 @@ class key_socket
 class unix_stream_socket
 class unix_dgram_socket
 
-# sysv-ipc-related clases
+# sysv-ipc-related classes
 class sem
 class msg
 class msgq
diff --git a/libsepol/tests/policies/test-deps/base-notmetreq.conf b/libsepol/tests/policies/test-deps/base-notmetreq.conf
index eee36dca..ecd92f6f 100644
--- a/libsepol/tests/policies/test-deps/base-notmetreq.conf
+++ b/libsepol/tests/policies/test-deps/base-notmetreq.conf
@@ -33,7 +33,7 @@ class key_socket
 class unix_stream_socket
 class unix_dgram_socket
 
-# sysv-ipc-related clases
+# sysv-ipc-related classes
 class msg
 class msgq
 class shm
diff --git a/libsepol/tests/policies/test-deps/small-base.conf b/libsepol/tests/policies/test-deps/small-base.conf
index 98f49c23..848d1741 100644
--- a/libsepol/tests/policies/test-deps/small-base.conf
+++ b/libsepol/tests/policies/test-deps/small-base.conf
@@ -33,7 +33,7 @@ class key_socket
 class unix_stream_socket
 class unix_dgram_socket
 
-# sysv-ipc-related clases
+# sysv-ipc-related classes
 class sem
 class msg
 class msgq
diff --git a/libsepol/tests/policies/test-expander/alias-base.conf b/libsepol/tests/policies/test-expander/alias-base.conf
index b950039d..34955924 100644
--- a/libsepol/tests/policies/test-expander/alias-base.conf
+++ b/libsepol/tests/policies/test-expander/alias-base.conf
@@ -33,7 +33,7 @@ class key_socket
 class unix_stream_socket
 class unix_dgram_socket
 
-# sysv-ipc-related clases
+# sysv-ipc-related classes
 class sem
 class msg
 class msgq
diff --git a/libsepol/tests/policies/test-expander/role-base.conf b/libsepol/tests/policies/test-expander/role-base.conf
index 8e88b4be..a387c8c0 100644
--- a/libsepol/tests/policies/test-expander/role-base.conf
+++ b/libsepol/tests/policies/test-expander/role-base.conf
@@ -33,7 +33,7 @@ class key_socket
 class unix_stream_socket
 class unix_dgram_socket
 
-# sysv-ipc-related clases
+# sysv-ipc-related classes
 class sem
 class msg
 class msgq
diff --git a/libsepol/tests/policies/test-expander/small-base.conf b/libsepol/tests/policies/test-expander/small-base.conf
index 055ea054..ac180f35 100644
--- a/libsepol/tests/policies/test-expander/small-base.conf
+++ b/libsepol/tests/policies/test-expander/small-base.conf
@@ -33,7 +33,7 @@ class key_socket
 class unix_stream_socket
 class unix_dgram_socket
 
-# sysv-ipc-related clases
+# sysv-ipc-related classes
 class sem
 class msg
 class msgq
diff --git a/libsepol/tests/policies/test-expander/user-base.conf b/libsepol/tests/policies/test-expander/user-base.conf
index b31ee8cd..789a59a2 100644
--- a/libsepol/tests/policies/test-expander/user-base.conf
+++ b/libsepol/tests/policies/test-expander/user-base.conf
@@ -33,7 +33,7 @@ class key_socket
 class unix_stream_socket
 class unix_dgram_socket
 
-# sysv-ipc-related clases
+# sysv-ipc-related classes
 class sem
 class msg
 class msgq
diff --git a/libsepol/tests/policies/test-hooks/cmp_policy.conf b/libsepol/tests/policies/test-hooks/cmp_policy.conf
index 9082b333..3c510bc4 100644
--- a/libsepol/tests/policies/test-hooks/cmp_policy.conf
+++ b/libsepol/tests/policies/test-hooks/cmp_policy.conf
@@ -33,7 +33,7 @@ class key_socket
 class unix_stream_socket
 class unix_dgram_socket
 
-# sysv-ipc-related clases
+# sysv-ipc-related classes
 class sem
 class msg
 class msgq
diff --git a/libsepol/tests/policies/test-hooks/small-base.conf b/libsepol/tests/policies/test-hooks/small-base.conf
index 9082b333..3c510bc4 100644
--- a/libsepol/tests/policies/test-hooks/small-base.conf
+++ b/libsepol/tests/policies/test-hooks/small-base.conf
@@ -33,7 +33,7 @@ class key_socket
 class unix_stream_socket
 class unix_dgram_socket
 
-# sysv-ipc-related clases
+# sysv-ipc-related classes
 class sem
 class msg
 class msgq
diff --git a/libsepol/tests/policies/test-linker/small-base.conf b/libsepol/tests/policies/test-linker/small-base.conf
index 890ebbeb..15ced459 100644
--- a/libsepol/tests/policies/test-linker/small-base.conf
+++ b/libsepol/tests/policies/test-linker/small-base.conf
@@ -33,7 +33,7 @@ class key_socket
 class unix_stream_socket
 class unix_dgram_socket
 
-# sysv-ipc-related clases
+# sysv-ipc-related classes
 class sem
 class msg
 class msgq
diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index c2afa37e..d9efa68a 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -1289,7 +1289,7 @@ int main(int argc, char *argv[])
 	/*
 	 * Step 5:  Execute a new shell with the new context in `new_context'. 
 	 *
-	 * Establish context, namesapce and any options for the new shell
+	 * Establish context, namespace and any options for the new shell
 	 */
 	if (optind < 1)
 		optind = 1;
diff --git a/python/semanage/semanage b/python/semanage/semanage
index b21d1484..e0bd98a9 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -130,7 +130,7 @@ class SetImportFile(argparse.Action):
                 sys.exit(1)
         setattr(namespace, self.dest, values)
 
-# define dictionary for seobject OBEJCTS
+# define dictionary for seobject OBJECTS
 object_dict = {
     'login': seobject.loginRecords,
     'user': seobject.seluserRecords,
diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 1bff8f9a..a488dcbf 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -739,7 +739,7 @@ SELinux %(domainname)s policy is very flexible allowing users to setup their %(d
 .B STANDARD FILE CONTEXT
 
 SELinux defines the file context types for the %(domainname)s, if you wanted to
-store files with these types in a diffent paths, you need to execute the semanage command to specify alternate labeling and then use restorecon to put the labels on disk.
+store files with these types in a different paths, you need to execute the semanage command to specify alternate labeling and then use restorecon to put the labels on disk.
 
 .B semanage fcontext -a -t %(type)s '/srv/%(domainname)s/content(/.*)?'
 .br
-- 
2.39.0

