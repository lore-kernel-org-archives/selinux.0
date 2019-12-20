Return-Path: <SRS0=yCNt=2K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6C4C43603
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 10:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A3B24680
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 10:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzAc3uSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfLTKHg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:07:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40398 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfLTKHg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Dec 2019 05:07:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so4928825pfh.7;
        Fri, 20 Dec 2019 02:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6PgYWM5KLlV9J2tK3zk6I8nnNGwI4hbAz2zL2Wrn36s=;
        b=mzAc3uScoLZwAwBmOTgWFx3Cdq1fgLMiP/eMZBb89JPZRCbQsfQbLR051CPKV1+USw
         uJUZcaqk+aFpUl2MG3sASSqslUGB1a/9J5kK5diM12XPZ6t4Pyk+AHYDCIH626wUKNEO
         yzykF3rxIBBMOJm3DXclTGMUDpzgnp1iQWZlNAwDNd9WXC3kU1VWdJcEdeZZwTUQgEzf
         Eq5zUFTq34HgBhd8FOYQeCqvGFST8jNNxoggaXx4jw51WOt8sB8+4qTxuLuWqaS2dIEg
         T2OF/D8/+1QuiMdOT35tOe/71p8vlAmujb34YXxBb1kc+cXqszYhr8awk66r+Ni59ITK
         lYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6PgYWM5KLlV9J2tK3zk6I8nnNGwI4hbAz2zL2Wrn36s=;
        b=HazFXY2QQduo1xZHErur9AnVUUnc0WX0CSRohCvehDNWRkl61HCjL74uWwMlt7ays6
         0hYBtnfI8g3HY6rsTMHZoNGIKtZRO0LkzPhuDeTAsGhw+B6HM2p9EOzCGNufZ2VAPNBJ
         EbM9kwUoVwkRhc6Huw3ZruaVoodDTgiac4jrLhxUhPp2JtAumgy7FoivhIAJ0reE7G9M
         FhmY0BGLQ/lOa7x3NdRb0c+zIXD6BA4ByhICyoUx2VRds4Ab64CXcPQ4tEI7fHED1mge
         Svvt+XiIG+RHUMB90rhHR/B0ArC6jN5fox5lfTZ4iWtDJl0Rjv/fWfXOYZ78f9vsdvlZ
         Cewg==
X-Gm-Message-State: APjAAAVDg9DXxixrwPJCxwj3Uimad0caEiiQCWQjw27JdJDZql5pxdMr
        Y0dnwQZH4OHeWKqqJabEHREtHXvn
X-Google-Smtp-Source: APXvYqzyrJiJfKc8rX8lBjjvKmrULKgmcXJij4rS1WiLYuEauayMSHOhA4KYXPWhs3IvVFAfwO5yUA==
X-Received: by 2002:aa7:9218:: with SMTP id 24mr14842974pfo.145.1576836455648;
        Fri, 20 Dec 2019 02:07:35 -0800 (PST)
Received: from ubuntu.localdomain ([118.193.245.26])
        by smtp.gmail.com with ESMTPSA id n7sm437345pjq.8.2019.12.20.02.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Dec 2019 02:07:34 -0800 (PST)
From:   hui yang <yanghui.def@gmail.com>
To:     paul@paul-moore.com
Cc:     sds@tycho.nsa.gov, eparis@parisplace.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, YangHui <yanghui.def@gmail.com>
Subject: [PATCH] netnode.c : fix sel_netnode_hash be destroyed
Date:   Fri, 20 Dec 2019 18:07:21 +0800
Message-Id: <1576836441-4140-1-git-send-email-yanghui.def@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: YangHui <yanghui.def@gmail.com>

we often find below error :
[   30.729718] Unable to handle kernel paging request at virtual address fffffffffffffffc
[   30.747478] Kernel BUG at sel_netnode_find+0x6c/0xf0 [verbose debug info unavailable]
[   30.818858] PC is at sel_netnode_find+0x6c/0xf0
[   30.824671] LR is at sel_netnode_sid+0x3c/0x248
[   30.829170] pc : [<ffffff8008428094>] lr : [<ffffff8008428154>] pstate: a0400145
[   30.833701] sp : ffffffc026f27c50
[   30.841319] x29: ffffffc026f27c50 x28: ffffffc026f27e40
[   30.849634] x27: ffffff8009132000 x26: 0000000000000000
[   30.854932] x25: ffffffc016f0aa80 x24: 0000000000000000
[   30.860224] x23: ffffffc026f27e38 x22: ffffffc026f27d34
[   30.865520] x21: 000000000000000a x20: ffffffc026f27e40
[   30.870818] x19: 000000000000000a x18: 0000007a13b48000
[   30.876118] x17: 0000007a16ca93c0 x16: ffffff8008e56b2c
[   30.881406] x15: 0000000000000020 x14: 002dc6bffa5d9e00
[   30.886701] x13: 203a644974654e4c x12: 00000000000017c1
[   30.891997] x11: 0000000000000000 x10: 0000000000000001
[   30.897292] x9 : 0000000000000002 x8 : ffffff8009933090
[   30.902588] x7 : ffffffc0725fd090 x6 : 0000000004fd9f2c
[   30.907881] x5 : 0000000000000000 x4 : 0000000000000000
[   30.913176] x3 : 00000001ffffffff x2 : 0000000000000000
[   30.918475] x1 : ffffff800a10ca80 x0 : ffffffffffffffe8
some sel_netnode_hash[idx].list==NULL,so happend this.
I add spin_lock_bh on sel_netnode_init.

Signed-off-by: YangHui <yanghui.def@gmail.com>
---
 security/selinux/netnode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 9ab84ef..aa0eeb7 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -293,11 +293,12 @@ static __init int sel_netnode_init(void)
 
 	if (!selinux_enabled)
 		return 0;
-
+	spin_lock_bh(&sel_netnode_lock);
 	for (iter = 0; iter < SEL_NETNODE_HASH_SIZE; iter++) {
 		INIT_LIST_HEAD(&sel_netnode_hash[iter].list);
 		sel_netnode_hash[iter].size = 0;
 	}
+	spin_unlock_bh(&sel_netnode_lock);
 
 	return 0;
 }
-- 
2.7.4

