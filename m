Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F7FC433EF
	for <selinux@archiver.kernel.org>; Sat, 16 Oct 2021 20:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5A96105A
	for <selinux@archiver.kernel.org>; Sat, 16 Oct 2021 20:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbhJPUKs convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sat, 16 Oct 2021 16:10:48 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:54658 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhJPUKr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 16 Oct 2021 16:10:47 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6EDA25648E4
        for <selinux@vger.kernel.org>; Sat, 16 Oct 2021 22:08:36 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso11756365pjb.4
        for <selinux@vger.kernel.org>; Sat, 16 Oct 2021 13:08:36 -0700 (PDT)
X-Gm-Message-State: AOAM533w/htveg1pq9vX2e9d/HgFEbtX/RuSx/q9RTLk3YT9B5DA5tnr
        abORNcnDwupVH0vwHRAQQQ73Rym8Ew4nMRYtgmE=
X-Google-Smtp-Source: ABdhPJxXLHEbr7Pe0TJs/KrPGw8lEO7xszKtAzlhG/mTqI2mKfr1dwSLD3tng8yvDkmepm1D9Db7kYPeLtCCr0Jb6gE=
X-Received: by 2002:a17:90b:3a85:: with SMTP id om5mr22908139pjb.115.1634414915023;
 Sat, 16 Oct 2021 13:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211013125358.15534-1-cgzones@googlemail.com> <20211013125358.15534-3-cgzones@googlemail.com>
In-Reply-To: <20211013125358.15534-3-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 16 Oct 2021 22:08:23 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mgB=8YYJ301fFKwYtG-yhvc6pQFRAbNn4Dn7sbZFq+gg@mail.gmail.com>
Message-ID: <CAJfZ7=mgB=8YYJ301fFKwYtG-yhvc6pQFRAbNn4Dn7sbZFq+gg@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsemanage/tests: free memory
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Oct 16 22:08:37 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 13, 2021 at 2:54 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Free all memory in test cases, reported by LeakSanitizer.
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  libsemanage/tests/test_bool.c      | 33 +++++++++++++++++++++++++++++-
>  libsemanage/tests/test_fcontext.c  | 31 +++++++++++++++++++++++++++-
>  libsemanage/tests/test_ibendport.c | 13 ++++++++++++
>  libsemanage/tests/test_iface.c     | 24 ++++++++++++++++++++++
>  libsemanage/tests/test_node.c      | 29 ++++++++++++++++++++++++++
>  libsemanage/tests/test_other.c     |  6 ++++++
>  libsemanage/tests/test_port.c      | 24 ++++++++++++++++++++++
>  libsemanage/tests/test_user.c      | 17 +++++++++++++++
>  libsemanage/tests/utilities.c      |  5 ++++-
>  libsemanage/tests/utilities.h      |  2 ++
>  10 files changed, 181 insertions(+), 3 deletions(-)

The diff was very large, so I posted 3 comments on GitHub:
https://github.com/SELinuxProject/selinux/pull/321/commits/322243ee7d34f1b3e23c04c75a6b5c4f597092f7#r730306247
and https://github.com/SELinuxProject/selinux/pull/321/commits/322243ee7d34f1b3e23c04c75a6b5c4f597092f7#r730306949
and https://github.com/SELinuxProject/selinux/pull/321/commits/322243ee7d34f1b3e23c04c75a6b5c4f597092f7#r730307266
, about the same pattern which causes (in my humble opinion) issues.
The pattern is in:

CU_ASSERT(semanage_ibendport_query_local(sh, key,
&ibendport_local) >= 0);
CU_ASSERT_PTR_NOT_NULL_FATAL(ibendport_local);
CU_ASSERT(semanage_ibendport_del_local(sh, key) >= 0);
CU_ASSERT(semanage_ibendport_query_local(sh, key,
&ibendport_local) < 0);

/* cleanup */
semanage_ibendport_key_free(key);
semanage_ibendport_free(ibendport_local);

The last ..._free occurs after a second call to
semanage_ibendport_query_local. It seems more appropriate to free the
memory right after CU_ASSERT_PTR_NOT_NULL_FATAL(ibendport_local),
before the second semanage_ibendport_query_local. So if an error
happens, there is no memory issue too.

This pattern is similar when testing boolean, fiface, node, port, user
and context objects.

What do you think?

Thanks,
Nicolas

