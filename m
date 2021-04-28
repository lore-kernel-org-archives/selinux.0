Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B1CC433B4
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B1F61442
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 14:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbhD1ODT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240130AbhD1ODO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 10:03:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B8AC0613ED
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 07:02:27 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x54-20020a05683040b6b02902a527443e2fso7342262ott.1
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u3EKhBfS5X+yOnWvtIFw4G9yiSn+7Ii9dfAWpm/404c=;
        b=teVMokCnzhZcp0+4s5h0UxLw1RyG4T7HlZBzJPhmcD5ZnwLlvem2XBvccqI/XtzMm2
         96NW60wLzXYV9upFjzZp7JZT8OmmTgDX7wrt7XTAis+LLjivz9ZTVC9a+Ahy1qtkYTdp
         MLhzAv3r723wWHkNeQ9T12LsQvvMOD/IovVlwF5n0qlB2c4iqoQgob7Ni/wDx+uWa4cs
         qs8Slu4G17axtwIddier9fyGNniWsO82kI0Qbd9VHQOHkJJHhFb9sbfn/gq2rR89euM2
         p8OEVExy3C8BR8ow1HzEM16mL/J3NXCvp0/mKWfgF31oWLr4uZEApTiPBwWZcsqAg39U
         rJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u3EKhBfS5X+yOnWvtIFw4G9yiSn+7Ii9dfAWpm/404c=;
        b=QxMywigIqfRXyMqEzO+tUQS1YB7Y0eDK+25QCyiYdAyIj3qRtCy34mfqMtLqA5TqpN
         I3eM1TirG/HpIHVH9ATKObX8oGQsp/ep9fVfkGMz+IZdVStESFaknjFrrDMehVZOcyqf
         /BHIv9AQFef55fzRqxtLlysCpeZCbf2TIQqCVY0rktm3p3ZzW3M29oY/GDMaeX8N+uOi
         MHvLlMbjNgwEYk85kRQ+vtNNE25sSatkxQwJKUagMK6ig2wXEcDO3JW9HACBJ0+eXVPu
         FPp5QbsfoA4K/N2u6g2xf3scYOmFJo+S6+m8WcULfdULErv3C7Z042RDH54W5/zXp/2b
         eb6A==
X-Gm-Message-State: AOAM531FAzL9utWg4lz7af+upZbhdxAglb1f6CxdSrPmtT652LVSNReG
        QZCYfSUEkKlMIW7A7rRD3S12+3Hxm5xAzRKLSUE=
X-Google-Smtp-Source: ABdhPJxwvFB5Yu16U+UT1CeJJNHT6vbI4QmpXtboSDwus0r241Uokw2PcGgYMEFxAwW8mxxerehsXvsNGDAmBmN56ns=
X-Received: by 2002:a9d:342:: with SMTP id 60mr23968768otv.295.1619618546687;
 Wed, 28 Apr 2021 07:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210413122508.24745-1-cgzones@googlemail.com>
In-Reply-To: <20210413122508.24745-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 28 Apr 2021 10:02:15 -0400
Message-ID: <CAP+JOzQkEWgMvNXw87-fDM_SiyT7=no7+RZHg_q8DynHmewsOw@mail.gmail.com>
Subject: Re: [RFC SHADOW PATCH 0/7] SELinux modernizations
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 13, 2021 at 10:58 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Modernize SELinux parts of shadow
> (https://github.com/shadow-maint/shadow).
>
> Upstream pull request: https://github.com/shadow-maint/shadow/pull/323
>
>
> Christian G=C3=B6ttsche (7):
>   struct commonio_db[selinux]: do not use deprecated type
>     security_context_t
>   vipw[selinux]: do not use deprecated typedef and skip context
>     translation
>   selinux.c: do not use deprecated typedef and skip context translation
>   selinux.c:reset_selinux_file_context(): do not fail in permissive mode
>   selinux.c: use modern selabel interface instead of deprecated
>     matchpathcon
>   set_selinux_file_context(): prepare context for actual file type
>   selinux: only open selabel database once
>
>  lib/commonio.c    |  4 ++--
>  lib/commonio.h    |  6 +----
>  lib/prototypes.h  |  2 +-
>  lib/selinux.c     | 60 ++++++++++++++++++++++++++++++++---------------
>  libmisc/copydir.c |  8 +++----
>  src/useradd.c     |  7 ++++--
>  src/userdel.c     |  3 +++
>  src/usermod.c     |  3 +++
>  src/vipw.c        | 10 ++++----
>  9 files changed, 65 insertions(+), 38 deletions(-)
>
> --
> 2.31.0
>

These patches look good to me.

Acked-by: James Carter <jwcart2@gmail.com>
