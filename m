Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85781C433DB
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 21:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37FC964FC0
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 21:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhCIVg5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhCIVgp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 16:36:45 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587DC06174A
        for <selinux@vger.kernel.org>; Tue,  9 Mar 2021 13:36:45 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id t4so14760411qkp.1
        for <selinux@vger.kernel.org>; Tue, 09 Mar 2021 13:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZTQqbtWvntHE1ADi9XGpSDv+hISDb6k9KJVDjQ+nBdQ=;
        b=X+5VXw2fnOouQJ5mPaZ4m2Kc7jqPaz7w1i5eAffeXV6qyPRWAKm+atNoipJRjKjS+W
         OE2ngLs4pK+gN1uckBvNeJRaZMb+R8Z7hsIOC8rTjYtTH6TWEgG9+ltzHoC3KuwfGiTA
         JenBAOBFgOAsV28bLW94/Czh/AEl1WvMltoYRCnK3R6zgVsrhPlK8l0KH4pQalzkrtuo
         ZAVvq2ZXdCQqYrPoLVosEs1CS8tPYVAuGKo+6o10Mu/TNN6ySKA8rX12hb0nDhZbj3mu
         whBVVCdmkS7NnQhWkIp8SeOkIKnSAjS0kGiG/UJQ1dxqCs4u4Jl6mC7DUeesy/KvQeCb
         N+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZTQqbtWvntHE1ADi9XGpSDv+hISDb6k9KJVDjQ+nBdQ=;
        b=q3Q9LYZW5mI9UcWx+vVCYtGnb20PyZ7DqOusxo7k4nVmzxiyVK44Ah2ZYDu95WGEUJ
         0rF8YcOq4au6Ffs5jGH9RJKGylR4FeajdZS29WbLtyevmVLKgJ3bTg/841nT18Y/v1TQ
         SyLqxeJllOxIFJnK/EjF3BOqvofoY1swIOoFezZ0d32RK/nSIYtosctSo9FwexXdzV9p
         OtMR300N/k2mTq63W6CH4N1Hs8HrvBOf/z3CLsSCpL2b0VPXdYWDDGC5nfa0bP3K9Ih4
         cQl2UkwF9iVGk/0tMN80LGUjWAWZETUS52rkxAldZOf01JobCObgnbVdfbG46o7Z+KNN
         Pcog==
X-Gm-Message-State: AOAM533tLCFri21WQEVXelh1lFB5cTtwuyuKvK8QHUKyBLd5uwwyMFpu
        ysKwzzVeQDV4nF1VihiIAgt205NKHf0=
X-Google-Smtp-Source: ABdhPJyXPyvOwysoKd2wrFEHFRXJta6XnSLkFyqPrRnmjOC8Fv3kkUk2VkUAMg82feseIaozDoCdsg==
X-Received: by 2002:a37:ba03:: with SMTP id k3mr27327064qkf.336.1615325804171;
        Tue, 09 Mar 2021 13:36:44 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m3sm1672293qkk.15.2021.03.09.13.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:36:43 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Properly handle types associated to role attributes
Date:   Tue,  9 Mar 2021 16:36:40 -0500
Message-Id: <20210309213640.120117-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Types associated to role attributes in optional blocks are not
associated with the roles that have that attribute. The problem
is that role_fix_callback is called before the avrule_decls are
walked.

Example/
  class CLASS1
  sid kernel
  class CLASS1 { PERM1 }
  type TYPE1;
  type TYPE1A;
  allow TYPE1 self : CLASS1 PERM1;
  attribute_role ROLE_ATTR1A;
  role ROLE1;
  role ROLE1A;
  roleattribute ROLE1A ROLE_ATTR1A;
  role ROLE1 types TYPE1;
  optional {
    require {
      class CLASS1 PERM1;
    }
    role ROLE_ATTR1A types TYPE1A;
  }
  user USER1 roles ROLE1;
  sid kernel USER1:ROLE1:TYPE1

In this example ROLE1A will not have TYPE1A associated to it.

Call role_fix_callback() after the avrule_decls are walked.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index eac7e450..1ee3e48f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -3017,10 +3017,6 @@ int expand_module(sepol_handle_t * handle,
 	if (hashtab_map(state.base->p_roles.table,
 			role_bounds_copy_callback, &state))
 		goto cleanup;
-	/* escalate the type_set_t in a role attribute to all regular roles
-	 * that belongs to it. */
-	if (hashtab_map(state.base->p_roles.table, role_fix_callback, &state))
-		goto cleanup;
 
 	/* copy MLS's sensitivity level and categories - this needs to be done
 	 * before expanding users (they need to be indexed too) */
@@ -3086,6 +3082,11 @@ int expand_module(sepol_handle_t * handle,
 		goto cleanup;
 	}
 
+	/* escalate the type_set_t in a role attribute to all regular roles
+	 * that belongs to it. */
+	if (hashtab_map(state.base->p_roles.table, role_fix_callback, &state))
+		goto cleanup;
+
 	if (copy_and_expand_avrule_block(&state) < 0) {
 		ERR(handle, "Error during expand");
 		goto cleanup;
-- 
2.26.2

