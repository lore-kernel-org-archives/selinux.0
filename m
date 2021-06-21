Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD2DC48BE5
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09E76124B
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFUU6r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUU6r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 16:58:47 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E81C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:56:31 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t140so21425758oih.0
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QzyqQ7PREYIvWOSQ/cZ+tLC2X6FQCokDuujhyLlxKlY=;
        b=AfFrx/6WSQGdjSvZAXHCBQkR6mkTzeAYINmhKgJTVXVEgXkAy8lfb7QqNBKbf36gZH
         RGLH5B9BgRUknt8bAB0MDC3mIEMmaNcF+GFlwJveyJZtGqSOiLCHR44+Vv9jcqd1OtXJ
         uJpeAwK3CbsIIdAj/gLHx9207jl/1aAvSxfQEUltfpiR4r6Oc3Mw26IMvubjJeq3Yh92
         LFHqeZ+vauEh4lAKrJNNNTzxtfsLSekQ2/dF/DW+ijzXayYsS3u9cZ1H4EJ4htbuRsl5
         uC8d9KayvWzHRicudnMEDTSWApe04wc8ddlZp4INH/ndGzvEzryvn/v7Eiq+5t0FoM0Z
         gA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QzyqQ7PREYIvWOSQ/cZ+tLC2X6FQCokDuujhyLlxKlY=;
        b=jIDAGVhb2wQXOPnr8DOOV8CMwV70wjfn6T9MHmBtLhaO+gNxCu9ZbzKLA6agE9j/vZ
         yuzh84BvX8EqBMgO9/hwYheW5WQ+uJIL1143Uzu2BlssD/VzC+KI5Ktd3aaOLngoELJE
         Nkj6jv9k0nBaIZ/09fjRLkvrkaDmx3ZVgKpo46OkLUKu/1Rnns+L5qf5XTmicrWZwD0K
         L1ZWRNcOe+0vYlHW+i/fmZ/CXzAH4UcbNVTH/tz55jK0QYz+5KwAQQ8hGfHvNSN/xabm
         mVPswmVBDw0OQRmFj3+HzUiYzkaARnjK3f/qlz5MpbqRoObjtS/radR2uqXQoExBrcHo
         O6Pg==
X-Gm-Message-State: AOAM533uZKROgE1YEhbBxrtF5cqwp6Zauk2dqmu7UjULY1rUttw9AJFX
        4q5+th+aNE1BM8z/R/TkBHk8dLgi6HPQc9RRz6Q=
X-Google-Smtp-Source: ABdhPJwR1h6zOehcN/AWirorOEQ/LZRn+tKdDBjMOYKfIR81/wC0O6l5BWP7bqqGt9ykDY3cMep/LbVZYSReEeU0JPE=
X-Received: by 2002:aca:d5cd:: with SMTP id m196mr283571oig.138.1624308991083;
 Mon, 21 Jun 2021 13:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-18-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-18-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:56:20 -0400
Message-ID: <CAP+JOzTXCg-M_tveOpdeGnViD2nPe6qijGgW8hi0HBCJnCN=9w@mail.gmail.com>
Subject: Re: [PATCH 17/23] libsepol/cil: drop dead store
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:01 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> ../cil/src/cil_binary.c:2230:24: warning: Value stored to 'cb_node' durin=
g its initialization is never read [deadcode.DeadStores]
>         struct cil_tree_node *cb_node =3D node->cl_head;
>                               ^~~~~~~   ~~~~~~~~~~~~~
>
> Found by clang-analyzer
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 85094b01..601fe8d1 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -2227,7 +2227,7 @@ int cil_booleanif_to_policydb(policydb_t *pdb, cons=
t struct cil_db *db, struct c
>         int rc =3D SEPOL_ERR;
>         struct cil_args_booleanif bool_args;
>         struct cil_booleanif *cil_boolif =3D (struct cil_booleanif*)node-=
>data;
> -       struct cil_tree_node *cb_node =3D node->cl_head;
> +       struct cil_tree_node *cb_node;
>         struct cil_tree_node *true_node =3D NULL;
>         struct cil_tree_node *false_node =3D NULL;
>         struct cil_tree_node *tmp_node =3D NULL;
> --
> 2.32.0
>
