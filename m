Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA5C4332F
	for <selinux@archiver.kernel.org>; Tue, 15 Nov 2022 19:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKOTrF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiKOTrC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Nov 2022 14:47:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEE21EACA
        for <selinux@vger.kernel.org>; Tue, 15 Nov 2022 11:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668541563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWfK2vrcZVoLhJl4x6kP8BCC8iuXsvYkZigzHV7I0QQ=;
        b=DyqAJaAyDgyPMyGqnvocgEdlBA2kVBaBD5Y9Wc3MUdnMkoYnJav8CR36GKWNp0L/NICZmR
        lnXPTu+0+cGH1e8G24cUxfJXvxdveg6P0DusK6hcTKc5NpgI/hnuF9MFRYrQUlxHa8l2jT
        4cqizPpmuGctkdvNX4azz5u+CkdMV9o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-cRo8Unh0MryAFq43Yk96ew-1; Tue, 15 Nov 2022 14:46:01 -0500
X-MC-Unique: cRo8Unh0MryAFq43Yk96ew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BA5929AA2FD
        for <selinux@vger.kernel.org>; Tue, 15 Nov 2022 19:46:01 +0000 (UTC)
Received: from localhost.localdomain (ovpn-195-4.brq.redhat.com [10.40.195.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6521112131E;
        Tue, 15 Nov 2022 19:46:00 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2 2/3] python/sepolicy: Use distro module to get os version
Date:   Tue, 15 Nov 2022 20:45:51 +0100
Message-Id: <20221115194552.338640-2-plautrba@redhat.com>
In-Reply-To: <20221115194552.338640-1-plautrba@redhat.com>
References: <20221115194552.338640-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Petr Lautrbach <lautrbach@redhat.com>

distro module uses /etc/os-release file which contains operating system
identification data, see os-release(5). Given that the mechanism doesn't
use `rpm` it should be possible to generate man pages on other
distributions.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 9c3caa05b80b..baa4c8e62e97 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -1226,27 +1226,14 @@ def boolean_desc(boolean):
 
 
 def get_os_version():
-    os_version = ""
-    pkg_name = "selinux-policy"
+    system_release = ""
     try:
-        try:
-            from commands import getstatusoutput
-        except ImportError:
-            from subprocess import getstatusoutput
-        rc, output = getstatusoutput("rpm -q '%s'" % pkg_name)
-        if rc == 0:
-            os_version = output.split(".")[-2]
-    except:
-        os_version = ""
-
-    if os_version[0:2] == "fc":
-        os_version = "Fedora" + os_version[2:]
-    elif os_version[0:2] == "el":
-        os_version = "RHEL" + os_version[2:]
-    else:
-        os_version = ""
+        import distro
+        system_release = distro.name(pretty=True)
+    except IOError:
+        system_release = "Misc"
 
-    return os_version
+    return system_release
 
 
 def reinit():
-- 
2.38.1

