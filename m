Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AC7C3F2D3
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 14:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1DE20665
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 14:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJ5CSau1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgB1OFz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:05:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45203 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB1OFy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 09:05:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id m15so1567478pgv.12
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 06:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d/Y46bzG5ztycq5iaWklqHBnLpUI47q++hNS8tSCU58=;
        b=rJ5CSau15fBX/sPGo0kVKZjBTjkL5kKmmYkkpNUO/aThaTtRtVJJQS4pAbxFrcOCod
         S7NFP9mTzP4VpHmgnRHvb0r0s1UaBoDfV7sXfx3meMJBucyyaYlhjuqVG9ZLXu9SQVYV
         STMbFwCm3zrj/knL2z+EGDMKa2VuMrsvtJZYwvjulH5bV5eLcJQtLM0edoHK/RjQHC5C
         fw2jWCcZx1QVzAzjMRpW93Us8UARUcw3PfZCwxhZ5MLx/R4XBxzAhmTbjO3weJYCa8jx
         uMD2sdXSW1CZdSYt1c5beA80QT+1wZrXOozPThbsh4+rOF0HKsP6PX5EF4n61OO8aI1X
         B/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d/Y46bzG5ztycq5iaWklqHBnLpUI47q++hNS8tSCU58=;
        b=TUjdr9VrOOdbSKBJzh2J0QJTzTJVh2+nOEqUcHYCgeqECPZoSV50YOpX90deH2xjWZ
         qzmQGd4vYZWs4G9UI/UGJx8X3Yzk49JJDU6S8T9K97EdsaK2r7bKzFhhyHksUyVIXPyr
         Jxva95HO7xa/1kTab8fXBZqioOxye/Mljem8yk7ZGrevp8jW1o+9mIkz/b8cgbI4Ukbn
         41fPviKnkEF7D95TKYcCTalPvWyJBRK0fv+c7k7np4WbUI/u3TytWSlSlZx/ofO6zA7u
         BJz/8/AMwzu0p7WGLaQ01J8yvAH93A/u7zTGeiHWLat3XN55DyYjAk2jNg8qTazg69P/
         ooNw==
X-Gm-Message-State: APjAAAWHIaCvt+Sm9xKjIYIM1iry8s+CWbImRzabER9pXdBV7TyGV/dn
        FO7oE9Ad6UGPiPfSedGwnhPEUzX6
X-Google-Smtp-Source: APXvYqxAi6extAIv9dOY+LYMbxUEOAWI3eEmqtN8C/KEFqz2tePUWH/uRxrS7NUJ49/wj1CIS71ZZQ==
X-Received: by 2002:a65:65c8:: with SMTP id y8mr4699262pgv.36.1582898753128;
        Fri, 28 Feb 2020 06:05:53 -0800 (PST)
Received: from localhost.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id t11sm2656903pjo.21.2020.02.28.06.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 06:05:52 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org, drepper@redhat.com, omosnace@redhat.com,
        stephen.smalley.work@gmail.com, plautrba@redhat.com
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 4/4] libselinux: drop symbols from map
Date:   Fri, 28 Feb 2020 08:05:24 -0600
Message-Id: <20200228140524.2404-5-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228140524.2404-1-william.c.roberts@intel.com>
References: <CAEjxPJ4ae=FLqEDofLwSP0PEeqUqh1WtoSVFb9TrafMhawfhPg@mail.gmail.com>
 <20200228140524.2404-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Previously, libselinux was exporting the following symbols:
  - dir_xattr_list;
  - myprintf_compat;
  - unmap_class;
  - unmap_perm;

However, these appear to be unused and can safely be dropped.

This is done as a seperate commit to so it can easily be reverted
seperately for any reasons.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/libselinux.map | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index 73f4c072af02..31342ca6b58a 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -37,7 +37,6 @@ LIBSELINUX_1.0 {
     context_type_set;
     context_user_get;
     context_user_set;
-    dir_xattr_list;
     fgetfilecon;
     fgetfilecon_raw;
     fini_selinuxmnt;
@@ -94,7 +93,6 @@ LIBSELINUX_1.0 {
     matchpathcon_init;
     matchpathcon_init_prefix;
     mode_to_security_class;
-    myprintf_compat;
     print_access_vector;
     query_user_context;
     realpath_not_final;
@@ -242,8 +240,6 @@ LIBSELINUX_1.0 {
     sidput;
     string_to_av_perm;
     string_to_security_class;
-    unmap_class;
-    unmap_perm;
   local:
     *;
 };
-- 
2.17.1

