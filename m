Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F88FC433EF
	for <selinux@archiver.kernel.org>; Fri,  8 Apr 2022 13:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiDHNOJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbiDHNNs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Apr 2022 09:13:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF01FCE
        for <selinux@vger.kernel.org>; Fri,  8 Apr 2022 06:10:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so17289971ejb.4
        for <selinux@vger.kernel.org>; Fri, 08 Apr 2022 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=874Mic0IEkcNIEk8DL6TKC0bE6uGH4uq7IE7JWBAFIY=;
        b=gled2cBpW9M9UDpBCQd//mSNTJuK/P4hhEZLXCg6QssQDcO+2cuuE7ztsH7j+Ce8ju
         XM+XkmQtcdfRT7l/D3sgDlahz2zk+cVGq/XL9HI0mNduuqX/FV60Zrn/KkKfQO7JVVlJ
         E/bg3ZNfNbe4k5Cx1UbNjHVO0jX6MZkoO1Zu0Kq7Ip2vAfpsTcO3TL0qb2zD9dhwaWxE
         DZRETs9lnuDNGlAg9iCqZHymGSFYLczo62vhabx/703UrQKHrtv1iu0rkzoufJLXShs+
         c6+waTvUnvQgfVPsjaRAE55JjlROtIKBqRe2n0T0ioyMPAseMbPCY8hBdL0eRkVsxxne
         ZkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=874Mic0IEkcNIEk8DL6TKC0bE6uGH4uq7IE7JWBAFIY=;
        b=bYVjmHLx4lDnYpYiB/Q9or2Ajb6cYK9UIyo3R8voaoeVPOPLt3SGmZc1At2hCcnVPT
         DXAZFxxtn0k7ieXnfsDmoaPcIG1YR/GsThfzV3v//hkARR7cWSug+6KvHzXawhSly0km
         eQCQtZXLIauzd6MT79MgbJAB5/jM2u0tjLAbx32npaSxvjScv+OQQNjYQ4t6ntetJoWT
         OedC4IR48mb2i/8bb60RB7B0vOAuLTh2xYgRW0b/6M5vbjoAizijoPELU+Zg98rYOLiX
         DdsbhZUvsbNWXq/ov4UXhSucTUdk8vYy0YkDq78ySLQst3KLN//kOLaqleLKbEQRXwOS
         yseA==
X-Gm-Message-State: AOAM533R/zFLx8vUTbs8q9DJtbNGjt0oHmn5osY7DIUMuiAPASOkb6l4
        rODVSN9WA6dJg7X6FpA21uHPbf5PG+U=
X-Google-Smtp-Source: ABdhPJy91V+LNPMCFxcLdRRsZsMuxJBuh5gmpYGzsxXxwa8MkamjDTGmoum8I3W8Luosvqzr8Vu38g==
X-Received: by 2002:a17:907:6e21:b0:6e1:c1ab:d0e0 with SMTP id sd33-20020a1709076e2100b006e1c1abd0e0mr18534818ejc.358.1649423438156;
        Fri, 08 Apr 2022 06:10:38 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-032-209.77.3.pool.telefonica.de. [77.3.32.209])
        by smtp.gmail.com with ESMTPSA id f7-20020a0564021e8700b0041d03a94f27sm2138685edf.66.2022.04.08.06.10.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 06:10:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] Correct misc typos
Date:   Fri,  8 Apr 2022 15:10:31 +0200
Message-Id: <20220408131031.7825-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by typos[1].

