Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5B0C433EF
	for <selinux@archiver.kernel.org>; Mon,  7 Feb 2022 18:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiBGS5m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Feb 2022 13:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiBGSzh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Feb 2022 13:55:37 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE28AC0401DC
        for <selinux@vger.kernel.org>; Mon,  7 Feb 2022 10:55:36 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so11592189ota.10
        for <selinux@vger.kernel.org>; Mon, 07 Feb 2022 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HLHcQpnmmLr5fD0Y0BeC0ScUaYVGh6aOjiWvI6sOWeY=;
        b=mwU6vQHKnlL4ePKAs018Uwz6QL1t6LfJxBn1a3O0ITWLlll8euugpv2ACX1cGoox0l
         zXKRMMOyfNRGbiVg4meDMbhoyLIgZ4H1Vswx9TPjs3rTSbKFHsbfLZ1HnbllEQI+2UI1
         xlgzWgb6vfqxAOEuKBkk2+i52bJD2UjhjFz4Y1gSDXT3pmDAze9qTCq45TYaKr28QJTO
         jF0+2oUsgZzTHXrU+/AwVCOTZhscZ5xSvouEcWYTq2Aj466RYM3Rh+k9suJNBkJH5Zau
         j0f9QLXwBYGQfbwOT5cDxTFKrg0O5HThJQ3EDl+Sn8IDd9OkkC5EsCF1YdWramGkrxKl
         Mpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HLHcQpnmmLr5fD0Y0BeC0ScUaYVGh6aOjiWvI6sOWeY=;
        b=hqHOnn2KUxlQwy/71Z50FsOKMTm7s+CWDpHju4g7GKbUGwZEj2yulozdu9JbM/o9ep
         KUFjIriBzSvc+yaWWEdumBEr9e1ew2+OAusJhGu0ChZmYq3+tvcdjArHHwIUvrOaz9JO
         l0jLLocQJ+OAt6LwzHfs6WJ0VN1QbU/0zf2lk+LN3i0uEgUjvDYUhZhAvg8gdPyCvZZj
         ObRSQOaUON+YMiXZwZLgY+kJtjSQGj2YT7XFCuSUWaFVaKIIKryzodlZLsddC7YdsV9v
         byQnswzmVVCVNurlkjlQGFfkmCgYu8u5GovmTFXQ1zP95NcMNxJC46RVG9MAOjtt5BQw
         VBhg==
X-Gm-Message-State: AOAM533aoufuoqGDJHNf12cbNRa5wN1kvsWHP5BHDRyt9m0+l89FNQoX
        MfXyq9/kZoYDsZP/m5RaeswysCN7k0u1jamQlZQYW9Zn
X-Google-Smtp-Source: ABdhPJzPMd1d+MhydQlJNqa0Q3hh5ju/oEtZcD6Gj9QQzKzZC1TrBYVpyZXBCpYMZ0CQIXB6fhJYTq3ki60tzStKdDw=
X-Received: by 2002:a9d:70cf:: with SMTP id w15mr513594otj.154.1644260135948;
 Mon, 07 Feb 2022 10:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20220105211602.359300-1-jwcart2@gmail.com>
In-Reply-To: <20220105211602.359300-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 7 Feb 2022 13:55:25 -0500
Message-ID: <CAP+JOzThuDcN_RpT8oZw-NBos0LbxEt=BkK5jgKGRV_skPadtw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol/cil: Do not copy blockabstracts when
 inheriting a block
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

FYI, I plan on merging this series at the end of the week. If anyone
has any objections, please let me know.
Jim

On Wed, Jan 5, 2022 at 4:16 PM James Carter <jwcart2@gmail.com> wrote:
>
> Do not copy any blockabstract statements when copying a block to
> resolve a blockinherit statement. Inheriting a block from what was
> just inherited does not work, so there is no reason to create an
> abstract block.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_copy_ast.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> index 2fad972c..a4ead9db 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -1725,6 +1725,12 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished, void
>                 copy_func = &cil_copy_block;
>                 break;
>         case CIL_BLOCKABSTRACT:
> +               if (args->orig_dest->flavor == CIL_BLOCKINHERIT) {
> +                       /* When inheriting a block, don't copy any blockabstract
> +                        * statements. Inheriting a block from a block that was
> +                        * just inherited never worked. */
> +                       return SEPOL_OK;
> +               }
>                 copy_func = &cil_copy_blockabstract;
>                 break;
>         case CIL_BLOCKINHERIT:
> --
> 2.31.1
>
