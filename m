Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CE9ECAAA1
	for <selinux@archiver.kernel.org>; Mon, 31 Oct 2022 16:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiJaQrY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Oct 2022 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJaQrY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Oct 2022 12:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A481277D
        for <selinux@vger.kernel.org>; Mon, 31 Oct 2022 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667234784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=17iCGUZZe5R0sYT68JFLiiM4CPjny8nyQK4HtR7cIMI=;
        b=cNgF0q9Pq33KXfDeX/dzhHziLWPQkx3DFd/t4KgaApP9T6Hg5U/dAbI434cja4iO2iW99S
        4vtsjAfJ+Zota8KHh3Y7lxMIH9BzExJPhdHvOTgAwUxxxeA2FZCiSCDJ2iNiXdUQkB80Q4
        saJH5EgkDCWBC+rgGBomrZNMce+OjoM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-D1fmNSq1O1KblIkUqvB_YQ-1; Mon, 31 Oct 2022 12:46:22 -0400
X-MC-Unique: D1fmNSq1O1KblIkUqvB_YQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E1661C0782B
        for <selinux@vger.kernel.org>; Mon, 31 Oct 2022 16:46:22 +0000 (UTC)
Received: from ovpn-193-28.brq.redhat.com (ovpn-193-28.brq.redhat.com [10.40.193.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B4A1200BA7E
        for <selinux@vger.kernel.org>; Mon, 31 Oct 2022 16:46:21 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: Ignore missing directories when -i is used
Date:   Mon, 31 Oct 2022 17:46:17 +0100
Message-Id: <20221031164617.3096227-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently "-i" only ignores a file whose parent directory exists. Start also
ignoring paths with missing components.

Fixes:
  # restorecon -i -v -R /var/log/missingdir/missingfile; echo $?
  255
  restorecon: SELinux: Could not get canonical path for /var/log/missingdir/missingfile restorecon: No such file or directory.

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 2d24559f..6b5f6921 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1108,6 +1108,10 @@ static int selinux_restorecon_common(const char *pathname_orig,
 			pathname = realpath(pathname_orig, NULL);
 			if (!pathname) {
 				free(basename_cpy);
+				/* missing parent directory */
+				if (state.flags.ignore_noent && errno == ENOENT) {
+					return 0;
+				}
 				goto realpatherr;
 			}
 		} else {
@@ -1121,6 +1125,9 @@ static int selinux_restorecon_common(const char *pathname_orig,
 			free(dirname_cpy);
 			if (!pathdnamer) {
 				free(basename_cpy);
+				if (state.flags.ignore_noent && errno == ENOENT) {
+					return 0;
+				}
 				goto realpatherr;
 			}
 			if (!strcmp(pathdnamer, "/"))
-- 
2.37.3

