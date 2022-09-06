Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458FAC54EE9
	for <selinux@archiver.kernel.org>; Tue,  6 Sep 2022 21:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIFVDo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Sep 2022 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiIFVDj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Sep 2022 17:03:39 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D38A2A99
        for <selinux@vger.kernel.org>; Tue,  6 Sep 2022 14:03:38 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a15so9158143qko.4
        for <selinux@vger.kernel.org>; Tue, 06 Sep 2022 14:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date;
        bh=1ZF2gBte2ipeQA8Nz2cQsa200sgcemuonfZmgozIZZM=;
        b=yk51w2T4BRIcBBAWAPby7+3MCpByr9ruRWFz+U9gdzJtoAdw4AYLszfduuEczK5g7i
         lSD+QLKZS/oy7ScTFtysmSQaZuqLoTkQsoXcwPUo3vI1+kQJ48G7czydeFPopt73KkSv
         Q9l/7+K0ZVCFQAXNjinFgGR6ouHc6BlDFBR3vG6yHVxZonWTvHhhJxZHUq6uUIhnAdVD
         v6wAwSTCwiX5lHUsNkVKqkss6RktNOtsGX69psm6+wOIAs/zxAgQsQLK1gbITolCYLgv
         sxc2w2/gVTtJflUhoRu73KoO2SStodHER1erB9n7x09Ul3f15wL72IwCRDmmkVC3BBca
         bzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date;
        bh=1ZF2gBte2ipeQA8Nz2cQsa200sgcemuonfZmgozIZZM=;
        b=KN9ODz+W4v6EYFhskr3h635lm/bQ2vrDWUqYizYYvrTed+EF3F17EqiORQSEMCnVjU
         pwm6ctQvyMqOiRCZXruktcn/FFSafPCH4Qg/FaMz4Yt2Woyqj++CLUuBM7ZSis5taLo0
         ImXWbVNIYzFxUA2fvbZnmJO9v1oQsY85hcBRaUZLx9lSwXax3BYVAhLNCSzg4M/HvPuD
         V4AMAQCPFSD4tiB1ZpVMwB0798Z+8k64zB1NcZDeNT113NIl2kfSnPCDZoHmLsLxxo9J
         ubnuh7IRy23l+G6Kk3tEPtkBKiMKaqM3i2Lxq7iZuzQxXGkBwir2T3EghnFRQdHQW4Pt
         5QGA==
X-Gm-Message-State: ACgBeo1KWHq3uvmDc+kbkVMTs2LYz7P8DDJBqaLoU2OJMgo01zVgaNjm
        9KfL34jyg5evWdq7wb4l4HCGFDjcgca4
X-Google-Smtp-Source: AA6agR5XvnXVCx8oY0f/PuqU/VsPB0iKEEOT3DdCjIG9Vm1xsN3kH+duMuMM/w+AzFh/TZq6gXsCQQ==
X-Received: by 2002:ae9:df41:0:b0:6bc:3e7b:1ec8 with SMTP id t62-20020ae9df41000000b006bc3e7b1ec8mr429418qkf.499.1662498217344;
        Tue, 06 Sep 2022 14:03:37 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id y8-20020a05620a44c800b006c479acd82fsm10046140qkp.7.2022.09.06.14.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:03:36 -0700 (PDT)
Subject: [v5.19.y PATCH 0/3] Backport the io_uring/LSM CMD passthrough
 controls
From:   Paul Moore <paul@paul-moore.com>
To:     stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Tue, 06 Sep 2022 17:03:36 -0400
Message-ID: <166249766105.409408.12118839467847524983.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The stable patch merging tools failed to automatically merge the
io_uring/LSM CMD passthrough controls into the stable v5.19.y branch,
so I'm doing the backport manually and submitting them directly to
stable for the next v5.19.y release.  The backport is necessary due
to the reorg/decomposition of the io_uring code in io_uring/ during
the v5.19->v6.0 merge window.  Other than the differences in the
filenames under io_uring, the code changes are pretty much the same.

I've done some basic sanity testing this afternoon with these
patches and everything looks good to me.

If you would prefer to pull these directly from a git tree instead
of email, they are available via the LSM tree on the stable-5.19
branch, using the lsm-pr-20220906 tag.

  git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
        lsm-pr-20220906

---

Paul Moore (3):
      lsm,io_uring: add LSM hooks for the new uring_cmd file op
      selinux: implement the security_uring_cmd() LSM hook
      Smack: Provide read control for io_uring_cmd


 include/linux/lsm_hook_defs.h       |  1 +
 include/linux/lsm_hooks.h           |  3 +++
 include/linux/security.h            |  5 +++++
 io_uring/io_uring.c                 |  4 ++++
 security/security.c                 |  4 ++++
 security/selinux/hooks.c            | 24 ++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +-
 security/smack/smack_lsm.c          | 32 +++++++++++++++++++++++++++++
 8 files changed, 74 insertions(+), 1 deletion(-)
