Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FB9EB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 13:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGFNsZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGFNsY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 09:48:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AF11990
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 06:48:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99364ae9596so93089966b.1
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688651302; x=1691243302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vALjcm4ze+ehZe+w/iTli65y6gFvaBjgG2WjrdE8Cu0=;
        b=IE8SxVpyrewQyNhSeLC+ma+uiCsLOGgQ8J4+k/iInH/Bt1PI5rX/TKPe02Cjzq+S35
         DxfMEZaVOKwvgVpyVcmK0vbqh6ipeTyG207rZXAtAbl3E94CQp37UyYO0F8VGbYu8oPW
         OaFguFU33dsVXPRcv+l6aHezMOHDqHTJyifUC+xQrKT5qCm7KbBwDEl0YkL1FltRiacN
         4TLaaU1O9TTjNt9IMNBIOchOXdvu93/xtjDqFZGMJF6EsmUNPKqvHFmLFTDqtLah15Q5
         WcqJpJuGPfWfwJeBmfwudD3ZfarPTbEOL0G3ObgGIxX736ngKMs361aDJURCVc8x7/QQ
         nAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651302; x=1691243302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vALjcm4ze+ehZe+w/iTli65y6gFvaBjgG2WjrdE8Cu0=;
        b=EUEHRyhLPCXHTfwVPW2SU6I0Z63gd43XhZodoVYoUR8hIwouqPQCiX7lEThgC5LhNQ
         TAElMSTIMhLboVUTKodir/qVtF4i7peOH6CJ8lNs612iSpCefuSwL2+O0k8fNx2k57gZ
         14lQmP7xYcZfF3eJ0Kpc5D0qMwl+qz8AlTXtIogtBadfR6PDWeHx+1mZTUikxDJ/mkfS
         PyUBb5pzXLc7t1ocyjlbp9FtKHnVNTBG6B5iwTnWWOFE4w2IIScLkKDl7PWhPEZF43yz
         NakWBf2Z04V035LPSY4zXbaBK1fZr8fu/1fB+D3CfbZPkG2tAzcbhCMqPhSF4J/g25Gl
         FQBQ==
X-Gm-Message-State: ABy/qLYkV0XYj/1yYVwm6uTP3HmG6/w59krna4qHO5vRWBANRU0yFfev
        p17Y2/Z6sfIS6sNPzIlqT6RCi4Q8c1bQY07k
X-Google-Smtp-Source: APBJJlFvPNvn5KsD30fBct6m60mJeEeXvfcE47yWn6i5nK9PZNgt64jkCDraQW1X4cLXDcj8ykuiAA==
X-Received: by 2002:a17:906:196:b0:974:1c99:7d3 with SMTP id 22-20020a170906019600b009741c9907d3mr1361864ejb.25.1688651301942;
        Thu, 06 Jul 2023 06:48:21 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906b18e00b00992ca779f42sm847153ejy.97.2023.07.06.06.48.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:48:21 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux/utils: introduce getpolicyload
Date:   Thu,  6 Jul 2023 15:48:19 +0200
Message-Id: <20230706134819.41903-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Introduce a helper binary to print the number of policy reloads on the
running system.
Print only a single number to ease the usage by scripts.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/getpolicyload.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 libselinux/utils/getpolicyload.c

diff --git a/libselinux/utils/getpolicyload.c b/libselinux/utils/getpolicyload.c
new file mode 100644
index 00000000..53217ff5
--- /dev/null
+++ b/libselinux/utils/getpolicyload.c
@@ -0,0 +1,29 @@
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <selinux/avc.h>
+
+
+int main() {
+        int rc;
+
+	/* 
+	 * Do not use netlink as fallback, since selinux_status_policyload(3)
+	 * works only after a first message has been received.
+	 */
+        rc = selinux_status_open(/*fallback=*/0);
+        if (rc < 0) {
+                fprintf(stderr, "getpolicyload:  failed to open SELinux status map:  %m\n");
+                return EXIT_FAILURE;
+        }
+
+        rc = selinux_status_policyload();
+        if (rc < 0)
+                fprintf(stderr, "getpolicyload:  failed to read policyload from SELinux status page:  %m\n");
+        else
+                printf("%d\n", rc);
+
+        selinux_status_close();
+
+        return (rc < 0) ? EXIT_FAILURE : EXIT_SUCCESS;
+}
-- 
2.40.1

