Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EA7C61DA4
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 21:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjCIVv1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCIVvW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 16:51:22 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90440FC21B
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 13:51:20 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c3so3708178qtc.8
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 13:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678398679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bgDBrCaF764XDO++Hb918lQnKf1q24OKaJ+xsY1z98=;
        b=iHcQ6FrYw8OVa+z4VgVtIDVUUyCLqv2F/t4VTvptJqxm/0j55lF38xAdiFhqXH751O
         oir7r8zlyUgGVlga4HpGaj9LZndysAGD1IvxiUeCmTPYeOB77u+QHhWGA22RWTm3WGt0
         kyVa+BR/0HvxIKy5JDtcdJQuFZcI076Zkb6A3y9Mj13C/9A0U/7huy8EZ42U2a1u/Xpy
         8Z1HWP788A1nSgeFDSPXUyNNBHVdd0CghwQzo6QN36MYGK34dadmGo+Ozq+6uLkkbdKI
         V1Hmg2MUFd2FST7Xl+V1LQwlKUPo1pNGOs+Yw6cUF7ez7bgxx/Pz87/c0zSRhVTZ8LbX
         jxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bgDBrCaF764XDO++Hb918lQnKf1q24OKaJ+xsY1z98=;
        b=bfs9UU/8lghPKRDf+bIu5B5Ide9Uctg6i1lgGlwr12yACNPuc6QNh4kFyGinWZdswR
         ec+vqT9bIJKEVNJWEcsTvhvm6LtzEoW3lKMVLcd71Fh9MD0twICt4LsPdV6/G9Qfeuq7
         J1ke0sGs6TsOlwxxtgj0XlNTWQvgewwyzonQKjI+azDtgTHqtkwp/nqar7brCTZ/nUZY
         ZFlyGWnRPQbcuhPk+dIrf/YtRIR6Tj2IjAD0orIJG3a7lazsk9Js/duMb4MBcp+m6b2Z
         lFsBXq37b8io6ZwHttcEiG7HiBndQDYpWzAVMn2Y59xcF2Vpp86dbChVE15CaSQA/vFX
         i81Q==
X-Gm-Message-State: AO0yUKVXFzzEbQ0rElxXhhea5a+/btTmjOBana0PnyjS9fCoiqGhj8pb
        VpqYTR5jrT+udKZS70+K6QE7xZqcWPA=
X-Google-Smtp-Source: AK7set9rt6UCAJuRltYQ0ZKEkx1oaYQylOaQROKUHifwCJvz7IOyIAzPDg/qpYwP5TU5DhDO5TF/Tw==
X-Received: by 2002:ac8:7d89:0:b0:3b9:b4b5:4b7a with SMTP id c9-20020ac87d89000000b003b9b4b54b7amr12977457qtd.11.1678398679410;
        Thu, 09 Mar 2023 13:51:19 -0800 (PST)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b007422fa6376bsm25731qkk.77.2023.03.09.13.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:51:18 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 2/9 v2] libsepol/cil: Add cil_list_is_empty macro
Date:   Thu,  9 Mar 2023 16:51:07 -0500
Message-Id: <20230309215114.357831-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309215114.357831-1-jwcart2@gmail.com>
References: <20230309215114.357831-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a macro, called cil_list_is_empty, that returns true if the
list pointer or list head is NULL.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_list.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/cil/src/cil_list.h b/libsepol/cil/src/cil_list.h
index 6b4708a0..f974fddc 100644
--- a/libsepol/cil/src/cil_list.h
+++ b/libsepol/cil/src/cil_list.h
@@ -44,6 +44,9 @@ struct cil_list_item {
 	void *data;
 };
 
+#define cil_list_is_empty(list) \
+	((list) == NULL || (list)->head == NULL)
+
 #define cil_list_for_each(item, list) \
 	for (item = (list)->head; item != NULL; item = item->next)
 
-- 
2.39.2

