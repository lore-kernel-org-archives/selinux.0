Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E66FC433EF
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 18:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbiCKSpm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 13:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCKSpm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 13:45:42 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3701C111185
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 10:44:37 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so11589491ooi.0
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 10:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5JkLLhMMHUXGuvgLN3MUf3fFq+RiY/tsN+L6ZxEO114=;
        b=mu3UcIO7HvCM/ehC4UlzjS4RVdrgZI9//Pb4v8cONZIMSHIeLlOVdIvD820Vua36/k
         UO6tAMBvsHURI9NS/oMwX1Xh07Wf3xZNGO5IkxMe4+OgeTVOma3xQv0GnbPYXMM/g661
         j47udagx2sBGqqQBnIaKFXXeRS9BmN/NxMltzKi9yX0BDpQ/M7gUPJvngdVF4OOBI7wV
         2eBShKJ5WJq2Gvt+jbYb5fEO+fr+L5b8HyI146PGhk8pVgG0mFEPDQTmaykcFhcmN6W+
         tWOybQGV2+muxAhYDhSQeTEzv9xoQ5dgdqI573ZnDlSl/T9F8CCEumT+yYv/OPD4yp1m
         aBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5JkLLhMMHUXGuvgLN3MUf3fFq+RiY/tsN+L6ZxEO114=;
        b=qu5apnovpq2c8PVwOSxitK542AowEUm12IGBKFogCx8ARFfxc7LVEcHGktrk9B4Pvy
         WJI5z0Mjb2BVwKCvXUkgaC3nhAdOyqQAKztk8eBhhQMerMXh3Kp0VBtTc7uhUCdsdQMR
         1SJoV+CFcr4GeSd9hGqDQ6hFVvI1oWPSXw+2RH8ObdqKNZJI1YHFtF5fGuPgD21BWVVP
         1qJWYf5uehJn0FXzKbFAUcw0HeHM2X1MH5a7LOamnZDDAcVVygrghVRe41If31IHOQxd
         BsZnYso0h9ZYepqYbAV1uQp9Rwl1oGgA44PvBsINfkcyoL6QdjWLS2a0wx+kOiTsMfO8
         5WfQ==
X-Gm-Message-State: AOAM533ufNEMvwnoF3SkkUJbmrswLXDrltrRKmpcaF+hjdT+jXyqecM/
        1jttSn5Jjij79PnVyzgjA45ACEqhSIGNCHsXkTg=
X-Google-Smtp-Source: ABdhPJye47sR/95NG0bdmeGsIFp4meEoMc/2RjJJbK5dTOKT/YLGxK+ZSU8VOUaFDX5a++g+3z/BBvNq8bit13k9FNM=
X-Received: by 2002:a05:6870:1688:b0:da:b3f:321d with SMTP id
 j8-20020a056870168800b000da0b3f321dmr6162895oae.205.1647024276431; Fri, 11
 Mar 2022 10:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20220111220823.596065-1-jwcart2@gmail.com>
In-Reply-To: <20220111220823.596065-1-jwcart2@gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 11 Mar 2022 19:44:25 +0100
Message-ID: <CAJ2a_DdJHS2vRj9c94rFTDHiRt9_yRqEwxfX7KR451Za2iJAsw@mail.gmail.com>
Subject: Re: [PATCH 0/2 RFC] libsepol: Adding support for not-self rules
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 11 Jan 2022 at 23:08, James Carter <jwcart2@gmail.com> wrote:
>
> These patches depend on the 16 patch set that refactors and fixes asserti=
on checking.
>
> The first patch is based on patches by Christian G=C3=B6ttsche <cgzones@g=
ooglemail.com>
> sent to the list on November 23rd. His patch adding support to checkpolic=
y is meant
> to be used with these patches.
>
> The second patch adds support for not-self rules to CIL. Currently, it wo=
rks for all
> access vector rules, but I am not sure if that is needed or wise.

Probably not caused by this patch set I noticed one inconvenience
duplicate reporting with the following example:

    attribute test_a;
    type test1_t, test_a;
    type test2_t, test_a;
    allow test_a test_a:xdp_socket ioctl;
    allowxperm test_a test6_a:xdp_socket ioctl 0x0002;
    neverallowxperm test1_t { test_a }:xdp_socket ioctl 0x0002;

The output looks like:

    libsepol.report_assertion_extended_permissions: neverallowxperm on
line 534 of policy/modules/kernel/kernel.te (or line 49039 of
policy.conf) violated by
    allowxperm test_a test_a:xdp_socket ioctl { 0x2 };
    libsepol.report_assertion_extended_permissions: neverallowxperm on
line 534 of policy/modules/kernel/kernel.te (or line 49039 of
policy.conf) violated by
    allowxperm test_a test_a:xdp_socket ioctl { 0x2 };

due to the two access permissions, one for test1_t on test1_t and one
for test1_t on test2_t.


Rebasing on to master should update validation due to ff25475c
("libsepol: validate several flags "):

--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -851,6 +851,7 @@ static int validate_avrules(sepol_handle_t
*handle, avrule_t *avrule, int condit
               switch(avrule->flags) {
               case 0:
               case RULE_SELF:
+               case RULE_NOTSELF:
                       break;
               default:
                       goto bad;

Otherwise together with ("checkpolicy: add not-self neverallow support") [1=
]

Tested-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>


[1]: https://patchwork.kernel.org/project/selinux/patch/20211204103516.1737=
5-3-cgzones@googlemail.com/

>
> James Carter (2):
>   libsepol: Add not self support for neverallow rules
>   libsepol/cil: Add notself and minusself support to CIL
>
>  libsepol/cil/src/cil.c                     |  12 ++
>  libsepol/cil/src/cil_binary.c              |  91 ++++++++-
>  libsepol/cil/src/cil_build_ast.c           |  10 +-
>  libsepol/cil/src/cil_find.c                | 206 ++++++++++++++++++---
>  libsepol/cil/src/cil_internal.h            |   4 +
>  libsepol/cil/src/cil_resolve_ast.c         |   4 +
>  libsepol/cil/src/cil_verify.c              |   3 +-
>  libsepol/include/sepol/policydb/policydb.h |   3 +-
>  libsepol/src/assertion.c                   | 144 +++++++++++---
>  9 files changed, 467 insertions(+), 64 deletions(-)
>
> --
> 2.31.1
>
