Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D559C25B07
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 01:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiHHBue (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 7 Aug 2022 21:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243248AbiHHBtq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Aug 2022 21:49:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A64186EB;
        Sun,  7 Aug 2022 18:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50BCBB80E13;
        Mon,  8 Aug 2022 01:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D98FC433C1;
        Mon,  8 Aug 2022 01:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659922654;
        bh=VJCmYCac8+0GtJU2jX1P9L9/IdytulRpy/aYEWsiEso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dinTtSQ+oI3TXu+bur5+GOYwmTrt1R/Jwt3hnTKrBkZ/bEfUvUzfSnOYDzirr2ENk
         h5jrO+9+Aay6LYdOc9AF14zRcfWofTc9v7hjEf0aTGCFZ2Uo3SkM/uDjz1OFDqyKhO
         xGbEi92GVNR4dXP9TiKdXyGRuCXwKW5Y7gWoGYeaI53b9eUvfFvpwKqHQwuh/rqqhY
         xbEG06Or/McLTM8UHGmCue/Xt4fhI4lYPQFLUV04BYuyTLd5APi0VVT+zMLW2GcIg7
         Ed7oUA9kz+XQo1URLeaF/e1kN0qlq6ToWjLMMNhQliW2knmwAeUn8QJZlBYJi10vja
         gbNYAyXYgRjEg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 43/45] selinux: Add boundary check in put_entry()
Date:   Sun,  7 Aug 2022 21:35:47 -0400
Message-Id: <20220808013551.315446-43-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808013551.315446-1-sashal@kernel.org>
References: <20220808013551.315446-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

[ Upstream commit 15ec76fb29be31df2bccb30fc09875274cba2776 ]

Just like next_entry(), boundary check is necessary to prevent memory
out-of-bound access.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/policydb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index c24d4e1063ea..ffc4e7bad205 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -370,6 +370,8 @@ static inline int put_entry(const void *buf, size_t bytes, int num, struct polic
 {
 	size_t len = bytes * num;
 
+	if (len > fp->len)
+		return -EINVAL;
 	memcpy(fp->data, buf, len);
 	fp->data += len;
 	fp->len -= len;
-- 
2.35.1

