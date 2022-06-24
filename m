Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D5C43334
	for <selinux@archiver.kernel.org>; Fri, 24 Jun 2022 14:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiFXOYf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiFXOYd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jun 2022 10:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C8EA52524
        for <selinux@vger.kernel.org>; Fri, 24 Jun 2022 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656080671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BZ3ZqoJK/nLQnM3VV0JowPbN5BqZyg+EgmZ/QDx0adI=;
        b=dqZF2qNXzVq+RgAo5KXlwZjNxTq1iHG6D04M1KB4kbE+xqwB0m1LD4oybf7WF6uiT05j23
        LlTjV7IbOrrBFUGEcjWrYEOYIdAKkU8/avdKpVGKtqqOWFYyqc4VL4tJQX/IkaEQ5R+Nhr
        S0LpmSEaCKqPe7o4T9X7ZcblUyZNqsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-nio51NWcMQyWSdCkNR1X5g-1; Fri, 24 Jun 2022 10:24:30 -0400
X-MC-Unique: nio51NWcMQyWSdCkNR1X5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E95B985A589
        for <selinux@vger.kernel.org>; Fri, 24 Jun 2022 14:24:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3910F18EAB
        for <selinux@vger.kernel.org>; Fri, 24 Jun 2022 14:24:29 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] gettext: handle unsupported languages properly
Date:   Fri, 24 Jun 2022 16:24:25 +0200
Message-Id: <20220624142425.3836193-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With "fallback=True" gettext.translation behaves the same as
gettext.install and uses NullTranslations in case the
translation file for given language was not found (as opposed to
throwing an exception).

Fixes:
  # LANG is set to any "unsupported" language, e.g. en_US.UTF-8
  $ chcat --help
  Traceback (most recent call last):
  File "/usr/bin/chcat", line 39, in <module>
    t = gettext.translation(PROGNAME,
  File "/usr/lib64/python3.9/gettext.py", line 592, in translation
    raise FileNotFoundError(ENOENT,
  FileNotFoundError: [Errno 2] No translation file found for domain: 'selinux-python'

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 gui/booleansPage.py                          | 3 ++-
 gui/domainsPage.py                           | 3 ++-
 gui/fcontextPage.py                          | 3 ++-
 gui/loginsPage.py                            | 3 ++-
 gui/modulesPage.py                           | 3 ++-
 gui/polgengui.py                             | 3 ++-
 gui/portsPage.py                             | 3 ++-
 gui/semanagePage.py                          | 3 ++-
 gui/statusPage.py                            | 3 ++-
 gui/system-config-selinux.py                 | 3 ++-
 gui/usersPage.py                             | 3 ++-
 python/chcat/chcat                           | 5 +++--
 python/semanage/semanage                     | 3 ++-
 python/semanage/seobject.py                  | 3 ++-
 python/sepolgen/src/sepolgen/sepolgeni18n.py | 4 +++-
 python/sepolicy/sepolicy.py                  | 3 ++-
 python/sepolicy/sepolicy/__init__.py         | 3 ++-
 python/sepolicy/sepolicy/generate.py         | 3 ++-
 python/sepolicy/sepolicy/gui.py              | 3 ++-
 python/sepolicy/sepolicy/interface.py        | 3 ++-
 sandbox/sandbox                              | 3 ++-
 21 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/gui/booleansPage.py b/gui/booleansPage.py
index 5beec58b..ad11a9b2 100644
--- a/gui/booleansPage.py
+++ b/gui/booleansPage.py
@@ -46,7 +46,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/gui/domainsPage.py b/gui/domainsPage.py
index e08f34b4..e6eadd61 100644
--- a/gui/domainsPage.py
+++ b/gui/domainsPage.py
@@ -38,7 +38,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
index bac2bec3..767664f2 100644
--- a/gui/fcontextPage.py
+++ b/gui/fcontextPage.py
@@ -55,7 +55,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/gui/loginsPage.py b/gui/loginsPage.py
index 18b93d8c..7e08232a 100644
--- a/gui/loginsPage.py
+++ b/gui/loginsPage.py
@@ -37,7 +37,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/gui/modulesPage.py b/gui/modulesPage.py
index c546d455..02b79f15 100644
--- a/gui/modulesPage.py
+++ b/gui/modulesPage.py
@@ -38,7 +38,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/gui/polgengui.py b/gui/polgengui.py
index a18f1cba..7a3ecd50 100644
--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -71,7 +71,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/gui/portsPage.py b/gui/portsPage.py
index 54aa80de..bee2bdf1 100644
--- a/gui/portsPage.py
+++ b/gui/portsPage.py
@@ -43,7 +43,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/gui/semanagePage.py b/gui/semanagePage.py
index 1371d4e7..efad14d9 100644
--- a/gui/semanagePage.py
+++ b/gui/semanagePage.py
@@ -30,7 +30,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/gui/statusPage.py b/gui/statusPage.py
index c241ef83..832849e6 100644
--- a/gui/statusPage.py
+++ b/gui/statusPage.py
@@ -43,7 +43,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.py
index 1b460c99..9f53b7fe 100644
--- a/gui/system-config-selinux.py
+++ b/gui/system-config-selinux.py
@@ -53,7 +53,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/gui/usersPage.py b/gui/usersPage.py
index d51bd968..9acd3b84 100644
--- a/gui/usersPage.py
+++ b/gui/usersPage.py
@@ -37,7 +37,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/python/chcat/chcat b/python/chcat/chcat
index e779fcc6..952cb818 100755
--- a/python/chcat/chcat
+++ b/python/chcat/chcat
@@ -38,9 +38,10 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
-except ImportError:
+except:
     try:
         import builtins
         builtins.__dict__['_'] = str
diff --git a/python/semanage/semanage b/python/semanage/semanage
index 1d828128..4e8d64d6 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -38,7 +38,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index ff8f4e9c..0782c082 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -42,7 +42,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/python/sepolgen/src/sepolgen/sepolgeni18n.py b/python/sepolgen/src/sepolgen/sepolgeni18n.py
index 56ebd807..1ff307d9 100644
--- a/python/sepolgen/src/sepolgen/sepolgeni18n.py
+++ b/python/sepolgen/src/sepolgen/sepolgeni18n.py
@@ -19,7 +19,9 @@
 
 try: 
     import gettext
-    t = gettext.translation( 'selinux-python' )
+    t = gettext.translation("selinux-python",
+                        localedir="/usr/share/locale",
+                        fallback=True)
     _ = t.gettext
 except:
     def _(str):
diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index 7ebe0efa..c7a70e09 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -36,7 +36,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 7208234b..9c3caa05 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -31,7 +31,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 67189fc3..3717d5d4 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -56,7 +56,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index b0263740..5bdbfeba 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -49,7 +49,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
index 599f97fd..43f86443 100644
--- a/python/sepolicy/sepolicy/interface.py
+++ b/python/sepolicy/sepolicy/interface.py
@@ -38,7 +38,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
diff --git a/sandbox/sandbox b/sandbox/sandbox
index cd5709fb..789621e1 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -45,7 +45,8 @@ try:
         kwargs['unicode'] = True
     t = gettext.translation(PROGNAME,
                     localedir="/usr/share/locale",
-                    **kwargs)
+                    **kwargs,
+                    fallback=True)
     _ = t.gettext
 except:
     try:
-- 
2.35.3

