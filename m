Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDCCC433FE
	for <selinux@archiver.kernel.org>; Fri, 18 Nov 2022 12:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiKRMye (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiKRMye (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Nov 2022 07:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED21FAF6
        for <selinux@vger.kernel.org>; Fri, 18 Nov 2022 04:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668776014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4a44dCvlQn9qpEvzCFThv2jLQmeGe+A+sddXTvKq9s=;
        b=DmDrjkV20hhvKoUSmZkWtG8QW24lhGVtRts3o/oUKQwbj/l9tTfJYM0v3FMhy1kuDJa4jL
        G+qeY6+39vS7S7jiebwGKkY84U/jsPZf9zmzXeQLXTYF433qu7ba+zLZ3Gv70p6zVUkcgv
        iW2nh1Xhqx4QpaS4sYZSB5ziBd/6KWU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-Cf2xVp5xP4aBOImckSU0cw-1; Fri, 18 Nov 2022 07:53:33 -0500
X-MC-Unique: Cf2xVp5xP4aBOImckSU0cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3171B85A59D
        for <selinux@vger.kernel.org>; Fri, 18 Nov 2022 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-194-48.brq.redhat.com [10.40.194.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9099C40C6EC3;
        Fri, 18 Nov 2022 12:53:32 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v3 2/3] python/sepolicy: Use distro module to get os version
Date:   Fri, 18 Nov 2022 13:51:53 +0100
Message-Id: <20221118125153.453700-2-lautrbach@redhat.com>
In-Reply-To: <20221118125153.453700-1-lautrbach@redhat.com>
References: <20221118125153.453700-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

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

