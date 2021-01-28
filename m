Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4471C433E0
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B42A60235
	for <selinux@archiver.kernel.org>; Thu, 28 Jan 2021 10:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhA1K3X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Jan 2021 05:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232098AbhA1K3P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Jan 2021 05:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611829669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gpo/qN5maZHQvZayQp/HcIB2mFsTaR07ymx/w+KtPuM=;
        b=C8OL1yNXIygN0AXpMlbs9uC04Mrgra9pFS5AczRH5EXxye27zrJFDPtnQMNw8ERk3mPvnk
        knYVxzSYzJKbH0djqJAlrfze9oHZONJBST21EqI8B+TQqhuhslBFBjdfDHXmtD8mdFAIPf
        Rz1zcOAjTr4J4YH8llhHa6pucHRt15o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-4BbyArCcPH6kw-YKp5MA6Q-1; Thu, 28 Jan 2021 05:27:47 -0500
X-MC-Unique: 4BbyArCcPH6kw-YKp5MA6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47A7391220
        for <selinux@vger.kernel.org>; Thu, 28 Jan 2021 10:27:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C80E7216E;
        Thu, 28 Jan 2021 10:27:45 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] libsemanage: sync filesystem with sandbox
Date:   Thu, 28 Jan 2021 11:27:41 +0100
Message-Id: <20210128102741.101112-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 libsemanage/src/semanage_store.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index cd5e46bb2401..632375a30925 100644
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
+    close(fd);
+
 	if (rename(sandbox, active) == -1) {
 		ERR(sh, "Error while renaming %s to %s.", sandbox, active);
 		/* note that if an error occurs during the next
-- 
2.30.0

