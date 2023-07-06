Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597B6EB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 13:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjGFNYp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjGFNYS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 09:24:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256E41BD2;
        Thu,  6 Jul 2023 06:24:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso10557661fa.1;
        Thu, 06 Jul 2023 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649842; x=1691241842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TT7ciLyG4XLP2FDxdoJcpM/orayGJKZgxrCVbgJsD4I=;
        b=Rczw5F5JKo/dyfkxPmv4W3mIrU152v6CC5K1Bte/H+WvrKIlDnswnvCHB1FfOyN25q
         uD/9ib9uoPN0+LbqY2Iegrepy/x+8JKDfhFjYLZ+EuIEDJOr8SrzRtuxQ7Hy7M6GrPVS
         pIhNsIu6mfe39MDdiez3ILlTKuQ6+oGL/GKOWlz+emkgQ6HEbnEOXCaln6q2Hm55JmXb
         EpmhVCN4yyVHdFH1R3lsL4w7NKoG0eeLpcL35Sbb4v539g1TYrbgF/1+qyuQmUMivKvJ
         ZlmoGWW4ytgpeoIcQllzTXOqsmd1mf74DywbctEMfmrS9ThvtxDiwk7AHi7+forbsiJU
         dx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649842; x=1691241842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT7ciLyG4XLP2FDxdoJcpM/orayGJKZgxrCVbgJsD4I=;
        b=ByzMMnfQ4nitwdXj2XYmeQFwQUJT2n+IyeZbumGb5pVN9E+UQll4LOvEUoFuohyuu5
         GixrOiJF/BVP3+19xOEF00WQhoKZ0344yX3jN9jq54Aj5Gr+euhRj/HFg/gIardFaglk
         K9XNtkuBmOSxSYEP7fpRpuGjk6SMnE3Xlrye006x/4o9HfbEwHZ+Y+BIIUSr6R+1O3i6
         Thl6LKp4DruGn7OjnlEQqZUVdWSzqnz8OFIjv4HxZ5s/bbg4dP1jDlq7JgY9amW+Z5Jb
         ZrVsAW14IsNP6vK+VBBsCidNmEQ8miJmUcAIjQd5OBpxMIX1Mr/Sttnbn+SKWbFVuDzU
         0t+A==
X-Gm-Message-State: ABy/qLaOtQqpkTzOuKlSeEDimaP9PvlTk+jYzDqlqU8TsEPTXVoucqTO
        CX8ZrFDNgC0Uz/H3TWaSi372XBN7R6VlRVUP
X-Google-Smtp-Source: APBJJlGD+mN/egbEhVFe2WWSkW2qA3GDDP7muMeYVIY7DIE1PJGSNtxVeYrHn2iLEAGh9epVT2v/eg==
X-Received: by 2002:a2e:6e19:0:b0:2b6:f009:d1b with SMTP id j25-20020a2e6e19000000b002b6f0090d1bmr1445409ljc.49.1688649841370;
        Thu, 06 Jul 2023 06:24:01 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:24:01 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 17/20] selinux: services: implicit conversions
Date:   Thu,  6 Jul 2023 15:23:32 +0200
Message-Id: <20230706132337.15924-17-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
References: <20230706132337.15924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the type identical to the source for local variables.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/services.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 823b000381a4..e2cd6d7ea7cc 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -856,7 +856,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 	struct sidtab *sidtab;
 	struct sidtab_entry *old_entry, *new_entry;
 	struct type_datum *type;
-	int index;
+	u32 index;
 	int rc;
 
 	if (!selinux_initialized())
@@ -1511,9 +1511,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 		return -ENOMEM;
 
 	if (!selinux_initialized()) {
-		int i;
-
-		for (i = 1; i < SECINITSID_NUM; i++) {
+		for (u32 i = 1; i < SECINITSID_NUM; i++) {
 			const char *s = initial_sid_to_string[i];
 
 			if (s && !strcmp(s, scontext2)) {
-- 
2.40.1

