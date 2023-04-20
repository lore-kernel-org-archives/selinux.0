Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E396CC77B7C
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjDTPF4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjDTPFz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:05:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CDA4C3E
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u3so6974264ejj.12
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682003152; x=1684595152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yn6I9/njhMxdU7VzCxBwfVe8IAelAP6oEreCcSg+PUE=;
        b=PdPQcZUv0pQNul7gNcPlkjwX0K/bm9xLrNzqhL/MYnS5TB4Rj0PrXJ1LyXeXep1GsO
         F0dUX9cVM5KDtRN34HgVUBxytKxciij24OG7Vp2dIykK4YoO1c58L1NAs7Vchi4/VNkL
         3xPVz3abc957ovJj+Bs+7alFaVWvIJteXOYtH3LzT3WsskmF023UMFYVTPJGLO8dpYb6
         tlAQ9MMnz7pCW7V8PQfJN0U5jGhXeWgrxFIGtGKj4V5YyH3K5MYGE18e9S87S+CMUN3B
         JqMCgEoxfB0I9S2IAs7f9HL2MrZb3h4C514U/YP+hzmRoBBYwjJCFEvaGgEYcfVgneID
         9BqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682003152; x=1684595152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yn6I9/njhMxdU7VzCxBwfVe8IAelAP6oEreCcSg+PUE=;
        b=G0KfqDaZxHYVWDvnkk480cSdMS4/LW5aeXzr/ApJiB3dEdSksJ8SrYhZlmaxxnJeIz
         L+wJPIOgPcLLvX3323AKGQuDHWd9Mg8tiKKS7v8hE3zPZMkHUTo8IXlzImEPSdz5YmAx
         9/GaGm7TX6oBd8vWFoXQO+y5q8j51FpvdA8W9owJtGrFOn55oDEBNYySmBKtseVtfnQm
         QJVWch5fFdpD6X4ZxF/Z8WUfzHoSXqUrXcaffhkt4ybBKPar4CBNWUyQhbV/2fMhaqaz
         Go2ncv24JLXvBk+i4NCea5iWp2woJkLJQbNZy3i5zMCJwA05CHu5dd0oyBOY7oYIuQ+o
         VfUQ==
X-Gm-Message-State: AAQBX9dK0T4ixOT36FtAaMW3ZcA5X8omB1rKNnAxYP+bsKCi0mMFJPs0
        uTOgi5bAD9LqtYQ/rss+dpg=
X-Google-Smtp-Source: AKy350aBYwHrDZi2XEUTLMhTf4k3AuDT2sL+HOzMlTm2U5dvv7saGU5nFsDISj2f/Ac1czhPwcv8ug==
X-Received: by 2002:a17:906:4808:b0:94f:b5c:a254 with SMTP id w8-20020a170906480800b0094f0b5ca254mr2023186ejq.49.1682003152154;
        Thu, 20 Apr 2023 08:05:52 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id jo2-20020a170906f6c200b009538cc79241sm827430ejb.56.2023.04.20.08.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:05:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: [PATCH 4/6] selinux: drop return at end of void function avc_insert()
Date:   Thu, 20 Apr 2023 17:05:01 +0200
Message-Id: <20230420150503.22227-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420150503.22227-1-cgzones@googlemail.com>
References: <20230420150503.22227-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 539813e4184a ("selinux: stop returning node from avc_insert()")
converted the return value of avc_insert() to void but left the now
unnecessary trailing return statement.

Improves: 539813e4184a ("selinux: stop returning node from avc_insert()")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/avc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 6bc65830e1a9..1074db66e5ff 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -642,7 +642,6 @@ static void avc_insert(u32 ssid, u32 tsid, u16 tclass,
 	hlist_add_head_rcu(&node->list, head);
 found:
 	spin_unlock_irqrestore(lock, flag);
-	return;
 }
 
 /**
-- 
2.40.0

