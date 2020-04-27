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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C7BC4CECC
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6C3206E2
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwXBxSZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgD0UXv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD0UXu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010E7C0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so1491992plr.0
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q86dvL0fgMsxhbOXy6t11FAfTgjjVDHq4dE+YOyTIPg=;
        b=kwXBxSZ/i1/kafp7LZ4D51KQmMxZw/7OeQuMoo7ReEgP8oMANKd0Wl788HL0+v610M
         8H6UaA1K3Nk9ZF02SPb+6J1zcaGm1fKmOfgIQeSInontbFUwRPZU6BbOH/JfCd8Jpnn7
         PZKyGJpanWU137B5QihatlC1xkCEfoUefbcbRQHAG1ceZtMczSwRUzb8UaiT6+aszpC7
         IPjbZ77pg726pxNLGf/zaIvDABDEYeugCSKIErydOgHW9xgLE+/SnEqjBTBtsysBrt5t
         dPQPO5WedrEU6PFew9O77GdzjhM1gSTXO535dtvm8VxJamMJHWX9CCG0g95DiEV/IY+l
         Bjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q86dvL0fgMsxhbOXy6t11FAfTgjjVDHq4dE+YOyTIPg=;
        b=kahligrQb/mr1UnQkSjm4Awk/8/txl8T3KrwAM+N/f/l6PdzYHtU83TXRlyOFmSoNB
         mM1Uf1bR3LJ2/t1Y/hkC7XPzskFl9o2yosb6mXCMjTmfXxrUzYeuNpotPi1CRMNe1VoT
         dNvU19vsEB7W3lfRYthanAA2GgHNK7g+RGrSD4PI8DS/sMo+HJjsi1M1+oO6ug4ZnE5/
         AAkM0XKK+6sJ1dxMduPjThBOrENjvcMpd6HCJzOIMW6QFpvMDzw4xJfkMBv0wqF7c5nq
         z0vjDK879DJ1qud//ODvMMJQTOVnH3SrNy+U2zjVrfgWbE2wLnVbXeQSJF8rNDLLHBOp
         3aMA==
X-Gm-Message-State: AGi0PuZlKOQFjK37pDf0QU7s914jrRlfVXQtHwruUptcQjd6C4hdGxEB
        70dckM3Gycmq48iaYaaiqaw=
X-Google-Smtp-Source: APiQypKCq/oBtC+JGz+Yd8mnskrVtqHRNgbrz0Lw61z51Acmxvvj2IeS0HXTsm5jXAQHVXEZqZ1jxQ==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr22925193ply.262.1588019029518;
        Mon, 27 Apr 2020 13:23:49 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:49 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 16/18] matchpathcon: allow use of deprecated routines
Date:   Mon, 27 Apr 2020 15:23:13 -0500
Message-Id: <20200427202315.4943-17-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Utility matchpathcon uses the matchpathcon interface which has been
deprectaed. However, this tool will continue to live on, so allow it to
use the deprecated interface.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/utils/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index b018a08acbe0..aa2d3e1b144f 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -56,6 +56,8 @@ sefcontext_compile: LDLIBS += $(PCRE_LDLIBS) ../src/libselinux.a -lsepol
 
 sefcontext_compile: sefcontext_compile.o ../src/regex.o
 
+matchpathcon: CFLAGS += -Wno-deprecated-declarations
+
 all: $(TARGETS)
 
 install: all
-- 
2.17.1

