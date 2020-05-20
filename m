Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69545C433DF
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 16:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA842072C
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 16:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFVMdOgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgETQe2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 12:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETQe1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 12:34:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7238C061A0E
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 09:34:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x15so1830122pfa.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 09:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NAPBxmALPhFQ1QtL5iroq0YLxL6zI/KA/PzeX2SrPgQ=;
        b=MFVMdOgQtjIe/jU4DT8OLlhGAcsnPsIaCQ/f1RqJ6zFN4QAth11z9JaTWnGppJZxH/
         4c6OjdUEhdIzEWM6g0RzqdnPLMg9NBc9o1vYdfIVgoJEbihOc74DcOCLD1EWou6nDRoY
         hAtqxVTZ/r+iBjf4osH7gkJZZQjaSEQihoFtBuXdqU7EtyyxYa9BChlfVtOwAGTWBHmc
         dcYAkEV/2pkC5LbzjWf0IjBDMLEXkivlquH5OHeRleB/zj5ewb2r0afazGKjI4WEXkH0
         Z71fxAWec2ypYtcrkf/phDE019lMCcG4JJS2/WkPUuK+JWf8EBIQw1EA+WYXJkEWeURL
         nMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NAPBxmALPhFQ1QtL5iroq0YLxL6zI/KA/PzeX2SrPgQ=;
        b=Ep4TdtwMs8KOK3z5PAyX3lJg2M/He/di7MvTO9vFYLzN3Ia2hJ/u9LlH3lNQJ/HBET
         SMkmuv05rSOPSwd30c8noqLMvCeD+mW8e7vJfhzU9mr2/A6fZyt4bIQ9mEDa+Mn45wYm
         7BHqNLuQTGOTMY1DsqEdqvLkdntD12Xaip1EjHWK8MSPcxoJoZ2cwXKuzWotEMDcHyN2
         TcXr/JB/ZKV4XCuyGGFalqjmrltUohFj5vs8Agac6cTwpYKBDr3Vg6RI4n2r2CvLIyEn
         XyVsQrDlE1B207cG/KDx494OC1DRY5n1HtrBovKUDy1nh9aR/w5UjUMuDoBC17UU4qkf
         UEkw==
X-Gm-Message-State: AOAM533jli3tivZVviDJBMnwssk9L+4ilNx+aOLwxEAv+NnEO5QeNE4Q
        UQ4mj7XGBs1cxbeEuZNWMi10ZrD6ZBQ=
X-Google-Smtp-Source: ABdhPJw75KWK5npSArDY4Z6pzG3KltnfAFP5ubcbmV6yHijdlAXkmaWshD7JbpbRyaDZIsh5CMnzVQ==
X-Received: by 2002:aa7:82c9:: with SMTP id f9mr5185653pfn.258.1589992467071;
        Wed, 20 May 2020 09:34:27 -0700 (PDT)
Received: from localhost.localdomain (jfdmzpr03-ext.jf.intel.com. [134.134.139.72])
        by smtp.gmail.com with ESMTPSA id i12sm2414710pjk.37.2020.05.20.09.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:34:26 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     paul@paul-moore.com
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org
Subject: [v2] Travis CI: Run selinux-testsuite
Date:   Wed, 20 May 2020 11:34:20 -0500
Message-Id: <20200520163421.27965-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

V2:
  - Added some dnf and ssh options
  - fixed SE Linux to SELinux

FYI The additional dnf commands didn't add any time really to the build,
the latest build is:
  - https://travis-ci.org/github/williamcroberts/selinux/jobs/689293166

Note that I squashed the patch series down from what that CI build saw,
but the diff is the same.

[PATCH v2] ci: run SELinux kernel test suite

