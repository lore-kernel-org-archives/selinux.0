Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47028C433FE
	for <selinux@archiver.kernel.org>; Thu, 24 Mar 2022 12:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiCXMC2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346869AbiCXMC1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Mar 2022 08:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3CA3986DD
        for <selinux@vger.kernel.org>; Thu, 24 Mar 2022 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648123253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjyJPjZw7hgHDv9scSONe3BJZRekLrE2cg4pNW8acEs=;
        b=G+ailL2KY8iCjDEVyXO+7odCyiAmxYk57DODlAKmBNvWA7N0ny45MB5kTV1SzyeaYCMtlM
        PyqtCDVFnRgZXBvecgY1u+b8RLLay6UYvg6eg/wAPIpVFCEQR9ytzneexrnF4bELxTKe3v
        PxliWD+cl7WGKuNAEDuCXOqYEY0koo8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-haW85swjN6eu59h7dNLDcQ-1; Thu, 24 Mar 2022 08:00:52 -0400
X-MC-Unique: haW85swjN6eu59h7dNLDcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B154811E9B
        for <selinux@vger.kernel.org>; Thu, 24 Mar 2022 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D07FE400E122;
        Thu, 24 Mar 2022 12:00:50 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Joseph Marrero Corchado <jmarrero@redhat.com>
Subject: [PATCH v3] libsemanage: Fall back to semanage_copy_dir when rename() fails
Date:   Thu, 24 Mar 2022 13:00:34 +0100
Message-Id: <20220324120034.1570408-1-plautrba@redhat.com>
In-Reply-To: <20220324095251.1561597-1-plautrba@redhat.com>
References: <20220324095251.1561597-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In some circumstances, like semanage-store being on overlayfs, rename()
could fail with EXDEV - Invalid cross-device link. This is due to the
fact that overlays doesn't support rename() if source and target are not
on the same layer, e.g. in containers built from several layers. Even
though it's not atomic operation, it's better to try to copy files from
src to dst on our own in this case. Next rebuild will probably not fail
as the new directories will be on the same layer.

Fixes: https://github.com/SELinuxProject/selinux/issues/343

Reproducer:

    $ cd selinux1

    $ cat Dockerfile
    FROM fedora:35
    RUN dnf install -y selinux-policy selinux-policy-targeted

    $ podman build -t localhost/selinux . --no-cache

    $ cd ../selinux2

    $ cat Dockerfile
    FROM localhost/selinux
    RUN semodule -B

    $ podman build -t localhost/selinux2 . --no-cache
    STEP 2/2: RUN semodule -B
    libsemanage.semanage_commit_sandbox: Error while renaming /var/lib/selinux/targeted/active to /var/lib/selinux/targeted/previous. (Invalid cross-device link).
    semodule:  Failed!
    Error: error building at STEP "RUN semodule -B": error while running runtime: exit status 1

With the fix:

    $ podman build -t localhost/selinux2 . --no-cache
    STEP 2/2: RUN semodule -B
    libsemanage.semanage_rename: Warning: rename(/var/lib/selinux/targeted/active, /var/lib/selinux/targeted/previous) failed: Invalid cross-device link, fall back to non-atomic semanage_copy_dir_flags()

    COMMIT localhost/selinux2
    --> d2cfcebc1a1
    Successfully tagged localhost/selinux2:latest
    d2cfcebc1a1b34f1c2cd661ac18292b0612c3e5fa71d6fa1441be244da91b1af

Reported-by: Joseph Marrero Corchado <jmarrero@redhat.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

v2
- improve the commit message
- use WARN() instead of fprintf(stderr, 

v3 
- WARN without \n at the end
- split long line

libsemanage/src/semanage_store.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 767f05cb2853..c6d2c5e72709 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -697,6 +697,10 @@ int semanage_store_access_check(void)
 
 /********************* other I/O functions *********************/
 
+static int semanage_rename(semanage_handle_t * sh, const char *tmp, const char *dst);
+int semanage_remove_directory(const char *path);
+static int semanage_copy_dir_flags(const char *src, const char *dst, int flag);
+
 /* Callback used by scandir() to select files. */
 static int semanage_filename_select(const struct dirent *d)
 {
@@ -768,7 +772,21 @@ out:
 	return retval;
 }
 
-static int semanage_copy_dir_flags(const char *src, const char *dst, int flag);
+static int semanage_rename(semanage_handle_t * sh, const char *src, const char *dst) {
+	int retval;
+
+	retval = rename(src, dst);
+	if (retval == 0 || errno != EXDEV)
+		return retval;
+
+	/* we can't use rename() due to filesystem limitation, lets try to copy files manually */
+	WARN(sh, "WARNING: rename(%s, %s) failed: %s, fall back to non-atomic semanage_copy_dir_flags()",
+		 src, dst, strerror(errno));
+	if (semanage_copy_dir_flags(src, dst, 1) == -1) {
+		return -1;
+	}
+	return semanage_remove_directory(src);
+}
 
 /* Copies all of the files from src to dst, recursing into
  * subdirectories.  Returns 0 on success, -1 on error. */
@@ -1770,7 +1788,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 		goto cleanup;
 	}
 
-	if (rename(active, backup) == -1) {
+	if (semanage_rename(sh, active, backup) == -1) {
 		ERR(sh, "Error while renaming %s to %s.", active, backup);
 		retval = -1;
 		goto cleanup;
@@ -1779,12 +1797,12 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 	/* clean up some files from the sandbox before install */
 	/* remove homedir_template from sandbox */
 
-	if (rename(sandbox, active) == -1) {
+	if (semanage_rename(sh, sandbox, active) == -1) {
 		ERR(sh, "Error while renaming %s to %s.", sandbox, active);
 		/* note that if an error occurs during the next
 		 * function then the store will be left in an
 		 * inconsistent state */
-		if (rename(backup, active) < 0)
+		if (semanage_rename(sh, backup, active) < 0)
 			ERR(sh, "Error while renaming %s back to %s.", backup,
 			    active);
 		retval = -1;
@@ -1795,10 +1813,10 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 		 * function then the store will be left in an
 		 * inconsistent state */
 		int errsv = errno;
-		if (rename(active, sandbox) < 0)
+		if (semanage_rename(sh, active, sandbox) < 0)
 			ERR(sh, "Error while renaming %s back to %s.", active,
 			    sandbox);
-		else if (rename(backup, active) < 0)
+		else if (semanage_rename(sh, backup, active) < 0)
 			ERR(sh, "Error while renaming %s back to %s.", backup,
 			    active);
 		else
-- 
2.35.1

