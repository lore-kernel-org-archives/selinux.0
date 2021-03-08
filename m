Return-Path: <SRS0=egAL=IG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9787C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Mar 2021 11:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19D0651C9
	for <selinux@archiver.kernel.org>; Mon,  8 Mar 2021 11:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhCHLUL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Mar 2021 06:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhCHLTq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Mar 2021 06:19:46 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B6C06174A;
        Mon,  8 Mar 2021 03:19:46 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id a188so6970810pfb.4;
        Mon, 08 Mar 2021 03:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QXafaz860vZHBHuJqEnkqblU6EnLSJb2Ehubz6QWDrQ=;
        b=Y9PmCOTCxxCYAX3cGr/tbsv5rsXNfU7tuAJrKXtmtOD/bSaHsawKV4tpy9vJgNGicJ
         ZCK3gIxLiXJiNStUT9xxSWe83Y2BUeaW+7r6k4FMmo88GLK5Fmvs893u/qMWYtFrX5RV
         lEQui5CVldXUaF62hzjU3kQQ552CxNfjEMQG3gQ0RWqAkdqReViawyrtbcSyLgBCiAaH
         Wr/hHeikpFZuym2YkN2JFe9etaT5E1pWBs2wWdY9W7J+Cq/jnkiV5NLcOWOgxzyX5N4L
         U8iI1wbZBxjxPlkJxQHjngSc9uBweICop+5+G3h/+6wchTR12qvCcYn438MV0v1XufDN
         6X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QXafaz860vZHBHuJqEnkqblU6EnLSJb2Ehubz6QWDrQ=;
        b=D8YyrhBSnIc55WTjCQxSphyQXympr7uauNgc3S7AqRCedU2S+Z/HNzWcQd/jstSjJ0
         kYdw1ymDt7gBdDvhNf4NF9E7RY6pomYMo+8QpHL6UrMMK8z3/31ztEuyCxW7w6jL0wn0
         5gaKKkdCGAcorcnGOgt9iE9yT0ulmHXUkO3xb87hZvhUSsEBxwzZie1+O7DJ1S7zfzri
         lxNKpWe4QQUXV8+5YUYe2U4r61xNioNWcotnA+P9uD3O1flCDoMRyGQqpiFJqKUdSDkS
         WzzqYePQUqla46FbpodWNmkkTcwkrDeHi/fg51tUMxWX3wvVhMJD9Hz2a1yScF2Wn5qq
         +ChQ==
X-Gm-Message-State: AOAM531HE43iMlISBsByHj8DSJeekzxnXDDCe804sB1isVPB/rN5Ttwj
        Omgs4oBorLvp7CI2LhGsnJ0=
X-Google-Smtp-Source: ABdhPJx1VYk8ZbupgprPeIewnbMD11y7ooEo+2SaiZbs+mGK9YxmStLlFYkudlyZ1FWN9yjd2ZHT+g==
X-Received: by 2002:a63:f648:: with SMTP id u8mr19579765pgj.270.1615202385930;
        Mon, 08 Mar 2021 03:19:45 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id p184sm9813872pgp.13.2021.03.08.03.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 03:19:45 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: xiong.zhenwu@zte.com.cn
To:     paul@paul-moore.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, nramas@linux.microsoft.com,
        tyhicks@linux.microsoft.com, xiong.zhenwu@zte.com.cn,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security/selinux/include/: fix misspellings using codespell tool
Date:   Mon,  8 Mar 2021 03:19:39 -0800
Message-Id: <20210308111939.261079-1-xiong.zhenwu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>

A typo is f out by codespell tool in 422th line of security.h:

$ codespell ./security/selinux/include/ 
./security.h:422: thie  ==> the, this

Fix a typo found by codespell.

Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
---
 security/selinux/include/security.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 6fe25300b89d..7130c9648ad1 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -419,7 +419,7 @@ extern struct page *selinux_kernel_status_page(struct selinux_state *state);
 
 #define SELINUX_KERNEL_STATUS_VERSION	1
 struct selinux_kernel_status {
-	u32	version;	/* version number of thie structure */
+	u32	version;	/* version number of the structure */
 	u32	sequence;	/* sequence number of seqlock logic */
 	u32	enforcing;	/* current setting of enforcing mode */
 	u32	policyload;	/* times of policy reloaded */
-- 
2.25.1

