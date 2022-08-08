Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E3DC25B07
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 01:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbiHHBoX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 7 Aug 2022 21:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbiHHBmU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Aug 2022 21:42:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A9EDEE0;
        Sun,  7 Aug 2022 18:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34EE460C94;
        Mon,  8 Aug 2022 01:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFCEC433C1;
        Mon,  8 Aug 2022 01:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659922544;
        bh=VJCmYCac8+0GtJU2jX1P9L9/IdytulRpy/aYEWsiEso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f23v+CuXZ50ESLvcIvvUpXV4dGfgAwT2af0X0GoJM3b3PSFM4XktI3Mhf26SvffgM
         KhjYcwzBC9KrYwnBhgQ9EkPT9lv1140sybEe5FEk2tsgPHXnHTyMvyWD54SoB0cIj8
         3ZkRKOkEi6ULei2WexqU9rShGSo9mHedt+CWp3ovb4X7b6QWia7bo9Go76umIOmJyE
         YkIFBK0KCV5QBAVusK7K32ltUa/LoLPfH/Ie/PHRKnpWaXV1CL8dlCxOchReKq9+2k
         MycJey0G6qI7PIybhl/vnbEhdA5VU5Sxs9hAtzFSkhh+VqX00MeYRuZRMbER3wSR7L
         LSm0R3vpbHhXw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 51/53] selinux: Add boundary check in put_entry()
Date:   Sun,  7 Aug 2022 21:33:46 -0400
Message-Id: <20220808013350.314757-51-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808013350.314757-1-sashal@kernel.org>
References: <20220808013350.314757-1-sashal@kernel.org>
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

