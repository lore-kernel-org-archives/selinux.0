Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3F1C11F64
	for <selinux@archiver.kernel.org>; Mon, 28 Jun 2021 20:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7B361CC9
	for <selinux@archiver.kernel.org>; Mon, 28 Jun 2021 20:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhF1U0V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jun 2021 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhF1U0V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jun 2021 16:26:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DAEC061574
        for <selinux@vger.kernel.org>; Mon, 28 Jun 2021 13:23:54 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 22so17426820oix.10
        for <selinux@vger.kernel.org>; Mon, 28 Jun 2021 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtZu4IyrCuCTXBUcT4e60ELhUIGNaiUY4VyBQG/PLSo=;
        b=ohIvrYLBswQIJEH0Fmh0FpMOZkRBCL8RHqFR/vABh7fnaf5CWC6q6IcyYZTgS019ms
         RJIwHa3fpEM4uxVILUaQACbgX4eNuVA4OipVNFTRf+mtPk0/DMbT6hDSqzc0DB+5iI36
         smOQjOPWyZAsPAydg3lYLpvltwn+9o9pSjTHUXXZ5mtdLQ5f+q6t7E54xVO7moV4e3Wh
         sP8Od5s5iKDkOlvx4HBggmIVQ3pgygiZBK0v7RehJPviah0REllkXZsiYrH0x8zFKHmY
         4KFxmWm8EUVms/owwl/3SxHyNllWw7lAuh/1UJUZB7Nz8z6a75YRfo8YbbH0T5PorzEB
         5PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtZu4IyrCuCTXBUcT4e60ELhUIGNaiUY4VyBQG/PLSo=;
        b=e8ySwp1/ruFS+nEGGqx6IMi9NYLgex7LzjUa/PCVyatU+7ug1H149ZmXQWDa0Bfl7h
         Fm7LTivLsLIfF+3srS5wnu+fxWNR9EuSLKCjFdWPgeyta+CpqJwbbOfSJz4y0PYUCB3U
         ew/ayAma7m4dOjtC8sIFvUQ3K5CxZj23MkY2mZrSzuBegQ0kMu8lguXYcC8QDCh/CCIS
         x5gw89iSjny238DmxKmHHuERGCvuV2dy+M3EFxhNYPEism6Xa1Td3jDpy1zoOtI8L4v7
         JXl+g3g7D+wxXliFpVdEId8duFCx5z5gBKygWZL0x+oQR94M+x0BKHeKwirxbDkJtZcM
         IKFQ==
X-Gm-Message-State: AOAM530cC+H9OCEt6WRaUMcSizGaLnaIMZMp2/9ui2zeb11UUUAypeX2
        zcFplRQqEESzwAMTLZ0yymUGnH+zPZ4JGQr8LXs=
X-Google-Smtp-Source: ABdhPJxSs6HsSFgQadKRTNN6806hiB34mPmjGBDjNOmkjsjbMw9GtLpFSKLYvfd3aJnkQF7/IDvfq4Ik0iavTWpPEsY=
X-Received: by 2002:a05:6808:148d:: with SMTP id e13mr16823171oiw.138.1624911834090;
 Mon, 28 Jun 2021 13:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210626123443.12149-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210626123443.12149-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 28 Jun 2021 16:23:43 -0400
Message-ID: <CAP+JOzS4XPRfBj+uiisUyjthKcR1vWMhL0_6++yNxM7LRnRmuw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: make array cil_sym_sizes const
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 26, 2021 at 8:35 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> The values of this table are never modified.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil.c          | 4 ++--
>  libsepol/cil/src/cil_internal.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 9d5038d91add..32e8b3cf419e 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -52,7 +52,7 @@
>  #include "cil_strpool.h"
>  #include "cil_write_ast.h"
>
> -int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
> +const int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
>         {64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
>         {8, 8, 8, 32, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
>         {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
> @@ -1882,7 +1882,7 @@ void cil_set_policy_version(struct cil_db *db, int policy_version)
>         db->policy_version = policy_version;
>  }
>
> -void cil_symtab_array_init(symtab_t symtab[], int symtab_sizes[CIL_SYM_NUM])
> +void cil_symtab_array_init(symtab_t symtab[], const int symtab_sizes[CIL_SYM_NUM])
>  {
>         uint32_t i = 0;
>         for (i = 0; i < CIL_SYM_NUM; i++) {
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
> index 8b9aeabf66e4..3211fc355ec9 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -275,7 +275,7 @@ enum cil_sym_array {
>         CIL_SYM_ARRAY_NUM
>  };
>
> -extern int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM];
> +extern const int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM];
>
>  #define CIL_CLASS_SYM_SIZE     256
>  #define CIL_PERMS_PER_CLASS (sizeof(sepol_access_vector_t) * 8)
> @@ -981,7 +981,7 @@ int cil_userprefixes_to_string(struct cil_db *db, char **out, size_t *size);
>  int cil_selinuxusers_to_string(struct cil_db *db, char **out, size_t *size);
>  int cil_filecons_to_string(struct cil_db *db, char **out, size_t *size);
>
> -void cil_symtab_array_init(symtab_t symtab[], int symtab_sizes[CIL_SYM_NUM]);
> +void cil_symtab_array_init(symtab_t symtab[], const int symtab_sizes[CIL_SYM_NUM]);
>  void cil_symtab_array_destroy(symtab_t symtab[]);
>  void cil_destroy_ast_symtabs(struct cil_tree_node *root);
>  int cil_get_symtab(struct cil_tree_node *ast_node, symtab_t **symtab, enum cil_sym_index sym_index);
> --
> 2.32.0
>
