Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D43C61D9B
	for <selinux@archiver.kernel.org>; Wed, 22 Nov 2023 17:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjKVRfd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Nov 2023 12:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjKVRfc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Nov 2023 12:35:32 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4961AB
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 09:35:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab11so44748a12.1
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 09:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700674526; x=1701279326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nElMTa8mOuOu6R9/oh6hE2whzy2TU3Y0KVhpSaWVzs=;
        b=Hbq9F3wavm31PWwdauvIC3VA7VCtAGFtmduLr4NrCV7v7Ee7+OACKxHTv+OqXWUIxc
         UM4+7E+LvCpBN1sTGAu5ZFhEcNgO8UEymcKncHHzUMCX+mFk9l8NvW6fn0ZWd6ok0H9n
         1B7J73XDexMURCDx0GLMPouXC83EQe0y8o8bucm91PkSlLmhoav8lVJdnIyqp2aZF3W6
         7cx/apMPMH8d2qTFOMr+1Ns0iMBswZ8hZxStp3zqq3/WqXK0dSyPh/VYuaNfHfil9zDT
         Z3V+NsHA82NsJYRR/cjlBZcgH0aqFyXXco+9Ymgm4wUUvm+A2SpuTa4/OJs31CfaSwF8
         VMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700674526; x=1701279326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nElMTa8mOuOu6R9/oh6hE2whzy2TU3Y0KVhpSaWVzs=;
        b=PWeZnvLbv80elfTLbHLb478T92Sl3J6moPzmIiRv8eJJAjHaNTEYMyJTVsVtprNsJi
         svSGc3/uaLSXKGsGU8/GhrGENU7gFD2vdY+JXogLhXtVMGRneQvxAFK7VclKDYQYvtfe
         473BuKyJPPEoM2QILnn84BlA70wI05zAwcZ+pxZwrBq43HrioULPk87xcsg+ROsrEFEK
         9lonuP30lQm06Kj8zymQyARzv7+3kjwah6wXdJlZKlxdqYqdXEC9ah+04tvpORkgoqLk
         cyUzggaDIbP915e1p6AwMDqT7DFjgG6wlSHzMuhutIq1EX0dpbTY4UojnW2r8Pt8wsU4
         Kivw==
X-Gm-Message-State: AOJu0YyjqOWr5AW011WC8eVGo1hpP9zf0/tNfkdwJSbAoucF3vC7smDP
        1+7J0qvqr9nM3f80DY0Hyjluf2NcosncDk40qUWwxLOe
X-Google-Smtp-Source: AGHT+IEJRGOV3q7OEWL3KYl/GKLJ8Y1pOQPd6R1ZBt0TJOPSU5uz9EwOWIhhCXEUJ0hBLV1zTwRqi6DK9sOA5toCrxA=
X-Received: by 2002:a17:906:d784:b0:9e6:59d5:71c1 with SMTP id
 pj4-20020a170906d78400b009e659d571c1mr763197ejb.58.1700674525842; Wed, 22 Nov
 2023 09:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20231103172953.24667-3-jsatterfield.linux@gmail.com> <d419ff729567246c50cf52b885e76903.paul@paul-moore.com>
