Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A029C433E9
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6217E23442
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 19:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbhATSnZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404384AbhATS1r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jan 2021 13:27:47 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6911C061575
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 10:27:03 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id j21so5996022oou.11
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 10:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LI/IVhYXuaNjTK7pZ4jpZ7oa9bT6c7zim1UtTH9NDC8=;
        b=kbyKA7vXVLnZXXA7es8h87hFv8I3f6SF7z5Z/0bBggFX4nIQ7UU1BApwILZON5bMCR
         HE4G34EvVr7zWKzqzX7OdvD/6GHgpTR05mWWVyG54ovq4FxnQsAWkOyRzwc5v1iUz11b
         WRqErO4/e4JyzBG8LIh4qPl2idOVghJnpnCNtvKGWW16YtEr7Eh4PwLMY85BJZASpAn2
         95jP9RAzE8RHmvjmNP05A4gokBKreJNPdLdOWp/cXMTrLU6Pb+YqCkfMpwCdHJZVyM2p
         RAtWz9Af6GVOO0pALxxG8eY88nrxf5Lov5UElOc62Vk+5t49HNKNlFmmmmDOuad2N7Dw
         WwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LI/IVhYXuaNjTK7pZ4jpZ7oa9bT6c7zim1UtTH9NDC8=;
        b=s80SEDsK1JKSSwBfPaCuA/7wW562022LE3sBC6vG9FvwWAtniAjmI2Uhb34ci4JmUK
         aLQ2NlcQEs03Y40XLNDL6vTw8liJ0itqRi9Q3QAo7O5jzxkpOLcZN6jYPEzAMvZdMhby
         AFpaszbRqS1TSfjIlR1Qz55YI84ijy+BNE6045lhtOqKryZr/u2mCMPTOk8fuwS4WWmV
         UbsCz387UyePy6HP/veoky3kPVRTiFdFscOh3FPSU4dSNb3R0XleeK1zUwRJmStfUH+m
         7HWSOL0fn+Z9P41eEPQSx0NHRypf8hFaZAzsi603TlQNVfKn05ygTMgOXGnxkkidV12H
         +68Q==
X-Gm-Message-State: AOAM530xaPv6VM0sMPUFeePlQ6aF5j5A3ZUQiJjYGP8D3oQ95Xx7iw0y
        Shuy5+gBpjuOclrA7aLoYyQdvqlhn+lABjN4eV0Bs+sn
X-Google-Smtp-Source: ABdhPJyqipo4Ye0JSdzePtiGm/CPKMZ9nxZ0tqBIG8liA2wqED06i8HcrrS01m/3T+w1oxLIcg8sVJ/aBZ87IOBfCBA=
X-Received: by 2002:a4a:c692:: with SMTP id m18mr6916364ooq.59.1611167223116;
 Wed, 20 Jan 2021 10:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20210120161321.13656-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210120161321.13656-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 20 Jan 2021 13:26:52 -0500
Message-ID: <CAP+JOzTiMd7-bghRsbUyrqz2jbPYU2zvvE=_DGC9WMyCVGtxiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] libsepol: do not decode out-of-bound rolebounds
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 20, 2021 at 11:13 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> While fuzzing /usr/libexec/hll/pp, a policy module was generated with a
> role->bounds larger that the number of roles in the policy.
>
> This issue has been found while fuzzing hll/pp with the American Fuzzy
> Lop.
>
> This patch was suggested by James Carter <jwcart2@gmail.com> in
> https://lore.kernel.org/selinux/CAP+JOzQc3yXczhk5JfUrr+6rFe3AXis+yJAukCFbz=aQotriQQ@mail.gmail.com/T/#mdd4bed0972c7c6f339e28270f73e9b7b09bb359f
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/policydb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index f5809315cc08..08c4cb18efcf 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1030,6 +1030,8 @@ static int role_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>                 return -EINVAL;
>         if (p->p_role_val_to_name[role->s.value - 1] != NULL)
>                 return -EINVAL;
> +       if (role->bounds > p->p_roles.nprim)
> +               return -EINVAL;
>         p->p_role_val_to_name[role->s.value - 1] = (char *)key;
>         p->role_val_to_struct[role->s.value - 1] = role;
>
> @@ -1049,6 +1051,8 @@ static int type_index(hashtab_key_t key, hashtab_datum_t datum, void *datap)
>                         return -EINVAL;
>                 if (p->p_type_val_to_name[typdatum->s.value - 1] != NULL)
>                         return -EINVAL;
> +               if (typdatum->bounds > p->p_types.nprim)
> +                       return -EINVAL;

This is very tricky, but for both of these the bounds value cannot be
0 or >= nprim because the value -1 is used as an index.

It has taken me longer than I thought it would, but I am almost ready
to send out a patch that should check everything in a policydb_t after
it is read in. Maybe by the end of the day, but definitely before the
end of the week.

Thanks,
Jim

>                 p->p_type_val_to_name[typdatum->s.value - 1] = (char *)key;
>                 p->type_val_to_struct[typdatum->s.value - 1] = typdatum;
>         }
> --
> 2.30.0
>
