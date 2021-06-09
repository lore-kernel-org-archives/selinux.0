Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C27C48BCD
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 13:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A052761285
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 13:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhFINtt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236336AbhFINts (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jun 2021 09:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623246474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qVAlp3bLEa1w8zODj1kmIXVkCuBqo3ZYEXEPzVkEhk=;
        b=G844LtehOZX5/P0bc2Zrr9r4c7TOzWHqa7HGvteGHADsWvWmI5SNiHJgcZMZEHRUpvCU+l
        zroZs09fjv7kEYH20P8fYY7+Mjsz763I95XAlNH+xkM0S5FwWWYBLH/v1j0wVbrcQId1vY
        MJyBKsVQQAer3RVZ7mRhd3KNOcoQYfs=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-zmsqU2v4P2aB6a5E3FdqFQ-1; Wed, 09 Jun 2021 09:47:52 -0400
X-MC-Unique: zmsqU2v4P2aB6a5E3FdqFQ-1
Received: by mail-yb1-f198.google.com with SMTP id v28-20020a25fc1c0000b0290547fac9371fso8923475ybd.14
        for <selinux@vger.kernel.org>; Wed, 09 Jun 2021 06:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2qVAlp3bLEa1w8zODj1kmIXVkCuBqo3ZYEXEPzVkEhk=;
        b=iP7UDbHvzOMcxysQoC5utOEjp/NaaJneXprJlgKUKjCqcPlZxwKOz1dzNpQdXfhAzR
         oZjN18NyM3v7bV/Q7q2ETKJNt13r5q+4RrubUP1OGL90wwzx31giTj/fypXy9gR7IILi
         T3oZVx121L0CSY7F+F/1k4jjor4e9a0oZFwX95va0uwyGcwODRFCB3R39ZRLASm7aV5U
         2w4RB6ol6SIvr1gY8zk5Xmn4w3qYX3griZwiFjxX5oV8CTYDvFfsTwqJWGBua38c3wZG
         YcZGDCmfs5ah1Gm01senNte+cw01W0177XqC+Xl3rKMjGDO/W2o54k5vg0N6abr/f+hN
         vkjA==
X-Gm-Message-State: AOAM531F7479+EeY2nOGlA8ishDBatA0xo+0765fl33UdoUizASbf0X/
        jODPP8FTUCoJfvGv+8R9uRMj2jvBxh0RKMzQHNDUtM/rMpqkXAiwx3Ubf0c0fk8a56zDZJFyD/4
        XZlTyoonurbZT/u+OP16oDdaVU/2Dut6jAQ==
X-Received: by 2002:a25:660b:: with SMTP id a11mr167863ybc.172.1623246471587;
        Wed, 09 Jun 2021 06:47:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxov43iIdxJwocX4P4VNVHB40kx8RjHX0nfU8tVcIIrinSib2HBHe3pfTfRFdMqamtzu9ZrWCV2KtRwbNHJito=
X-Received: by 2002:a25:660b:: with SMTP id a11mr167840ybc.172.1623246471411;
 Wed, 09 Jun 2021 06:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-6-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-6-cgzones@googlemail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 9 Jun 2021 15:47:40 +0200
Message-ID: <CAFqZXNvZL+1TKUeJpa_npxBpoQJq_0dHDTYYkXXSU8XtZK=sdA@mail.gmail.com>
Subject: Re: [PATCH 05/23] libsepol: avoid implicit conversions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 5:59 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Avoid implicit conversions from signed to unsigned values, found by
> UB sanitizers, by using unsigned values in the first place.
>
> expand.c:1644:18: runtime error: implicit conversion from type 'int' of v=
alue -1 (32-bit, signed) to type 'uint32_t' (aka 'unsigned int') changed th=
e value to 4294967295 (32-bit, unsigned)
>
> expand.c:2892:24: runtime error: implicit conversion from type 'int' of v=
alue -2 (32-bit, signed) to type 'unsigned int' changed the value to 429496=
7294 (32-bit, unsigned)
>
> policy_define.c:2344:4: runtime error: implicit conversion from type 'int=
' of value -1048577 (32-bit, signed) to type 'unsigned int' changed the val=
ue to 4293918719 (32-bit, unsigned)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/include/sepol/policydb/conditional.h | 2 +-
>  libsepol/include/sepol/policydb/policydb.h    | 2 +-
>  libsepol/src/expand.c                         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol/inc=
lude/sepol/policydb/conditional.h
> index 9c3df3ef..db3ef98d 100644
> --- a/libsepol/include/sepol/policydb/conditional.h
> +++ b/libsepol/include/sepol/policydb/conditional.h
> @@ -90,7 +90,7 @@ typedef struct cond_node {
>         uint32_t expr_pre_comp;
>         struct cond_node *next;
>         /* a tunable conditional, calculated and used at expansion */
> -#define        COND_NODE_FLAGS_TUNABLE 0x01
> +#define        COND_NODE_FLAGS_TUNABLE 0x01U

UINT32_C(0x01) would be better here.

>         uint32_t flags;
>  } cond_node_t;
>
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 9ef43abc..c29339dc 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -253,7 +253,7 @@ typedef struct class_perm_node {
>
>  #define xperm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
>  #define xperm_set(x, p) (p[x >> 5] |=3D (1 << (x & 0x1f)))
> -#define xperm_clear(x, p) (p[x >> 5] &=3D ~(1 << (x & 0x1f)))
> +#define xperm_clear(x, p) (p[x >> 5] &=3D ~(1U << (x & 0x1f)))

Ditto here (used on av_extended_perms_t::perms, which is uint32_t).
And xperm_test() and xperm_set() should be also updated in the same
way.

>  #define EXTENDED_PERMS_LEN 8
>
>  typedef struct av_extended_perms {
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 84bfcfa3..35e45780 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1641,7 +1641,7 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t *=
 handle,
>                  * AUDITDENY, aka DONTAUDIT, are &=3D assigned, versus |=
=3D for
>                  * others. Initialize the data accordingly.
>                  */
> -               avdatum.data =3D key->specified =3D=3D AVTAB_AUDITDENY ? =
~0 : 0;
> +               avdatum.data =3D key->specified =3D=3D AVTAB_AUDITDENY ? =
~0U : 0U;

Also UINT32_C().

>                 /* this is used to get the node - insertion is actually u=
nique */
>                 node =3D avtab_insert_nonunique(avtab, key, &avdatum);
>                 if (!node) {
> --
> 2.32.0
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

