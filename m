Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1F1C4332F
	for <selinux@archiver.kernel.org>; Mon, 17 Oct 2022 12:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJQMXU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJQMXT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Oct 2022 08:23:19 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251A42A40B
        for <selinux@vger.kernel.org>; Mon, 17 Oct 2022 05:22:53 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id z18so7258673qvn.6
        for <selinux@vger.kernel.org>; Mon, 17 Oct 2022 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xDF6IyuXaOP+Y6NBeMxM1SYQfC3FnHJCjUzhcZ6PO3w=;
        b=MOrv+/YWNK/yNp77Qo+Kxfz5D+Ro2aYMt5zrqTZdSiez4OAlBy/1EHU6Zi+Zn14ul9
         /OEhvkZFWImcOGP/oZoIMmNJt3Cq4zrcJr48lWj36NiUXBTg7IeTNAFbcEWHFy7J6O9+
         0lWoT+DI0J9wc39J32FTlyl7B7UUjBVh8jAP/x+zxdO/EY4wSqTAHDPeqMUZX4HTBCh6
         uCXb2mvAY9DGXOY2+ZkiAbLjvb6oIEkvE4JV1rY9usEo7Z4ZYT6Bjv3vjofAJj+w9tfo
         kZQGiGHHB/cV+8AdsqMw6P8sXNG0MZWRo1KqcAU5YSbocZzpqa1ilLo5y6LuSILjLEj/
         /+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDF6IyuXaOP+Y6NBeMxM1SYQfC3FnHJCjUzhcZ6PO3w=;
        b=wTeyat0pgHqHU9t7PsB5S2Pm7w1KwUVr9J/6fpimKy8MKYTFos+Bvv2B1AJDcAbnL0
         y8aFpHT4N2Q6GRfiH2V0NOBsGzBExPv18UhhLbTUBRoRe20l6Hf+Do4EXLmolcGmmvOA
         sXeffZf0G4p1et4VGuRueQZeXIeCja6jc6xs5BYZiFvh8UqkOh74zwiGMllfVz5YgGy9
         7XW8UknjkucVcq8LsjqVSXDdFAOAgDP7qC+ZUInsgz5B8cltWPWk+LikwPfAXFE8PVdJ
         LF5mvM4Vrdf9QRS0Ox/aaoJH08Ec4ca/BH2juW1rBHpl2EaQlwp6J9GrUhZLH0+7dRry
         2j8w==
X-Gm-Message-State: ACrzQf0XocOj/c9mb04q48s9L/urrDoPz85S5EMVvBQcryvWMnFoCyNP
        R5CS9IWkjsKPj5idekD+W2BGAV7hluI=
X-Google-Smtp-Source: AMsMyM6t1SL5F+30YFAmDnSR/E2zr9MT4YHhs7pwaMJ+FmRCaCvVJJZ7IaqBwWrofgj0G3NIBSeCrg==
X-Received: by 2002:a05:6214:e6f:b0:4b4:4e78:c0e with SMTP id jz15-20020a0562140e6f00b004b44e780c0emr8255517qvb.16.1666009322807;
        Mon, 17 Oct 2022 05:22:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id 74-20020a37084d000000b006ee7923c187sm8930076qki.42.2022.10.17.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:22:02 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     perfinion@gentoo.org, nicolas.iooss@m4x.org,
        James Carter <jwcart2@gmail.com>
Subject: [PATCH V2] docs: Add GPG fingerprints
Date:   Mon, 17 Oct 2022 08:21:51 -0400
Message-Id: <20221017122151.2837373-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For Nicolas Iooss, James Carter, and Jason Zaman.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Removed Ondrej Mosnacek's GPG fingerprint

 SECURITY.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/SECURITY.md b/SECURITY.md
index c817eac9..4f624f5d 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -26,12 +26,15 @@ the issue as quickly as possible and shorten the disclosure window.
 
 * Petr Lautrbach, plautrba@redhat.com
 * Nicolas Iooss, nicolas.iooss@m4x.org
+  *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 C5EB
 * Jeffrey Vander Stoep, jeffv@google.com
 * Joshua Brindle, brindle@gmail.com
 * James Carter, jwcart2@gmail.com
+  *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 62AE
 * Paul Moore, paul@paul-moore.com
   *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
 * Jason Zaman, perfinion@gentoo.org
+  *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
 * Steve Lawrence, slawrence@tresys.com
 * William Roberts, bill.c.roberts@gmail.com
 * Ondrej Mosnacek, omosnace@redhat.com
-- 
2.37.3

