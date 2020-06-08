Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5998C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 22:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB522074B
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 22:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgZEjH0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgFHWiZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgFHWiX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 18:38:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A89C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 15:38:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d66so9181992pfd.6
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 15:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=53OvRtuUyUIjTgb6rgxtOxjOhohQFM7yA+u7GrhNLuM=;
        b=pgZEjH0Cri19AsMRobapXkXgf3hrv9d6ZoCDiUK2pVuTuDFwSSCNSQXFQR8wNc4iOA
         0ZNb+10dfF3GL+OuNXnC4CmPZlIUa3tolk/YQkb+dUYEBuG0u3HA2GbU10+TjXuonpGy
         gS6KFWQ5DSqkPTnSzJPhq39iE3FFhLeO00zMR1VEtChyYAORJkqmRcJgsmRsQy8CLOFr
         z48d0JsWcZVeSESM95Lz9Ohks40y+02sP0xqetTky4LIE1Zw88UGP8bm6/2HT56X1ckr
         I6oH89h8EVJ8YbqfdmNlb6VOkFBxj1Smq/XNovQA8cO/z7q0pW0h27joNWLvqzK5eOUx
         3Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=53OvRtuUyUIjTgb6rgxtOxjOhohQFM7yA+u7GrhNLuM=;
        b=QAc9t0UyjXquhVsGb/rran/8i2ZHTa2f/ETISQq8PF//GlfS+BH8PFowQS48p6Uc2r
         NYk2vDiU1klMqHr4HPz5lGF6q0ubMQSKDObOTWuodW8GsCNvff9VghVNvDQabie6JvXl
         b8mwt8QO1PzjNoTKlUBl6mtN4YNvk7E2UdjAUuH/1t8O2Qt6sW1lJ/4v8dYA9UGVvWsb
         rDYm8MkbiWYzWHRbM+Vtl9Egn2Q1adR4IXjP1gMeOsMVNhJE0reQm8ZPn1apRQ2iDMtZ
         d60X9Rc9D/fTvz4jkcZSZQ5Ew0JO/kXNsM863AqwJiKOoBhEmt7P1Ii261k3C2mJofQh
         i0Xw==
X-Gm-Message-State: AOAM530Fk6rzAkJrwyppv4He0jodhhAUv3HOtcBIAc9vCK+ekOIPk9Ic
        U9WqxXjriuHTrKyVkCqmQP3nmFQNicg=
X-Google-Smtp-Source: ABdhPJykVzbw2ilWEjZNLhzqzCL0xafBIWTGqvUWgvuPI3vcaG4kD/kP5NrBKoqraaCwpj17JUkiEQ==
X-Received: by 2002:a63:9347:: with SMTP id w7mr21439846pgm.409.1591655902878;
        Mon, 08 Jun 2020 15:38:22 -0700 (PDT)
Received: from localhost.localdomain ([134.134.137.77])
        by smtp.gmail.com with ESMTPSA id d67sm8140066pfc.63.2020.06.08.15.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 15:38:22 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     stephen.smalley.work@gmail.com
Cc:     bigon@debian.org, bill.c.roberts@gmail.com, plautrba@redhat.com,
        selinux@vger.kernel.org, william.c.roberts@intel.com
Subject: [PATCH v3] README: start a section for documenting CFLAGS
Date:   Mon,  8 Jun 2020 17:38:16 -0500
Message-Id: <20200608223816.17039-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAEjxPJ7AtH67Gdoj6eHGJ22mXWYHWOqaRZP+Gi18aR5iJeJ5Cg@mail.gmail.com>
References: <CAEjxPJ7AtH67Gdoj6eHGJ22mXWYHWOqaRZP+Gi18aR5iJeJ5Cg@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Start a section in the README for documenting that custom CFLAGS yields
custom results and that your mileage may vary. The first CFLAG to
document that you likely want to include is -fno-semantic-interposition.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
v3:
  - lowercased CUSTOM in the commit message.
  - Updated -fsemantic-interposition to -fno-semantic-interposition in
      the commit message and README file.
v2:
  - Fixed commit message spelling of yields.
  - Reduced usages of CFLAGS in documentation.
 README.md | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/README.md b/README.md
index 9d64f0b5cf90..4d33686da1f8 100644
--- a/README.md
+++ b/README.md
@@ -120,6 +120,17 @@ lacks library functions or other dependencies relied upon by your
 distribution.  If it breaks, you get to keep both pieces.
 
 
+## Setting CFLAGS
+
+Setting CFLAGS during the make process will cause the omission of many defaults. While the project strives
+to provide a reasonable set of default flags, custom CFLAGS could break the build, or have other undesired
+changes on the build output. Thus, be very careful when setting CFLAGS. CFLAGS that are encouraged to be
+set when overriding are:
+
+- -fno-semantic-interposition for gcc or compilers that do not do this. clang does this by default. clang-10 and up
+   will support passing this flag, but ignore it. Previous clang versions fail.
+
+
 macOS
 -----
 
-- 
2.17.1

