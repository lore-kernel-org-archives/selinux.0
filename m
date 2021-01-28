Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8409FC433DB
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 10:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E69464DCE
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 10:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhA1KoL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Jan 2021 05:44:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhA1KoL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Jan 2021 05:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611830564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTfe3GjuEzNRMj01iGRD+aZk0jOSEiTp4KAgCLiL1sg=;
        b=exEooapTT8fmL5BMqks3RTlig/dCzwSV0V14UIg4ChBVXaEeviScvbf3d6gNiR2FtTvBZv
        TA6S8QiJU8DeXmbw5orrNDcK6DLfpY2v7pDp/C/mN1/E9PtrMGBjijgr1Xx9rZvIyYX6Rs
        OKUwZBLvm6W95Jn8A2wWR6+BgsBUX8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-Qb8bRub3Ot2EbdDs1sc_5Q-1; Thu, 28 Jan 2021 05:42:42 -0500
X-MC-Unique: Qb8bRub3Ot2EbdDs1sc_5Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F11910054FF
        for <selinux@vger.kernel.org>; Thu, 28 Jan 2021 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 500FD722E8;
        Thu, 28 Jan 2021 10:42:40 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2] libsemanage: sync filesystem with sandbox
Date:   Thu, 28 Jan 2021 11:42:31 +0100
Message-Id: <20210128104231.102470-1-plautrba@redhat.com>
In-Reply-To: <20210128102741.101112-1-plautrba@redhat.com>
References: <20210128102741.101112-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 331a109f91ea ("libsemanage: fsync final files before rename")
added fsync() for policy files and improved situation when something
unexpected happens right after rename(). However the module store could
be affected as well. After the following steps module files could be 0
size:

1. Run `semanage fcontext -a -t var_t "/tmp/abc"`
2. Force shutdown the server during the command is run, or right after
   it's finished
3. Boot the system and look for empty files:
    # find /var/lib/selinux/targeted/ -type f -size 0 | wc -l
    1266

It looks like this situation can be avoided it the filesystem with the
store is sync()ed before rename()

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

- fixed close(fd) indentation

 libsemanage/src/semanage_store.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index cd5e46bb2401..9a81be54db60 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1764,6 +1764,21 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 	/* clean up some files from the sandbox before install */
 	/* remove homedir_template from sandbox */
 
+	/* sync filesystem with sandbox first */
+	fd = open(sandbox, O_DIRECTORY);
+	if (fd == -1) {
+		ERR(sh, "Error while opening %s for syncfs(): %d", sandbox, errno);
+		retval = -1;
+		goto cleanup;
+	}
+	if (syncfs(fd) == -1) {
+		ERR(sh, "Error while syncing %s to filesystem: %d", sandbox, errno);
+		close(fd);
+		retval = -1;
+		goto cleanup;
+	}
+	close(fd);
+
 	if (rename(sandbox, active) == -1) {
 		ERR(sh, "Error while renaming %s to %s.", sandbox, active);
 		/* note that if an error occurs during the next
-- 
2.30.0

