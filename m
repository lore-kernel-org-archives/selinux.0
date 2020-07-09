Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC12EC433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 09:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B448206E2
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 09:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BL2ABdM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGIJpb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:45:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29003 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726339AbgGIJpb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 05:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594287929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yo+96MnmtJIkt+z1a2bBIsRJZY8qMe1NGKnqoY9opLE=;
        b=BL2ABdM1HZOabUrbXouQQmmxOLg4xhmQfTCDaStVpbRWY31hlU/nH+AQ1jnvVi7FL4TV3g
        Q0RRjpVTr2UhgF8VZ1kS3WD/1KSsJLWwmD3EMkkWXjXi6ANC6+J9ulcWcFEbDLx/TvIgnV
        G6yX4W80H90lsndTkXEfEFs7xkXH+8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-ZocrNHjwNQyjPG8Yfow54Q-1; Thu, 09 Jul 2020 05:45:27 -0400
X-MC-Unique: ZocrNHjwNQyjPG8Yfow54Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98712108BD0B
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C02B727CDF;
        Thu,  9 Jul 2020 09:45:25 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] Update VERSIONs and Python bindings version to 3.1 for release
Date:   Thu,  9 Jul 2020 11:45:09 +0200
Message-Id: <20200709094509.1620563-2-plautrba@redhat.com>
In-Reply-To: <20200709094509.1620563-1-plautrba@redhat.com>
References: <20200709094509.1620563-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 checkpolicy/VERSION      | 2 +-
 dbus/VERSION             | 2 +-
 gui/VERSION              | 2 +-
 libselinux/VERSION       | 2 +-
 libselinux/src/setup.py  | 2 +-
 libsemanage/VERSION      | 2 +-
 libsepol/VERSION         | 2 +-
 mcstrans/VERSION         | 2 +-
 policycoreutils/VERSION  | 2 +-
 python/VERSION           | 2 +-
 python/sepolgen/VERSION  | 2 +-
 python/sepolicy/setup.py | 2 +-
 restorecond/VERSION      | 2 +-
 sandbox/VERSION          | 2 +-
 secilc/VERSION           | 2 +-
 semodule-utils/VERSION   | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/checkpolicy/VERSION b/checkpolicy/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/checkpolicy/VERSION
+++ b/checkpolicy/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/dbus/VERSION b/dbus/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/dbus/VERSION
+++ b/dbus/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/gui/VERSION b/gui/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/gui/VERSION
+++ b/gui/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/libselinux/VERSION b/libselinux/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/libselinux/VERSION
+++ b/libselinux/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/libselinux/src/setup.py b/libselinux/src/setup.py
index c8270bdc1c53..1b97ed8c0434 100644
--- a/libselinux/src/setup.py
+++ b/libselinux/src/setup.py
@@ -4,7 +4,7 @@ from distutils.core import Extension, setup
 
 setup(
     name="selinux",
-    version="3.0",
+    version="3.1",
     description="SELinux python 3 bindings",
     author="SELinux Project",
     author_email="selinux@vger.kernel.org",
diff --git a/libsemanage/VERSION b/libsemanage/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/libsemanage/VERSION
+++ b/libsemanage/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/libsepol/VERSION b/libsepol/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/libsepol/VERSION
+++ b/libsepol/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/mcstrans/VERSION b/mcstrans/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/mcstrans/VERSION
+++ b/mcstrans/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/policycoreutils/VERSION b/policycoreutils/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/policycoreutils/VERSION
+++ b/policycoreutils/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/python/VERSION b/python/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/python/VERSION
+++ b/python/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/python/sepolgen/VERSION b/python/sepolgen/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/python/sepolgen/VERSION
+++ b/python/sepolgen/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
index fa60ef6ce386..b943e14621c7 100644
--- a/python/sepolicy/setup.py
+++ b/python/sepolicy/setup.py
@@ -6,7 +6,7 @@ from distutils.core import setup
 
 setup(
     name="sepolicy",
-    version="3.0",
+    version="3.1",
     description="Python SELinux Policy Analyses bindings",
     author="Daniel Walsh",
     author_email="dwalsh@redhat.com",
diff --git a/restorecond/VERSION b/restorecond/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/restorecond/VERSION
+++ b/restorecond/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/sandbox/VERSION b/sandbox/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/sandbox/VERSION
+++ b/sandbox/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/secilc/VERSION b/secilc/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/secilc/VERSION
+++ b/secilc/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
diff --git a/semodule-utils/VERSION b/semodule-utils/VERSION
index 0ff4b45d1bf9..8c50098d8aed 100644
--- a/semodule-utils/VERSION
+++ b/semodule-utils/VERSION
@@ -1 +1 @@
-3.1-rc2
+3.1
-- 
2.26.2

