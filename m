Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6558C433ED
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FA561242
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhDMMZj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhDMMZh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Apr 2021 08:25:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F794C061574
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f8so19139590edd.11
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AwCiEql8EAjv7PcY1GadBG6JPtUSXhWz98WtSZQx7F8=;
        b=ekGGZ0PSgXIdm1ZL0rBJf/fbUyquedhnuM29+0NLMHYzUyVihiyMJQMFf/OoNkORQn
         jdINztsV9RYy9QOi+gBsu4XcT1woFk7UAF7rnGqHk8V16K579tKMngwIJc4cQWF7YF5c
         v5O9UCAbDMmd6bh+4mLuJW1XX2jz7jlfkOUIIHdrCp9WLS8B/PQi5eAw9Z3SREz0k1pH
         RaMMj4Uu41f0rjKvrm2KGA2GjoJAlrIpPyn4GO5HNXYfV09cJr+IJNBSGyfUzx93aRZl
         h0xWk4rMn/esSvPgRjwnEzS61b+AxYmI3lhmlInpaQY4Ym6KOddxhAjL8O4s4ZpCSQZ/
         kBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AwCiEql8EAjv7PcY1GadBG6JPtUSXhWz98WtSZQx7F8=;
        b=YQaxVGTnbUNayjGq/UQVniGTEUrjLxCIH27NhEvlwZW2h47fvbtB5lnFAEtzAemDb8
         a4u0LvFxiJCrOmOxf5H4unqwmhBmNWi3mUvt5X9I3MiwX0F5HJUU/EFTES6f/B2UWws+
         dNj8vAbXDiyQ29ONlNan8gWDS6xjUuVV0cAdxKETOsuNfidKsoYDXrnYiE8HFqOC0/+0
         jxe2gBQMQ0XUFgz6HBNMrsqK4IhYLjsf3Op/bUpAHGi9JpYvOqnOoLYQGq0Za+XfE8f3
         vVXMM4rWu+ZSIbIG4R8ytx6rhr6ryodw0rZRPal6of3IjVRJFf4XMhlqb6tY3esewa1J
         DXog==
X-Gm-Message-State: AOAM533+Zf+rVEAfm890kFPywCMwwyVcM8hXQBKaOkU9nmRa5BPYQhyL
        dKr1JwZCMsugLE501MHiw4uNar7749E=
X-Google-Smtp-Source: ABdhPJzhNahLoZmASCjjUgg5+NZnXBKZDBZ+vJGBKCq6yE035GhlVozA+Jg51AnEAT21sxcsEyuhEQ==
X-Received: by 2002:a05:6402:280f:: with SMTP id h15mr32160861ede.150.1618316714178;
        Tue, 13 Apr 2021 05:25:14 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-170-158.77.1.pool.telefonica.de. [77.1.170.158])
        by smtp.gmail.com with ESMTPSA id mp36sm7594438ejc.48.2021.04.13.05.25.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:25:13 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC SHADOW PATCH 0/7] SELinux modernizations
Date:   Tue, 13 Apr 2021 14:25:01 +0200
Message-Id: <20210413122508.24745-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Modernize SELinux parts of shadow
(https://github.com/shadow-maint/shadow).

Upstream pull request: https://github.com/shadow-maint/shadow/pull/323


Christian Göttsche (7):
  struct commonio_db[selinux]: do not use deprecated type
    security_context_t
  vipw[selinux]: do not use deprecated typedef and skip context
    translation
  selinux.c: do not use deprecated typedef and skip context translation
  selinux.c:reset_selinux_file_context(): do not fail in permissive mode
  selinux.c: use modern selabel interface instead of deprecated
    matchpathcon
  set_selinux_file_context(): prepare context for actual file type
  selinux: only open selabel database once

 lib/commonio.c    |  4 ++--
 lib/commonio.h    |  6 +----
 lib/prototypes.h  |  2 +-
 lib/selinux.c     | 60 ++++++++++++++++++++++++++++++++---------------
 libmisc/copydir.c |  8 +++----
 src/useradd.c     |  7 ++++--
 src/userdel.c     |  3 +++
 src/usermod.c     |  3 +++
 src/vipw.c        | 10 ++++----
 9 files changed, 65 insertions(+), 38 deletions(-)

-- 
2.31.0

