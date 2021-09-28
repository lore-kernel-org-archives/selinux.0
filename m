Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778D4C433F5
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5751861206
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbhI1Pqx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhI1Pqw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 11:46:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BF8C061745
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:45:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id dn26so7989321edb.13
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFKrFwH8ECcHyRFPnLS3WtEvNm/zOuGjs68h+UOVH2g=;
        b=qNCoAevHoJv75r1Cdnl3F27ruVE9SaQrxu99CSHVE7Er1zMI5oxZ5rz4u8GorxCOnZ
         XCvD59kAERcpoI2gP6c13GXjztiIyquNmtjx/nWs9XUTO+Toi52p5Do5ky4/tANntI2Y
         Uq4DOUsqAvJNOCYVuKcHjtYReEj4prS1JiqmFhNXgMbXrRlBBK9CrfPy77VylW4922Bu
         DMWlN9fGR8Twc2kKRNgqTPjgZnkNmOfXg4rxOymPyT2BKzUjIGK80JABp1ezCda8Ghxs
         yQWFV7x2A7tPn0yQu7euKzn7MMHsDkncev2bamIY66+4BylM/dOgWP2RdSTTCnecOC7x
         374w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFKrFwH8ECcHyRFPnLS3WtEvNm/zOuGjs68h+UOVH2g=;
        b=BDpyaPccjxTmI6n8Ryo8rU6uUj4ufwujhCDXR3Fh5E9A9ImHYxn4CD5Y/4wh7AqxhH
         33w7gpZgPng3BQs6ccesHg9xcygZ/VaQh3JGiSig/b/f6TMv4KXr+1IdpcUaNf1ReuMB
         ZCUNtkk34m9pG7fV7FGxIanCmEhPzPZiK8SxCj3YYHpJsENF3QvRm0Cp7ZuyVa0+hyeF
         DBI8wsplkwEcXSWYpNRcpq6D0qRv8T14fjknK0jsi0LHEtM09wh92IWsEKUaaMmGtlrB
         0UCHkJWYhwHSbTqb59J1/zia7iJbXgbht/cpTLnLdo2P/uCUX7kOtkAAEs5tn5ketZOm
         j4Pw==
X-Gm-Message-State: AOAM532FQHQLHXM3Rr9F31ZsvEu+pAmLiPoCSjfrPqwAkOnITCXV5vwe
        qQYz72SjjMOMOYiPmn/cKx0eRcjCw9A=
X-Google-Smtp-Source: ABdhPJyaGxqa0BmxeBoZdRH+SaozVchZXHiYlkQnxmYGcO2aHszbpMqofP/WSLhwXhIWW95r/Mvtqg==
X-Received: by 2002:a17:907:2131:: with SMTP id qo17mr7681021ejb.224.1632843850630;
        Tue, 28 Sep 2021 08:44:10 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-152-081.95.112.pool.telefonica.de. [95.112.152.81])
        by smtp.gmail.com with ESMTPSA id e9sm3171366ejh.0.2021.09.28.08.44.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:44:10 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] Correct some typos
Date:   Tue, 28 Sep 2021 17:44:05 +0200
Message-Id: <20210928154405.10722-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by codespell

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/Makefile          | 2 +-
 policycoreutils/newrole/newrole.c         | 2 +-
 python/semanage/semanage                  | 6 +++---
 python/sepolgen/src/sepolgen/refpolicy.py | 2 +-
 python/sepolgen/src/sepolgen/yacc.py      | 2 +-
 python/sepolicy/sepolicy/manpage.py       | 2 +-
 secilc/docs/cil_access_vector_rules.md    | 2 +-
 secilc/docs/secil.xml                     | 2 +-
 secilc/test/block_test.cil                | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
index 0e7ebce3..4dedb7dd 100644
--- a/policycoreutils/newrole/Makefile
+++ b/policycoreutils/newrole/Makefile
@@ -12,7 +12,7 @@ AUDITH ?= $(shell test -f $(INCLUDEDIR)/libaudit.h && echo y)
 # This will make newrole a setuid root program.
 # The capabilities used are: CAP_AUDIT_WRITE.
 AUDIT_LOG_PRIV ?= n
-# Enable capabilities to permit newrole to utilitize the pam_namespace module.
+# Enable capabilities to permit newrole to utilize the pam_namespace module.
 # This will make newrole a setuid root program.
 # The capabilities used are: CAP_SYS_ADMIN, CAP_CHOWN, CAP_FOWNER and
 # CAP_DAC_OVERRIDE. 
diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 7c1f062f..31b51c5a 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -1022,7 +1022,7 @@ static int set_signal_handles(void)
 int main(int argc, char *argv[])
 {
 	char *new_context = NULL;	/* target security context */
-	char *old_context = NULL;	/* original securiy context */
+	char *old_context = NULL;	/* original security context */
 	char *tty_context = NULL;	/* current context of tty */
 	char *new_tty_context = NULL;	/* new context of tty */
 
diff --git a/python/semanage/semanage b/python/semanage/semanage
index 18a27105..ff9fb66b 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -129,7 +129,7 @@ class SetImportFile(argparse.Action):
                 sys.exit(1)
         setattr(namespace, self.dest, values)
 
-# define dictonary for seobject OBEJCTS
+# define dictionary for seobject OBEJCTS
 object_dict = {
     'login': seobject.loginRecords,
     'user': seobject.seluserRecords,
@@ -146,7 +146,7 @@ object_dict = {
 }
 
 def generate_custom_usage(usage_text, usage_dict):
-    # generate custom usage from given text and dictonary
+    # generate custom usage from given text and dictionary
     sorted_keys = []
     for i in usage_dict.keys():
         sorted_keys.append(i)
@@ -160,7 +160,7 @@ def generate_custom_usage(usage_text, usage_dict):
 
 
 def handle_opts(args, dict, target_key):
-    # handle conflict and required options for given dictonary
+    # handle conflict and required options for given dictionary
     # {action:[conflict_opts,require_opts]}
 
     # first we need to catch conflicts
diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/src/sepolgen/refpolicy.py
index 74763687..3e907e91 100644
--- a/python/sepolgen/src/sepolgen/refpolicy.py
+++ b/python/sepolgen/src/sepolgen/refpolicy.py
@@ -42,7 +42,7 @@ PERMS     = 3
 ROLE      = 4
 DEST_TYPE = 5
 
-# String represenations of the above constants
+# String representations of the above constants
 field_to_str = ["source", "target", "object", "permission", "role", "destination" ]
 str_to_field = { "source" : SRC_TYPE, "target" : TGT_TYPE, "object" : OBJ_CLASS,
                 "permission" : PERMS, "role" : ROLE, "destination" : DEST_TYPE }
diff --git a/python/sepolgen/src/sepolgen/yacc.py b/python/sepolgen/src/sepolgen/yacc.py
index 55c1ef7d..c1c79880 100644
--- a/python/sepolgen/src/sepolgen/yacc.py
+++ b/python/sepolgen/src/sepolgen/yacc.py
@@ -1502,7 +1502,7 @@ class Grammar(object):
         self.Precedence   = {}      # Precedence rules for each terminal. Contains tuples of the
                                     # form ('right',level) or ('nonassoc', level) or ('left',level)
 
-        self.UsedPrecedence = set() # Precedence rules that were actually used by the grammer.
+        self.UsedPrecedence = set() # Precedence rules that were actually used by the grammar.
                                     # This is only used to provide error checking and to generate
                                     # a warning about unused precedence rules.
 
diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 2f847abb..3e61e333 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -797,7 +797,7 @@ SELinux %(domainname)s policy is very flexible allowing users to setup their %(d
 .B STANDARD FILE CONTEXT
 
 SELinux defines the file context types for the %(domainname)s, if you wanted to
-store files with these types in a diffent paths, you need to execute the semanage command to sepecify alternate labeling and then use restorecon to put the labels on disk.
+store files with these types in a diffent paths, you need to execute the semanage command to specify alternate labeling and then use restorecon to put the labels on disk.
 
 .B semanage fcontext -a -t %(type)s '/srv/%(domainname)s/content(/.*)?'
 .br
diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
index fa68609e..f0ba4a90 100644
--- a/secilc/docs/cil_access_vector_rules.md
+++ b/secilc/docs/cil_access_vector_rules.md
@@ -360,7 +360,7 @@ dontauditx
 
 Do not audit the access rights defined when access denied. This stops excessive log entries for known events.
 
-Note that for this to work there must *also* be atleast one [`allowx`](cil_access_vector_rules.md#allowx) rule associated with the target type.
+Note that for this to work there must *also* be at least one [`allowx`](cil_access_vector_rules.md#allowx) rule associated with the target type.
 
 Note that these rules can be omitted by the CIL compiler command line parameter `-D` or `--disable-dontaudit` flags.
 
diff --git a/secilc/docs/secil.xml b/secilc/docs/secil.xml
index daa80ded..b015490d 100644
--- a/secilc/docs/secil.xml
+++ b/secilc/docs/secil.xml
@@ -208,7 +208,7 @@
             <context name="String" attribute="String" lineEndContext="#stay">
                 <RegExpr attribute="Char" context="#stay" String="#\\."/>
 
-                <!-- allow escaping " or similiar -->
+                <!-- allow escaping " or similar -->
                 <HlCStringChar attribute="String Char" context="#stay"/>
 
                 <DetectChar attribute="String" context="#pop" char="&quot;"/>
diff --git a/secilc/test/block_test.cil b/secilc/test/block_test.cil
index 2dfcb899..2dd30c23 100644
--- a/secilc/test/block_test.cil
+++ b/secilc/test/block_test.cil
@@ -84,7 +84,7 @@
 )
 
 
-;; Inherting the abstract block causes the allow rule to be in the policy
+;; Inheriting the abstract block causes the allow rule to be in the policy
 (type t5)
 (block b5
   (blockabstract b5)
-- 
2.33.0

