Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138F5C433EF
	for <selinux@archiver.kernel.org>; Wed,  5 Jan 2022 18:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242872AbiAESZW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Jan 2022 13:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbiAESZT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Jan 2022 13:25:19 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82EFC061245
        for <selinux@vger.kernel.org>; Wed,  5 Jan 2022 10:25:18 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so282325otu.10
        for <selinux@vger.kernel.org>; Wed, 05 Jan 2022 10:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nGy6LNPbS4vVkV/2jgq4TCyFJsvW+2En5nC0dpjNIsg=;
        b=DvyRQZZheL0HMT3kJXFf8NuSL2ELNGAJLY/SQETeYx3ZYJSEl4uu0EvQcQ6T6MIG00
         FEuhE+kqWiugMlg/3Cevw7VvexnMsbWMWxVcXUFAyRJM2liGhFPP+259uV+SIJqTFaLV
         MIhoNR75J2QZmfsjLWAUKLave9fltceIKflDYmLUl8SEj2WNUNR/gwXa0MxXerYdwhgT
         /TX5FSX8kacBdKZ7D9CRO4Mq2gLeocKJrYciyuEwqNMmLQUVL1mLSdmwXQiCtmcnQ1fq
         eYLphm4Uu6dlyEAncdavxKVb1W5W52+hu2B9Kc985x65q24bfneoQ35XA/Aw9MJ68mj6
         p6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nGy6LNPbS4vVkV/2jgq4TCyFJsvW+2En5nC0dpjNIsg=;
        b=iPmoFrdw/YhJwN/FvGWqDsWYYXQQ4SYK5cROQnFJKdw3HUlxyXxstq6WhR9mmAPiGZ
         1f2VNdAMYJzLVIMSTZFjyED98Riv6JEWrlk92UGbT5Fru26GGA5n5lbMRdQuUzVvsfuS
         Ph18hhEKar9+UJnR0hOwGQC0q2HCo1Gaodt3qZ0rIXqqk1646NK1RYWWyUvbi4KvopAJ
         om6sYGPnN9Eyq7Io48AuL9Duvhxuiqn4u0pStWGiRbRR4wTM3rXdx/yJy+pWsfh8/nDY
         t7sb8dsPJUf9Iin1/IaresralWcvggEiVauVJ/Uy3jGVzq4BTp+QUX32ayFZ56XTcxki
         0jdQ==
X-Gm-Message-State: AOAM530U4C63QKwaZpcw3vkKut9FdrT/Y1k5+yb9289+rWh2UUHxDpMo
        u2rVn3K3PHAK9jmEYYvE4f81EUQaCIGPnIB0ZbXZuwbv
X-Google-Smtp-Source: ABdhPJxK1hq9XsfVCPpJXVPmcFeZ5MzFnpNW36MEmhvf5vOvoTJBe3MvU86WUJuaB5dN/fyTBZ+5XfzQAzyhZBWUphs=
X-Received: by 2002:a05:6830:1384:: with SMTP id d4mr2535018otq.139.1641407118217;
 Wed, 05 Jan 2022 10:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20211223181945.68723-1-cgzones@googlemail.com> <CAP+JOzR-G0mre7PJcf=rvyapEAqP-nbwU3PJr_1TBw87XGQQ=A@mail.gmail.com>
In-Reply-To: <CAP+JOzR-G0mre7PJcf=rvyapEAqP-nbwU3PJr_1TBw87XGQQ=A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 5 Jan 2022 13:25:07 -0500
Message-ID: <CAP+JOzSz7bKStGXTE0ahcGmkvu0OHr93s=YCgMUFMzMfBj_Ojw@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: check for valid sensitivity before lookup
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 3, 2022 at 1:44 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Dec 24, 2021 at 8:09 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Check the sensitivity is valid and thus the lookup in the name array
> > `p_sens_val_to_name` is valid.
> >
> > Found by oss-fuzz (#42729, #42730, #42735, #42741)
> >
> >     =3D=3D54784=3D=3DThe signal is caused by a READ memory access.
> >         #0 0x5a10f3 in mls_semantic_level_expand ./selinux/libsepol/src=
/expand.c:934:11
> >         #1 0x53839e in policydb_user_cache ./selinux/libsepol/src/polic=
ydb.c:972:7
> >         #2 0x5c6325 in hashtab_map ./selinux/libsepol/src/hashtab.c:236=
:10
> >         #3 0x5392e9 in policydb_index_others ./selinux/libsepol/src/pol=
icydb.c:1274:6
> >         #4 0x53f90a in policydb_read ./selinux/libsepol/src/policydb.c:=
4496:6
> >         #5 0x50c679 in LLVMFuzzerTestOneInput ./selinux/libsepol/fuzz/b=
inpolicy-fuzzer.c:35:6
> >         #6 0x4409e3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char co=
nst*, unsigned long) (./selinux/out/binpolicy-fuzzer+0x4409e3)
> >         #7 0x4295bf in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*,=
 unsigned long) (./selinux/out/binpolicy-fuzzer+0x4295bf)
> >         #8 0x42f850 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsi=
gned char const*, unsigned long)) (./selinux/out/binpolicy-fuzzer+0x42f850)
> >         #9 0x45b6d2 in main (./selinux/out/binpolicy-fuzzer+0x45b6d2)
> >         #10 0x7f059fcd71c9 in __libc_start_call_main csu/../sysdeps/npt=
l/libc_start_call_main.h:58:16
> >         #11 0x7f059fcd7277 in __libc_start_main csu/../csu/libc-start.c=
:409:3
> >         #12 0x423900 in _start (./out/binpolicy-fuzzer+0x423900)
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
>
> Someday it would be nice to have this validation of contexts done with
> the other policydb validation, but I don't want to mess with that
> right now.
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > v2: also check the entry is non-null
> >
> > ---
> >  libsepol/src/expand.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 8a7259a0..898e6b87 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -929,6 +929,10 @@ int mls_semantic_level_expand(mls_semantic_level_t=
 * sl, mls_level_t * l,
> >         if (!sl->sens)
> >                 return 0;
> >
> > +       /* Invalid sensitivity */
> > +       if (sl->sens > p->p_levels.nprim || !p->p_sens_val_to_name[sl->=
sens - 1])
> > +               return -1;
> > +
> >         l->sens =3D sl->sens;
> >         levdatum =3D (level_datum_t *) hashtab_search(p->p_levels.table=
,
> >                                                     p->p_sens_val_to_na=
me[l->sens - 1]);
> > --
> > 2.34.1
> >
