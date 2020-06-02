Return-Path: <SRS0=4SPy=7P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1AEC433E0
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 19:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44EDB206E2
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 19:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUL/mkct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgFBTTJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTTI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Jun 2020 15:19:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EDFC08C5C0
        for <selinux@vger.kernel.org>; Tue,  2 Jun 2020 12:19:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b201so1470353pfb.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2020 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m7SR5hFLnChAV0ucTvXCDRpIZd4M42hXeJAcZjrlgu0=;
        b=hUL/mkct5A8kEw9TlzPKhBFn9Y7+Z2cCRHCJ5duKogQvPj7nCIJz1g3X/Bh36kUQwT
         1NfLxHPZEiTINvBEJ8MibbKRBbCkWavxk+XykonEycryv1k1V3jEor6V7LYJmAaZZPqT
         vQJHGjc199WYesc0/S3eZFwBxKY6P/QwD7F7J+2OOve8evAmjvdEINOfPk4eqOjwUCD6
         RlugO+vDfEXlf5PPO0ruimcB+u40xhKjBoB1Eplor7ZAYPf/oYG2JjysNkcBFCunlE1I
         KozGlFJWg/OAMkExHhDvVWi0lZ5ecAtqFeaspLpolbt/MpMOdNd31nZnUKsTavOrh9WG
         1yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m7SR5hFLnChAV0ucTvXCDRpIZd4M42hXeJAcZjrlgu0=;
        b=LPyHO+z5VK80LufG4t0ghJX5mOwD4lJBjB7ClwwdYvTRIqAcMiHg1dbuiKwN4Hcr13
         poDdXo9mBtJS3saPQ2c2ANvf1RfaRF1yYJNbAXy2A2JlesD594D699ohHZbn8eNccb6J
         a1bJbzA596Gs2h4CGTgfQUAdOZt48hsmRHHG2QPGNtpw6dNSztRt2FJADDot0cLPJIfZ
         Mh2/ZhBHmeGE1nsI+MaJy8CmZfHsso1MEdrYq6ugc8+F4DjgQS5dggdoujlmhSsiG1nD
         6jun/Ck8HCB2azXiebNUyDqdzP2q8va67zU+Jby93439s/z5LcBjcEtvzkatNoBVbDcm
         UxVw==
X-Gm-Message-State: AOAM531gEv7Gu244KZTpHK7Qxl8ADLooGuRrZNTzRoQ7kbEOJ+vcOZ9K
        0Br1SS8mlJAhfm4LGGTESKA=
X-Google-Smtp-Source: ABdhPJwBZ/NeN2cjmR6+lgw6ctnV0gRgz/mbZ+BDMum8D6AuF2H1lf7gyn6QwWpmthEBjXN6u3X3Xg==
X-Received: by 2002:a17:90a:17e9:: with SMTP id q96mr770134pja.56.1591125547084;
        Tue, 02 Jun 2020 12:19:07 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id u14sm3239971pfk.211.2020.06.02.12.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 12:19:06 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     paul@paul-moore.com, selinux@vger.kernel.org
Subject: [v3] Travis CI: Run selinux-testsuite
Date:   Tue,  2 Jun 2020 14:18:55 -0500
Message-Id: <20200602191856.5040-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520163421.27965-1-william.c.roberts@intel.com>
References: <20200520163421.27965-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

V3:
  - Fix shell check errors.
  - Use nproc for VPCU count.
  - Change ~ to $HOME.
  - Fix some spelling and grammar mistakes in comments.
  - Use variables for image location to make updates easier.
     - Use a TRAVIS variable to control this: TRAVIS_CLOUD_IMAGE_VERSION
         - Default it to Fedora version 32 Minor Version 1.16
     - Test that going from 32-1.6 to 31-1.9 works:
        - https://travis-ci.org/github/williamcroberts/selinux/jobs/693957154
        - Note it failed in the ssh connection but it did download a different
          image and verify the checksum. I would just take that up as we need
          to change images in the future, as 33 might not have an issue.

V2:
  - Added some dnf and ssh options
  - fixed SE Linux to SELinux

The latest build is:
  - https://travis-ci.org/github/williamcroberts/selinux/jobs/693969148

Note that I squashed the patch series down from what that CI build saw,
but the diff is the same.

[PATCH v3] ci: run SELinux kernel test suite

