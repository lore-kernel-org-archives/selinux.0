Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9EBC433FE
	for <selinux@archiver.kernel.org>; Wed, 12 Oct 2022 15:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJLPis (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Oct 2022 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJLPim (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Oct 2022 11:38:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CECDD89A
        for <selinux@vger.kernel.org>; Wed, 12 Oct 2022 08:38:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c24so16601430plo.3
        for <selinux@vger.kernel.org>; Wed, 12 Oct 2022 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khenpMXStx74CtCp9wMjCCPwkyBVnrP1kqr0CFu8y/Y=;
        b=nuwr5PzZMqPxohsrJngYZe7vJeZs9vego39VCRUdC0CetfgM/MfikxB96aYaswtrAm
         MBvPPWun7GwjMQzERRxo6o4sUl/cTdhRqsnOSf7b0l0z3rEpnBk1Iq7u+9Gg1p4ew19T
         I+d2ET/R5GOeWXBJ4LlpenTnQJIDVzxJT9kaGSBN67nw7Lw0vd0R0GWmp+8IZP9Q6Vjv
         Irsb9R0ikmv91TP90eB1JDodiPdo5sAo87W8k0TdxInsNKreDXnXjU+j9n+Tw1cnWFfy
         2WkcMA0dHthuP0ab2RxOoop29yXw/lbfg6vT71BppDG+Uz6PRriIuH/oKYzs6acyTiJN
         oFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khenpMXStx74CtCp9wMjCCPwkyBVnrP1kqr0CFu8y/Y=;
        b=HS8AnfXuW1NzfVTJGCWwQFRd24lHMDznrmU+2BvYyDROpwD4q7H81bxEKKIIMmS9z3
         ukgCNEz3LDfGTwmh16sf3YJy05AIxSxpsiMLPAVNHg8P6NdFjw3mi+/LkudmAHQHBOup
         JsN2HURUyr674LDRD9+9RJnj4H8A36cyUV2dT4QlA59oAeRiGhbfkw3bStF2RU3IPoY9
         C0yuPR6DicxhiskEdoq1Cy5SY/uo6e6iL9WN9ZdM8ruRr+H//aEMuOInnPD7Cig/Ceue
         G3GhSVAdqGgRxMIoUZA/J3VEsPzPnMryalXoxuhcY3vAncurfw5niTTkj2RcCoeziVYh
         RRew==
X-Gm-Message-State: ACrzQf3DKbBLiJv628qMfwLOP3NKiROrHgBzki12Zf2A4FVvZOYJi/Pf
        nK9P66+A7PyjPwOKDAv3LNReqG3qFEKT2C1iKEA=
X-Google-Smtp-Source: AMsMyM4E1OyW1taHuAKEqnY3dn+bYHjXxTIvkpNjDDyT+ngRr4veSs/5D07oHyuYkH8bfPhIhcTliT6sI15b5DpKZAU=
X-Received: by 2002:a17:90b:3b82:b0:20b:516:5ff5 with SMTP id
 pc2-20020a17090b3b8200b0020b05165ff5mr5710453pjb.92.1665589121070; Wed, 12
 Oct 2022 08:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221012142751.17979-1-cgzones@googlemail.com>
In-Reply-To: <20221012142751.17979-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 12 Oct 2022 11:38:30 -0400
Message-ID: <CAP+JOzQr_1bBDAp=jyBb37cNFQKW0CDsixiM3aAcWSWAJtvQxg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: restore error on context rule conflicts
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Milos Malik <mmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 12, 2022 at 10:28 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Commit bc26ddc59c8d ("libsepol/cil: Limit the amount of reporting for
> context rule conflicts") reworked the processing of context rule
> conflicts to limit the number of written conflicting statements to
> increase readability of the printed error message.  It forgot to set the
> return value, signaling a context conflict, in the case the logging
> level is higher than warning (e.g. in semodule(8), which defaults to
> error).
>
> Reported-by: Milos Malik <mmalik@redhat.com> [1]
> Fixes: bc26ddc59c8d ("libsepol/cil: Limit the amount of reporting for con=
text rule conflicts")
>
> [1]: https://lore.kernel.org/selinux/87y1u1rkoo.fsf@redhat.com/
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_post.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 6e95225f..11e572e2 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -2290,6 +2290,7 @@ static int __cil_post_process_context_rules(struct =
cil_sort *sort, int (*compar)
>                 } else {
>                         removed++;
>                         if (!db->multiple_decls || concompar(&sort->array=
[i], &sort->array[j]) !=3D 0) {
> +                               rc =3D SEPOL_ERR;
>                                 conflicting++;
>                                 if (log_level >=3D CIL_WARN) {
>                                         struct cil_list_item li;
> @@ -2297,7 +2298,6 @@ static int __cil_post_process_context_rules(struct =
cil_sort *sort, int (*compar)
>                                         li.flavor =3D flavor;
>                                         if (conflicting =3D=3D 1) {
>                                                 cil_log(CIL_WARN, "Found =
conflicting %s rules\n", flavor_str);
> -                                               rc =3D SEPOL_ERR;
>                                                 li.data =3D sort->array[i=
];
>                                                 rc2 =3D cil_tree_walk(db-=
>ast->root, __cil_post_report_conflict,
>                                                                          =
               NULL, NULL, &li);
> --
> 2.37.2
>
