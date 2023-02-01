Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F116CC05027
	for <selinux@archiver.kernel.org>; Wed,  1 Feb 2023 10:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBAKzT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Feb 2023 05:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjBAKzS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Feb 2023 05:55:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CC2448A
        for <selinux@vger.kernel.org>; Wed,  1 Feb 2023 02:55:17 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id dr8so28615563ejc.12
        for <selinux@vger.kernel.org>; Wed, 01 Feb 2023 02:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZxRf1xg5j7Cb/uM5pprTyQjYyeoKqqzWl4KhDHfP4g=;
        b=SBp3yxwveSOuyxqjyKR5RP2XKgUdOShtynaDFwK+P7NqnptvcAV5Irt3y9E3G9dCjW
         1797kSzWZn4BkdXxDEaJHcGwD6CME8lBgnyiqrLVKCaGZcnuJzulF/XVL37edq5H5dkR
         8LcGcLWL2AFGIgMPgVKXtE7oanrz+JI5pry6zUffWt+IE+StPlf7QHsVo24au978uHTD
         fAulDc9EsJXFarrDvT/A01izSpPSjMse76UOgNq/KrqwJwiJS10a/Fvm5Fs0dDDMnli2
         nCuZJfO8vwQAhnYmsOEmM3ChXGngO3BLjr3Agwkv321Hdrg3vSrnEl6YVaj4rKn8znKS
         pNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZxRf1xg5j7Cb/uM5pprTyQjYyeoKqqzWl4KhDHfP4g=;
        b=jaMVSdq322rtofZ1jAJ5SI84d3AxH/OM9sjJq7JfdoBTDlYvfekNmvrqKI4nucD1VY
         Eg5/lVwkNaP+dGyTikngomz0IInEj6on1JOK38VRbF6UiHILbpYoQueehTVDDdnQc07n
         K50Pxds22FLUC+yAuIn4P7poIqWkIYjsVNPF4KXk+1OGZqV3HweyVwfyV5j47orxl4P2
         MdpFMS40MfjEczjQsipSwbjV/4x/W3qignYoi4HeW3dml3De14fVp4NxJLvh/KdvkuhH
         WBMor7lg/HJRsBRww83o3T+bnpVTY5CqHYRSmowcPnwsoaeUHS7cZPC+4OwBZ5HJnqED
         9+vQ==
X-Gm-Message-State: AO0yUKUNcZRTjmCYwaBH71d4ljORNyeDDZzqvCQbJCzsu0OuhKRwViTl
        5hZF9oKKrt+btlSpgkvwqeV7pDj1pqwuSA==
X-Google-Smtp-Source: AK7set8GwxaLB+pDjEUs6zXqTHqTFlA2TPp2Oq1bCDrPUF3Wn3jWigJn22GixgiCcvjGa5Yhl4AQtw==
X-Received: by 2002:a17:907:7757:b0:86f:e30c:72c1 with SMTP id kx23-20020a170907775700b0086fe30c72c1mr1907641ejc.8.1675248916053;
        Wed, 01 Feb 2023 02:55:16 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-178-099.77.8.pool.telefonica.de. [77.8.178.99])
        by smtp.gmail.com with ESMTPSA id o25-20020a1709061b1900b0084d4e9a13cbsm9927632ejg.221.2023.02.01.02.55.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:55:15 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libselinux: restore: misc tweaks
Date:   Wed,  1 Feb 2023 11:55:09 +0100
Message-Id: <20230201105510.14125-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201105510.14125-1-cgzones@googlemail.com>
References: <20230201105510.14125-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add const qualifier to read-only state struct.

Minimize scope of function local variables, to reduce complexity.

Pass only the file type related file flags to selabel_lookup(3).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 6b5f6921..40a759f0 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -432,7 +432,7 @@ static pthread_mutex_t fl_mutex = PTHREAD_MUTEX_INITIALIZER;
  * that matched.
  */
 static int filespec_add(ino_t ino, const char *con, const char *file,
-			struct rest_flags *flags)
+			const struct rest_flags *flags)
 {
 	file_spec_t *prevfl, *fl;
 	int h, ret;
@@ -624,15 +624,13 @@ out:
 }
 
 static int restorecon_sb(const char *pathname, const struct stat *sb,
-			    struct rest_flags *flags, bool first)
+			    const struct rest_flags *flags, bool first)
 {
 	char *newcon = NULL;
 	char *curcon = NULL;
 	char *newtypecon = NULL;
 	int rc;
-	bool updated = false;
 	const char *lookup_path = pathname;
-	float pc;
 
 	if (rootpath) {
 		if (strncmp(rootpath, lookup_path, rootpathlen) != 0) {
@@ -647,10 +645,10 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	if (rootpath != NULL && lookup_path[0] == '\0')
 		/* this is actually the root dir of the alt root. */
 		rc = selabel_lookup_raw(fc_sehandle, &newcon, "/",
-						    sb->st_mode);
+						    sb->st_mode & S_IFMT);
 	else
 		rc = selabel_lookup_raw(fc_sehandle, &newcon, lookup_path,
-						    sb->st_mode);
+						    sb->st_mode & S_IFMT);
 
 	if (rc < 0) {
 		if (errno == ENOENT) {
@@ -670,7 +668,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		fc_count++;
 		if (fc_count % STAR_COUNT == 0) {
 			if (flags->mass_relabel && efile_count > 0) {
-				pc = (fc_count < efile_count) ? (100.0 *
+				float pc = (fc_count < efile_count) ? (100.0 *
 					     fc_count / efile_count) : 100;
 				fprintf(stdout, "\r%-.1f%%", (double)pc);
 			} else {
@@ -710,6 +708,8 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	}
 
 	if (curcon == NULL || strcmp(curcon, newcon) != 0) {
+		bool updated = false;
+
 		if (!flags->set_specctx && curcon &&
 				    (is_context_customizable(curcon) > 0)) {
 			if (flags->verbose) {
-- 
2.39.1

