Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC58C77B61
	for <selinux@archiver.kernel.org>; Thu, 13 Apr 2023 19:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDMTe4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Apr 2023 15:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjDMTez (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Apr 2023 15:34:55 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDB46A62
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:54 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54f6fc7943eso184703017b3.3
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681414493; x=1684006493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du8qZb3Y09UKSedGq8cZEDMngsx3l3raY/byiezZIqI=;
        b=pYHEk3UlbDmUS53jCy+jZqigBO9oC5Id/WWibNp3ZbgXLq/p7UdA5cikAIiwZXUl97
         DpkZNpDXOunbIh0AfugN9EWFVRFrFRKsh4Haz6BT8WSIvkC2hSEz85Y7glrsg76x49NF
         P3LirsHwpBDjqFoSYLhm07JI+woT74bv4mcwVaY0oTj6kBy+oXPjkhnvUl0PMzhBXr+r
         EmnKA6Mg5UbOgybJlXFF3J/G7RPQBIDJYK7gK4TQPmfDoTK3AsYFnMKZqkD04fQ5RFoJ
         t6V5i0LBoacKYvNQN3gRV/H24zo8ff7wtyGJlYf4hiMc90Glmf9umSWHGOtkftJJlGXj
         HmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681414493; x=1684006493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du8qZb3Y09UKSedGq8cZEDMngsx3l3raY/byiezZIqI=;
        b=A6ta33P8AEtMqroU07qBwBTKvS/acfoCVHZcW96wXp82SUDu8N9em1y9bDZrv4TFJ1
         sFEJ1ExibuChK6I/CK6ZY4QQz4zlIlvx6IiEQz8aor91fHb0aPsIq6Tl6t2RvAPTPi6R
         HBZGyAcNTZreo5+3SPeVeueatJCgpV9+2xwzdJ8uRYdlpBoUzc4e6x1TXzvZ9F5KtrN1
         gFYtMhnjZsesxc4k2l01PjsCYG/Sp1op6IMYL/jkdcfbHedHNg8pU9+yLvBoToX4VRDF
         PSY0c+wvlyCBmNmIPBBIq4ywplY7YSwb8nyIXzxJDmh5WEdaBcQA+q5EQTaBWpbLV1fR
         FtIQ==
X-Gm-Message-State: AAQBX9c9CV06gssOqW0y7NvVnOLfhvFjkGoE/i+KAX1fwaGOiYaZ26x7
        BQ7rE/NPv5K+dzN5Fg4nwJV0Qwy6EEo=
X-Google-Smtp-Source: AKy350ZixsMYbMeFZ1Tj7YPeoe7dizl4iAZaAkzbz96CwLNG5tn69xj/hEt2loGgBu17RYsjS44xCQ==
X-Received: by 2002:a81:6d54:0:b0:54f:e2ae:21d8 with SMTP id i81-20020a816d54000000b0054fe2ae21d8mr99185ywc.28.1681414493573;
        Thu, 13 Apr 2023 12:34:53 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id 21-20020a811615000000b0054c0f46b24bsm691350yww.5.2023.04.13.12.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:34:53 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 6/9 v3] libsepol: Export the cil_write_post_ast function
Date:   Thu, 13 Apr 2023 15:34:42 -0400
Message-Id: <20230413193445.588395-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413193445.588395-1-jwcart2@gmail.com>
References: <20230413193445.588395-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/libsepol.map.in | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 844924fc..6ad68f0b 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -289,3 +289,8 @@ LIBSEPOL_3.4 {
 	sepol_string_to_security_class;
 	sepol_validate_transition_reason_buffer;
 } LIBSEPOL_3.0;
+
+LIBSEPOL_3.5 {
+  global:
+	cil_write_post_ast;
+} LIBSEPOL_3.4;
-- 
2.39.2

