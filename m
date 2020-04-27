Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8E9C4CECC
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5EED206E2
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN/88/eV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgD0UXx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbgD0UXw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5296EC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r4so9191135pgg.4
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qo/M9ma8hAwhDuNMFiAuZ2jdy9oV5PDzurKa+6UdQu8=;
        b=fN/88/eVLfNxt9P8Hpq2TmaqZWV96IZ9a8xriQR4qF7RyQFgZuNoEpyyuLIWRLqBp/
         5uiMTjMwfsjr6xgGEpn93mOI1CWcEpZdpIsn2IOcMyaN4jUbxDu9KQTbp+7Ps2RYHuK5
         uHzAHRVrWMvPzqZ72Z52EMAlLnpbarbS0aSqUItK3Lb2oXK3qlAsmGU+bNnFLp8rRK2z
         FI4B58fAXnJoRfL654cA5WD7oHz6s/hQLUAVGf1HYDBJBQfX9ZSgOoYPU5CEhhdHTmJA
         XTg/JA2s+5FBHizOHX6UG2fBeJhCTaUIv8HMzeLGH0aqj/v+N4QF7jkujJP8Ifjkp9K4
         LopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qo/M9ma8hAwhDuNMFiAuZ2jdy9oV5PDzurKa+6UdQu8=;
        b=Uuw94ZHX5MlmP2ioI/IctRObneee8MOSpaEmc/WYJrVDnJagIijNs2fPSAyJVH0j7o
         TbD8Q2NgEoyvavpObpG22Iy2qf6Mio1in5L+CWksn3NNiwiJKcyK3nwdzbEPDZw91hLH
         ZbcR2O7ywQxR9tO3QP/Md3/4lFhrhIQt93eLWZSv+M3Mn1NrV2dC/ToQxWz72d6sbT6N
         3UaZ8QeDRNPDofQWQHlcft/hqH9Izy3617ipdcniAZZHpuHCX8iTN5CFz3cPNPcb6N5x
         QHsSUQ06w0eVkUsoDWJZ8E3178x683DegflABStgCXh1zxOu5bfTSTYzX/oFzGBIQvKn
         DV5g==
X-Gm-Message-State: AGi0Puaxa6VBB6ESLEmOHENXZdxGgsToyVjo64YvH3JsXwec/akVB2P7
        YI4v8hNOD0YNYMymB4UXwrQ=
X-Google-Smtp-Source: APiQypKUepUI6LtlZuWNh+471rNXZ8BYm066Cg5endivb5o90ehljGYMDGuaFPG5fTfeGv09yUXN7w==
X-Received: by 2002:a63:f50a:: with SMTP id w10mr23819002pgh.181.1588019031732;
        Mon, 27 Apr 2020 13:23:51 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:51 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 17/18] utils: matchpathcon add deprecated warning
Date:   Mon, 27 Apr 2020 15:23:14 -0500
Message-Id: <20200427202315.4943-18-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Add a deprecated warning to matchpathcon encouraging users to switch to
selabel_lookup.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/utils/matchpathcon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index eb39a1881066..cc018d213f4c 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -73,6 +73,9 @@ int main(int argc, char **argv)
 	int error = 0;
 	int quiet = 0;
 
+	fprintf(stderr,
+		"Deprecated, use selabel_lookup\n");
+
 	if (argc < 2)
 		usage(argv[0]);
 
-- 
2.17.1

