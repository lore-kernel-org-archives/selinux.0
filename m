Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BDDC07E9C
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 07:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3483D61606
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 07:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbhGLHpN convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 03:45:13 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:49002 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbhGLHif (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 03:38:35 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3C500564C4B
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 09:35:46 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id b12so5802005plh.10
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 00:35:46 -0700 (PDT)
X-Gm-Message-State: AOAM533d2NQ96mI4xoHNKtBNu46WmRWYCCAnNp13mfF+Yl7L26O+n8MF
        FTKH0CwoDaZBME0dh1UkG+JBLh5V9KfQ5khdlOs=
X-Google-Smtp-Source: ABdhPJxByrCtafQbK9iitXJ7Ck5qVYUoDFBK0zfg0L40fzBPKFFK920SO5hNBgybFSbsG15cdZNlvOXDjZALOMA5eAA=
X-Received: by 2002:a17:902:70c6:b029:12a:7a50:c723 with SMTP id
 l6-20020a17090270c6b029012a7a50c723mr18085155plt.61.1626075344933; Mon, 12
 Jul 2021 00:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-14-cgzones@googlemail.com> <20210701180707.120172-1-cgzones@googlemail.com>
In-Reply-To: <20210701180707.120172-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 12 Jul 2021 09:35:34 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==-in9CtKJwagwFV3btKt2KqfLQQ9v2Tu75VdN18cYOJA@mail.gmail.com>
Message-ID: <CAJfZ7==-in9CtKJwagwFV3btKt2KqfLQQ9v2Tu75VdN18cYOJA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libsepol: assure string NUL-termination of ibdev_name
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Jul 12 09:35:46 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 1, 2021 at 8:07 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Clang complains:
>
>     ibendport_record.c: In function ‘sepol_ibendport_get_ibdev_name’:
>     ibendport_record.c:169:2: error: ‘strncpy’ specified bound 64 equals destination size [-Werror=stringop-truncation]
>       169 |  strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
>           |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     ibendport_record.c: In function ‘sepol_ibendport_set_ibdev_name’:
>     ibendport_record.c:189:2: error: ‘strncpy’ specified bound 64 equals destination size [-Werror=stringop-truncation]
>       189 |  strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX);
>           |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> strncpy(3) does not NUL-terminate the destination if the source is of
> the same length or longer then the specified size.
> The source of these copies are retrieved from
> sepol_ibendport_alloc_ibdev_name(), which allocates a fixed amount of
> IB_DEVICE_NAME_MAX bytes.
> Reduce the size to copy by 1 of all memory regions allocated by
> sepol_ibendport_alloc_ibdev_name().
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

> ---
> v2:
>   - use at all affected places as pointed out by James Carter
>
>  libsepol/src/ibendport_record.c | 8 ++++----
>  libsepol/src/ibendports.c       | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/src/ibendport_record.c b/libsepol/src/ibendport_record.c
> index adf67161..1eb50914 100644
> --- a/libsepol/src/ibendport_record.c
> +++ b/libsepol/src/ibendport_record.c
> @@ -62,7 +62,7 @@ int sepol_ibendport_key_create(sepol_handle_t *handle,
>         if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_key->ibdev_name) < 0)
>                 goto err;
>
> -       strncpy(tmp_key->ibdev_name, ibdev_name, IB_DEVICE_NAME_MAX);
> +       strncpy(tmp_key->ibdev_name, ibdev_name, IB_DEVICE_NAME_MAX - 1);
>         tmp_key->port = port;
>
>         *key_ptr = tmp_key;
> @@ -166,7 +166,7 @@ int sepol_ibendport_get_ibdev_name(sepol_handle_t *handle,
>         if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_ibdev_name) < 0)
>                 goto err;
>
> -       strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
> +       strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX - 1);
>         *ibdev_name = tmp_ibdev_name;
>         return STATUS_SUCCESS;
>
> @@ -186,7 +186,7 @@ int sepol_ibendport_set_ibdev_name(sepol_handle_t *handle,
>         if (sepol_ibendport_alloc_ibdev_name(handle, &tmp) < 0)
>                 goto err;
>
> -       strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX);
> +       strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX - 1);
>         free(ibendport->ibdev_name);
>         ibendport->ibdev_name = tmp;
>         return STATUS_SUCCESS;
> @@ -230,7 +230,7 @@ int sepol_ibendport_clone(sepol_handle_t *handle,
>         if (sepol_ibendport_alloc_ibdev_name(handle, &new_ibendport->ibdev_name) < 0)
>                 goto omem;
>
> -       strncpy(new_ibendport->ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
> +       strncpy(new_ibendport->ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX - 1);
>         new_ibendport->port = ibendport->port;
>
>         if (ibendport->con &&
> diff --git a/libsepol/src/ibendports.c b/libsepol/src/ibendports.c
> index 6d56c9a1..ee5cb193 100644
> --- a/libsepol/src/ibendports.c
> +++ b/libsepol/src/ibendports.c
> @@ -34,7 +34,7 @@ static int ibendport_from_record(sepol_handle_t *handle,
>                                            &ibdev_name) < 0)
>                 goto err;
>
> -       strncpy(tmp_ibendport->u.ibendport.dev_name, ibdev_name, IB_DEVICE_NAME_MAX);
> +       strncpy(tmp_ibendport->u.ibendport.dev_name, ibdev_name, IB_DEVICE_NAME_MAX - 1);
>
>         free(ibdev_name);
>         ibdev_name = NULL;
> --
> 2.32.0
>

