Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322D1C47257
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E9421841
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeM4+nnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgEHPmc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgEHPm3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:29 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35945C061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:29 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id k81so1972901qke.5
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLk6bzCO68v53IV0tfoA6lxReYaor204Vwv3QlArqY8=;
        b=SeM4+nnUsDdnV/K2jX9/tkouTYCfmVfuGD97kUcB87X3vsf4hW0AMqgZB/010gPp3s
         f3vN0+fsAyIZRoCpHs/z6vyh5oye9ZtSiENP/hL3SI/3zfE8SY5VOo1nFB3uKVvtirq0
         cko7haSSW0zN6S2xjWq1pDpX6yl7clu4+g2zMZ9eNyj1los+ohGijrkC3iML9NY+8xTy
         l7t0c63aiDlixFB6mWXD5B2ghFwUpJVaEXIcO2QcoXZAmkgNWm/9zGKss5yyZrFyxe2L
         Bp/bhF2xPbSPpe2N7rlnJ0H3DpkUkTn+lL52GwmNYGG8PczB9tZWxfhlPXMS+f/ukc3e
         3t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLk6bzCO68v53IV0tfoA6lxReYaor204Vwv3QlArqY8=;
        b=gbQlPmmWqY9Ep0yF8HwLXy6OTRvHpbGXNIJoJu/QA3KEqedqNkKVQ0KEVBJzfAzJsE
         VH2qqHomxYsSF1dQBXFoZnfcwuVOgXTOFn+aIEiIeGqq2rgrxdtqo7G5qPz1yAGlVSOs
         KQwLX0v2CXWSyTXDZZi/mtQ6dGZehpiBzgsJmHsPke913aYah2g4muqg8LDSloKzApz+
         SmEmkGzEkbd5bH1Yuu4ZV5oOlB5BTMN0l79757XXPjRWgrYTgtxgjtic5M4ADVM82Tyd
         LJQl0SCrotLUDvzsOpOhffD3rRn76iwYMRgxFPuUWJDL01TBUDmQ6doJaObkvWfstqwu
         sCzQ==
X-Gm-Message-State: AGi0PuaaAW58brMJ/3OIcnMfdsRIaWt02OHWRZ6VjOQk40r7zBdpahR5
        tUfBJ8Xuz328DMXnPGvTXkJtQTad
X-Google-Smtp-Source: APiQypJFzULxOr0WmYUN4F4pujW2b4VCHP6mvHIiJM3rmDD5rcDTdQHC7Ed89A6eRGYopmKiVENxYQ==
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr3236964qkf.365.1588952548184;
        Fri, 08 May 2020 08:42:28 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:27 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 13/15] tests/cap_userns: set /proc/sys/kernel/unprivileged_userns_clone if needed
Date:   Fri,  8 May 2020 11:41:36 -0400
Message-Id: <20200508154138.24217-14-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Debian does not allow unprivileged user namespace clones by default,
so update the test to enable it when running the test to avoid requiring
sys_admin permission to the capability class during the cap_userns tests.
The current test is specifically exercising the sys_admin check in the
separate cap_userns class used for capability checks against non-init
user namespaces.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/cap_userns/test | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/cap_userns/test b/tests/cap_userns/test
index 9eafba6..917da00 100755
--- a/tests/cap_userns/test
+++ b/tests/cap_userns/test
@@ -6,6 +6,10 @@ BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
+    if ( -e '/proc/sys/kernel/unprivileged_userns_clone' ) {
+        system(
+            "echo 1 > /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null");
+    }
     if ( system("$basedir/userns_child_exec -t -U > /dev/null 2>&1") == 0 ) {
         plan tests => 2;
     }
@@ -27,3 +31,7 @@ $result = system(
 "runcon -t test_no_cap_userns_t -- $basedir/userns_child_exec -p -m -U -M '0 0 1' -G '0 0 1' -- true 2>&1"
 );
 ok($result);
+
+if ( -e '/proc/sys/kernel/unprivileged_userns_clone' ) {
+    system("echo 0 > /proc/sys/kernel/unprivileged_userns_clone 2> /dev/null");
+}
-- 
2.23.1

