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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2015AC47257
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019A124955
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhzSVLZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEHPm0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgEHPmX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:23 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B548C05BD43
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:23 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 23so961239qkf.0
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RG54SSvG29zCrzlGVFlIi3+AD666jCT33pG0JJWSBts=;
        b=OhzSVLZm9C0CjBhYnBlyWueKQh2pMMv8ZSn27x1UgogVTFknZWUfG0lFq6IAPZq4qg
         6iVM7WvQOEk5clTEHieV7e7EzkkYKdK7kmMZkNxScQceeUp49cbZ7wujuG+BYwhhuhH8
         V123ZCzdsoyTIsJrquc2pwFkHNf0M4KBTONyxG9f+0BRIS4mDLOO4KjZUqnLBlbZkN1r
         Kk05fry2rT6PuOpBCr3+C9itcxe0MdraRmNbm1kYNnXd7OULiygO/ffWEwGBPuFcI0Hd
         ZyhkZWXHwpGVgY03WlTHr+vvM0z3wVCGh0703oY59QCZqVPmXyKM+lhi+WccH5sdYCPD
         x6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RG54SSvG29zCrzlGVFlIi3+AD666jCT33pG0JJWSBts=;
        b=sKxJrY01Ueg3WYUuksFqAYnqsQxGqMe0vVYTmY6a3lZbIVT2p1uwSesNcR07u5+Hlb
         hstnkN0M3peWW+N6hX0DcOP3rvnWLEP7CKYXy/5GiwfS4AXCiidVhvECsZGgFQ3gWMRD
         mb4x2DtnzXzBXBXxXNEQvLQVdmmiMjrQtKTtbu6Cp9Gar4ZGvJucM09ZKRMQBh1cThr5
         WMViehCSEq+CPSX9ukRLF8NHLhRrurDHTI6O0HTPNG50U+DK5My+krfWjColHT/UpGo5
         2flwBIhDUD54vh50RWX5E8ZcO3eYknVB7qO/Wr0UexM+ABQs28lPWCnEuej6nMdX/OOu
         jckw==
X-Gm-Message-State: AGi0PuYzidWLc9ofTJ+fGvk7PwecaDprTmZRyQlZ8LiY4kEuiSGYeXFc
        B3aemXbbk8ws/3z09djfIG4bk9hU
X-Google-Smtp-Source: APiQypLhq+f6egSzWvPkdQ/JrRAHzfVp1e9CMbn+QVCL9sxYUAzawXbKPraeGPKRPsQdx18Zdh2WcQ==
X-Received: by 2002:a37:d287:: with SMTP id f129mr3377534qkj.52.1588952540609;
        Fri, 08 May 2020 08:42:20 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:20 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 04/15] test_global.te: allow test domains to statfs selinuxfs
Date:   Fri,  8 May 2020 11:41:27 -0400
Message-Id: <20200508154138.24217-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

libselinux probes for the presence of selinuxfs on /sys/fs/selinux
via statfs(2); this is required for any operations that involve selinuxfs.
Fedora policy allows this to all domains in its base policy but refpolicy
and Debian do not, so explicitly allow it to allow the tests to work.
Otherwise various programs think SELinux is disabled and abort.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_global.te | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policy/test_global.te b/policy/test_global.te
index c9520ec..d19b4be 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -83,6 +83,7 @@ domain_use_interactive_fds(testdomain)
 seutil_read_config(testdomain)
 
 # can getsecurity
+selinux_getattr_fs(testdomain)
 selinux_validate_context(testdomain)
 selinux_compute_access_vector(testdomain)
 selinux_compute_create_context(testdomain)
-- 
2.23.1

