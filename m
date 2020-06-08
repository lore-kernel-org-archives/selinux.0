Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2A1C433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 00:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3042072F
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 00:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661259;
	bh=6pPFugxbQhag+Gcg3s4zYYrpngAtaHNVwPKm2oVb/40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sC7PEMyM6NLX1/O1x10gJ7i09kdvXsJBKIY6JhFwOM5dRXeiZ0JxGjefb5sUXDqEO
	 +H56t3QpuWx6/1+B7piNP+oReVO0AnNbKMhoHv1swxPQHRtqQldagl2/YppUPoRWrZ
	 yYoEdBJat9d9eKlc6WYWapiU8RfcPb6IpLRWBFg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgFHXUx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbgFHXUw (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526952072F;
        Mon,  8 Jun 2020 23:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658452;
        bh=6pPFugxbQhag+Gcg3s4zYYrpngAtaHNVwPKm2oVb/40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcCjXA2oEDW75iP/lnP8Gjlvgb5LoIIS5YVB2tSWlxLYNf+UbMf4AbwTIYKxFkrZK
         xGIDaUFqdTJgdIA8M2WcLvazZqZLwOC0O5IqCLGVA++oCPlztmQXBxv/Y+faxoiAof
         hWl7Iijc6/AWp+ovZjpjkeNgKVdUWIBHrDJAefg8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, selinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 093/175] selinux: fix error return code in policydb_read()
Date:   Mon,  8 Jun 2020 19:17:26 -0400
Message-Id: <20200608231848.3366970-93-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 4c09f8b6913a779ca0c70ea8058bf21537eebb3b ]

Fix to return negative error code -ENOMEM from the kvcalloc() error
handling case instead of 0, as done elsewhere in this function.

Fixes: acdf52d97f82 ("selinux: convert to kvmalloc")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/policydb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 1260f5fb766e..dd7aabd94a92 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2496,6 +2496,7 @@ int policydb_read(struct policydb *p, void *fp)
 	if (rc)
 		goto bad;
 
+	rc = -ENOMEM;
 	p->type_attr_map_array = kvcalloc(p->p_types.nprim,
 					  sizeof(*p->type_attr_map_array),
 					  GFP_KERNEL);
-- 
2.25.1

