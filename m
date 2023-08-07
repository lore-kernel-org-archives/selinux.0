Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F162C001B0
	for <selinux@archiver.kernel.org>; Mon,  7 Aug 2023 18:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjHGSFZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjHGSFY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Aug 2023 14:05:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2895171E
        for <selinux@vger.kernel.org>; Mon,  7 Aug 2023 11:05:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so1020913266b.0
        for <selinux@vger.kernel.org>; Mon, 07 Aug 2023 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691431522; x=1692036322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MjxFyC2nDKUg0JoP1lWtvdts0WPcN3iQhjZYswASANg=;
        b=XY2Htg4A7jM3IsEOaZgcof+Mkx4NIaiDfHIeNSiyIzf0mbsSkvwIuPIr1ILrp8Gsce
         RrbuofPsaJMhYX8nQ9iskVlCN93jSgvAhkqbHbuiuipjo1dmzCsxhN4DSvB6L09L7lyG
         m6fP0psdZ8kAo/Gqe93hDbToB6W4OT0yDV6wRQsNBoQUhIQjqPhfi1UONcI1L/8G+YeI
         CmXcmpLsY8FEr8UNzz/AVaMU2UQgxO89st1RWX6fYrr2QyJpndrmyqL7rJ7/0Q7Ra6tP
         cEZ3zZvkqKe4YVlFBAcd4RxbQihBPN6bp8bdxOPQdGTLi2j5SIh7hNU+2W3IMovcUMBl
         i/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691431522; x=1692036322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjxFyC2nDKUg0JoP1lWtvdts0WPcN3iQhjZYswASANg=;
        b=j7P0beOi9/sekKm8BCVRIp0oRm/IR0OqshVW4zR/To6EPUw/ACs4HZOXJRoGjoxgFf
         hy0hSFVXZ3GQb8IVdSk5OFGKvQJzTv5owUsdleNxlmGgG1XREZWiEowknq8BWeAGavig
         ouFZyOrD+HKVw7I+28TrFyVlYQSKOncKEVht7O6Q5Vzmnxsx+3HjE9rQLrke14YTUAQC
         T6a0UVRvkcPz/XApJyMGaEWzOMS+VagmpAxfJ5ZnDMAx2W49kJ5vmDS/bMyU9+ENYSRp
         nAmXlqrI0P2dv1FF0LUT5pa8MMnYN+axr7WB8Ip73gH8N8FxEZsiY7d+mh0YOq+10sWA
         FBWQ==
X-Gm-Message-State: AOJu0YxcaYod8EaEGd/NWcbpHvQDInNQvhFAxFIw44x+1Vr/rvA9jxW5
        MjKxG7AYGIwj3sKzBV2O4S/J2Hosz8n5CA==
X-Google-Smtp-Source: AGHT+IEBn/lKiPO2zumUJUX3hn7S/FSdJManHxlSU5X3IW70mCWeBAdtIINGfY024bBotckWiJctvw==
X-Received: by 2002:a17:906:cc47:b0:993:d632:2c3 with SMTP id mm7-20020a170906cc4700b00993d63202c3mr8067854ejb.21.1691431522010;
        Mon, 07 Aug 2023 11:05:22 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-033-028.95.112.pool.telefonica.de. [95.112.33.28])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906284f00b00992e265495csm5466265ejc.212.2023.08.07.11.05.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:05:21 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH] selinux: use GFP_KERNEL while reading binary policy
Date:   Mon,  7 Aug 2023 20:05:18 +0200
Message-Id: <20230807180518.223481-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use GFP_KERNEL instead of GFP_ATOMIC while reading a binary policy in
sens_read() and cat_read(), similar to surrounding code.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index a424997c79eb..bb850b608dc6 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1597,7 +1597,7 @@ static int sens_read(struct policydb *p, struct symtab *s, void *fp)
 	__le32 buf[2];
 	u32 len;
 
-	levdatum = kzalloc(sizeof(*levdatum), GFP_ATOMIC);
+	levdatum = kzalloc(sizeof(*levdatum), GFP_KERNEL);
 	if (!levdatum)
 		return -ENOMEM;
 
@@ -1608,12 +1608,12 @@ static int sens_read(struct policydb *p, struct symtab *s, void *fp)
 	len = le32_to_cpu(buf[0]);
 	levdatum->isalias = le32_to_cpu(buf[1]);
 
-	rc = str_read(&key, GFP_ATOMIC, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
 	rc = -ENOMEM;
-	levdatum->level = kmalloc(sizeof(*levdatum->level), GFP_ATOMIC);
+	levdatum->level = kmalloc(sizeof(*levdatum->level), GFP_KERNEL);
 	if (!levdatum->level)
 		goto bad;
 
@@ -1638,7 +1638,7 @@ static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 	__le32 buf[3];
 	u32 len;
 
-	catdatum = kzalloc(sizeof(*catdatum), GFP_ATOMIC);
+	catdatum = kzalloc(sizeof(*catdatum), GFP_KERNEL);
 	if (!catdatum)
 		return -ENOMEM;
 
@@ -1650,7 +1650,7 @@ static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 	catdatum->value = le32_to_cpu(buf[1]);
 	catdatum->isalias = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_ATOMIC, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
-- 
2.40.1

