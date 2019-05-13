Return-Path: <SRS0=Ozag=TN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE75C04AA7
	for <selinux@archiver.kernel.org>; Mon, 13 May 2019 11:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790D7208CA
	for <selinux@archiver.kernel.org>; Mon, 13 May 2019 11:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfEML6c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 May 2019 07:58:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56231 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfEML6b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 May 2019 07:58:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id x64so2338162wmb.5
        for <selinux@vger.kernel.org>; Mon, 13 May 2019 04:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HQG2aHVzKDOu5bdBsMSwfv1Gpjo++7Q5Sx0rwS4cqF8=;
        b=biB3nZzEq8rT+VM0gFGk7BvfqpvdG/ARTe2wHMgqfA+61K/3kvujOpRBK9NRzeDYzx
         rQX5EVcGLx/IDNfd0Hiep7qmSRr4dGMrAW/zXoymVuxTJLq9elbnSuhfXIOzAsYJT+PN
         vjp5JzzrNbF27/0tuk9m/rcqAYGrtEfKBix9Txz2ZWEi9jMM+Lh/mo9c59MOKsUSpG2G
         MRS+lkC6gZ8iSZ9PPQbJMNAOudMRsw9uHHEfx0vn9PFRQJPzIsH1A5WZnCQrYfdJVIz2
         5dXrRmYRx0cX1y/F+njJxg2m1fHpLVwfzfnnvH2otfhrJyyeIcfA7UDO074M7vPw1lv1
         jV1Q==
X-Gm-Message-State: APjAAAVUP+UsG50R+/8AZLRQRssBYdnau0pFuOW6hYzULWL9GzRWKMcg
        br7cYIdxeKEIbIGtC5EeXma88/SD1So=
X-Google-Smtp-Source: APXvYqx6dAf7dLyYOdL9IR3mRb8SJCf0XdTo13nJQvRj46YHkuY8dyZfdV7XB3d3EnNCzMkQ941sig==
X-Received: by 2002:a1c:c016:: with SMTP id q22mr9911081wmf.6.1557748709801;
        Mon, 13 May 2019 04:58:29 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q7sm13942379wmc.11.2019.05.13.04.58.27
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 04:58:28 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] run_init: fix build when crypt() is not in unistd.h
Date:   Mon, 13 May 2019 13:58:26 +0200
Message-Id: <20190513115826.22475-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

According to [1], crypt() support in POSIX is optional, so include
also <crypt.h> when _XOPEN_CRYPT is not defined or is defined to -1.
Without this I can't build run_init from source out-of-the-box on
Fedora 29.

[1] http://man7.org/linux/man-pages/man3/crypt.3.html#NOTES

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/run_init/run_init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index 4bc32b1c..a007ce49 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -159,6 +159,14 @@ int authenticate_via_pam(const struct passwd *p_passwd_line)
 #include <shadow.h>		/* for shadow passwd functions */
 #include <string.h>		/* for strlen(), memset() */
 
+/*
+ * crypt() may not be defined in unistd.h; see:
+ *   http://man7.org/linux/man-pages/man3/crypt.3.html#NOTES
+ */
+#if !defined(_XOPEN_CRYPT) || _XOPEN_CRYPT == -1
+#include <crypt.h>
+#endif
+
 #define PASSWORD_PROMPT _("Password:")	/* prompt for getpass() */
 
 int authenticate_via_shadow_passwd(const struct passwd *);
-- 
2.20.1

