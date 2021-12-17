Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAABC433F5
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhLQST0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbhLQST0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:26 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7DCC061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:25 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id kd9so3148609qvb.11
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Nau85lIm8XUOSikt+tFbBnGRfMmlGupzneZeAhwPiE=;
        b=UobLhp0Vnov+5bA+/ZxusEf+d5EqcUtWD8XfsYlqaYtu9o6BhIBFxpuOr6wSvTyhGN
         /I2JRKX04Uj+SYvUv6G20YvC9EZMWdhLNDHN8Vvc7f0J1kbNRlHRme16QVXQF7IcOSnu
         wcVcmV0UKT+l8g8AAUJNwP39SoxyXDQG19cMkkG1M3fR0wvpAYkG81rO2kJ34/qpDCDe
         oEDIO8KD11eQgyMZp92Z7Ih6UFCS2OxOcESgH2gZkOEfQJKBK+0QH+2O/cd0YJz2f6IW
         j1WLIP2l3NWcDM6pZQzPeWru9pPDrDSicxu1/vIoQQuuj4NPHRKU1KFE0Ya1Y1eXTy+u
         NFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Nau85lIm8XUOSikt+tFbBnGRfMmlGupzneZeAhwPiE=;
        b=lKn9TNce27robEkPB8xpJgyna6RP4BExtXRQccQayvahNcLdVcMcbjYYJqBU7NEJOJ
         bdWmS+2KaAopDX5MgYbqjSj8wuXihVOaXfELH2hPT675XytD0NBRTvnnZENrOnsUgFw1
         ROl+IOz87iIuC880f+Myvw2ghquYlq1+GmD5BlqZxXq4Fwr/Z4lwoM7SznsEEE2r65Qm
         Pu44kO/+wcDBGMnm+i/+ZUuvXAf5ULay5HBdePmbFaGdik4VJ7WZipcuES/fF6xD+Bgi
         CB0KB9zMlVbfMjj6Px1PXm+0/q5CfT6/peoxIRq+lUuEIGFkgRYYGD0rjRNmFROtn/dG
         7eFQ==
X-Gm-Message-State: AOAM532BpO0Fs1qiB/dKJkryPUiSOZNVv9QTtXdUA1R4dAkWtc+szrqc
        KB98s+Z/SJnX2qiuo+K/+Gl+qMNlzH4=
X-Google-Smtp-Source: ABdhPJzg5EZV285MHgMjQ7TwFaiIv8MBQjOEqa05XrlqBKDN6a/rBQ+6N70BS7mKWbIlDNZupaylfw==
X-Received: by 2002:a05:6214:c42:: with SMTP id r2mr3634063qvj.70.1639765164772;
        Fri, 17 Dec 2021 10:19:24 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:24 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 00/16] Refactor and fix assertion checking
Date:   Fri, 17 Dec 2021 13:18:57 -0500
Message-Id: <20211217181913.336360-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The first 13 patches refactor and cleanup the neverallow and
neverallowxperm checking code to make it easier to understand.

The last 3 patches fixes errors in the assertion checking code.

This series is to prepare for adding not-self support to assertion
checking.

James Carter (16):
  libsepol: Return an error if check_assertion() returns an error.
  libsepol: Change label in check_assertion_avtab_match()
  libsepol: Remove uneeded error messages in assertion checking
  libsepol: Check for error from check_assertion_extended_permissions()
  libsepol: Use consistent return checking style
  libsepol: Move check of target types to before check for self
  libsepol: Create function check_assertion_self_match() and use it
  libsepol: Use (rc < 0) instead of (rc) when calling ebitmap functions
  libsepol: Remove unnessesary check for matching class
  libsepol: Move assigning outer loop index out of inner loop
  libsepol: Make use of previously created ebitmap when checking self
  libsepol: Refactor match_any_class_permissions() to be clearer
  libsepol: Make return value clearer when reporting neverallowx errors
  libsepol: The src and tgt must be the same if neverallow uses self
  libsepol: Set args avtab pointer when reporting assertion violations
  libsepol: Fix two problems with neverallowxperm reporting

 libsepol/src/assertion.c | 193 +++++++++++++++++++++------------------
 1 file changed, 102 insertions(+), 91 deletions(-)

-- 
2.31.1

