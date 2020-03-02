Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE9C3F2D7
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 19:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2ED2173E
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 19:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdT33Mdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCBTLM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:11:12 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40852 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgCBTLM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 14:11:12 -0500
Received: by mail-ot1-f65.google.com with SMTP id x19so372848otp.7
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 11:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35AmAzAjOap0cCQQzAK8cHH5BHbCtPmnqSDr5kZ/4XY=;
        b=PdT33MdzcRv1OHaYztO0XsaO5dBzkZMViK3hxiFodqxht+aOe+zIpfrYt+wwZ/Pr3N
         itpokDKyqzz4Obz+pL4fQBWmkP9KObmURPShyGahdpH25Xzop/u5uNYyR4qjKYZLxF91
         gHbDf4mJ5JGtTfxlmdxgUVsBFmvO/74awuszV+M+uC9K+AKPRSR/AIkxu8ukHjxmpEGi
         SgjR/H02jTKpsJuXDstBGT+enIuAAOew5G3W4Nhorx0XNteqhK0J+SdLZQERJPtr5QoC
         bBHYGqelPB2MJfRS/QLeHwvowVkHKyX4+iIJdiaCZmBqNZ0R9Z/PVa/AtUoc9aXXm1jW
         ZUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35AmAzAjOap0cCQQzAK8cHH5BHbCtPmnqSDr5kZ/4XY=;
        b=G2KHfwoxCP6Oj0dNMnzoNP21lMXXIBOpoH0NaeMIcmBGI34+qsWbxeearq+t3pnIMg
         mzbLleQ0eaoJl2QV4TU/worHTWTkvaSABfgGsK4X6Z2yrD6Nz5maAPWRJ7Gy0OsZfwjo
         +AiJeCL69tOVRil21mC3ZL4C2TYC3ScDBkThOIF+0PptBAKbzogP+bxUE7ge6X16DM74
         LyPtb7s14cehHmu4fWDJlmuir+pUpb6svZpjy6wnbxNJg+hArTQigUOf6y8lKk2VEIA9
         fYhHnGVOvWrhQbgG1tIbxR+FXWYVK/OlUqLTPWjC6xBxHtCN4WFnxQeyEhXnR4k2Fg+y
         Z2DA==
X-Gm-Message-State: ANhLgQ2pzlNyAQeVs9aWOZKy97P2TcPxjBJ6iPLeUnb0iBpOVyG0U9MK
        pPc+n2mqb+bxA18PaRq/SIss6dhZ8jfwo/SVeF1dFw==
X-Google-Smtp-Source: ADFU+vttNVLsewjWDWD0NlHFPxrTukoB0NZyx8kDeVJQ3DQ2DpzbE8QTcqgqzFBw2NX9JwB+PtqMNXkjJDGcjJf6vxo=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr508525oto.135.1583176271889;
 Mon, 02 Mar 2020 11:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20200226155452.301544-1-omosnace@redhat.com>
In-Reply-To: <20200226155452.301544-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Mar 2020 14:12:58 -0500
Message-ID: <CAEjxPJ5M=iaVBQQGT8QqnHsndXKzxvRMSxSNbm3arNwXnmu4GQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: reduce the use of hard-coded hash sizes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 26, 2020 at 10:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Instead allocate hash tables with just the right size based on the
> actual number of elements (which is almost always known beforehand, we
> just need to defer the hashtab allocation to the right time). The only
> case when we don't know the size (with the current policy format) is the
> new filename transitions hashtable. Here I just left the existing value.
>
> After this patch, the time to load Fedora policy on x86_64 decreases
> from 790 ms to 167 ms. If the unconfined module is removed, it decreases
> from 750 ms to 122 ms. It is also likely that other operations are going
> to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> but I didn't try to quantify that.
>
> The memory usage of all hash table arrays increases from ~58 KB to
> ~163 KB (with Fedora policy on x86_64).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 32b3a8acf96f..7ca8c74efba3 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -503,20 +482,12 @@ static int policydb_init(struct policydb *p)
>                 goto out;
>         }
>
> -       p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
> -       if (!p->range_tr) {
> -               rc = -ENOMEM;
> -               goto out;
> -       }
> -
>         ebitmap_init(&p->filename_trans_ttypes);
>         ebitmap_init(&p->policycaps);
>         ebitmap_init(&p->permissive_map);
>
>         return 0;
>  out:
> -       hashtab_destroy(p->filename_trans);
> -       hashtab_destroy(p->range_tr);
>         for (i = 0; i < SYM_NUM; i++) {
>                 hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
>                 hashtab_destroy(p->symtab[i].table);

Sorry, just pointed out to me that this left the symtab destruction
code in the out path of policydb_init()
even though we are no longer creating them there.  Harmless but should
be dropped.
