Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C3FC49EA6
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 14:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34340613EA
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 14:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhFXOcJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhFXOcI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Jun 2021 10:32:08 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C2CC061574
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 07:29:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so5773730ota.4
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IxgcXV53HB+9BhM+zFTMJe2s0vgKvQqEvoHX5PcapKs=;
        b=KxcfccfsYWSHsHyHOksQfhrZAWdcNA5uOdMKtbP87SyHc3PsnFizaXWUqrNJaXdvy1
         MMw4Z8lddgDto36a4p8M2Z/XWs5oy8VC6PZTjayXUPskYd+RvRCdNRKkf4SjqbaUvgUl
         dBXOoilxViD5k6nVjfLiYh96TjFofH+mHY4+Vj+2Byil5ekBEK+CgfW4kjR0uIwssQl+
         Py/J1II2wiIQz5dMEM7qTSAFlESFYjLoRfLDlUwWkFZo8nxb3BZghoijxW6wyva89hpz
         mkOWyum5Y2Vcsb38CHU3mbHScSmGNh1D0hDlvYMR+mN+/olCPZqHn5iXam5EblzuK0hF
         lsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IxgcXV53HB+9BhM+zFTMJe2s0vgKvQqEvoHX5PcapKs=;
        b=i94udAZqy7En4IvHyM9IRM+WXtRXFFo1inZqpWJDq+WiLd2YmZ8rThHp4XgvlTj7bB
         6OU6v8lEVMIOZ29WLjK0c4NIK/1x89prJkublxHy5HlmLGQmdcK/sd7WP+NdBLeYS0Nc
         otj6AyM09RuIwc1QxEEZp8bFdSg+l+7V0rFWK3bFVeS8/kILolHRbtLMaC9dHQ4Rzl6x
         ltemQ+nVOzPHspIDFAzE0TK2vqIhn746R+NUBIVbNjmpFf20axYp7DIJHiWNuKLBy+ea
         024o/2hBuNthJnZrhJSyJkuGAl85RSgPCww9b0CX2Dfwowfz57g7EO72Wi0Cncd89LAb
         3lkw==
X-Gm-Message-State: AOAM531QUTxcpBhhI1WOXxRyF4OIDwyLkgjYpIJUId//MdbGyTCamXSY
        D8v0ACyQ0NggUj+SKHM08pbcLA925mQvTNEkCTs=
X-Google-Smtp-Source: ABdhPJxnhKwsVRGcait6TrTmGoth3/xCOqlZW8UxV5P/Wjdber0uKgTK31C+kA0QjzOprF1dyZBcjy5fFgHhncVV770=
X-Received: by 2002:a05:6830:34a2:: with SMTP id c34mr4971472otu.59.1624544988315;
 Thu, 24 Jun 2021 07:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 24 Jun 2021 10:29:37 -0400
Message-ID: <CAP+JOzRk_uDaap97b22qxOba08K-0VVBCH7nQaKBXcVa+k=GfQ@mail.gmail.com>
Subject: Re: [PATCH 00/23] libsepol: miscellaneous cleanup
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:00 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Clean up several code smells, compiler warnings, static analyzer issues
> and UBSAN findings in libsepol.
>
> Also declare local functions and variables static and some interface
> parameters const to improve maintainability.
>
> Christian G=C3=B6ttsche (23):
>   libsepol: fix typos
>   libsepol: resolve missing prototypes
>   libsepol: remove unused functions
>   libsepol: ignore UBSAN false-positives
>   libsepol: avoid implicit conversions
>   libsepol: avoid unsigned integer overflow
>   libsepol: follow declaration-after-statement
>   libsepol/cil: follow declaration-after-statement
>   libsepol: remove dead stores
>   libsepol: mark read-only parameters of ebitmap interfaces const
>   libsepol: mark read-only parameters of type_set_ interfaces const
>   libsepol: do not allocate memory of size 0
>   libsepol: assure string NUL-termination
>   libsepol: remove dead stores
>   libsepol/cil: silence cast warning
>   libsepol/cil: drop extra semicolon
>   libsepol/cil: drop dead store
>   libsepol/cil: drop unnecessary casts
>   libsepol/cil: avoid using maybe uninitialized variables
>   libsepol: drop repeated semicolons
>   libsepol: drop unnecessary casts
>   libsepol: declare file local variable static
>   libsepol: declare read-only arrays const
>
>  libsepol/cil/src/cil_binary.c                 |  19 +--
>  libsepol/cil/src/cil_build_ast.c              |   9 +-
>  libsepol/cil/src/cil_fqn.c                    |   3 +-
>  libsepol/cil/src/cil_list.c                   |   7 +-
>  libsepol/cil/src/cil_post.c                   |   2 +-
>  libsepol/cil/src/cil_resolve_ast.c            |   8 +-
>  libsepol/cil/src/cil_strpool.c                |  16 +--
>  libsepol/cil/src/cil_write_ast.c              |   4 +-
>  libsepol/include/sepol/policydb/conditional.h |   2 +-
>  libsepol/include/sepol/policydb/ebitmap.h     |  16 +--
>  libsepol/include/sepol/policydb/policydb.h    |   6 +-
>  libsepol/src/assertion.c                      |   2 +-
>  libsepol/src/avrule_block.c                   |   2 +-
>  libsepol/src/avtab.c                          |   8 +-
>  libsepol/src/booleans.c                       |   6 +-
>  libsepol/src/conditional.c                    |   3 -
>  libsepol/src/context_internal.h               |   1 +
>  libsepol/src/debug.c                          |   2 +-
>  libsepol/src/ebitmap.c                        |  29 +++--
>  libsepol/src/expand.c                         |   8 +-
>  libsepol/src/ibendport_record.c               |   4 +-
>  libsepol/src/kernel_to_cil.c                  |   7 +-
>  libsepol/src/kernel_to_conf.c                 |   5 +-
>  libsepol/src/link.c                           |   2 +-
>  libsepol/src/module.c                         |   2 +-
>  libsepol/src/module_to_cil.c                  |  14 +-
>  libsepol/src/nodes.c                          |   6 +-
>  libsepol/src/polcaps.c                        |   2 +-
>  libsepol/src/policydb.c                       |  70 +++++-----
>  libsepol/src/policydb_internal.h              |   2 +-
>  libsepol/src/policydb_validate.c              |   2 +-
>  libsepol/src/private.h                        |   6 +-
>  libsepol/src/services.c                       | 120 ++++++------------
>  libsepol/src/sidtab.c                         |  31 -----
>  libsepol/src/symtab.c                         |   6 +
>  libsepol/src/util.c                           |   2 +-
>  libsepol/src/write.c                          |   8 +-
>  37 files changed, 187 insertions(+), 255 deletions(-)
>
> --
> 2.32.0
>

Merged all the patches except for 0004, 0005, and 0013 which still
have outstanding comments.
Thanks,
Jim
