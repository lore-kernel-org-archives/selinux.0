Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341D5C001DC
	for <selinux@archiver.kernel.org>; Fri, 14 Jul 2023 18:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjGNSo2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbjGNSo0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jul 2023 14:44:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DFB1FF1
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:44:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5216754c3edso769578a12.0
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689360263; x=1691952263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXcOKJHtH1JY7H+s1D2v7FKYWGX0jLNnXa6CbbqfvmI=;
        b=UAeSE7QZcuyLUhHsgf228vbZrnilMLd5eKl8H8RzSjwoFHDFBj0lEephaZOLlz+Da3
         udA5Et8FspQwS1VBa5Y047XlBEYtl/XBQmzYbCbh+RRKCD5VK0ZtkL/xH8kJvq7GFcPQ
         gIKCDHHtjBtL8UDW/hnm8Ke4I8FqLdDFYTnj1/tpwZdX/NQCMBy/nOVnkBjNqEb8m8Fd
         EvHjrdFBbbnJjcBUZR5rq/CQX9KKhMKy1L5WYuoejLOOgcGSHUbZdYeSiCFaGlWz4Db7
         MG1AGokPm59+H3hV3CdeJPGqZj0OV5ZoAron4zhgclfKaimnwOT9POFNJ0U8k24aYzF0
         lrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360263; x=1691952263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXcOKJHtH1JY7H+s1D2v7FKYWGX0jLNnXa6CbbqfvmI=;
        b=g8UmSdZ5gqNRm27pOxYuZnqpEWtIzjtWyWc9WjClbx9I+K5IgQ+pNkrr8LMzZn5owA
         94Rztt2uy4DDfE6MIPV7eZyazllz4ga+bk7pxB9fNIYPJDF7TUvSwwWuRSFhWLrW0232
         TRCQuKA9tqP3/OqxbdUMmTwUk0Prw8hU/9mcYz07zrZcWM6nOZF9X92AVK2JBxuRKFbH
         9fgLwJ2m0F8pVySP8auMZUJfKL7TmyI4AUJHw3Eex4nCiu4XwbwRbTsf8u5NqkghUCu/
         AozICbd7RHFXndP/CV4xS68VLtC+LvlUyKmC4JZE36Iu0egdTaUyl0US4kowxQZtif/v
         r9LQ==
X-Gm-Message-State: ABy/qLYgcos6THAYMbtd5oPJhmcps9Jr1BjcZlmbsu9+u0HMbFh2vKFw
        KgYNMVEToF5uWvzpMOBugNYwDjgDH54veg==
X-Google-Smtp-Source: APBJJlHakyH1Bd3e3ph+rgeC+g/hf3AV1QgbEpcEnkKhlVbJbCNYpkDAo7qO2xzoQWbaULkf+j54+A==
X-Received: by 2002:a17:907:3e8a:b0:989:1a52:72b5 with SMTP id hs10-20020a1709073e8a00b009891a5272b5mr6045737ejc.45.1689360262970;
        Fri, 14 Jul 2023 11:44:22 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-078-050-124-229.78.50.pool.telefonica.de. [78.50.124.229])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709064d8700b00993004239a4sm5692167eju.215.2023.07.14.11.44.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:44:22 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/4] libsepol: expand: check for memory allocation failure
Date:   Fri, 14 Jul 2023 20:44:14 +0200
Message-Id: <20230714184414.40724-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714184414.40724-1-cgzones@googlemail.com>
References: <20230714184414.40724-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/expand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 2ff06cd7..5c20b806 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2954,6 +2954,10 @@ int expand_module(sepol_handle_t * handle,
 	state.out->policyvers = POLICYDB_VERSION_MAX;
 	if (state.base->name) {
 		state.out->name = strdup(state.base->name);
+		if (!state.out->name) {
+			ERR(handle, "Out of memory!");
+			goto cleanup;
+		}
 	}
 
 	/* Copy mls state from base to out */
-- 
2.40.1

