Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE7C433FE
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 13:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiBVNzK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiBVNzJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 08:55:09 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5E310E047
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:54:44 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vz16so43251577ejb.0
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 05:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2inaDl8WI+CFg/Q7OxRf0iskS8aLjWaAzTvoH2VWFd4=;
        b=E7aRwANleecJr3OZlZS0MX+QMGbxaPK7I0CicekZsWPcH5AJVCygbuXCGuEGpbmfTm
         +OXR86HZM9ViYIA+kDfWQDucjRp3ZDd/NOH//xqvJJAG0gvMCQYEpGM8m6Za0OFtKj06
         XizuXLC9PviADTB7nu1DuaMBr4QyeqlRuiK2nTGHdPbjChHCpU5IRgpMen1qsw/CsSxd
         B2cGcaOPOKLGNKP5giY+dWqcbxPUlf1SAqes4iuWfCx1jv8vJK8A3aiHegZ7W+HBPMBz
         pXQfLWt9wtg4on4yt/KjtAShPcVpeK+3HiGfETeZ3G3LOeyHOlxxzEAN5BjXlCpbV/da
         pOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2inaDl8WI+CFg/Q7OxRf0iskS8aLjWaAzTvoH2VWFd4=;
        b=r4uJKQfRr8Gqf53FBYQCy+FmLVDND45s2yKNSIFjORrFGs0oaGj7K//vjbhTWBcnmP
         u1L6ayOa9Sor4wAmhSMzpnaEef4SWvzLzAlrfXrhU3U6LTnoFN+CsFqOKBKTJ+2S5QuF
         F3Dn7q0cAMz9aVOoD9DYX9aJ9du555Dr7+547AB7Anzo2i4XHRvY1WlA0LaCo56bQBu9
         bqveTmuydKN/YaZmvmro61aU7XaVEZyppBSuNfgeIVd2hg2oM0qAtYHxoFYjnkZ//wrC
         QmK11s/BmE11MvVN2q6exmy9pbL4uFt57w2Lms1PDiDNJw7pTaTlTxd95B0c1yMNgEMy
         ptmA==
X-Gm-Message-State: AOAM533QOcAaaBz1yAxuVb6WI1Qqs/Ymdi3vd5xn3Q/xJ8nRA1m3JzG/
        ObquQQ7auB4ugeKDwIe8iP6oi04SH7I=
X-Google-Smtp-Source: ABdhPJy3KLeD9O/hkNuV1xpE05l3BvFzNO7Sns8CKqw6tMMuDMBePjTwESR1SgCnz8Ov5eRXuNS4KA==
X-Received: by 2002:a17:906:719a:b0:6ba:493e:3bfc with SMTP id h26-20020a170906719a00b006ba493e3bfcmr19180511ejk.16.1645538082681;
        Tue, 22 Feb 2022 05:54:42 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-065-014.77.3.pool.telefonica.de. [77.3.65.14])
        by smtp.gmail.com with ESMTPSA id l13sm4688424edr.61.2022.02.22.05.54.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:54:42 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 3/4] libsepol: export functions for policy analysis
Date:   Tue, 22 Feb 2022 14:54:34 +0100
Message-Id: <20220222135435.31216-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222135435.31216-1-cgzones@googlemail.com>
References: <20220204133507.26977-1-cgzones@googlemail.com>
 <20220222135435.31216-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Export functions needed for converting security identifiers from and to
strings and functions computing security server decisions.  These can
be used to debug or run tests on binary policies without running on a
SELinux enabled kernel.

TODO:
These functions have currently a non consistent return behavior: some
are returning -1 on failure and set errno most but not all of the time,
some return a negative errno like value.
Maybe this should be addressed before exporting them?

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/libsepol.map.in | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 0e05d606..844924fc 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -274,3 +274,18 @@ LIBSEPOL_3.0 {
 	cil_write_resolve_ast;
 	cil_set_qualified_names;
 } LIBSEPOL_1.1;
+
+LIBSEPOL_3.4 {
+  global:
+	sepol_av_perm_to_string;
+	sepol_change_sid;
+	sepol_compute_av;
+	sepol_compute_av_reason;
+	sepol_compute_av_reason_buffer;
+	sepol_context_to_sid;
+	sepol_member_sid;
+	sepol_sid_to_context;
+	sepol_string_to_av_perm;
+	sepol_string_to_security_class;
+	sepol_validate_transition_reason_buffer;
+} LIBSEPOL_3.0;
-- 
2.35.1

