Return-Path: <SRS0=eoah=N2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7633AC43441
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 13:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E787223CB
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 13:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JjJGa1cV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E787223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeKOXKr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:10:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40174 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732953AbeKOXKq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Nov 2018 18:10:46 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so14071094lfe.7
        for <selinux@vger.kernel.org>; Thu, 15 Nov 2018 05:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fU0bSahDOVLphCMLSHPEdDcSEo/lWX0hmnXsSE8SHtE=;
        b=JjJGa1cVNvAjxasjq32pTy2r7G6/zLKQWghQAftoNiR7KSNvcEacIq4aAaCVWiQ9z2
         Xmoz3waCssQ9WSvN4QIRBGWeYm+bMIapBEIl8Ayfer+yeOCP92SemG9iaNcLrEK406Lk
         64T2l9V6+KHkwViSWdAL7T8JNXW+GMKRKPEcu7kB2CxpQPjyS2McnbasbzeAw9ELCRjF
         IKzWgy/STZO+VJWu5lde5lf4TirVF3G0Iz58ZiGsu6CtaHzFT+FhXPkezXYmMw3AtsNK
         NnZgb3iBAoX+rvqaDo5smvdguTUzQuFzv0cn3NqjfpwUI6FZEDKuQpPndPbvr2dLfd1K
         RmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fU0bSahDOVLphCMLSHPEdDcSEo/lWX0hmnXsSE8SHtE=;
        b=R0VynQ26IgkcBt/fW2ylBRg2ZsiEi6sqzzvFR/MntRl5ICAnFGxDZW7QSeFy7o00cw
         Y33VPgR2QYyBBZNeJsQLdlwYsrvu+Cw0xD1X9qLET42hOV09WQbjuJD866iabUAhJzCQ
         fbSjRiIiPbNXoimH4+B9K0JTn36tjSDTgpW9EUp6bi2aZzD5jMmKVlnymbSdvb/210E2
         YoP0RFbxqLxn6Oi2xM/h7l36Zi0AuxsFjQKjGu+gYXhOEMe/XHK8V9ySuJE+3nq7DCxg
         DGtq+PlJhR8fAOOOk8yAkwLJHBq0kWdAFitQ4qN3PAfjZGJOdBinYdrrI8pYtvEKG/W7
         cQxA==
X-Gm-Message-State: AGRZ1gJKz9qfLmymVxqGHHtyDqe3BDrq6vIqKUK7Aa8I7/UNgP8SX+JF
        UERw/k5A2XSjVueXFunt06jyFSChghTa8DA6Qv9T3gfaPw==
X-Google-Smtp-Source: AJdET5c5LRJPfYcCYNAtxewzKAyacBPE0MRcxhDW3MUowdf8MCl5aC/vDgvI6kXI4KpA7KwiDjkf6Z1FYtN6VmLL/sA=
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr3255399lfe.4.1542286978330;
 Thu, 15 Nov 2018 05:02:58 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 15 Nov 2018 08:02:47 -0500
Message-ID: <CAHC9VhRWJ2s+z3TYazcgb6e2mkYuvD4Hy5W-N8i4Qo9Rn_8SeA@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v4.20 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Linus,

Two small SELinux fixes for v4.20; Ondrej's patch adds a check on user
input, and my patch ensures we don't look past the end of a buffer.
Both patches are quite small and pass the selinux-testsuite, please
merge them into the next v4.20-rc.

Thanks,
-Paul

--
The following changes since commit 4458bba09788e70e8fb39ad003f087cd9dfbd6ac:

 selinux: Add __GFP_NOWARN to allocation at str_read()
   (2018-09-13 15:36:25 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20181115

for you to fetch changes up to 877181a8d9dc663f7a73f77f50af714d7888ec3b:

 selinux: fix non-MLS handling in mls_context_to_sid()
   (2018-11-13 21:44:33 -0500)

----------------------------------------------------------------
selinux/stable-4.20 PR 20181115

----------------------------------------------------------------
Ondrej Mosnacek (1):
     selinux: check length properly in SCTP bind hook

Paul Moore (1):
     selinux: fix non-MLS handling in mls_context_to_sid()

security/selinux/hooks.c  |  3 +++
security/selinux/ss/mls.c | 10 +++++++---
2 files changed, 10 insertions(+), 3 deletions(-)

-- 
paul moore
www.paul-moore.com
