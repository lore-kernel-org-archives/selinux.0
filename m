Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E648CC433F5
	for <selinux@archiver.kernel.org>; Mon, 10 Jan 2022 17:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiAJRfj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:35:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238408AbiAJRfi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Jan 2022 12:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641836138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U+yNnbuI5RzeedYIYRiBJCLeM2mHA8KFfXrlScgKyFY=;
        b=Sb8sqRfjcypKEqbq5Z82YC7MpKG+CYLkkv6SP7KqqSOHCxREOWJ4qMyc/Ytvn6wct893zX
        jJbuGxgN/kRGs+ItPr6Q5+ROE4TlU9DbFbooIvERPyapXL41dq8h2LTpJELIwT9JskXbLb
        VNrHEBCiIFfhdS8QlQew+Qend+7244I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-2ujJ63vcO8uBXVAO5hraAA-1; Mon, 10 Jan 2022 12:35:36 -0500
X-MC-Unique: 2ujJ63vcO8uBXVAO5hraAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8E4A3939B
        for <selinux@vger.kernel.org>; Mon, 10 Jan 2022 17:35:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30D6175763
        for <selinux@vger.kernel.org>; Mon, 10 Jan 2022 17:35:34 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] policycoreutils: Improve error message when selabel_open fails
Date:   Mon, 10 Jan 2022 18:35:27 +0100
Message-Id: <20220110173527.582954-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When selabel_open fails to locate file_context files and
selabel_opt_path is not specified (e.g. when the policy type is
missconfigured in /etc/selinux/config), perror only prints
"No such file or directory".
This can be confusing in case of "restorecon" since it's
not apparent that the issue is in policy store.

Before:
  \# restorecon -v /tmp/foo.txt
  No such file or directory
After:
  \# restorecon -v /tmp/foo.txt
  /etc/selinux/yolo/contexts/files/file_contexts: No such file or directory

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 policycoreutils/setfiles/restore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index 74d48bb3..e9ae33ad 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -29,7 +29,7 @@ void restore_init(struct restore_opts *opts)
 
 	opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
 	if (!opts->hnd) {
-		perror(opts->selabel_opt_path);
+		perror(opts->selabel_opt_path ? opts->selabel_opt_path : selinux_file_context_path());
 		exit(1);
 	}
 
-- 
2.34.1

