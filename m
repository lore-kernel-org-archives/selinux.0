Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36FBC3F2D1
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B952173E
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR7LlNxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCBQlc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:41:32 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34404 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBQlc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 11:41:32 -0500
Received: by mail-pj1-f68.google.com with SMTP id f2so96584pjq.1
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ucs+UlypnPYhLbuEJdxhTDwfA15QUnhYt88v22w3Wk4=;
        b=VR7LlNxMzpBWXotxAUlFgn5L8Q8O6AsS6H104PO+6NXplF2sEDttOUmEZG0JWNXh/t
         jbKhPsMW3ED+SuZoTXT/fD3sykb+Qbm55UUoDv6KQ/yAySfpKGbZ47T/tGBjAMxZhAdZ
         mo8Pq0mIZ81fOiwKSm+PS9KZPeChUuzrVXvtJjGp03LNWD1T3FG+o3FEV+RwmJR1igK9
         XKunRlMge0ix7TCX/5TvP1lDuU5uJ5klt7t+1Z0dzajPj1CjGHT2ZLngHPkKkwLUj/6G
         2w/BOKzNxVk3VgZmHRiaFZPtUpfzt9BaF+W3RiPMuXdGYsgdGUz/ymzmV7GudeKnBnIX
         d2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ucs+UlypnPYhLbuEJdxhTDwfA15QUnhYt88v22w3Wk4=;
        b=P23xr0F0aBnjOpmIJ9TVEo4ugAIWGTlE43NSRVhfG7EPCpCDoJiBCK+IOi+T8RttP0
         uGjN7kvABZZLw9pyLl3bNZVYSGzyL1DAyy5GfhMheOouFhwUUdp7GOx2FSBZVwGwEq3k
         RfHlr1AXacnNwwCzO222Dr9kS5MOU0BA4pxUFwkAhWiSFcA+JKkbhQb7sDeGPUCmKiHO
         +x6dke4aOkjLXPp2v0ujxmgQa0efoK0sMqf01tHn5JyOIYZ8L7ta0pLj3yPAVqIRtD7u
         mk0hsT3ph+NdWkX1ZevRDZUZc/LdXgwl9+EZ1UvS0CWzK5hTtr/32Cg8aMoLx7/EXzvk
         LmWw==
X-Gm-Message-State: ANhLgQ2uCSpUYun7wFufcLfw2FMyy2e28JnsQOOubj+SiNdavllpmu+m
        ln6q4/Dm0NWmV2qIsyJLo+Q=
X-Google-Smtp-Source: ADFU+vt16DsJfvYJqb3GUltdv2yFkRo8gu2zk/x7ApYy/Dl5WTe7WuQXpqhFxxIUUHyISnLT4tHC6w==
X-Received: by 2002:a17:902:bd4c:: with SMTP id b12mr73826plx.109.1583167290418;
        Mon, 02 Mar 2020 08:41:30 -0800 (PST)
Received: from localhost.localdomain ([192.55.55.41])
        by smtp.gmail.com with ESMTPSA id o6sm23331087pfg.180.2020.03.02.08.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 08:41:29 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, drepper@redhat.com, omosnace@redhat.com,
        plautrba@redhat.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: [PATCH v4 4/4] libselinux: drop symbols from map
Date:   Mon,  2 Mar 2020 10:41:12 -0600
Message-Id: <20200302164112.10669-5-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302164112.10669-1-william.c.roberts@intel.com>
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
 <20200302164112.10669-1-william.c.roberts@intel.com>
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

