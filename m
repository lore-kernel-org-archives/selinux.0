Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1C7C76186
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 22:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A103E2073F
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 22:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfG2WVT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:21:19 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:43722 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfG2WVT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 18:21:19 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B542156128F
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2019 00:21:15 +0200 (CEST)
Received: by mail-ot1-f45.google.com with SMTP id n5so64285345otk.1
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 15:21:15 -0700 (PDT)
X-Gm-Message-State: APjAAAWc/3IKjRRbdHfr9T6rRV+vHtIm4ze+A9OreTnoFCFN1/hrbjZR
        cNJRTvA3OfXq5QjLi1s2xNIOEC8RqEZHTGG8fEA=
X-Google-Smtp-Source: APXvYqwlQtNKQUslXW7PoVgfr8YenYTiOMROZdBLatm2P+zbDpiIqdfO21+r2ZP5qiYKyEats2UFOJmEYuPruz5qZyE=
X-Received: by 2002:a9d:6ac3:: with SMTP id m3mr24671125otq.92.1564438874747;
 Mon, 29 Jul 2019 15:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190624180229.9573-1-richard_c_haines@btinternet.com>
In-Reply-To: <20190624180229.9573-1-richard_c_haines@btinternet.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 30 Jul 2019 00:21:03 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mYQz-g+zvy+9xzhLHtQn4asZfy8G1TetVnhVO44tCiBA@mail.gmail.com>
Message-ID: <CAJfZ7=mYQz-g+zvy+9xzhLHtQn4asZfy8G1TetVnhVO44tCiBA@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] selinux: Remove legacy local boolean and user code
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 30 00:21:16 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 24, 2019 at 8:25 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> I've removed the legacy code as discussed and seems to work okay when
> loading policy on Fedora 30 & Rawhide (they both boot as well).
> Note: I cannot test any other releases.
>
> Tested downgrading policy to 24 okay using load_policy(8).
>
> V2 Changes:
> Updated as requested in [1].
> Add manpages.
> V3 Change:
> Fix deprecated_funcs.c WARN() messages in Patch 1.
>
> [1] https://lore.kernel.org/selinux/18e772cde0ed8f4d83752a9957ad2a3a11ecad8c.camel@btinternet.com/

Hello,
As these patches have been around for more than a month without any
complain and they looked good to me, I merged them.

Thanks,
Nicolas

> Richard Haines (2):
>   selinux: Remove legacy local boolean and user code
>   selinux: Update manpages after removing legacy boolean and user code
>
>  libselinux/include/selinux/selinux.h          |  18 +-
>  libselinux/man/man3/security_load_booleans.3  |  12 +-
>  .../man/man3/selinux_binary_policy_path.3     |   7 +-
>  libselinux/man/man3/selinux_booleans_path.3   |   1 -
>  libselinux/man/man5/booleans.5                |  80 ----
>  libselinux/man/man5/local.users.5             |  68 ----
>  libselinux/man/ru/man5/booleans.5             |  83 -----
>  libselinux/man/ru/man5/local.users.5          |  72 ----
>  libselinux/src/booleans.c                     | 225 +-----------
>  libselinux/src/file_path_suffixes.h           |   2 +
>  libselinux/src/load_policy.c                  | 100 +----
>  libselinux/src/selinux_config.c               |   9 +-
>  libselinux/src/selinux_internal.h             |   1 -
>  libsepol/include/sepol/booleans.h             |  15 +-
>  libsepol/include/sepol/policydb/services.h    |   6 -
>  libsepol/include/sepol/users.h                |  13 +-
>  libsepol/man/man3/sepol_genbools.3            |  30 --
>  libsepol/man/man3/sepol_genusers.3            |  54 ---
>  libsepol/src/deprecated_funcs.c               |  50 +++
>  libsepol/src/genbools.c                       | 279 --------------
>  libsepol/src/genusers.c                       | 343 ------------------
>  policycoreutils/load_policy/load_policy.c     |   2 +-
>  policycoreutils/man/man5/selinux_config.5     |  15 +-
>  policycoreutils/man/ru/man5/selinux_config.5  |  11 +-
>  24 files changed, 86 insertions(+), 1410 deletions(-)
>  delete mode 100644 libselinux/man/man3/selinux_booleans_path.3
>  delete mode 100644 libselinux/man/man5/booleans.5
>  delete mode 100644 libselinux/man/man5/local.users.5
>  delete mode 100644 libselinux/man/ru/man5/booleans.5
>  delete mode 100644 libselinux/man/ru/man5/local.users.5
>  delete mode 100644 libsepol/man/man3/sepol_genbools.3
>  delete mode 100644 libsepol/man/man3/sepol_genusers.3
>  create mode 100644 libsepol/src/deprecated_funcs.c
>  delete mode 100644 libsepol/src/genbools.c
>  delete mode 100644 libsepol/src/genusers.c
>
> --
> 2.21.0
>

