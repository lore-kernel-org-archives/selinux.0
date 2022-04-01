Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09678C433F5
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 11:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345523AbiDAL3c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242508AbiDAL3a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 07:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E334275C88
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 04:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648812460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5UT6f7IgOODSICaHkqN+kTEPwFmZnIYEHnVP0axQ4u8=;
        b=GIYWi1qrEw6OvQ+Ui2xOSb91l8l+/2P736S1p1GqqVVmkg2kXbhNWhADnacJc6pVUY44eJ
        lSw9CzgsFR/fGo90wastULpd2ViIy7syrMe/YQrH8zjZivRhjsbO7a1GFQOpaENC11jnza
        wqoK3CL8fVrTuZ6lG3k0bZlEtIfj1Ts=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-Jfgya2TlPtmLci8f-hVwHA-1; Fri, 01 Apr 2022 07:27:39 -0400
X-MC-Unique: Jfgya2TlPtmLci8f-hVwHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C79F22800F6E
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28EC52166B26;
        Fri,  1 Apr 2022 11:27:38 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Vit Mojzis <vmojzis@redhat.com>
Subject: [PATCH] policycoreutils/setfiles: Improve description of -d switch
Date:   Fri,  1 Apr 2022 13:27:30 +0200
Message-Id: <20220401112730.108257-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Vit Mojzis <vmojzis@redhat.com>

The "-q" switch is becoming obsolete (completely unused in fedora) and
debug output ("-d" switch) makes sense in any scenario. Therefore both
options can be specified at once.

Resolves: rhbz#1271327

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 policycoreutils/setfiles/setfiles.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 15f939d1bee0..0aab2aa24681 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -59,7 +59,7 @@ option will force a replacement of the entire context.
 check the validity of the contexts against the specified binary policy.
 .TP
 .B \-d
-show what specification matched each file.
+show what specification matched each file. Not affected by "\-q".
 .TP
 .BI \-e \ directory
 directory to exclude (repeat option for more than one directory).
-- 
2.35.1

