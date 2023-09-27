Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8117EE82CB7
	for <selinux@archiver.kernel.org>; Wed, 27 Sep 2023 19:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI0TAh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjI0TAg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Sep 2023 15:00:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483B619C
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:31 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4194c3cf04aso30227621cf.3
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695841230; x=1696446030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdBnWtzoXF0YC1d6WmoTAlt+VipfjpOemZ2fPUyNttI=;
        b=e0K1Db0zasYPfJDqgOGmZIeLGaLlVU5FgJ18QHUrJScl/M3Vs+GC3WR5C2ZFt8qsG2
         O130rBdbp9tyqvxbDvHtHzJjeDNL7L6vzYMV5sRqqAVhai/WIpD/mkEhNvl9tb/pSiQC
         3FbETIEpvDhJoBFnfDr5dnDwcRLvgjgnNZGLZ7grKq+chbeQw4TBEivIARn44iPrx04A
         fE75+oHvs3QTcwjQuP0FLoAeBH1z5Fjm2XBTTaT9h6+DdpufTCyS0jQpw6JXem1wWzv7
         77MaaFlss5qC5gRGrBHnQU9/E+XEVTdtkaw1spSoHpaH3m4q3zFam31bEaySNZ6LlrEr
         U7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695841230; x=1696446030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdBnWtzoXF0YC1d6WmoTAlt+VipfjpOemZ2fPUyNttI=;
        b=Ki5GrXjpGH65RfGO9bIdFXAkyDDlYCqRf3zWn9tdo5fXne4/aCnggbVDI6+y8bC8wO
         LsZ6CmK0re1vkQBNdUjhKzzHRhIZ+fMkyCbSGsFRB7QmfYdLP5oobeLMSks4ExpQsDC/
         1/cqLgp0jfHem91tsG1uM1n+QbwwBJGo9vuiJ5GE2oW8b0MOpq0lHZ81EzD8TUP1N6j1
         zZMzLeAHrTF7wP3ao2XCj2f0/fC1G+xS2YFqHZPKb9DpiYvjh3xIwjBwpdC5rKP6E8y7
         iRGuri2/nZamdk65IdxlJEpRryx2K2O7eFejWlhU9fts8P4z9beQ7CTcOdQlXlW98nYH
         4Y7w==
X-Gm-Message-State: AOJu0Ywj31pjQ3QjUS9m0JhqwR1XZFmmyWtdQLKCLGwXDAWGw+P1i5Kq
        WtkE+6H04r0CWgbItXXjliMbqeyu7Ko=
X-Google-Smtp-Source: AGHT+IHp6nrpGA0QXhUTeHFeDiKo5f2DWlkugsO9KNRslKd4eIL9Im1NVlejEUCuiocf9SlsMDT+vg==
X-Received: by 2002:a05:622a:288:b0:410:90c7:5185 with SMTP id z8-20020a05622a028800b0041090c75185mr2956790qtw.54.1695841229877;
        Wed, 27 Sep 2023 12:00:29 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm2415167qtb.89.2023.09.27.12.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:00:29 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/9] secilc/docs: Update syntax for IP addresses and nodecon
Date:   Wed, 27 Sep 2023 15:00:16 -0400
Message-ID: <20230927190021.1164278-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927190021.1164278-1-jwcart2@gmail.com>
References: <20230927190021.1164278-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For nodecon rules, IP Addresses may be declared without a previous
declaration by enclosing them within parentheses.
Like this: (127.0.0.1) or (::1)

Allow them to also be declared by writing them directly.
Like this: 127.0.0.11 or ::1

This can be done without causing problems with the use of named
IP addresses because identifiers cannot start with a number or
contain a ":".

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/docs/cil_network_labeling_statements.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/secilc/docs/cil_network_labeling_statements.md b/secilc/docs/cil_network_labeling_statements.md
index f92e2136..fed269f9 100644
--- a/secilc/docs/cil_network_labeling_statements.md
+++ b/secilc/docs/cil_network_labeling_statements.md
@@ -10,7 +10,7 @@ Notes:
 
 -   CIL statements utilising an IP address may reference a named IP address or use an anonymous address, the examples will show each option.
 
--   IP Addresses may be declared without a previous declaration by enclosing within parentheses e.g. `(127.0.0.1)` or `(::1)`.
+-   IP Addresses may be declared without a previous declaration by either writing them directly e.g. `127.0.0.11 or `::1` or by enclosing within parentheses e.g. `(127.0.0.1)` or `(::1)`.
 
 **Statement definition:**
 
@@ -113,7 +113,7 @@ nodecon
 
 Label network address objects that represent IPv4 or IPv6 IP addresses and network masks.
 
-IP Addresses may be declared without a previous declaration by enclosing within parentheses e.g. `(127.0.0.1)` or `(::1)`.
+IP Addresses may be declared without a previous declaration by either writing them directly e.g. `127.0.0.11 or `::1` or by enclosing within parentheses e.g. `(127.0.0.1)` or `(::1)`.
 
 **Statement definition:**
 
@@ -160,7 +160,7 @@ These examples show named and anonymous [`nodecon`](cil_network_labeling_stateme
     (ipaddr ipv4_1 192.0.2.64)
 
     (nodecon ipv4_1 netmask_1 context_2)
-    (nodecon (192.0.2.64) (255.255.255.255) context_1)
+    (nodecon 192.0.2.64 255.255.255.255 context_1)
     (nodecon (192.0.2.64) netmask_1 (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
 
     (context context_3 (sys.id sys.role my48prefix.node ((s0)(s0))))
-- 
2.41.0