In-Reply-To: <d419ff729567246c50cf52b885e76903.paul@paul-moore.com>
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
Date:   Wed, 22 Nov 2023 12:35:14 -0500
Message-ID: <CALMFcesyueiXg_8Z=LVhKjy7eYnE=3vJS0daTEC7+Z5GKxa4Cg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] selinux: fix conditional avtab slot hint
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 20, 2023 at 8:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Nov  3, 2023 Jacob Satterfield <jsatterfield.linux@gmail.com> wrote:
> >
> > Due to how conditional rules are written in the binary policy, the
> > code responsible for loading does not know how many conditional rules
> > there are before creating the avtab structure. Instead, it uses the
> > number of elements in the non-conditional avtab as a hint and allocates
> > the hash table based on it. In the refpolicy and default Fedora policy,
> > the actual sizes of these tables are not similar (~85k vs ~10k) thereby
> > creating more slots than needed and resulting in wasted memory.
> >
> > This patch introduces a two-pass algorithm to calculate the conditional
> > rule count before allocating the avtab nodes array. Albeit with a sligh=
t
> > performance penalty in reading a portion of the binary policy twice,
> > this causes the number of hash slots for the conditional array to becom=
e
> > 4096 instead of 32768. At 8-bytes per slot on 64-bit architectures, thi=
s
> > results in a net savings of 224 KB of heap memory.
> >
> > Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/ss/avtab.c       | 15 ++++++++++--
> >  security/selinux/ss/avtab.h       |  2 +-
> >  security/selinux/ss/conditional.c | 38 ++++++++++++++++++++-----------
> >  security/selinux/ss/conditional.h |  2 +-
> >  4 files changed, 40 insertions(+), 17 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/co=
nditional.c
> > index 81ff676f209a..810319bf0e60 100644
> > --- a/security/selinux/ss/conditional.c
> > +++ b/security/selinux/ss/conditional.c
> > @@ -407,16 +408,17 @@ static int cond_read_node(struct policydb *p, str=
uct cond_node *node, void *fp)
> >                       return -EINVAL;
> >       }
> >
> > -     rc =3D cond_read_av_list(p, fp, &node->true_list, NULL);
> > +     rc =3D cond_read_av_list(p, fp, &node->true_list, NULL, nrules);
> >       if (rc)
> >               return rc;
> > -     return cond_read_av_list(p, fp, &node->false_list, &node->true_li=
st);
> > +     return cond_read_av_list(p, fp, &node->false_list, &node->true_li=
st, nrules);
> >  }
> >
> > -int cond_read_list(struct policydb *p, void *fp)
> > +int cond_read_list(struct policydb *p, struct policy_file *fp)
> >  {
> >       __le32 buf[1];
> > -     u32 i, len;
> > +     struct policy_file tmp_fp;
> > +     u32 i, len, nrules;
> >       int rc;
> >
> >       rc =3D next_entry(buf, fp, sizeof(buf));
> > @@ -428,15 +430,25 @@ int cond_read_list(struct policydb *p, void *fp)
> >       p->cond_list =3D kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
> >       if (!p->cond_list)
> >               return -ENOMEM;
> > +     p->cond_list_len =3D len;
> > +
> > +     /* first pass to only calculate the avrule count */
> > +     tmp_fp =3D *fp;
> > +     nrules =3D 0;
> > +     for (i =3D 0; i < p->cond_list_len; i++) {
> > +             rc =3D cond_read_node(p, &p->cond_list[i], &tmp_fp, &nrul=
es);
> > +             if (rc)
> > +                     goto err;
> > +             cond_node_destroy(&p->cond_list[i]);
> > +     }
>
> I'm a concerned about all the work we have to do just to count the
> conditional rules.  Other than not working with existing binary
> policies, have you looked at bumping the policy version and introducing
> a binary format change that would include the number of conditional
> rules?
>
> --
> paul-moore.com

Thanks for raising the issue. I had considered adding the total size
of the conditional table to the binary policy, but I wasn't sure if it
would be substantive enough to warrant bumping the policy version. As
you point out, the counting work will be needed for existing binary
policies making this patch necessary for the default case, but if you
are concerned about the performance penalty this patch brings (which
is less than the gain provided by the avtab array patch), then there
are two threads to possibly be worked on.

One is to rework this patch to include more invasive changes to count
rules without actually reading and destroying nodes thus saving cycles
but requiring more lines of code. Because policy parsing is not
handled separately from the construction of the policydb structure
(they are deeply intertwined), I was reluctant to add more complexity
just to have a parse-only code path. Would you prefer speed or simpler
logic for older policies?

The other is to obviously sum and add the total size of the
conditional rules table to the binary policy in cond_write_list() of
libsepol/src/write.c. If you think just adding the total conditional
rules table size is worth bumping the kernel policy version, then I
can prioritize sending a patch to libsepol for inclusion as soon as I
can.
