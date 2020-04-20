Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BF8C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3E4206DD
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJeU7SsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgDTPqY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgDTPqY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359A2C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r14so5133224pfg.2
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qo/M9ma8hAwhDuNMFiAuZ2jdy9oV5PDzurKa+6UdQu8=;
        b=MJeU7SsUyhwTUZFwztC88MNQXAf4mfNTlQ8Mpt5g8npPURDu+QeBA0IKxRyrPtfpMD
         /HudXvY4I2L7t+4Ozo0Uf0Udcio+mCyaOo4SADiH1j2vC4bM7wd6C1/0u1R+t26g17AM
         PtNSoWAk+uUbhbRSYKu6NRTcAphh2sXhelACc2Z5mRgRgx8ny4vXFLNFvfhA6kha8849
         h89b+aBBjprh3dQu7//EDwegPG6gu2oIiAwFo47N0a33RIvCaYhjzazPu/8HFPAqHA+d
         ASlQHelrGy7HAm7zEKTXXbxW5Gv/ppX2arGqoxJ8yt2nGCRHdM7YCO1+j2f5iMhUNCYE
         5gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qo/M9ma8hAwhDuNMFiAuZ2jdy9oV5PDzurKa+6UdQu8=;
        b=XfFNJiPU4pwh0157dpVPWAUq8heJuXnjHkYSc8ta5Z8lvgWtab09FuCEW9TjAXrERI
         f0P9GhcDt0M9GD1Og/3MovxBSgLoEM+FbiJ7AKl+HxBTWUAXCEcpTRcv88H2wthqCa6q
         E4A3LwJKWZVq8H9J4OHj6gRDexxnEkiiWmENQ0c/u+YER4p9mhc1GbHIQxnLbHwwRFbv
         UB6nKF2Wh3WtqYjCOn52MWwYE2n0z24Nxv47voxt7/Lwa9eUktmsUeAY6TRLNqXiwLYf
         925/HlNSbfXylgalbT0EMSpdAq83y8su+SsBAoxlq2R/k4ASBweuiJ1vwYgW2WBOBCeK
         40WA==
X-Gm-Message-State: AGi0PubVyDDwHpXxswarW9lbKnWAZirDW3IefPIzWqIruLYd9Js1jKZ/
        ahay/cnAP7Aag02tGr3yAGo=
X-Google-Smtp-Source: APiQypK4SRM3B/+RfYdLD/dqhNgTdJ51aK6MSBo6UdrQh8V0k4Ui96DY1ecXCZ99Jg7g5qzn+8KcMQ==
X-Received: by 2002:a63:fe54:: with SMTP id x20mr16382780pgj.195.1587397582687;
        Mon, 20 Apr 2020 08:46:22 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:22 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 18/19] utils: matchpathcon add deprecated warning
Date:   Mon, 20 Apr 2020 10:45:36 -0500
Message-Id: <20200420154537.30879-19-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
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

