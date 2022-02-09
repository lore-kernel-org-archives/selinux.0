Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689F6C433F5
	for <selinux@archiver.kernel.org>; Wed,  9 Feb 2022 20:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiBIUfv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Feb 2022 15:35:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiBIUfq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Feb 2022 15:35:46 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AFAC1DF64A
        for <selinux@vger.kernel.org>; Wed,  9 Feb 2022 12:35:49 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso3840357oop.9
        for <selinux@vger.kernel.org>; Wed, 09 Feb 2022 12:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HNDb6WV+l9uHYSeiL8Y3ZiA10pJn1e9QRiv2CSaELSE=;
        b=m/6XP5s8/8w3e4TYuz3skBoHv97tWB8g+MT7UACe7dW5mDKEScV3zk06kblMd1H5tS
         scRf/1IqVgC5MQLtmEVCdRcBZCKjwTkHGPIfk6ZBuQwlBFwoARcN0MLKOq3DxJ8EC2zG
         URPvvHPvRszphXZLpparJqqHxTJ704yPeR8l4lZSTu+uSXEYUUO2sp/tJiBIOcezGdxv
         9NqLQo7dffBm67LoIfN6c6xETIFU7Yd0uyz5gPmcMcc1jMsdiq4usTpEx1ymNjmIFYzS
         DTXZ5lJ9tpcQSyN9yOZT0Qqqz/Z2GFyut9CLX1NdMKWhCrYwCV174WpWBXr5YLXYRNHa
         tRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HNDb6WV+l9uHYSeiL8Y3ZiA10pJn1e9QRiv2CSaELSE=;
        b=waTUia833SbTZIPiaxx29moK/8PcmbXyadoNOa84v7Qmfrdsfh6XgY7gp3UrskdWCY
         flh5J4AeUsz/RNQfkAIEfSdXZl6bez5UtnzD7z37GspwPNqK+hGVdCwN7k8MKFcE4T79
         vm6/fTpOMe0+Ft3JmvqQZJPyn5JAMO3dN2PmtbrBJZuMHgWEnRIrR6HEo/4DFZpemRJu
         JEuYVKrBhu8ASb1mJja/I/Ug0TbBo/L2Pdq9AVW6vgIskXeOnxsoB1/Of0omE13xQCm8
         fptfSRyWQHmXt1smMX9lgEjUJ7xiKUishvjXIpTFvnaQy1/0VMYQkdWU/IuuCxWrY+Js
         vryw==
X-Gm-Message-State: AOAM533RqXGTo/RynUm/BCYENY9QCJPmcKtPdKMSrd7NlvTrsbQ3lqLd
        uF2eQGXEKfaeRfB48qjzd16Ch0vg2Mnu96nvmHY=
X-Google-Smtp-Source: ABdhPJyoHhJnHgT7zvkc4fEOAw7BqpxgFEJZnhM7+zXo48hHqnC6bYanjgd1hKHzeYx9E3QKWdB2V22XxUbQLaeUuu8=
X-Received: by 2002:a05:6871:506:: with SMTP id s6mr1389635oal.62.1644438948626;
 Wed, 09 Feb 2022 12:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20220204133717.27793-1-cgzones@googlemail.com>
In-Reply-To: <20220204133717.27793-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Feb 2022 15:35:37 -0500
Message-ID: <CAP+JOzQAJm1BCcMzKELxfwd8+06ckLCG1Ft-twMiZ5N-ED3sVg@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: allow wildcard permissions in constraints
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 4, 2022 at 3:04 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Allow all and complement permission sets in constraints, e.g.:
>
>     constrain service ~ { status } (...);
>     constrain service * (...);
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/policy_define.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index b2ae3263..ded19570 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -3590,6 +3590,16 @@ int define_constraint(constraint_expr_t * expr)
>                         cladatum =3D policydbp->class_val_to_struct[i];
>                         node =3D cladatum->constraints;
>
> +                       if (strcmp(id, "*") =3D=3D 0) {
> +                               node->permissions =3D ~UINT32_C(0);
> +                               continue;
> +                       }
> +

If the class has less than 32 permissions, then bits will be set for
non-existent permissions.

> +                       if (strcmp(id, "~") =3D=3D 0) {
> +                               node->permissions =3D ~node->permissions;
> +                               continue;
> +                       }
> +

If "~" is used on a list of all of the classes permissions, then there
will be no permissions. If the policy is then turned back into a
policy.conf, there will be no permissions and the constraint will have
an invalid permission. (Obviously, a problem with the kernel_to_conf
routines that needs to be fixed). The right thing is to drop the
constraint in this case since it isn't valid for any permissions. (I
see now that the CIL compiler doesn't handle this correctly either.)

I am fine with the overall idea here.

Thanks,
Jim


>                         perdatum =3D
>                             (perm_datum_t *) hashtab_search(cladatum->
>                                                             permissions.
> --
> 2.34.1
>
