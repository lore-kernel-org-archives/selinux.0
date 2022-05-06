Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513B4C433EF
	for <selinux@archiver.kernel.org>; Fri,  6 May 2022 14:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245226AbiEFOKZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 May 2022 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiEFOKZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 May 2022 10:10:25 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C38E5A2DF
        for <selinux@vger.kernel.org>; Fri,  6 May 2022 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651846000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pZKt5EGxN5EB09St0dXmjC6AEbl1cb0v1cRftjFM8G4=;
        b=JL4rpziIDWiFF+WPuJgs3WL2mc6bsiqz2xzJUM+fLbpoMeNAE53FC7pEINCPPXAlGvgobD
        rxvk4JngSoaiBMMx6u7dNHrKIFQCNsYoy2ItO1eM/5KSOLIUlxIyRbmhvSmTxrdcqK5JI2
        8UY4fLy9bv7zZfrELkqIUIhstrWmS58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-9sy0fgx2PWSq7apwpH_qLw-1; Fri, 06 May 2022 10:06:36 -0400
X-MC-Unique: 9sy0fgx2PWSq7apwpH_qLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC3E71014A63
        for <selinux@vger.kernel.org>; Fri,  6 May 2022 14:06:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.195.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 464C2C27D9A
        for <selinux@vger.kernel.org>; Fri,  6 May 2022 14:06:35 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] gettext: set _ on module level instead of builtins namespace
Date:   Fri,  6 May 2022 16:06:23 +0200
Message-Id: <20220506140623.736036-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Some calls to "_" where unsuccessful because the function was
initialized with a different translation domain than the string.
e.g. selinux-polgengui calls functions from sepolicy.generate, which end
up printing untranslated strings because polgengui uses selinux-gui
domain while sepolicy uses selinux-python

- Set "_" in module namespace instead of "builtins"
- Set the whole "sepolicy.generate()" confirmation as translatable
- Drop "codeset" parameter since it is deprecated

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 gui/booleansPage.py                   | 4 ++--
 gui/domainsPage.py                    | 4 ++--
 gui/fcontextPage.py                   | 4 ++--
 gui/loginsPage.py                     | 4 ++--
 gui/modulesPage.py                    | 4 ++--
 gui/polgengui.py                      | 4 ++--
 gui/portsPage.py                      | 4 ++--
 gui/semanagePage.py                   | 4 ++--
 gui/statusPage.py                     | 4 ++--
 gui/system-config-selinux.py          | 4 ++--
 gui/usersPage.py                      | 4 ++--
 python/chcat/chcat                    | 4 ++--
 python/semanage/semanage              | 4 ++--
 python/semanage/seobject.py           | 4 ++--
 python/sepolicy/sepolicy.py           | 4 ++--
 python/sepolicy/sepolicy/__init__.py  | 4 ++--
 python/sepolicy/sepolicy/generate.py  | 6 +++---
 python/sepolicy/sepolicy/gui.py       | 4 ++--
 python/sepolicy/sepolicy/interface.py | 4 ++--
 sandbox/sandbox                       | 4 ++--
 20 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/gui/booleansPage.py b/gui/booleansPage.py
index dd12b6d6..5beec58b 100644
--- a/gui/booleansPage.py
+++ b/gui/booleansPage.py
@@ -44,10 +44,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/gui/domainsPage.py b/gui/domainsPage.py
index 6bbe4de5..e08f34b4 100644
--- a/gui/domainsPage.py
+++ b/gui/domainsPage.py
@@ -36,10 +36,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
index 52292cae..bac2bec3 100644
--- a/gui/fcontextPage.py
+++ b/gui/fcontextPage.py
@@ -53,10 +53,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/gui/loginsPage.py b/gui/loginsPage.py
index cbfb0cc2..18b93d8c 100644
--- a/gui/loginsPage.py
+++ b/gui/loginsPage.py
@@ -35,10 +35,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/gui/modulesPage.py b/gui/modulesPage.py
index 35a0129b..c546d455 100644
--- a/gui/modulesPage.py
+++ b/gui/modulesPage.py
@@ -36,10 +36,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/gui/polgengui.py b/gui/polgengui.py
index 01f541ba..a18f1cba 100644
--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -69,10 +69,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/gui/portsPage.py b/gui/portsPage.py
index a537ecc8..54aa80de 100644
--- a/gui/portsPage.py
+++ b/gui/portsPage.py
@@ -41,10 +41,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/gui/semanagePage.py b/gui/semanagePage.py
index 5361d69c..1371d4e7 100644
--- a/gui/semanagePage.py
+++ b/gui/semanagePage.py
@@ -28,10 +28,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/gui/statusPage.py b/gui/statusPage.py
index a8f079b9..c241ef83 100644
--- a/gui/statusPage.py
+++ b/gui/statusPage.py
@@ -41,10 +41,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.py
index 8c46c987..1b460c99 100644
--- a/gui/system-config-selinux.py
+++ b/gui/system-config-selinux.py
@@ -51,10 +51,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/gui/usersPage.py b/gui/usersPage.py
index d15d4c5a..d51bd968 100644
--- a/gui/usersPage.py
+++ b/gui/usersPage.py
@@ -35,10 +35,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/python/chcat/chcat b/python/chcat/chcat
index 839ddd3b..e779fcc6 100755
--- a/python/chcat/chcat
+++ b/python/chcat/chcat
@@ -36,10 +36,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except ImportError:
     try:
         import builtins
diff --git a/python/semanage/semanage b/python/semanage/semanage
index 12bb159e..8f4e44a7 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -36,10 +36,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 69e60db8..ff8f4e9c 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -40,10 +40,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index 32956e58..7ebe0efa 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -34,10 +34,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 203ca25f..7208234b 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -29,10 +29,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 43180ca6..67189fc3 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -54,10 +54,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
@@ -1372,7 +1372,7 @@ Warning %s does not exist
         fd.close()
 
     def generate(self, out_dir=os.getcwd()):
-        out = "Created the following files:\n"
+        out = _("Created the following files:\n")
         out += "%s # %s\n" % (self.write_te(out_dir), _("Type Enforcement file"))
         out += "%s # %s\n" % (self.write_if(out_dir), _("Interface file"))
         out += "%s # %s\n" % (self.write_fc(out_dir), _("File Contexts file"))
diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 4f892f82..b0263740 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -47,10 +47,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
index 9d40aea1..599f97fd 100644
--- a/python/sepolicy/sepolicy/interface.py
+++ b/python/sepolicy/sepolicy/interface.py
@@ -36,10 +36,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
diff --git a/sandbox/sandbox b/sandbox/sandbox
index 16c43b51..cd5709fb 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -43,10 +43,10 @@ try:
     kwargs = {}
     if sys.version_info < (3,):
         kwargs['unicode'] = True
-    gettext.install(PROGNAME,
+    t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    codeset='utf-8',
                     **kwargs)
+    _ = t.gettext
 except:
     try:
         import builtins
-- 
2.35.1

