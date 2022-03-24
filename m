Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF989C433F5
	for <selinux@archiver.kernel.org>; Thu, 24 Mar 2022 09:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244270AbiCXJyo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Mar 2022 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349089AbiCXJyi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Mar 2022 05:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5030C6544
        for <selinux@vger.kernel.org>; Thu, 24 Mar 2022 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648115584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vbb20GdGEX3bKiyJXVgyCCMKnidyxPKPQOYdD3bc9qU=;
        b=ULUFUcaOsFp2wn6LMFaV8Gp2gvw8agNWjLrXcNnIdyj++Sf1H3EdOEO/rPtuxbSyW3lJtW
        EaXYwYXha0fcK8F52SK5IGdZ52qDkLVOu6EuEZkrqyr+YY5U2+pEjd41jzNtbyENy4n3bX
        Cw20afrURixZUVmE9bN8W7nWndrwi4Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-b5KqB_n9OGmudMjLXUlMZA-1; Thu, 24 Mar 2022 05:53:03 -0400
X-MC-Unique: b5KqB_n9OGmudMjLXUlMZA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FC1D3C16187
        for <selinux@vger.kernel.org>; Thu, 24 Mar 2022 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F50941D3F9;
        Thu, 24 Mar 2022 09:53:02 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Joseph Marrero Corchado <jmarrero@redhat.com>
Subject: [PATCH v2] libsemanage: Fall back to semanage_copy_dir when rename() fails
Date:   Thu, 24 Mar 2022 10:52:51 +0100
Message-Id: <20220324095251.1561597-1-plautrba@redhat.com>
In-Reply-To: <CAFqZXNs11g0x6wTvu_kkHVkUE==SV-ameWRnnW5ipd_gY3aAwg@mail.gmail.com>
References: <CAFqZXNs11g0x6wTvu_kkHVkUE==SV-ameWRnnW5ipd_gY3aAwg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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
changes to v1 base on Ondrej's feedback:

- improve the commit message
- use WARN() instead of fprintf(stderr, 

 libsemanage/src/semanage_store.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 767f05cb2853..3ae60493c8e5 100644
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
@@ -768,7 +772,20 @@ out:
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
+	WARN(sh, "Warning: rename(%s, %s) failed: %s, fall back to non-atomic semanage_copy_dir_flags()\n", src, dst, strerror(errno));
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
+	if (semanage_rename(sh, active, backup) == -1) {
 		ERR(sh, "Error while renaming %s to %s.", active, backup);
 		retval = -1;
 		goto cleanup;
@@ -1779,12 +1796,12 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
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
@@ -1795,10 +1812,10 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
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