[1]: https://github.com/crate-ci/typos

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/genhomedircon.c             | 2 +-
 libsemanage/src/handle.h                    | 2 +-
 libsemanage/src/semanage_store.c            | 2 +-
 libsemanage/tests/test_iface.c              | 2 +-
 policycoreutils/newrole/newrole.pamd        | 2 +-
 policycoreutils/run_init/run_init.pamd      | 2 +-
 python/sepolgen/src/sepolgen/objectmodel.py | 2 +-
 python/sepolgen/src/sepolgen/refpolicy.py   | 2 +-
 python/sepolgen/tests/test_audit.py         | 2 +-
 python/sepolgen/tests/test_refpolicy.py     | 2 +-
 python/sepolicy/sepolicy-bash-completion.sh | 6 +++---
 python/sepolicy/sepolicy/gui.py             | 4 ++--
 12 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 7ca9afc3..8f8774d3 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -490,7 +490,7 @@ static int STR_COMPARATOR(const void *a, const void *b)
 	return strcmp((const char *) a, (const char *) b);
 }
 
-/* make_tempate
+/* make_template
  * @param	s	  the settings holding the paths to various files
  * @param	pred	function pointer to function to use as filter for slurp
  * 					file filter
diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
index 4d2aae8f..c7f4e903 100644
--- a/libsemanage/src/handle.h
+++ b/libsemanage/src/handle.h
@@ -72,7 +72,7 @@ struct semanage_handle {
 	int do_check_contexts;	/* whether to run setfiles check the file contexts file */
 
 	/* This timeout is used for transactions and waiting for lock
-	   -1 means wait indefinetely
+	   -1 means wait indefinitely
 	   0 means return immediately
 	   >0 means wait that many seconds */
 	int timeout;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index c6d2c5e7..14a0957a 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1327,7 +1327,7 @@ static char **split_args(const char *arg0, char *arg_string,
 		goto cleanup;
 	s = arg_string;
 	/* parse the argument string one character at a time,
-	 * repsecting quotes and other special characters */
+	 * respecting quotes and other special characters */
 	while (s != NULL && *s != '\0') {
 		switch (*s) {
 		case '\\':{
diff --git a/libsemanage/tests/test_iface.c b/libsemanage/tests/test_iface.c
index 434372f8..46937e10 100644
--- a/libsemanage/tests/test_iface.c
+++ b/libsemanage/tests/test_iface.c
@@ -47,7 +47,7 @@ void test_iface_get_set_msgcon(void);
 void test_iface_create(void);
 void test_iface_clone(void);
 
-/* iterfaces_policy.h */
+/* interfaces_policy.h */
 void test_iface_query(void);
 void test_iface_exists(void);
 void test_iface_count(void);
diff --git a/policycoreutils/newrole/newrole.pamd b/policycoreutils/newrole/newrole.pamd
index de3582f3..683c5441 100644
--- a/policycoreutils/newrole/newrole.pamd
+++ b/policycoreutils/newrole/newrole.pamd
@@ -1,5 +1,5 @@
 #%PAM-1.0
-# Uncomment the next line if you do not want to enter your passwd everytime
+# Uncomment the next line if you do not want to enter your passwd every time
 # auth       sufficient   pam_rootok.so
 auth       include	system-auth
 account    include	system-auth
diff --git a/policycoreutils/run_init/run_init.pamd b/policycoreutils/run_init/run_init.pamd
index 1c323d20..ef460134 100644
--- a/policycoreutils/run_init/run_init.pamd
+++ b/policycoreutils/run_init/run_init.pamd
@@ -1,5 +1,5 @@
 #%PAM-1.0
-# Uncomment the next line if you do not want to enter your passwd everytime
+# Uncomment the next line if you do not want to enter your passwd every time
 #auth       sufficient   pam_rootok.so
 auth       include	system-auth
 account    include	system-auth
diff --git a/python/sepolgen/src/sepolgen/objectmodel.py b/python/sepolgen/src/sepolgen/objectmodel.py
index 84955f7c..ccce86c1 100644
--- a/python/sepolgen/src/sepolgen/objectmodel.py
+++ b/python/sepolgen/src/sepolgen/objectmodel.py
@@ -95,7 +95,7 @@ class PermMappings:
     """The information flow properties of a set of object classes and permissions.
 
     PermMappings maps one or more classes and permissions to their PermMap objects
-    describing their information flow charecteristics.
+    describing their information flow characteristics.
     """
     def __init__(self):
         self.classes = { }
diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index 3e907e91..9cac1b95 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -34,7 +34,7 @@ import selinux
 # the data structures that we need for policy generation.
 #
 
-# Constans for referring to fields
+# Constants for referring to fields
 SRC_TYPE  = 0
 TGT_TYPE  = 1
 OBJ_CLASS = 2
diff --git a/python/sepolgen/tests/test_audit.py b/python/sepolgen/tests/test_audit.py
index dbe6be2a..b659bf3b 100644
--- a/python/sepolgen/tests/test_audit.py
+++ b/python/sepolgen/tests/test_audit.py
@@ -230,7 +230,7 @@ class TestGeneration(unittest.TestCase):
 
         self.assertEqual(len(avs), 1)
 
-    def test_genaration_granted(self):
+    def test_generation_granted(self):
         parser = sepolgen.audit.AuditParser()
         parser.parse_string(granted1)
         avs = parser.to_access()
diff --git a/python/sepolgen/tests/test_refpolicy.py b/python/sepolgen/tests/test_refpolicy.py
index c7219fd5..a24381a6 100644
--- a/python/sepolgen/tests/test_refpolicy.py
+++ b/python/sepolgen/tests/test_refpolicy.py
@@ -144,7 +144,7 @@ class TestSecurityContext(unittest.TestCase):
         self.assertNotEqual(sc1, sc3)
         self.assertNotEqual(sc1, sc4)
 
-class TestObjecClass(unittest.TestCase):
+class TestObjectClass(unittest.TestCase):
     def test_init(self):
         o = refpolicy.ObjectClass(name="file")
         self.assertEqual(o.name, "file")
diff --git a/python/sepolicy/sepolicy-bash-completion.sh b/python/sepolicy/sepolicy-bash-completion.sh
index 779fd75b..13638e4d 100644
--- a/python/sepolicy/sepolicy-bash-completion.sh
+++ b/python/sepolicy/sepolicy-bash-completion.sh
@@ -36,10 +36,10 @@ __get_all_booleans () {
 __get_all_types () {
     seinfo -t 2> /dev/null | tail -n +3
 }
-__get_all_admin_interaces () {
+__get_all_admin_interfaces () {
     awk '/InterfaceVector.*_admin /{ print $2 }' /var/lib/sepolgen/interface_info | awk -F '_admin' '{ print $1 }'
 }
-__get_all_user_role_interaces () {
+__get_all_user_role_interfaces () {
     awk '/InterfaceVector.*_role /{ print $2 }' /var/lib/sepolgen/interface_info | awk -F '_role' '{ print $1 }'
 }
 __get_all_user_domains () {
@@ -139,7 +139,7 @@ _sepolicy () {
                 COMPREPLY=( $(compgen -W "-n --name -t --type" -- "$cur") )
                 return 0
             elif [ "$prev" = "--admin" -o "$prev" = "-a" ]; then
-                COMPREPLY=( $(compgen -W "$( __get_all_admin_interaces ) " -- "$cur") )
+                COMPREPLY=( $(compgen -W "$( __get_all_admin_interfaces ) " -- "$cur") )
                 return 0
             elif [ "$prev" = "--user" -o "$prev" = "-u" ]; then
                 COMPREPLY=( $(compgen -W "$( __get_all_users )" -- "$cur") )
diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index c9ca158d..4f892f82 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -1309,9 +1309,9 @@ class SELinuxGui():
                 filename = i['filename']
             else:
                 filename = None
-            self.transitions_files_inital_data_insert(i['target'], i['class'], i['transtype'], filename)
+            self.transitions_files_initial_data_insert(i['target'], i['class'], i['transtype'], filename)
 
-    def transitions_files_inital_data_insert(self, path, tclass, dest, name):
+    def transitions_files_initial_data_insert(self, path, tclass, dest, name):
         iter = self.transitions_file_liststore.append()
         self.transitions_file_liststore.set_value(iter, 0, path)
         self.transitions_file_liststore.set_value(iter, 1, tclass)
-- 
2.35.1

