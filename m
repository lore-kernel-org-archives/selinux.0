Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944DAC433E0
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 14:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEF864DEC
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 14:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhBPOQY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229713AbhBPOQX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Feb 2021 09:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613484896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aVqFQLgW7RUhN9jM6itaY3qhtu9cMr5shvzdP6THvno=;
        b=USYML25Oi8/JEdvHf7DxYNi0NH3yj6aKrFCh7Hfm2ADeI8MIzcpvN4Tqk5NLFuQ1hikjhq
        clNpxnWlS0NdWL/runbi0KZE8eNbKtj1N84zH0o9VBWsoGfXJnRtTb7ubEyHL75wd5O2ke
        TADBoHQv+bbYE+epnK8NjVURuGzc21w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-lXjFvK0SO_WmE1G-70Z-pg-1; Tue, 16 Feb 2021 09:14:55 -0500
X-MC-Unique: lXjFvK0SO_WmE1G-70Z-pg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73EF180197A
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 14:14:54 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9852560C94;
        Tue, 16 Feb 2021 14:14:53 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 2/2] policycoreutils: Resolve path in restorecon_xattr
Date:   Tue, 16 Feb 2021 15:14:46 +0100
Message-Id: <20210216141446.171306-2-plautrba@redhat.com>
In-Reply-To: <20210216141446.171306-1-plautrba@redhat.com>
References: <20210216141446.171306-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Resolve pathname before selinux_restorecon_xattr() to prevent problems
with 'No Match' when relative path is used.

Fixes:
    # restorecon_xattr -v tmp
    ...
    tmp Digest: f9cd2da7141068bd2c08bc02fa471db63ac7d44c No Match

    # restorecon_xattr -v `pwd`/tmp
    ...
    /root/tmp Digest: f9cd2da7141068bd2c08bc02fa471db63ac7d44c Match

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/setfiles/restorecon_xattr.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/setfiles/restorecon_xattr.c b/policycoreutils/setfiles/restorecon_xattr.c
index 59b1f748b8c5..56f6f9d0e043 100644
--- a/policycoreutils/setfiles/restorecon_xattr.c
+++ b/policycoreutils/setfiles/restorecon_xattr.c
@@ -38,7 +38,7 @@ int main(int argc, char **argv)
 	unsigned int xattr_flags = 0, delete_digest = 0, recurse = 0;
 	unsigned int delete_all_digests = 0, ignore_mounts = 0;
 	bool display_digest = false;
-	char *sha1_buf, **specfiles, *fc_file = NULL;
+	char *sha1_buf, **specfiles, *fc_file = NULL, *pathname = NULL;
 	unsigned char *fc_digest = NULL;
 	size_t i, fc_digest_len = 0, num_specfiles;
 
@@ -163,7 +163,16 @@ int main(int argc, char **argv)
 	xattr_flags = delete_digest | delete_all_digests |
 		      ignore_mounts | recurse;
 
-	if (selinux_restorecon_xattr(argv[optind], xattr_flags, &xattr_list)) {
+	pathname = realpath(argv[optind], NULL);
+	if (!pathname) {
+		fprintf(stderr,
+			    "restorecon_xattr: realpath(%s) failed: %s\n",
+			    argv[optind], strerror(errno));
+		rc = -1;
+		goto out;
+	}
+
+	if (selinux_restorecon_xattr(pathname, xattr_flags, &xattr_list)) {
 		fprintf(stderr,
 			"Error selinux_restorecon_xattr: %s\n",
 			strerror(errno));
@@ -215,6 +224,7 @@ int main(int argc, char **argv)
 
 	rc = 0;
 out:
+	free(pathname);
 	selabel_close(hnd);
 	restore_finish();
 	return rc;
-- 
2.30.1

