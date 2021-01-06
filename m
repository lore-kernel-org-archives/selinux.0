Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B51C433E0
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C4E23106
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 08:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbhAFIFz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:05:55 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:45155 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFIFz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 03:05:55 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 762A5564EFB
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 09:05:12 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id a109so2307933otc.1
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 00:05:12 -0800 (PST)
X-Gm-Message-State: AOAM530mCiL7tLyTHnfuH63xp3pSay+CxDQdPSZekuCtj5YeDdnpkPot
        M6OL0U0a0n16tnm9/cAeZl0bUlpKtXNhmPwALjI=
X-Google-Smtp-Source: ABdhPJzkH7Pu8KhmCgY6Lo48F9CX8e3I2feiv8oG0sEotosUAqZ4fJH5QUSxxaMZvx4GR5eOwMvvUD13T3HQnFL8HKo=
X-Received: by 2002:a9d:620f:: with SMTP id g15mr2270377otj.361.1609920311352;
 Wed, 06 Jan 2021 00:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20201230100746.2549568-1-nicolas.iooss@m4x.org>
 <CAP+JOzQBQ--xZWukZcZTsZ1Eq01Fk4xCa66AotYCHKxZEG-QgQ@mail.gmail.com> <CAP+JOzQc3yXczhk5JfUrr+6rFe3AXis+yJAukCFbz=aQotriQQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQc3yXczhk5JfUrr+6rFe3AXis+yJAukCFbz=aQotriQQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 6 Jan 2021 09:05:00 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=k-+XpKtzt4CdCL71vHYwpGUeBVQhxpidUA8c2n7rS1XA@mail.gmail.com>
Message-ID: <CAJfZ7=k-+XpKtzt4CdCL71vHYwpGUeBVQhxpidUA8c2n7rS1XA@mail.gmail.com>
Subject: Re: [PATCH 1/6] libsepol: do not decode out-of-bound rolebounds
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan  6 09:05:12 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 4, 2021 at 4:51 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Jan 4, 2021 at 10:48 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Wed, Dec 30, 2020 at 5:11 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > >
> > > While fuzzing /usr/libexec/hll/pp, a policy module was generated with a
> > > role->bounds larger that the number of roles in the policy.
> > >
> > > This issue has been found while fuzzing hll/pp with the American Fuzzy
> > > Lop.
> > >
> > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > ---
> > >  libsepol/src/module_to_cil.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> > > index a87bc15e7610..c99790eb76e7 100644
> > > --- a/libsepol/src/module_to_cil.c
> > > +++ b/libsepol/src/module_to_cil.c
> > > @@ -2165,7 +2165,9 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
> > >                         }
> > >                 }
> > >
> > > -               if (role->bounds > 0) {
> > > +               if (role->bounds >= pdb->p_roles.nprim) {
> > > +                       log_err("Warning: role %s defines an out-of-bound rolebounds", key);
> > > +               } else if (role->bounds > 0) {
> > >                         cil_println(indent, "(rolebounds %s %s)", key, pdb->p_role_val_to_name[role->bounds - 1]);
> > >                 }
> > >                 break;
> > > --
> > > 2.29.2
> > >
> >
> > There are other places where the bounds value is used as an index and
> > type datums also have bounds that are used in the same way.
> >
> > Correct me if I am wrong, but I think that this can only occur by
> > crafting a binary (and not as a result of a policy being compiled). So
> > I think the correct place for the check would be when the binary file
> > is read.
> >
> > I'll have to test to be sure, but I think the attached patch might do
> > the proper checking.
> >
>
> Oops, that patch had typos. This one.

I agree, and I confirm your patch fixed the crash I experienced. Thanks!
Nicolas

