Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DBDC433F5
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 10:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhKWKlX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:41:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235594AbhKWKlX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 05:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637663893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EwZQ55Tovjy8AtkxbEH1jMnHH3VyBfszH+Z9YOa0BvQ=;
        b=GHiyw92i1qbUQxKmNlt/63yiQiqyzFN95GR5Z7XqPnySAnm59iLTTv44Fisw5OK7YVJJv+
        GG/8JTtM2RdtjptlLhhsUfqpSKQyEYsVblsJA4ZaCP2+xu7gGU6mW/hk5C5aeqCSm2auqW
        pyizWAG2OoSNZ1F9VqviQ5jSY9LMOXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-29zqqAUINGCCvA1jKYQ3fQ-1; Tue, 23 Nov 2021 05:38:12 -0500
X-MC-Unique: 29zqqAUINGCCvA1jKYQ3fQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F416107B0F1
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 10:38:11 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.40.193.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7183860D30;
        Tue, 23 Nov 2021 10:38:10 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libselinux: Fix selinux_restorecon_parallel symbol version
Date:   Tue, 23 Nov 2021 11:38:05 +0100
Message-Id: <20211123103805.415558-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selinux_restorecon_parallel was originally proposed before 3.3, but it
was merged after release so it will be introduced in version 3.4.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/libselinux.map | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index d138e951ef0d..4acf1caacb55 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -241,7 +241,7 @@ LIBSELINUX_1.0 {
     *;
 };
 
-LIBSELINUX_3.3 {
+LIBSELINUX_3.4 {
   global:
     selinux_restorecon_parallel;
 } LIBSELINUX_1.0;
-- 
2.33.1

