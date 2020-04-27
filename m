Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BDAC54EEB
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C219206E2
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ/Ua8tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgD0UX2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgD0UX2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E9C0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so8320389pfv.8
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hj+i+tMN050sCBe+IQticD3qraeN9Ogi50YT5Ooklvk=;
        b=eZ/Ua8tM1cqommL7CE6RVu/5VNghlWDhJh49CJBi6kgu4TDvAIIMvcqP6dH2VSp3bn
         /wIQ70tF3jqKmkTfLI/uuX+XOFonQKvWT919h8lMZMEa5cDi2xvhR9PPNNHrMmbAjKDj
         8WOdCmvtgzqsI3OuoN09wfMwbEV2nD/04FZjVYhWx3PwcSQQ5p6v1tThVPNIOVNWsMaC
         GuUqP6agI8cPHJadQEUL2hV7iskYyqV+y8zAz4BZOqLNK4+6vkltw59Cn4GEgferoMHB
         g/ZGQn7BJqasgklgYBVocjt2WGsUFhVPNIIwdbHEPOxQ5lk+4TCaA+DcPUfenp6qTWwM
         AZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hj+i+tMN050sCBe+IQticD3qraeN9Ogi50YT5Ooklvk=;
        b=HXFaWuqp/lAR+4U+FAh5L05srOtDctn0Nn1aZ2FUbmyXHeWeWzPSXQuRNtw0/kedqR
         XZXrQX+GvxPPqMs1d3GLBqlZKTWYCdFggcjAcOaR7SG9AcBLV5degiUDu/qEZBlnDoBv
         48mzYp4ndIWv5swLiUKRGVCIIhrsWSUdf4RGt91YsTMTbV1HstHiGjNE4AJaL+CTGf1Y
         TwrmjrxobBAKNCOrsoaEz2FrZiCfANNLEzv2iJWzmrl22KgYhALRndW6QrNMH86s+qFi
         d0OQ2IAsqIWEGqFschrrteJZR/lP/+uPVDhFutXhoJoMMFcxmFmZxg3sdk5LyW3Sg5YF
         qWvg==
X-Gm-Message-State: AGi0PuZ01FH+bQcE6Aly2KMAiLRl9LKiyBS7AaLZLwX7scEeDKYwRQBU
        QcqnNjKgTyxw17LEJKIIzxc=
X-Google-Smtp-Source: APiQypI/8u1v+qs0TLRkPF8TjIYmRmgcVJ5Yt4sacJxyfyF3KNOYgg46IgANW0fQijTF83t+kn4q0A==
X-Received: by 2002:a63:383:: with SMTP id 125mr24311655pgd.242.1588019007435;
        Mon, 27 Apr 2020 13:23:27 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:27 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 04/18] selinux_users_path: annotate deprecated
Date:   Mon, 27 Apr 2020 15:23:01 -0500
Message-Id: <20200427202315.4943-5-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 19b22c166651..75f65e367bf4 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -586,7 +586,11 @@ __attribute__ ((deprecated))
 ;
 extern const char *selinux_customizable_types_path(void);
 /* Deprecated as policy ./users no longer supported. */
-extern const char *selinux_users_path(void);
+extern const char *selinux_users_path(void)
+#ifdef __GNUC__
+__attribute__ ((deprecated))
+#endif
+;
 extern const char *selinux_usersconf_path(void);
 extern const char *selinux_translations_path(void);
 extern const char *selinux_colors_path(void);
-- 
2.17.1

