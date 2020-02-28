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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294F6C3F2CD
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A5D2469F
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR1i+U5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgB1PtQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:49:16 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50251 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgB1PtQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 10:49:16 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so1459226pjb.0
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 07:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ucs+UlypnPYhLbuEJdxhTDwfA15QUnhYt88v22w3Wk4=;
        b=JR1i+U5LWXm8ZlxVOu3hfs9rN8o/xowzDbfiayUv3H35TYF6vOXwvSEuetRsYVcqiF
         2fK5rTPwQJMRfGYyEaU/SEJ76qGfdLWCxyXOZTKT/5sk6TWaciHUO6AJ/ulCtcii/jCz
         lC3y7bDcEgUeGALzATL9oz7EuivONaA6a4iGuozmzM09HA+6ETitRubypxD+7H4/Btci
         sVQ4dKrhN+VI+HAs2facxbUVyIrFWR74tqzYXbUh9K+Szw1763gvTZKHh3ZO//GbzgCr
         LLMXG7UO3b3tYhBHBKdOF3D8VrTHQTaN1u7V3BmnjQSev+/eBhG72TjVyxEs7KMmq3ub
         iANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ucs+UlypnPYhLbuEJdxhTDwfA15QUnhYt88v22w3Wk4=;
        b=In3p2g9L3EbcV+cRXAwCRVe+PDoOLq3w4Iu8mapxTmwHAFnixni0Mw094B2iVG7BGj
         LKwzvNhhg7/Kj+se8aojN3SFUtVvnBpcKN4EK5gQMBxlUmX9rBdRCiz+9xZg0tSuMH1R
         N28R3mCov3CrABEHl3b7+5Z06fzTNXIHkSAkeNplTBn32/ajMFK9gDRPsj9CxFo0YRZ0
         eRmWZglb+VCE5jFBmzqIVAwxjyX2YPank+BGa3ARazOS6mqnnM9xhKk0c1uqwokzh/aW
         J8q1vQGJ2TKc4OvBONIXcU7sa/lX4vc0XA+llTxtzRJjHpjonNG1v7+oLo7+WQlbTi2I
         2wgg==
X-Gm-Message-State: APjAAAVFJ2FZzd8FghptuRJiu1++io/y6gdM729f9BPYsajlpEP7KyJu
        VvKms/e11P8El0I1m4lDcRIvRZUz
X-Google-Smtp-Source: APXvYqw9dJVPzmveF1lp1GuJ+vtQ4fE8Qg22zKoPPASrLGUm2Mn8Tjg4KxF1oLP/jkCQT8575SoIyw==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr4677367plo.193.1582904955188;
        Fri, 28 Feb 2020 07:49:15 -0800 (PST)
Received: from localhost.localdomain ([134.134.137.79])
        by smtp.gmail.com with ESMTPSA id w18sm12091796pfq.167.2020.02.28.07.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:49:14 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org, drepper@redhat.com, omosnace@redhat.com,
        stephen.smalley.work@gmail.com, plautrba@redhat.com
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 4/4] libselinux: drop symbols from map
Date:   Fri, 28 Feb 2020 09:48:57 -0600
Message-Id: <20200228154857.587-5-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228154857.587-1-william.c.roberts@intel.com>
References: <20200227230129.31166-1-william.c.roberts@intel.com>
 <20200228154857.587-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Previously, libselinux was exporting the following symbols:
  - dir_xattr_list;
  - map_class;
  - map_decision;
  - map_perm;
  - myprintf_compat;
  - unmap_class;
  - unmap_perm;

However, these appear to be unused and can safely be dropped.

This is done as a seperate commit to so it can easily be reverted
seperately for any reasons.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/libselinux.map | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index 73f4c072af02..2a368e93f9fd 100644
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
@@ -80,9 +79,6 @@ LIBSELINUX_1.0 {
     lsetfilecon;
     lsetfilecon_raw;
     manual_user_enter_context;
-    map_class;
-    map_decision;
-    map_perm;
     matchmediacon;
     matchpathcon;
     matchpathcon_checkmatches;
@@ -94,7 +90,6 @@ LIBSELINUX_1.0 {
     matchpathcon_init;
     matchpathcon_init_prefix;
     mode_to_security_class;
-    myprintf_compat;
     print_access_vector;
     query_user_context;
     realpath_not_final;
@@ -242,8 +237,6 @@ LIBSELINUX_1.0 {
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

