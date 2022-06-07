Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54211C433EF
	for <selinux@archiver.kernel.org>; Tue,  7 Jun 2022 11:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243250AbiFGL4G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 07:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242118AbiFGL4F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 07:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FD9AB5264
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 04:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654602963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6nNtAgdF1aWQL1TL+Labnpu95l9UyFvCUdcOKcyQklw=;
        b=M8zf4XKEBLiUVYhVVImkO6srEYSOlDCyClKMnZpr/FHk1TZZmRAyI3wgc58cPEQ4S8fPzP
        mXe6WRM+MsYTKpwmsCL6efu4+ZlfbpdcPiRBsTIsy7TQSAFjhrzWXm3T5jXWfLNdRgoSre
        kGGFSbuE//gxOcloXYn/y4bNkzCYBCk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-Hn7wUK-VP2SNez5T4KzKrQ-1; Tue, 07 Jun 2022 07:56:02 -0400
X-MC-Unique: Hn7wUK-VP2SNez5T4KzKrQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50D5D101AA46
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 11:56:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D3E8416144;
        Tue,  7 Jun 2022 11:56:01 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libsepol: Drop unused assignment
Date:   Tue,  7 Jun 2022 13:55:57 +0200
Message-Id: <20220607115557.492447-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes:
cil/src/cil_build_ast.c:4622:4: warning[deadcode.DeadStores]: Value stored to 'rc' is never read

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsepol/cil/src/cil_build_ast.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 26fa79069b96..4177c9f6778c 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4619,7 +4619,6 @@ int cil_gen_genfscon(struct cil_db *db, struct cil_tree_node *parse_current, str
 			} else {
 				cil_log(CIL_ERR, "Invalid file type \"%s\"\n", file_type);
 			}
-			rc = SEPOL_ERR;
 			goto exit;
 		}
 		context_node = parse_current->next->next->next->next;
-- 
2.36.1

