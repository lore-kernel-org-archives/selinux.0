Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136D2C433F5
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 16:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345716AbiC3QZ6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 12:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbiC3QZ6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 12:25:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A2C337E
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 09:24:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h7so36750176lfl.2
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=joavtRUUYqLy4freALvby3g8lcz5IydigTDJsXK3j84=;
        b=ivpugNd6P7kxZ1qeiNjVVJMsNS9Rg0OnQO2fbz3jeMZRNy/EzF/9SlnHlafFn2p059
         sGEMWKsfjfZZf82AlM9AVY4Jgibu3TntjnxRRrl6ni80Mj7KctEJ/CenLtN2ojGf8dYb
         MTBxehbC9L81YO1fflssjTibHRuK2djGrWmgdPQlfV6Sp9SDJc5c2BBJxvXlMlPkrLYK
         qDcYmS/TpLh5Mi76bQfwQORXXvs6/Fb35VxygzctQOvidaYIRZS5cbc8MO3MmT7K3tcA
         0kb9zXtQTRiQniY3GlSo/dqP0pJ3xeWraBZuMca93loL5Ef7GcWLlB4DNOxBSZbh2eBM
         wz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joavtRUUYqLy4freALvby3g8lcz5IydigTDJsXK3j84=;
        b=RFa29aZ2Af/QtqUXz2+ZEJC/smJ9v+UBBUqUHgb5zxtKEsuukimlGGjypEz7LBvwlQ
         Effp9BkheStHELZaZCnZ3ZjRl9LB/+P32x8rPTSrMmRrIDP//BUhkauRlQ20lfGsXncd
         s7jLtorM8BkIyg6OQ+vQ1KGFQXP2F2J1nEQkLLB7Rbd9QtexZecTHL3az0Hc5hVPveAO
         4es/6oHcj3eVwCaQONH1JaKb70UNWgzXcTuUuofXoqEVuc2iZL5/pzfAMAhZPxa810zs
         nET6KmEC//oebL75CxcF2YN+IKlEw6c8UxpPHN8gObxOM20+ijIraOU3GEVCBZRRGO5B
         ZCaw==
X-Gm-Message-State: AOAM532QfX8RfGpuNmnkkO+aPE9dfylpeKyCOZKjeh8nKSUcRGawBtio
        qAzLElWAm0lk2tDKPf/xjFz6qoXhXC6bpW8oTHbkKY7ImIc=
X-Google-Smtp-Source: ABdhPJy4eUrnAOKV4uMHnFByKdJj8ZOCumthAFifAA7tTqtg9UlvAlxgdnjbNmG9m3TjDBd6ZCqb38gl6Hj0IXh/rg4=
X-Received: by 2002:a05:6512:318a:b0:44a:be25:7082 with SMTP id
 i10-20020a056512318a00b0044abe257082mr3174107lfe.439.1648657447185; Wed, 30
 Mar 2022 09:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220314182400.121510-1-jwcart2@gmail.com> <CAGB+Vh59mbuLpAAXU2vikcF+3H9t_DY9N8GNHEkWv7bzP0hXGQ@mail.gmail.com>
In-Reply-To: <CAGB+Vh59mbuLpAAXU2vikcF+3H9t_DY9N8GNHEkWv7bzP0hXGQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 30 Mar 2022 11:23:57 -0500
Message-ID: <CAFftDdrng3DgzCsF6FZH-CwRy+qp3ve0XWkX9HpvBwhw57cdPg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use calloc when initializing bool_val_to_struct array
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 30, 2022 at 10:46 AM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
>
> On Mon, Mar 14, 2022 at 2:24 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Use calloc() instead of mallocarray() so that everything is
> > initialized to zero to prevent the use of unitialized memory when
> > validating malformed binary policies.
> >
> > Found by oss-fuzz (#45493)
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/src/conditional.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> > index f78b38a2..a620451d 100644
> > --- a/libsepol/src/conditional.c
> > +++ b/libsepol/src/conditional.c
> > @@ -522,7 +522,7 @@ int cond_init_bool_indexes(policydb_t * p)
> >         if (p->bool_val_to_struct)
> >                 free(p->bool_val_to_struct);
> >         p->bool_val_to_struct = (cond_bool_datum_t **)
> > -           mallocarray(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> > +           calloc(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> >         if (!p->bool_val_to_struct)
> >                 return -1;
> >         return 0;
> > --
> > 2.34.1
>
> Why not change the mallocarray macro to use calloc? I see a number of
> mallocarray calls that should be audited if this approach is taken.

+1, it also gets rid of initialization code like this (note the loop
setting to NULL):
int sepol_sidtab_init(sidtab_t * s)
{
        int i;

        s->htable = mallocarray(SIDTAB_SIZE, sizeof(sidtab_ptr_t));
        if (!s->htable)
                return -ENOMEM;
        for (i = 0; i < SIDTAB_SIZE; i++)
                s->htable[i] = (sidtab_ptr_t) NULL;
        s->nel = 0;
        s->next_sid = 1;
        s->shutdown = 0;
        INIT_SIDTAB_LOCK(s);
        return 0;
}
