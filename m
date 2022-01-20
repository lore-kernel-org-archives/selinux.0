Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E325DC433F5
	for <selinux@archiver.kernel.org>; Thu, 20 Jan 2022 17:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiATRhx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jan 2022 12:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiATRhx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jan 2022 12:37:53 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1BEC061574
        for <selinux@vger.kernel.org>; Thu, 20 Jan 2022 09:37:53 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id m8-20020a9d4c88000000b00592bae7944bso8536674otf.1
        for <selinux@vger.kernel.org>; Thu, 20 Jan 2022 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o4BaXpKphwgObGaSH2KKTMa2Vny6hV4kLNTkJA3mp9s=;
        b=mzvJlFHvZv5mZm2Zvf/LIML7FGvGeNx7DsYSGS2tWrQgANwPuRX1mB6Ed81FrehCCS
         N8VxuTlBh7+yGdGRnDlDUJVtJQ4e/nm/wviJEEcBeENJsb7gAWjE8di53sjEzL/2qYVV
         dNTSxYCQxF8NGic/X9Irr4s/tvhzWnt6Ot3udbuYrcdU8Zg/RDT9HEc1okK1qeaG0nof
         W53+7FAlGMba9LNOgeeuzqpVNAxNp+QKXbY71uqj41ZpRQITX2d3hGavxAgn/0qyNZQu
         mm+y4rZtZyqgaZZHZU8NMftSgZa71SCEIzVFqnImMBmv8/h7Bb/3merLKIzdqll6h0hO
         SNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o4BaXpKphwgObGaSH2KKTMa2Vny6hV4kLNTkJA3mp9s=;
        b=dnQuN49vqz+lWV+tRIEjpFT7j+nnVSOOjrkEvgZP3awXTr0+uUyGtj1ltfAk9nnfNq
         DZs1Qm+DoyTf3md5cWJZjnyCvq2E2NyHogLE7VVAoda0JX+M7BumPVyVl22qholzKsWs
         78jHrmofv1J0i6zsp87BNEXzw7qWjNp9WFf+TJCjDx8+hwjITkfCmxwdgJ212iGg95bj
         E1wEx1r7lyVx9MF2/QB0saaIRHDmF0Yh7PeFZ2Mj+ziEWkRYgRELAnqpodHoY16PGIDO
         2R34JZ4/JrtjQNjFRFFz6G8W29nDBzBjl8JjSQWkHIb6O5CsmDF4wqj5msAUREvUS3EE
         QQqg==
X-Gm-Message-State: AOAM533Kx+ZovJ8f7o1ICMl/EA2Z6PkdskOgQ62kMcooeh/qYqOVg5fa
        hITYlGVrQRDXPJuQ5dtWEWqFJJvoQyBzND80pQM=
X-Google-Smtp-Source: ABdhPJyS9Q0bpEekMlgPeGViV57qPemrWNQoSP6WiSV1EHB1y5uTL5OA+GjzJFWGQg5YhEX7T8ZS4o/FfTtwipM2OTY=
X-Received: by 2002:a9d:6754:: with SMTP id w20mr4177052otm.53.1642700272397;
 Thu, 20 Jan 2022 09:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20220117150200.24953-1-cgzones@googlemail.com>
 <CAP+JOzRj5EY20ATmHhk2PsYOTabmBDRuxQKNYZtqgkU7ky-Ozg@mail.gmail.com> <CAJ2a_DdE_4Y=htZTefgb+X1UnXRNjCyb_CfEbcg=_N8u5VAoBw@mail.gmail.com>
In-Reply-To: <CAJ2a_DdE_4Y=htZTefgb+X1UnXRNjCyb_CfEbcg=_N8u5VAoBw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 20 Jan 2022 12:37:41 -0500
Message-ID: <CAP+JOzQF4k+XUge8ba9QRoTxRjQ0TOtqW5LFK7gY8EBdkKGeNQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: reject invalid roles before inverting
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 20, 2022 at 11:15 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 19 Jan 2022 at 20:18, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Mon, Jan 17, 2022 at 9:34 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Since the role datums have not been validated yet, they might be inva=
lid
> > > and set to an enormous high value. Inverting such an ebitmap will tak=
e
> > > excessive amount of memory and time.
> > >
> > > Found by oss-fuzz (#43709)
> > > ---
> > >  libsepol/src/expand.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > > index 898e6b87..3fc54af6 100644
> > > --- a/libsepol/src/expand.c
> > > +++ b/libsepol/src/expand.c
> > > @@ -2481,6 +2481,10 @@ int role_set_expand(role_set_t * x, ebitmap_t =
* r, policydb_t * out, policydb_t
> > >
> > >         /* if role is to be complimented, invert the entire bitmap he=
re */
> > >         if (x->flags & ROLE_COMP) {
> > > +               /* inverting an ebitmap with an invalid highbit will =
take aeons */
> > > +               if (ebitmap_length(r) > p->p_roles.nprim)
> > > +                       return -1;
> > > +
> > >                 for (i =3D 0; i < ebitmap_length(r); i++) {
> > >                         if (ebitmap_get_bit(r, i)) {
> > >                                 if (ebitmap_set_bit(r, i, 0))
> > > --
> > > 2.34.1
> > >
> >
> > One would think that ebitmap_length() would be the right function, but
> > actually it will return the highest position in the bitmap without
> > regard to whether it is set or not. Since the ebitmap has 64 bit
> > nodes, it will be a multiple of 64.
> >
> > The function you want to use here is ebitmap_highest_set_bit().
>
> On a second thought: does this inverting even work?
>
> Consider `p->p_roles.nprim` being 42, the highest bit in the current
> ebitmap being 32, and thus the length/highbit being 64.
> The highest bit 32 is less than 42 so that's fine.
> But then the inversion inverts all bits up to `ebitmap_length()`
> (=3D64), so now the highest bit is 64, which is bigger than
> `p->p_roles.nprim`.
> The ebitmap now has a role set that is not defined, some further
> operations might fail, and any subsequent validation will fail (e.g.
> in `validate_ebitmap()`).
> git-blame[1] shows this code was introduced with the initial import
> from svn and also the flag ROLE_COMP is otherwise unused (with an
> exception in the test binary dismod).
> checkpolicy(8) does not accept role complements, e.g. `user sys_user
> roles ~sys_role;` or `allow role1 ~role2;` are invalid.
>
> Maybe the inversion would be safe if the upper bound was
> `p->p_roles.nprim` not `ebitmap_length()`?
>

Yes, it should be using p->p_roles.nprim and not ebitmap_length(). The
function type_set_expand() uses p->p_types.nprim as it should.

Thanks,
Jim


>
> [1]: https://github.com/SELinuxProject/selinux/blame/master/libsepol/src/=
expand.c
>
> >
> > Thanks,
> > Jim
