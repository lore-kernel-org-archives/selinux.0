Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F6FC4332F
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 06:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjKNGIS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 01:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKNGIR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 01:08:17 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C20B1BF
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 22:08:14 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d865854ef96so5394201276.2
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 22:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699942094; x=1700546894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11W2yWOQeqxKoFWhglEscMXpJFpYL5sSUjsco3f4y6Y=;
        b=K+pDO4q9ilnGiJNEoC70UVJ+Ovr6+b1fxN+sMrYJQjN6h+q/R6bLlQIld3ngLtJDQm
         pFA3iXYuebH49EiiuHrVuHzMCOGtCbb4M2Et3QkDj7yrIJrI8YwCXTLRbcj/ejE4CqFG
         YeKLvhGQWyjNasVflEE58+c0CBS+HKdR2MUwZibof7npt0Upr2SumHSTzquo06Cq1lO9
         HIfdCs+GQDQyyAyvKLv2Qiehsab2XW1dubzPbWmfKvA8E5P6+6qCZVB8pCFQsEGmQr9p
         +zjAz/XlnuJZYc+tvfx85T3PlJr3NvnOq8DGcPH5kvdPA6YKIQniS7QDqxrXgPxEP1Ha
         nRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699942094; x=1700546894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11W2yWOQeqxKoFWhglEscMXpJFpYL5sSUjsco3f4y6Y=;
        b=LYR2O+7ASHjdDmKrdSVGvKST3uLpwqn6gKWZcaK3+K1OGeVffYMNBNFRSydXXOhbyZ
         619KmmV1/89t8lMhkbA9qYzlv5KKIwKArTIEsss4QmN+pKiPs6myzvrBkv3dGPcPDsM9
         zVfWWLycGYhUPa/Jf3HgZJax8xNQQeQEGBDi3MZTQuGrXe0OaIElqAoAPWDa1FW3x2uH
         1MAWaOstcmnyq5mBIzViNy86qioHfyRysZv0cZSFCkN2zd4zBKWPsrPVlxJQnKXdbT0K
         MZ/pMqEkcqHU0Hyz6repMF/+9TVwnaWJKdhoCKnqEa4KSk9UhE6BXkGQRoMVPn3iCf0O
         a7gA==
X-Gm-Message-State: AOJu0YyQiyEkpWQufE565pma2kbDj5eYLMfo1G1JdYU4Er/oWrqpzfl6
        aI4EQisIVrmxhx7TylXMge1MwywGf2HsKzjpU61szdRVrjM3h2IoXQ==
X-Google-Smtp-Source: AGHT+IGaZYQ9MkeHWuKtOazDnnlfoB7iH75ZD6zyT6WqCQNOMtlPslQH3hbU/hz0ZtJIvskqZnYHv0cUjpJSBvrfynw=
X-Received: by 2002:a25:42d2:0:b0:da0:c8d1:5c5 with SMTP id
 p201-20020a2542d2000000b00da0c8d105c5mr7777075yba.41.1699942093732; Mon, 13
 Nov 2023 22:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20231111160954.45911-2-paul@paul-moore.com> <CAHk-=wjg45Pg5qxbio9szL+rMSGT7qm3a466d-zVwZwO96FNdw@mail.gmail.com>
In-Reply-To: <CAHk-=wjg45Pg5qxbio9szL+rMSGT7qm3a466d-zVwZwO96FNdw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Nov 2023 01:08:02 -0500
Message-ID: <CAHC9VhQ9yh2_yEnGWWZ8-ur0x7rbyqLukQQ1kkDfy0sJa5s0DQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: update filenametr_hash() to use full_name_hash()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Nov 11, 2023 at 4:53=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, 11 Nov 2023 at 08:10, Paul Moore <paul@paul-moore.com> wrote:
> >
> > Using full_name_hash() instead of partial_name_hash() should result
> > in cleaner and better performing code.
>
> This looks obviously good to me, but I don't actually know what that
> hash is used for and whether it all matters.

Based on a (very) quick look, it seems like full_name_hash() shouldn't
really be any worse than partial_name_hash() with the advantage of
being a bit faster in some cases and cleaner from a code perspective
so it's a win from my perspective even if the performance remains
completely the same.

I haven't seen any objections so I'm going to merge it now.

> Also, looking at the actual use of this all ...
>
> ...
>
> So here's a *TOTALLY UNTESTED* patch that tries to remove the use of
> "h->size' for the hash table size, and replace it with an
> almost-equivalent 'h->hbits' for the size of the table in bits.

Unfortunately I'm pretty swamped at the moment digging out of
maintainer backlog stuff so it might take me a while to get to
properly reviewing this, but I'll add this patch to the todo pile.

Christian, would you happen to have any time or interest in reviewing
Linus' patch and giving it a good test?

[Side note for Linus, yes, we do have a somewhat simple test suite for
quick regression testing, if you're interested have a look at
https://github.com/SELinuxProject/selinux-testsuite]

> Also, while at it, I removed the pattern that I absolutely *detest*
> that the list handling in the hashing code used, which was that
> disgusting "what is the previous pointer to be filled in" pattern.
>
> The trivial - and *horrible* - way to do it is
>
>         prev =3D NULL;
>         cur =3D h->htable[hvalue];
>         ... walk the list ...
>                 prev =3D cur;
>         ...
>         prev ? &prev->next : &h->htable[hvalue],
>
> which shows that people don't understand the power of pointers.
>
> The *proper* way to do this with pointers is:
>
>         pprev =3D hashtab_entry(h, key, key_params);
>         .. walk the list with (cur =3D *pprev) !=3D NULL) ...
>                 pprev =3D &cur->next;
>         ...
>         pprev
>
> which doesn't have that unnecessary conditional for "is this the first
> entry". It not only generates better code, it shows that you
> understand pointers.
>
> Yes, this is the smallest hill I'll die on. It's literally a pet peeve of=
 mine.

That's fine by me.  I can't say it bothers me to the same level as
you, but I will admit to having my own annoyances, I think we all do.

> I also moved variable declarations into the blocks where they are
> used, rather than at the top level.
>
> Now, I want to state this very clearly once again: this attached patch
> is ENTIRELY UNTESTED.  It might have some completely stupid thinko in
> it, and may be entirely broken.
>
> I test-compiled it, and I've looked through it a couple of times for
> sanity, and I do think it's better to keep "hbits" around instead of
> "size", but I'm not going to force this on you.
>
> Anyway, I guess I should test this, but here is that untested patch if
> you want to consider it.

Thanks again for the patch.  I'm going to post it quickly to the
SELinux list as an inline patch so patchwork will pick it up and it
doesn't get lost in my inbox, feel free to ignore the repost.

--=20
paul-moore.com
