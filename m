Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1376C433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 18:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiFHS2t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jun 2022 14:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiFHS2r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jun 2022 14:28:47 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55286125
        for <selinux@vger.kernel.org>; Wed,  8 Jun 2022 11:28:46 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id p129so24469165oig.3
        for <selinux@vger.kernel.org>; Wed, 08 Jun 2022 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXjWmb38gJWuieSkhq6Ds3HCUiUfn5k/UKEUAlHji7g=;
        b=VEnLEsbk5UaUj1S/hGtKrPL3CezAHGm+U8+1CUfKJlE7O5Uk/gkJr8sqShLzNINdA+
         jFmJG69mm7cNbJEsoJxkULmMxXw04jsG1dIdrY/JPCzGvGZFx7V1cvYcGKupVsH9Yj3y
         O7BX7z/RviSTbYW41hMd0YMQ4xJ6O3nuuRoWfSidv6mWo6IIMPUlVSjISVYGC/onCnBn
         4MTFVufOIOHYryw7UhWcJqDzD5Lw6IGINfHTJxP2XOXuzTMDtLuki1RzgCvAPzai28gB
         Kt4Jn2j8owJ06V5PkI6OswnEoSZ3zJJ1NaKIuhKIyJHVE8VWT8Jd5JjwX9Ger32Ug7C8
         ZSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXjWmb38gJWuieSkhq6Ds3HCUiUfn5k/UKEUAlHji7g=;
        b=Yo624La5g6zD41xBgo6z33IWs+Z0WzxQIsLaISsq2fyQXW+oZl3CQwe1dlnnge0m8a
         4Qrg75bAPWP0fZDSXWBNmyFT+nbNZid1d1ZbMdNw4TctkxU34MZxIKsCLYYPfc8KiMVR
         ztevPWMT8QLa8IxDnXulPzJvyIwp9IPUcPZXBRjyjmValBk01hTjM8CcNBnqxv6E5uUq
         mRlhAawYi1RVJj7b0hPDn2SG/pESphZABMSnhhe6qXODJ6crPZ61NzFKTt5krctqC1Em
         8jUr0J1c3L8HPZvLC7VPwbh5wE3pP/t40qFpi/iw/sE66dIVXFmNxqzaJf617e3uw6gn
         l7oA==
X-Gm-Message-State: AOAM531ALnebSOnfPdVITnA7soxIJop3BENqtTVvVfAYDXWF6J6t39vq
        YCyoNh8WTn7aaEZwfMdJXo7ZnK00Yj1qxeoLxpiKsBWZi84=
X-Google-Smtp-Source: ABdhPJyeGOuhWfaX9ab0TYIwgnXzXT2XW+2he9fKF9wahZ4f+rpAdI09Iz3zrbhfHnNOI59O2l+mu3xNmZdVpODgfEM=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr3184988oiv.156.1654712925738; Wed, 08
 Jun 2022 11:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220607115557.492447-1-plautrba@redhat.com>
In-Reply-To: <20220607115557.492447-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 8 Jun 2022 14:28:34 -0400
Message-ID: <CAP+JOzTkrBTKijb2Ojes7s3JKNgNS4DhAdveSKsCez=GtOoPJg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Drop unused assignment
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 7, 2022 at 8:55 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Fixes:
> cil/src/cil_build_ast.c:4622:4: warning[deadcode.DeadStores]: Value stored to 'rc' is never read
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_build_ast.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 26fa79069b96..4177c9f6778c 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -4619,7 +4619,6 @@ int cil_gen_genfscon(struct cil_db *db, struct cil_tree_node *parse_current, str
>                         } else {
>                                 cil_log(CIL_ERR, "Invalid file type \"%s\"\n", file_type);
>                         }
> -                       rc = SEPOL_ERR;
>                         goto exit;
>                 }
>                 context_node = parse_current->next->next->next->next;
> --
> 2.36.1
>
