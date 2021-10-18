Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF21C433F5
	for <selinux@archiver.kernel.org>; Mon, 18 Oct 2021 19:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044AB61002
	for <selinux@archiver.kernel.org>; Mon, 18 Oct 2021 19:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhJRT7X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Oct 2021 15:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhJRT7X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Oct 2021 15:59:23 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099D7C06161C
        for <selinux@vger.kernel.org>; Mon, 18 Oct 2021 12:57:12 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso1250408otp.5
        for <selinux@vger.kernel.org>; Mon, 18 Oct 2021 12:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hfwz25wvdaTmjWJpK6/a6QHTSwEfu7uUgJy28Y+GOlg=;
        b=X76IHddXeWYaDJvTALewHWwXx7H2wJtXCNQuR3UXULYRlPh7bcQCeFN4BINHSRUYme
         lLu10SluXq1gxrWDTAjkBQSahv9UilQSKinZnllX5/5/I1OpreEeeDPllhi6ft+AQBw0
         OxbcVRB/KbdAvQc67Jdo6EcHvCrs0lJ4eOr67YX8syo0saVa+9qurhQHOEFkQJsUhuAo
         +nImrkOXhi6KyxrC3T+KTSEfSj9E7Z5i91BLmHz/kqMroJSFt7NKxU5LytXcU8sHEHR6
         /7xnvctUEd9CtaiKUAAiEIDN91nZGPMvibdvkv/APE4jqFThRz0BDWeAOKlekf4Exp8e
         gVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hfwz25wvdaTmjWJpK6/a6QHTSwEfu7uUgJy28Y+GOlg=;
        b=Ogqu87xlk3AmRxwExV0nvIRB2IlXQmXFsfuay9Iy+jqqnzZVeRj8+OwabFnXsBFRkA
         Tn+i37CbgSTpUg2LBklMjn82Hg0M9LikQPsoW9mw7SIRA/3wy0VXfyNJLm83UpuV+5Tu
         KLz1WLJjhOGG+CRCIYZl7jjfQd1Fafp8xhM1Yj0QvZJdagMNNizk7grPaSxNZ3O4QD4v
         Fb8MpDmhXUgpdy2OnVtj/quxFxEs+CIL9GjvZKbsMOrY/GksaZYv+6f8eoZMQnIjTn4u
         v2PlL0wv0Fo8GKdsHMyH+ZPKFmzaevOH3CNYNQugZeC+lphbf++dAV4TRWHFXkJpjRG2
         joHQ==
X-Gm-Message-State: AOAM531Y3gCCeYUT3322UsXhj+Y+9WUZcRJVrFchjtQu2TLd3bk9aWr1
        IyR9PjnlqoR0PLFY4ut2oxRDAqa0BbHWCFLPb8b6RJXp
X-Google-Smtp-Source: ABdhPJysUmFIdVDdU3TefgaN+s8snSxCkPtZTsXi3GjgUVqm2Q69y0iOIjqoKr8y1v9ljmRtPvc5mEqm7gw066bfsNk=
X-Received: by 2002:a9d:7182:: with SMTP id o2mr1607920otj.53.1634587031429;
 Mon, 18 Oct 2021 12:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211011162533.53404-15-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-15-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 Oct 2021 15:57:00 -0400
Message-ID: <CAP+JOzQY596M+nOLCTKn1+3tMgpJDMcLJonCrh8D9VbspxG44A@mail.gmail.com>
Subject: Re: [RFC PATCH 14/35] libsepol: reject invalid fsuse types
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 12:41 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Reject loading a policy with invalid fsuse declarations, except xattr,
> trans and task, so that all following code, e.g. the different output
> modes, do not need to handle unsupported ones.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 70b503e1..980af059 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -48,6 +48,7 @@
>  #include <sepol/policydb/expand.h>
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/avrule_block.h>
> +#include <sepol/policydb/services.h>
>  #include <sepol/policydb/util.h>
>
>  #include "kernel_to_common.h"
> @@ -3099,6 +3100,14 @@ static int ocontext_read_selinux(const struct poli=
cydb_compat_info *info,
>                                 if (rc < 0)
>                                         return -1;
>                                 c->v.behavior =3D le32_to_cpu(buf[0]);
> +                               switch (c->v.behavior) {
> +                               case SECURITY_FS_USE_XATTR:
> +                               case SECURITY_FS_USE_TRANS:
> +                               case SECURITY_FS_USE_TASK:
> +                                       break;
> +                               default:
> +                                       return -1;
> +                               }
>                                 len =3D le32_to_cpu(buf[1]);
>                                 if (zero_or_saturated(len))
>                                         return -1;
> --
> 2.33.0
>

I think that I would prefer this to be in policydb_validate.c
somewhere. Eventually it would be nice to call validate_policydb() on
a policydb before writing it as well as after reading it.

Thanks,
Jim
