Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBCC433EF
	for <selinux@archiver.kernel.org>; Thu, 25 Nov 2021 19:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350283AbhKYTcb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Nov 2021 14:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350366AbhKYTab (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Nov 2021 14:30:31 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE22C061756
        for <selinux@vger.kernel.org>; Thu, 25 Nov 2021 11:27:19 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l25so29336252eda.11
        for <selinux@vger.kernel.org>; Thu, 25 Nov 2021 11:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3CD6MBaklyA2wY5USJ8GzgZ4/IeQzV0KAglEC7GPWPE=;
        b=odGv26NQ6EKnw11vpBjRa/tjSF9d4GHABMnoembY/hkAsXo3HElEW5QQWDgOPyGO0o
         1/BLBJUU1EivyT4xq5+UTJtcK5HgKSYH/Ee+7MnnnGhs72k13bNMCpsk3/JtvG0OjvFf
         /VHpSY8nI92eDvNjT20hg+x4XnGcv1oupgBrmakLZWAt29awDkWb6/KON05TnKPr+pKO
         1Ekh3+XpGV3UF8bfrnwT0p4TESoQ1wBKd3mMamoFS5Jt9dlUd3QV383uiuSOWgxw2uWn
         D9j8pDsnqMgyVfoQTdrKi+wCgPdBSQhlxRoMsbd+yaDnni746JucmoNPWOEI+i0i2FpM
         XX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CD6MBaklyA2wY5USJ8GzgZ4/IeQzV0KAglEC7GPWPE=;
        b=2IfdG3Cc6zyNi+wP46Trehsais0PAixhsYIum816CApoU0hLqrjJG/02SPO5pvXgUN
         ve5XkWu6J6WC6OIKOFvnzrLGuApL9eq6a0FgIQVvQCPLIgBol9WBQc1az3PTk5deQuUw
         jSdT3IJLBbIKXkttljjVwNfL4/6dAde20wELcd32Ksx99HXT+0cYOSdl/3c6fhBopmIp
         AYy8l1jVHuj9SaDWozc4lfC1+Ccgvx/34EkA8/BlE4etFo4RVKcKKR2ija0NNmpAblmz
         /kuPEG4Jm6bZcd2CjyqbNiybyijge5Iqs5QPG/3cQ4R8kjxohw6goTzXytvlXwUSaE8M
         pPlQ==
X-Gm-Message-State: AOAM531vJR0AeIo9QyCYFBi6gmS6wwL4eEl/DLxKBXqVjcnVrvFHG0kj
        cXtFJcagdsIeia5JiY9h7+aJ8SJGJcWX91vu
X-Google-Smtp-Source: ABdhPJyAH5P3WQhoSx9e/nUviJRsb3u6sGZJvEHWRGZYhAVLQayHewmj7216ozqG/cQoVwsKdtUVnA==
X-Received: by 2002:a17:906:fa87:: with SMTP id lt7mr34641288ejb.426.1637868437682;
        Thu, 25 Nov 2021 11:27:17 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-112-150-062.95.112.pool.telefonica.de. [95.112.150.62])
        by smtp.gmail.com with ESMTPSA id z22sm2938703edd.78.2021.11.25.11.27.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 11:27:17 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH XSERVER 2/2] selinux: log events with appropriate audit type
Date:   Thu, 25 Nov 2021 20:27:10 +0100
Message-Id: <20211125192710.191445-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211125192710.191445-1-cgzones@googlemail.com>
References: <20211125192710.191445-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the appropriate audit type for SELINUX_ERROR, SELINUX_POLICYLOAD and
SELINUX_SETENFORCE libselinux messages, e.g. avoid USER_SELINUX_ERR for
policy load events:
    audit[980]: USER_SELINUX_ERR pid=980 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:xorg_t:s0 msg='avc:  op=load_policy lsm=selinux seqno=8 res=1 exe="/usr/lib/xorg/Xorg" sauid=0 hostname=? addr=? terminal=?'

Do not generate an audit event for SELINUX_WARNING messages.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
See upstream merge request https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/801
---
 Xext/xselinux_hooks.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/Xext/xselinux_hooks.c b/Xext/xselinux_hooks.c
index b9d47103a..4305ba9b4 100644
--- a/Xext/xselinux_hooks.c
+++ b/Xext/xselinux_hooks.c
@@ -301,25 +301,41 @@ SELinuxLog(int type, const char *fmt, ...)
 {
     va_list ap;
     char buf[MAX_AUDIT_MESSAGE_LENGTH];
-    int rc, aut;
+    int aut;
 
     switch (type) {
+    case SELINUX_ERROR:
+        aut = AUDIT_USER_SELINUX_ERR;
+        break;
     case SELINUX_INFO:
         aut = AUDIT_USER_MAC_POLICY_LOAD;
         break;
     case SELINUX_AVC:
         aut = AUDIT_USER_AVC;
         break;
+#ifdef SELINUX_POLICYLOAD /* since libselinux 3.2 */
+    case SELINUX_POLICYLOAD:
+        aut = AUDIT_USER_MAC_POLICY_LOAD;
+        break;
+#endif
+#if defined(SELINUX_SETENFORCE) && defined(AUDIT_USER_MAC_STATUS) /* since libselinux 3.2 and audit 3.0 */
+    case SELINUX_SETENFORCE:
+        aut = AUDIT_USER_MAC_STATUS;
+        break;
+#endif
+    case SELINUX_WARNING:
     default:
-        aut = AUDIT_USER_SELINUX_ERR;
+        /* Do not generate an audit event, just log normally. */
+        aut = -1;
         break;
     }
 
     va_start(ap, fmt);
     vsnprintf(buf, MAX_AUDIT_MESSAGE_LENGTH, fmt, ap);
-    rc = audit_log_user_avc_message(audit_fd, aut, buf, NULL, NULL, NULL, 0);
-    (void) rc;
     va_end(ap);
+
+    if (aut != -1)
+        (void) audit_log_user_avc_message(audit_fd, aut, buf, NULL, NULL, NULL, 0);
     LogMessageVerb(X_WARNING, 0, "%s", buf);
     return 0;
 }
-- 
2.34.0

