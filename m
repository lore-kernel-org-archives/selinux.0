Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3725C433EF
	for <selinux@archiver.kernel.org>; Wed,  6 Jul 2022 11:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiGFLiO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jul 2022 07:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiGFLiN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jul 2022 07:38:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E83C252A7
        for <selinux@vger.kernel.org>; Wed,  6 Jul 2022 04:38:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h23so26550474ejj.12
        for <selinux@vger.kernel.org>; Wed, 06 Jul 2022 04:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KQb2FUMAcguvNIGVBlKqR4gWR+HRIGKrgVb7GQPyVZA=;
        b=Qvw2UrnZsgCz+t1Ne5UMKH2SfGXR+ecAy58XQerwk5aLMRy0MuCA04WD4SZe3F6d9v
         XWXnZlinYzH6KHUf81i1aG6zN9tYuIE0ExFi6rS4l6fT72ot5yrmCiuh6Gq0af3DgCJP
         J7gLZkJ8Enkzn69Cvbh+ryPeNQCH2X1Rla/p4OVG/Q7cy4BSWnWH1rq4ND27LA8WBuIR
         WcgRu7oB3hEeq6+UbY/OH5kOVICIe3tYsdTaKNvC/h5APUPjKylFH2xuzR9amT/jTWtF
         W2y7FCM1xdW/avbYe5Jc1kH2alH8BMhaTVX7zOerjh+oz1DdcMwtZ2eojlsuY7jCWHK1
         C+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQb2FUMAcguvNIGVBlKqR4gWR+HRIGKrgVb7GQPyVZA=;
        b=HQdI9ikHAsRISvZK2H8fcjPgogc4B+wM9R7Y2/bEILVOid0rfgmXW14XVtQ2dhbsmd
         8TGCbXw+QFtrdIHKWzZAXD2OmKoY2ydARU/iN2CfLpIVI2O24PZsk6SIRlFTBxVGhRub
         +tx1yqh6/6gBbsCjct8rs7ebDrgMnTIs0NH+cIz1nedne1+wypTAGblTHf1Lc/f71+Eu
         Nn0Gm/PqqWOJJPppHuxPAQYu6opRtcmem6ZyM0iSpcrGRO5/mn5T+NtaFHnmyLw37CYF
         wRHuOmJUvHX3lVVpfzXe6WeGF1vaOwt5LNL4ZGaHY+kDvmyy3Iv9ksGQ7oRSHp/PKpCT
         N7ug==
X-Gm-Message-State: AJIora/xKcYTs9qdJm5TRPaxpD0/BE9U0fKktkgdh8XyJiu/ORpSgmsd
        +HaqBwaostCVXv17ByIyl0eIiN7phiGKpQ==
X-Google-Smtp-Source: AGRyM1s7iRKAShEzx9eAySXmP/8MBhySHQ6VuR0gJZL2TDNh+IklHkCXBtlhnqsHNSX3AYUIFTXQ4g==
X-Received: by 2002:a17:907:7f1a:b0:726:2b37:7b82 with SMTP id qf26-20020a1709077f1a00b007262b377b82mr38133459ejc.366.1657107490814;
        Wed, 06 Jul 2022 04:38:10 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-141-252.95.116.pool.telefonica.de. [95.116.141.252])
        by smtp.gmail.com with ESMTPSA id f16-20020a056402329000b0043a83f77b59sm2063196eda.48.2022.07.06.04.38.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 04:38:10 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libselinux: set errno to EBADF on O_PATH emulation ENOENT failure
Date:   Wed,  6 Jul 2022 13:38:04 +0200
Message-Id: <20220706113804.8272-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706104729.14975-1-cgzones@googlemail.com>
References: <20220706104729.14975-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When the O_PATH emulation fails due to getxattr(2)/setxattr(2) failing
with ENOENT, e.g. because no procfs being available, override the errno
value to EBADF.  This avoids confusion to the caller as it would suggest
the target of the operation does not exist, which is not the case:

    setfiles: Could not set context for /:  No such file or directory

Fixes: a782abf2 ("libselinux: emulate O_PATH support in fgetfilecon/fsetfilecon")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   only override errno on ENOENT
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/fgetfilecon.c | 5 ++++-
 libselinux/src/fsetfilecon.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.c
index baf38ec1..d7051171 100644
--- a/libselinux/src/fgetfilecon.c
+++ b/libselinux/src/fgetfilecon.c
@@ -26,7 +26,10 @@ static ssize_t fgetxattr_wrapper(int fd, const char *name, void *value, size_t s
 
 	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
 	errno = saved_errno;
-	return getxattr(buf, name, value, size);
+	ret = getxattr(buf, name, value, size);
+	if (ret < 0 && errno == ENOENT)
+		errno = EBADF;
+	return ret;
 }
 
 int fgetfilecon_raw(int fd, char ** context)
diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon.c
index be821c7a..19ea15b7 100644
--- a/libselinux/src/fsetfilecon.c
+++ b/libselinux/src/fsetfilecon.c
@@ -25,7 +25,10 @@ static int fsetxattr_wrapper(int fd, const char* name, const void* value, size_t
 
 	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", fd);
 	errno = saved_errno;
-	return setxattr(buf, name, value, size, flags);
+	rc = setxattr(buf, name, value, size, flags);
+	if (rc < 0 && errno == ENOENT)
+		errno = EBADF;
+	return rc;
 }
 
 int fsetfilecon_raw(int fd, const char * context)
-- 
2.36.1

