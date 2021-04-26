Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B50C433ED
	for <selinux@archiver.kernel.org>; Mon, 26 Apr 2021 22:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBC461152
	for <selinux@archiver.kernel.org>; Mon, 26 Apr 2021 22:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhDZWfZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Apr 2021 18:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhDZWfY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Apr 2021 18:35:24 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F1CC061574
        for <selinux@vger.kernel.org>; Mon, 26 Apr 2021 15:34:42 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 3so3311551qvp.6
        for <selinux@vger.kernel.org>; Mon, 26 Apr 2021 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tlyYjR1wcA8YSjY0zXS/bRXI+S+ww7eWi/pGVqNdlCE=;
        b=gXIg+6AglXSrsF1h0D0ifd9DmN8b6RNa0Sr9G5DxAOHmxa0ISNHugj6tIzS8I5nFqK
         upMicfEJrQikkBk9+hJUZ7lE1WEdQzWdHvwsNTe/4AeR0VPspkFn4iSA8oFqu3Twqla0
         9BQ3Xbt4O32SX203TwHhTz0Yp7Z+DtSbEHyoaB1NK5VxYj/sbNQIXm4Dz0PdHegBYAFn
         gOCs27v6bpxUEu+1lZ9erLeWWNNPG85722bhMCrqEgaHSO/diqWD1BTmGg24dt3OTma8
         xeob/0PL1v/bEtZbdoliuqaVFVCNHcE+i+u7tBbWsKeNWO7QLAhudxH9lg71roz8q8Bt
         KI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=tlyYjR1wcA8YSjY0zXS/bRXI+S+ww7eWi/pGVqNdlCE=;
        b=q3pdfoe1igxqEmMXj+toOszrCwPmE6TwWfTpdPnzRV/cA0bZHAL1RbrVMEWcqYTjI9
         V295BEMpeRUhCtHs0hCqlEPi7gHnTXTCoXZWmQH0A1Hg+YilHhxNNKbPTmkgQokD/u4i
         qdZwfu72s/W7oR+rBjy888cMf+3SZGmvfN5UF4zvp/24uCj1+7opOTh3jf4Gy5cCWkzc
         LdP7R9iK2p+iNCyvg6Wqzbqr/pIlg2qw8B/x9TgpHGxJ4qc561Q/S7mu1u+Mc2OS62Ou
         U8Nzu6Mbn5d7b2PO86tak1YD12C8XeUoR2d+sWFxgpb2Zs3Tmz2ua4FqDwGdPOKHJrlZ
         ELRA==
X-Gm-Message-State: AOAM532JOABtmPbvrFby2hadhFUWPp0yLuSgxaiaCwb0DTrci/x6iPzM
        RGfdTzwvEw85j63BHBPidiPep4ZAv7k8
X-Google-Smtp-Source: ABdhPJyyp4GUc0vtwaEBM4B7d0rSN70SvIvgHd/obSRZqijYXhq21F4eL9CQ0r/TMZvRolDwO6cHHQ==
X-Received: by 2002:a05:6214:1467:: with SMTP id c7mr20366228qvy.7.1619476481462;
        Mon, 26 Apr 2021 15:34:41 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id g16sm6157415qtv.64.2021.04.26.15.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 15:34:41 -0700 (PDT)
Subject: [PATCH] testsuite: fix cap_userns for kernels >= v5.12
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 26 Apr 2021 18:34:40 -0400
Message-ID: <161947648054.55076.7300753011213416749.stgit@olly>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Starting with Linux v5.12 CAP_SETFCAP is required to map UID 0/root.
This is due to kernel commit db2e718a4798 ("capabilities: require
CAP_SETFCAP to map uid 0").  In order to resolve this in the test
suite allow the test_cap_userns_t domain to exercise the setfcap
capability.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 policy/test_cap_userns.te |    1 +
 1 file changed, 1 insertion(+)

diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
index ab74325..052afea 100644
--- a/policy/test_cap_userns.te
+++ b/policy/test_cap_userns.te
@@ -14,6 +14,7 @@ typeattribute test_cap_userns_t capusernsdomain;
 
 # This domain is allowed sys_admin on non-init userns for mount.
 allow test_cap_userns_t self:cap_userns sys_admin;
+allow test_cap_userns_t self:capability setfcap;
 
 # Domain for process that is not allowed non-init userns capabilities
 type test_no_cap_userns_t;

