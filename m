Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226CEC4332F
	for <selinux@archiver.kernel.org>; Thu,  8 Dec 2022 19:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiLHTqC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Dec 2022 14:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiLHTqB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Dec 2022 14:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1591AA11
        for <selinux@vger.kernel.org>; Thu,  8 Dec 2022 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670528626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vmTKzc1dOAal8F99jKmuCLN3tNCMSPLNMulhCNik4qo=;
        b=QeunCqnxNW20LPJKxREzsX+FYhcRo1tp6hR7SSzLsClbRZOgv3PLrRxxir1F3CZsLN9C5O
        cM80gAdwTKu+kYY+RAf6gFAjUS3OVDGCVW9FVAfQY4gFZOTvr5civgyukZTSUZhRl4dD6Y
        CG9lomTTA3CZ4HTBYvwq/NJjUlhxFTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-JO9_vekzPwGTkCuZytS87w-1; Thu, 08 Dec 2022 14:43:45 -0500
X-MC-Unique: JO9_vekzPwGTkCuZytS87w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0F9287A9E1
        for <selinux@vger.kernel.org>; Thu,  8 Dec 2022 19:43:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-192-196.brq.redhat.com [10.40.192.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D649492CA2;
        Thu,  8 Dec 2022 19:43:44 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 2/2] python: Fix detection of sepolicy.glade location
Date:   Thu,  8 Dec 2022 20:43:35 +0100
Message-Id: <20221208194335.479739-2-lautrbach@redhat.com>
In-Reply-To: <20221208194335.479739-1-lautrbach@redhat.com>
References: <20221208194335.479739-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit c08cf24f3998 ("python: Remove dependency on the Python module
distutils") replace usage of distutils.sysconfig by sysconfig but it was
forgotten on the fact that the later provide a different api.

Fixes:
    self.code_path = sysconfig.get_python_lib(plat_specific=False) + "/sepolicy/"
                     ^^^^^^^^^^^^^^^^^^^^^^^^
    AttributeError: module 'sysconfig' has no attribute 'get_python_lib'

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/sepolicy/sepolicy/gui.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 53f3c6148b58..04208049360d 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -130,7 +130,7 @@ class SELinuxGui():
         self.application = app
         self.filter_txt = ""
         builder = Gtk.Builder()  # BUILDER OBJ
-        self.code_path = sysconfig.get_python_lib(plat_specific=False) + "/sepolicy/"
+        self.code_path = sysconfig.get_path('purelib', vars={'base': "/usr"}) + "/sepolicy/"
         glade_file = self.code_path + "sepolicy.glade"
         builder.add_from_file(glade_file)
         self.outer_notebook = builder.get_object("outer_notebook")
-- 
2.38.1

