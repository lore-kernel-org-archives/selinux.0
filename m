Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07768C433F5
	for <selinux@archiver.kernel.org>; Thu, 25 Nov 2021 19:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350132AbhKYTca (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Nov 2021 14:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350283AbhKYTaa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Nov 2021 14:30:30 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785A2C06174A
        for <selinux@vger.kernel.org>; Thu, 25 Nov 2021 11:27:18 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id e3so29593088edu.4
        for <selinux@vger.kernel.org>; Thu, 25 Nov 2021 11:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJiLzX5jrXpmY0/hfEQmM+iw2NHLWsWyw/70eqbIg8Q=;
        b=D9EGQCKX2CxQcJzLkdp4cTdUNetT44mmkeAPG7aR1yikm2MbryH9UODLApOBWbP67M
         aSYP3MJIu/0JUMn10HPOXfjMDNryH9oC6VojaYFyuDhRZ2QIBynmysKCmNU0zgxXL5Os
         KNbo5sYgrPAHAGKjwBgm7ayFHvYVohN1HAKOxNR1FYlhJYY/XlurfsVRjePSKngfgwyk
         hiVg2FCYOCunmyPFn8YUzGp1ssNcN3n+Mu6flcgKozFsVCXqeyit9w4UsCtFRDAz/YYb
         EPWeNszidnyqnbYq5TXwwBhlsxYnvXNnMQtNWL62CdTD4Dhi/Tvn/x9W+5lvRogijGJw
         J3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJiLzX5jrXpmY0/hfEQmM+iw2NHLWsWyw/70eqbIg8Q=;
        b=2sDNR04vKE+8oUtp2n5+Pi92hRRQLp9pFYYoKCBbpfFK3uEhwZSa0pYTPncvPIKqxk
         tZ8KtElfwzH5bBJ9z6rhgC5x/pYXB/Gx9t5I+4v8nwbx5lXmfEc2d2THURL+EmXmXdxQ
         K2WwLk3r47Vh/dURJlw0JGUJjhKovEM1ql1s6JEYWaKwyQvosy64U/TlM0bm7jOe6J4X
         oG2PlfNgXtbpLB6GMUPaIJSrbBBdPO6qnFoTAWAkmxy438MOrmfstYmDj6X8G7GB7GxP
         jh5xPklEdEt0SE6HOIKvbtgzFeM7aUwS1067UEHMn+1S4xvtNhuENPiuVrsK+pNwFw59
         Se1A==
X-Gm-Message-State: AOAM531dSuk14n9rJKXV8oD9mkZQ6oQj1GBWpe9dM2gxwYTx5dF04dl6
        5blQtN3tqF0KdXlz9PS4ke6Tt3gLiZe9QHLo
X-Google-Smtp-Source: ABdhPJwtsEJdGLdRJKFtZsH/9Gow82GrBd9CQ0MBttYkUspyHa+tVAJA6ixJGsH2TsXFx1uWRDMb1g==
X-Received: by 2002:a05:6402:278e:: with SMTP id b14mr42328017ede.354.1637868437028;
        Thu, 25 Nov 2021 11:27:17 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-112-150-062.95.112.pool.telefonica.de. [95.112.150.62])
        by smtp.gmail.com with ESMTPSA id z22sm2938703edd.78.2021.11.25.11.27.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 11:27:16 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH XSERVER 1/2] selinux: remap security classes on policyload
Date:   Thu, 25 Nov 2021 20:27:09 +0100
Message-Id: <20211125192710.191445-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Re-map the SELinux security classes on policy loads, as the mapping will
be desynchronized (see man:selinux_set_mapping(3)) and audit messages
will not show the actual class and permission names:

    USER_AVC pid=24283 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:xorg_t:s0 msg='avc:  denied  { 0x10 } for request=XFIXES:SelectSelectionInput comm=/usr/bin/python3 resid=6400001 restype=WINDOW scontext=xuser_u:xuser_r:systemd_user_instance_generic_bin_t:s0 tcontext=xuser_u:object_r:xorg_t:s0 tclass=(null) permissive=1

In addition use type-safe assignments.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
See upstream merge request https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/801
---
 Xext/xselinux_hooks.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Xext/xselinux_hooks.c b/Xext/xselinux_hooks.c
index 57b24e452..b9d47103a 100644
--- a/Xext/xselinux_hooks.c
+++ b/Xext/xselinux_hooks.c
@@ -324,6 +324,21 @@ SELinuxLog(int type, const char *fmt, ...)
     return 0;
 }
 
+static int
+SELinuxPolicyLoad(int seqno)
+{
+    LogMessage(X_INFO, "SELinux: PolicyLoad (%d) detected, remapping security classes\n", seqno);
+
+    if (selinux_set_mapping(map) < 0) {
+        if (errno == EINVAL)
+            ErrorF("SELinux: Invalid object class mapping\n");
+        else
+            ErrorF("SELinux: Failed to set up security class mapping\n");
+    }
+
+    return 0;
+}
+
 /*
  * XACE Callbacks
  */
@@ -865,9 +880,9 @@ SELinuxFlaskInit(void)
     }
 
     /* Set up SELinux stuff */
-    selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback) SELinuxLog);
-    selinux_set_callback(SELINUX_CB_AUDIT,
-                         (union selinux_callback) SELinuxAudit);
+    selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback) { .func_log = SELinuxLog });
+    selinux_set_callback(SELINUX_CB_AUDIT, (union selinux_callback) { .func_audit = SELinuxAudit });
+    selinux_set_callback(SELINUX_CB_POLICYLOAD, (union selinux_callback) { .func_policyload = SELinuxPolicyLoad });
 
     if (selinux_set_mapping(map) < 0) {
         if (errno == EINVAL) {
-- 
2.34.0

