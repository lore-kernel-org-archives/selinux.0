Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7FBC46467
	for <selinux@archiver.kernel.org>; Tue,  3 Jan 2023 08:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjACIcy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Jan 2023 03:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbjACIcx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Jan 2023 03:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3A8DF85
        for <selinux@vger.kernel.org>; Tue,  3 Jan 2023 00:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672734728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=64j9Dv3mgdM3QwGClwvGY8NZl27DrkxNUPyy5CNRU+g=;
        b=XX43I3jGlS4lRxGXeSyhWUbTdxP0Z13XGOW94WTrdSuSWns8h5OffokKO6ACuONje4V2oH
        AqOzy4u0FzgVFbadBOzHGT6nu2zzcOAOjTY9DqJcalCXd/JmkVcZEfP8tBlFinZmcfoy0s
        RTwDNo1uzOa4YYQAWVe6k10z5InSq88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-F3GsvqSmMHC2hL7z_YlLGA-1; Tue, 03 Jan 2023 03:32:06 -0500
X-MC-Unique: F3GsvqSmMHC2hL7z_YlLGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E5881818E47
        for <selinux@vger.kernel.org>; Tue,  3 Jan 2023 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-193-29.brq.redhat.com [10.40.193.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0CE240C2064;
        Tue,  3 Jan 2023 08:32:05 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] sepolicy: Make generated boolean descriptions translatable
Date:   Tue,  3 Jan 2023 09:32:00 +0100
Message-Id: <20230103083200.168385-1-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 68907a4f9759..be89dd2f9928 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -1222,7 +1222,7 @@ def boolean_desc(boolean):
         return _(booleans_dict[boolean][2])
     else:
         desc = boolean.split("_")
-        return "Allow %s to %s" % (desc[0], " ".join(desc[1:]))
+        return _("Allow {subject} to {rest}").format(subject=desc[0], rest=" ".join(desc[1:]))
 
 
 def get_os_version():
-- 
2.39.0

