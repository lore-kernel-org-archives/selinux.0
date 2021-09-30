Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6089C433F5
	for <selinux@archiver.kernel.org>; Thu, 30 Sep 2021 19:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B222661528
	for <selinux@archiver.kernel.org>; Thu, 30 Sep 2021 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbhI3TmA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Sep 2021 15:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhI3Tl7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Sep 2021 15:41:59 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35513C06176A
        for <selinux@vger.kernel.org>; Thu, 30 Sep 2021 12:40:16 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so8764992otb.1
        for <selinux@vger.kernel.org>; Thu, 30 Sep 2021 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yrml7JPmScrZNlbR7M6+97aI78/cbfg3943e6ADiQDM=;
        b=lnaKxOhCQneVm7hGdJKit8tk2jJRCyDMG4CZlFGZc6mNEEG9Rt9zRJ4fJ42YnTXNFm
         W4MS14uboTla2y+CHW0pjh90AajjAiuuAs7Lbx5MlVocjhxLvdIb6yaaUBmFxPyUFZR5
         sFl5fAzuC+KUu/97aSAZBI/D3+KgQH70/TYAeoinbVGLcHvpnZYxZ6SeXZx/l9FDULSh
         Lv5pKv6LPyv+D3OphcnZpHJ9RVgRwdoPYxGQCAKAaEv1nv8wnies6iACe4CKRS8CBIc1
         5asLm7j5ut965gDln4n1XleoNFVgab3ST+/RRqULSwxrPxFRFUGMW7a7bEIxiRJ7PTX9
         giNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yrml7JPmScrZNlbR7M6+97aI78/cbfg3943e6ADiQDM=;
        b=qWFahHD8O6GFSWqZLtu0Fq8qTbkvX/Uai0QXcb03XdYOEp/qKq3xpOVGUFLhFwbOZW
         pkanJeXYR5hBYw8nr+Lzu46WdY6rZvy1C+eEKAX5s077XIxscWBNIZ8oj/zrVsml2LnU
         4mIufRKbKMP6uTOA9xCMkFBfWk8JMwVK/GCCp7lkH51iXqjqJHPEWmToKY1MB8ste2+C
         u2k9g/WVyObT+aYFCgqhnR/Mxb5Q7FGn1i+xwp699TZKPDW2HIxvr9LcIH+eshbM652P
         vb1JVSrHiarqbjahYkP0mFP2xPMsd48HASNG+aFjohc88bCwWrBiMty2pDiMr39UyAh7
         /Vfw==
X-Gm-Message-State: AOAM531u8f4Xltb2rTRII6gHHE7ZUpUT7XkuuEEcfLlB3cLpXdL0Pz+m
        Xzx6rbx/jO4mtA5HltA05ljqFVbTe2gT6Yndm4k1AVJ8+Ac=
X-Google-Smtp-Source: ABdhPJzQXrao3QMzkwCMwvdzuZDqAzG3F3hA44vtNzlkrbswsS0tleLJaus6THKhYP2F8oJmAmN6RdDN1HNmnzxqZM8=
X-Received: by 2002:a9d:6399:: with SMTP id w25mr6822911otk.53.1633030815473;
 Thu, 30 Sep 2021 12:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154620.11181-1-cgzones@googlemail.com>
In-Reply-To: <20210928154620.11181-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 30 Sep 2021 15:40:04 -0400
Message-ID: <CAP+JOzSgGga6pG6QG1t-20vhm3B3yp9g=SrXLnXYGD36oyee4A@mail.gmail.com>
Subject: Re: [PATCH 1/9] libsepol: ebitmap: mark nodes of const ebitmaps const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 28, 2021 at 11:47 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Mark pointers to nodes of const ebitmaps also const. C does not enforce
> a transitive const-ness, but it clarifies the intent and improves
> maintainability.
>
> Follow-up of 390ec54d278a
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For all 9 patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/ebitmap.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index 4e9acdf8..1de3816a 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -17,7 +17,8 @@
>
>  int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * =
e2)
>  {
> -       ebitmap_node_t *n1, *n2, *new, *prev;
> +       const ebitmap_node_t *n1, *n2;
> +       ebitmap_node_t *new, *prev;
>
>         ebitmap_init(dst);
>
> @@ -154,7 +155,7 @@ int ebitmap_hamming_distance(const ebitmap_t * e1, co=
nst ebitmap_t * e2)
>
>  int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2)
>  {
> -       ebitmap_node_t *n1, *n2;
> +       const ebitmap_node_t *n1, *n2;
>
>         if (e1->highbit !=3D e2->highbit)
>                 return 0;
> @@ -175,7 +176,8 @@ int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t=
 * e2)
>
>  int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
>  {
> -       ebitmap_node_t *n, *new, *prev;
> +       const ebitmap_node_t *n;
> +       ebitmap_node_t *new, *prev;
>
>         ebitmap_init(dst);
>         n =3D src->node;
> @@ -204,7 +206,7 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * sr=
c)
>
>  int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2)
>  {
> -       ebitmap_node_t *n1, *n2;
> +       const ebitmap_node_t *n1, *n2;
>
>         if (e1->highbit < e2->highbit)
>                 return 0;
> @@ -231,8 +233,8 @@ int ebitmap_contains(const ebitmap_t * e1, const ebit=
map_t * e2)
>
>  int ebitmap_match_any(const ebitmap_t *e1, const ebitmap_t *e2)
>  {
> -       ebitmap_node_t *n1 =3D e1->node;
> -       ebitmap_node_t *n2 =3D e2->node;
> +       const ebitmap_node_t *n1 =3D e1->node;
> +       const ebitmap_node_t *n2 =3D e2->node;
>
>         while (n1 && n2) {
>                 if (n1->startbit < n2->startbit) {
> @@ -253,7 +255,7 @@ int ebitmap_match_any(const ebitmap_t *e1, const ebit=
map_t *e2)
>
>  int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit)
>  {
> -       ebitmap_node_t *n;
> +       const ebitmap_node_t *n;
>
>         if (e->highbit < bit)
>                 return 0;
> --
> 2.33.0
>
