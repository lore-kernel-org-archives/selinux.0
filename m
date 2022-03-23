Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7213C433F5
	for <selinux@archiver.kernel.org>; Wed, 23 Mar 2022 17:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbiCWRfw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Mar 2022 13:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343633AbiCWRfv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Mar 2022 13:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1B0C793BC
        for <selinux@vger.kernel.org>; Wed, 23 Mar 2022 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648056859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+jbudH5P0f4enE35DQr0kxK/X6GjzOGU9WLYHYe4zME=;
        b=W8yO5hG1WEg2LfTJEKdxrvkfiUS+jMy7Hhk6qLQ8pwema+qjOoFjwQuCwYDr88aJ+Xb3Xd
        c7wUXkOsmh3aei0dNfuysbv80vBRNPP0+ZZgQCRjnMJSgHX3ZgUr9XAeAgYWxaalRd33H/
        P9txWsFoRSgrHdbziEGMIeWRmoimQ68=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-ejqqlNWOPDy498PmsaRNAA-1; Wed, 23 Mar 2022 13:34:18 -0400
X-MC-Unique: ejqqlNWOPDy498PmsaRNAA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DE751C09044
        for <selinux@vger.kernel.org>; Wed, 23 Mar 2022 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DE48401E5A;
        Wed, 23 Mar 2022 17:34:17 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Joseph Marrero Corchado <jmarrero@redhat.com>
Subject: [PATCH] libsemanage: Fallback to semanage_copy_dir when rename() failed
Date:   Wed, 23 Mar 2022 18:34:12 +0100
Message-Id: <20220323173412.1538778-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In some circumstances, like semanage-store being on overlayfs, rename()
could fail with EXDEV - Invalid cross-device link. This is due to fact
that overlays doesn't support rename() is source and target are not on
the same layer, e.g. in rpm-ostree based containers. Even though it's
not atomic operation, it's better to try to to copy files from src to
dst on our own in this case. Next rebuild will probably not fail as the
new directories will be on the same layer.

Fixes: https://github.com/SELinuxProject/selinux/issues/343
Before:
    # semodule -B
    libsemanage.semanage_commit_sandbox: Error while renaming /etc/selinux/targeted/active to /etc/selinux/targeted/previous. (Invalid cross-device link).
semodule:  Failed!

After:
    # semodule -B
    Warning: rename(/etc/selinux/targeted/active, /etc/selinux/targeted/previous) failed: Invalid cross-device link, fallback to non-atomic semanage_copy_dir_flags()

Reported-by: Joseph Marrero Corchado <jmarrero@redhat.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/src/semanage_store.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 767f05cb2853..aa44ebb7e481 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -697,6 +697,10 @@ int semanage_store_access_check(void)
 
 /********************* other I/O functions *********************/
 
+static int semanage_rename(const char *tmp, const char *dst);
+int semanage_remove_directory(const char *path);
+static int semanage_copy_dir_flags(const char *src, const char *dst, int flag);
+
 /* Callback used by scandir() to select files. */
 static int semanage_filename_select(const struct dirent *d)
 {
@@ -760,7 +764,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
 		retval = -1;
 	}
 
-	if (!retval && rename(tmp, dst) == -1)
+	if (!retval && semanage_rename(tmp, dst) == -1)
 		return -1;
 
 out:
@@ -768,7 +772,20 @@ out:
 	return retval;
 }
 
-static int semanage_copy_dir_flags(const char *src, const char *dst, int flag);
+static int semanage_rename(const char *src, const char *dst) {
+	int retval = -1;
+
+	retval = rename(src, dst);
+	if (retval == 0 || errno != EXDEV)
+		return retval;
+
+	/* we can't use rename() due to filesystem limitation, lets try to copy files manually */
+	fprintf(stderr, "Warning: rename(%s, %s) failed: %s, fallback to non-atomic semanage_copy_dir_flags()\n", src, dst, strerror(errno));
+	if (semanage_copy_dir_flags(src, dst, 1) == -1) {
+		return -1;
+	}
+	return semanage_remove_directory(src);
+}
 
 /* Copies all of the files from src to dst, recursing into
  * subdirectories.  Returns 0 on success, -1 on error. */
@@ -1770,7 +1787,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 		goto cleanup;
 	}
 
-	if (rename(active, backup) == -1) {
+	if (semanage_rename(active, backup) == -1) {
 		ERR(sh, "Error while renaming %s to %s.", active, backup);
 		retval = -1;
 		goto cleanup;
@@ -1779,12 +1796,12 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 	/* clean up some files from the sandbox before install */
 	/* remove homedir_template from sandbox */
 
-	if (rename(sandbox, active) == -1) {
+	if (semanage_rename(sandbox, active) == -1) {
 		ERR(sh, "Error while renaming %s to %s.", sandbox, active);
 		/* note that if an error occurs during the next
 		 * function then the store will be left in an
 		 * inconsistent state */
-		if (rename(backup, active) < 0)
+		if (semanage_rename(backup, active) < 0)
 			ERR(sh, "Error while renaming %s back to %s.", backup,
 			    active);
 		retval = -1;
@@ -1795,10 +1812,10 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 		 * function then the store will be left in an
 		 * inconsistent state */
 		int errsv = errno;
-		if (rename(active, sandbox) < 0)
+		if (semanage_rename(active, sandbox) < 0)
 			ERR(sh, "Error while renaming %s back to %s.", active,
 			    sandbox);
-		else if (rename(backup, active) < 0)
+		else if (semanage_rename(backup, active) < 0)
 			ERR(sh, "Error while renaming %s back to %s.", backup,
 			    active);
 		else
-- 
2.35.1

