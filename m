Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ABFC433EF
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 13:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiBVNwO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiBVNwO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 08:52:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2C690FFD
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:51:48 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hw13so42924265ejc.9
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFurHR0pq931GS0HCE9XoYrSZM3+oBed7Dr+xT2gxCo=;
        b=dEZOl5RgmxbOOzIsXk3vMkfJL3LLvFUMRolKaz0zY8cGERPZQANWryhNj00iHhd7pP
         PCpif+frbTJzh+rTq03S9awYsqmR6AbDFXNj3yBcJNBHpd1NDCNBfWMvGQXzk7QfCU8Y
         mODysJ6u9vt84mraNf2LB2+XdnlqnIPZBH/EGS6q4UHBflANP9aofWt3ryo5H5Q6iBfE
         CPPbAe5ddgKNn5fHMKuktYgCks+kgpUIfgvRTiF0Uv7W6VIoVC7/Sfy7kFihGqYLeTt2
         WCzHiZyvHTXByfVtsH8amVPfMHzn5aG+l66spVyo8P86fqFf/sNtvYI538wUnnubYQC0
         Pr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFurHR0pq931GS0HCE9XoYrSZM3+oBed7Dr+xT2gxCo=;
        b=DBXlgqZboDjVYs2LxrWBjKsGZh3ACU12fiFJ22omrbZxuLwPqLwBLykntzu5q0wsor
         txQQ9Ph6PFthV9oXSPII3fP9L8jhTOlmUt9jwbJjss6CtWRnVRxYMKniKOvzhO6DC37c
         ybZLkWbOXq1Nda4oFzcofsAM6WZHgTukSytDC72oPiiuO1DlRlSVZP4QaLCGUsAU+LqC
         n/AGpoOI0DzpmqknVLOZPxPwReu/XzOL3Utf+tFHwXy8q08wURpWCnoBBmp2IFZPS0oY
         ZIS/4H44e0qAkf7NaSCqgZ9Sb+rtucD/iomfVhyqWCp4UcvAFp775nLxd9cUvnjHXJIU
         ikUw==
X-Gm-Message-State: AOAM533U8Oo+pgJW5F2mD8vyaMKHG/919h5j5xDl1QAwLBskJY67Utjj
        u1829np3vFJSTveGFjFZ+toLpjAVQa4=
X-Google-Smtp-Source: ABdhPJxNHiK7vFDiNvjQmfDdx2vJUpLlj6lE17vIsIsKlgqhrncifhFIvzy8vReoA7/NEuVv7lMJlA==
X-Received: by 2002:a17:907:96ac:b0:6d3:4554:598b with SMTP id hd44-20020a17090796ac00b006d34554598bmr1371683ejc.424.1645537907331;
        Tue, 22 Feb 2022 05:51:47 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-065-014.77.3.pool.telefonica.de. [77.3.65.14])
        by smtp.gmail.com with ESMTPSA id eg42sm8266916edb.79.2022.02.22.05.51.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:51:46 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] newrole: add Makefile target to test build options
Date:   Tue, 22 Feb 2022 14:51:40 +0100
Message-Id: <20220222135143.30602-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a Makefile target which build newrole with all combinations of
supported build options.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
index 4dedb7dd..b3ccf671 100644
--- a/policycoreutils/newrole/Makefile
+++ b/policycoreutils/newrole/Makefile
@@ -91,3 +91,16 @@ indent:
 
 relabel: install
 	/sbin/restorecon $(DESTDIR)$(BINDIR)/newrole
+
+test-build-options:
+	$(MAKE) PAMH=y AUDITH=y AUDIT_LOG_PRIV=y NAMESPACE_PRIV=y clean newrole
+	$(MAKE) PAMH=y AUDITH=y AUDIT_LOG_PRIV=y NAMESPACE_PRIV=n clean newrole
+	$(MAKE) PAMH=y AUDITH=y AUDIT_LOG_PRIV=n NAMESPACE_PRIV=y clean newrole
+	$(MAKE) PAMH=y AUDITH=y AUDIT_LOG_PRIV=n NAMESPACE_PRIV=n clean newrole
+	$(MAKE) PAMH=y AUDITH=y AUDIT_LOG_PRIV=y NAMESPACE_PRIV=y clean newrole
+	$(MAKE) PAMH=y AUDITH=n AUDIT_LOG_PRIV=n NAMESPACE_PRIV=y clean newrole
+	$(MAKE) PAMH=y AUDITH=n AUDIT_LOG_PRIV=n NAMESPACE_PRIV=n clean newrole
+	$(MAKE) PAMH=n AUDITH=y AUDIT_LOG_PRIV=y NAMESPACE_PRIV=n clean newrole
+	$(MAKE) PAMH=n AUDITH=y AUDIT_LOG_PRIV=n NAMESPACE_PRIV=n clean newrole
+	$(MAKE) PAMH=n AUDITH=n AUDIT_LOG_PRIV=n NAMESPACE_PRIV=n clean newrole
+	$(MAKE) clean
-- 
2.35.1

