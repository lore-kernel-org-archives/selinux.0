Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D497C433F5
	for <selinux@archiver.kernel.org>; Sat,  4 Dec 2021 10:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhLDKi6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 4 Dec 2021 05:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbhLDKi5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 4 Dec 2021 05:38:57 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E260C061751
        for <selinux@vger.kernel.org>; Sat,  4 Dec 2021 02:35:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y12so21587069eda.12
        for <selinux@vger.kernel.org>; Sat, 04 Dec 2021 02:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QWgGrkFDgatjSy86S3rlLuRx6M4kWAYtj4lxNA8zols=;
        b=qpGDey4ljBYsT+x4bChMRgRmwTsjhFxORng2aeCDZMq72oPlbZR0GkjsTEp5vNmsnm
         g5smkrdw9CU4YHohJ3LCaY7FVM04rEDINtdyPny+m06ZmrXdx76VpMylw03iFZikn3A6
         sxSqX+zyrakj9FXuWFCyLkgVaaMKsKJQ9Jl83kmsQ9ISDxskPwiwD0a944k21ivH5oAj
         oEQxxfBNYhCh7P8tB+8mhNvcK9d7s4FPPIoX403vBWm9rgwepYiJ9cAOkmOQ/wLQ4WZ5
         nwB0DdI+LHhs2tUJAZTLscPUV+/CUcvf2JxsnKyRK6RHoNFb2CGX41aKV65AcnLhrg7d
         7e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QWgGrkFDgatjSy86S3rlLuRx6M4kWAYtj4lxNA8zols=;
        b=z76thNpayzzXNDom8rFXEH1iLFP7n76CZ5IkZRd3ts8+R59SEKuTFl3Rs6Vo+1AfD5
         awYN4fYqqcy1J9cdt3mOyf++N80qJgiOnhiBByE8RTMFZcDNGiOWLWQZqX9oZxi1kQxD
         9QytgcULx8+28sYsanzMqDgKE0FCBbcQV6kQGrlx/kStTPK1yZD3Qc3rR+0Do4VzrPVS
         LEt07CToOLc9u96K0OVZimZdT5FEJQOBqasspEqraG1I7jZg3rHUXTe+09NApadUZR8V
         /Jf9iZPX/4ilKrmq/g/k9T2Wct7+8o8JrYJluYyk8RPMvznObgXBR4MegPLRCAxZM1o1
         LlKg==
X-Gm-Message-State: AOAM533lZy5FGsXO6GD9hjdesCR2r0OSj6jiC6CzzN14r0UvYT/oYAnu
        96OpwpKgyejs1QunberRAXRPHbtN68c=
X-Google-Smtp-Source: ABdhPJz24NkQ2Zq4jO+X6uP3xfTqBX+0wTLvxYHgLLjiEISx3dAqjcPZymTSm6Sozj4oRmThJ/NRcg==
X-Received: by 2002:a05:6402:710:: with SMTP id w16mr34806956edx.218.1638614130141;
        Sat, 04 Dec 2021 02:35:30 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-006-110-042.77.6.pool.telefonica.de. [77.6.110.42])
        by smtp.gmail.com with ESMTPSA id hc16sm3192756ejc.12.2021.12.04.02.35.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:35:29 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v3 4/5] libsepol: free ebitmap on end of function
Date:   Sat,  4 Dec 2021 11:35:15 +0100
Message-Id: <20211204103516.17375-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204103516.17375-1-cgzones@googlemail.com>
References: <20211124190815.12757-1-cgzones@googlemail.com>
 <20211204103516.17375-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/assertion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index fe6b88ae..4600be41 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -460,6 +460,7 @@ oom:
 exit:
 	ebitmap_destroy(&src_matches);
 	ebitmap_destroy(&tgt_matches);
+	ebitmap_destroy(&self_matches);
 	ebitmap_destroy(&matches);
 	return ret;
 }
-- 
2.34.1

