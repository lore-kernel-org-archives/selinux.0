Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B712C433EF
	for <selinux@archiver.kernel.org>; Wed,  6 Jul 2022 10:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiGFKrt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jul 2022 06:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiGFKrs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jul 2022 06:47:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A025EA1
        for <selinux@vger.kernel.org>; Wed,  6 Jul 2022 03:47:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g26so26394945ejb.5
        for <selinux@vger.kernel.org>; Wed, 06 Jul 2022 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pTYenX5w9q1Rz33zeyq/iCO7+4AeehIKa1cZmJQwia8=;
        b=KTByTXmpDsqKMxUuLUfccMsDiXSFUBtpqzzad9DRcbYDyltlz+mgybSSHaqbjIP2tb
         ar5cZjgNnOeyb5enL2I1N4D3xR+EliOhUj5bvIQQdy23uzGv3cltkKIk7uOKxqFY/zgJ
         5wk1KRxoQv65OnYK1eHynttmM+tQ3g17nRwHcvuxsVQVZ0vzrL6lKJvhn4bvq5XfoC35
         oliYXtgfAqi+2OHhwxwWRodcJJDx1O5TahslWvpVJtyZZLKgD7NrYLgxMn+yEObk312q
         VaeObN4qp7Rg2//AX3uOJCs8oBDFs23/KyiSXTSfljvdIwva5prPO6NIu7GxqUGNJQiH
         mTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pTYenX5w9q1Rz33zeyq/iCO7+4AeehIKa1cZmJQwia8=;
        b=EWbfBxbN2xLI3aip7WM8xCiFrkPIS1oJ6mlmB/5l4trNkaaIt4Pb00jeQrN0mr2l/V
         jjeJfJ+rMgTyCPDxRZVNE9J/WV5BUxbdnFNaF9ebdDAhNSStWp8tlxXcRgLf5T0Op9TF
         hNDz5sa314aQlJMo9Yf23L+r4QyIyWwzetJLtebuu1fP+Jdy9NqLOM8ZVYcqbSSun6XQ
         3HlBJ1qqW73AvFjtStE9mc2ymIDMQz2eQkNouVhUw6IrorrhhrzpBGTrLVLVirJGrEUq
         xuxSoE2FwqtUpi1Jylf+/wgFwJYQs3fznogtDJZ0OrEcDi5ofwGG+YSE2ps4PwmK4l95
         Jq+w==
X-Gm-Message-State: AJIora9l5GWgLGqyeni0bKgNAEwd2dSwVOQ6oeucTPERWHoeVky+cTtz
        MqpFTKBchf2R3OPqJHNUu/QixQhBZKyMng==
X-Google-Smtp-Source: AGRyM1vZuol01R33oL/JrZrWFITXwRXooLINWvVcXCra6nLG65Z2l4UQcBn51SodhfYldJBKY8/Ftw==
X-Received: by 2002:a17:907:1c13:b0:72a:fb14:4a0c with SMTP id nc19-20020a1709071c1300b0072afb144a0cmr2029494ejc.305.1657104465878;
        Wed, 06 Jul 2022 03:47:45 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-141-252.95.116.pool.telefonica.de. [95.116.141.252])
        by smtp.gmail.com with ESMTPSA id sd23-20020a170906ce3700b00711c7cca428sm17272220ejb.155.2022.07.06.03.47.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:47:45 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: set errno to EBADF on O_PATH emulation failure
Date:   Wed,  6 Jul 2022 12:47:29 +0200
Message-Id: <20220706104729.14975-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When the O_PATH emulation fails override the errno value to EBADF
instead of retaining the one from getxattr(2)/setxattr(2).

For example in the case of no procfs being mounted, e.g. inside of a
chroot, getxattr(2)/setxattr(2) fail with ENOENT.  This is confusing to
the caller as it seems the target of the operation does not exist, which
is not the case:

    setfiles: Could not set context for /:  No such file or directory

Fixes: a782abf2 ("libselinux: emulate O_PATH support in fgetfilecon/fsetfilecon")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/fgetfilecon.c | 8 +++++---
 libselinux/src/fsetfilecon.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.c
index baf38ec1..4c440df3 100644
--- a/libselinux/src/fgetfilecon.c
+++ b/libselinux/src/fgetfilecon.c
@@ -10,7 +10,7 @@
 
 static ssize_t fgetxattr_wrapper(int fd, const char *name, void *value, size_t size) {
 	char buf[40];
-	int fd_flag, saved_errno = errno;
+	int fd_flag;
 	ssize_t ret;
 
 	ret = fgetxattr(fd, name, value, size);
@@ -25,8 +25,10 @@ static ssize_t fgetxattr_wrapper(int fd, const char *name, void *value, size_t s
 	}
 
 	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
-	errno = saved_errno;
-	return getxattr(buf, name, value, size);
+	ret = getxattr(buf, name, value, size);
+	if (ret < 0)
+		errno = EBADF;
+	return ret;
 }
 
 int fgetfilecon_raw(int fd, char ** context)
diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.c
index be821c7a..374dc627 100644
--- a/libselinux/src/fsetfilecon.c
+++ b/libselinux/src/fsetfilecon.c
@@ -10,7 +10,7 @@
 
 static int fsetxattr_wrapper(int fd, const char* name, const void* value, size_t size, int flags) {
 	char buf[40];
-	int rc, fd_flag, saved_errno = errno;
+	int rc, fd_flag;
 
 	rc = fsetxattr(fd, name, value, size, flags);
 	if (rc == 0 || errno != EBADF)
@@ -24,8 +24,10 @@ static int fsetxattr_wrapper(int fd, const char* name, const void* value, size_t
 	}
 
 	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
-	errno = saved_errno;
-	return setxattr(buf, name, value, size, flags);
+	rc = setxattr(buf, name, value, size, flags);
+	if (rc < 0)
+		errno = EBADF;
+	return rc;
 }
 
 int fsetfilecon_raw(int fd, const char * context)
-- 
2.36.1

