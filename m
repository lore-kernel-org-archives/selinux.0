Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B7CC54FB9
	for <selinux@archiver.kernel.org>; Thu, 16 Nov 2023 14:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjKPO5e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Nov 2023 09:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPO5d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Nov 2023 09:57:33 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67E093
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:57:29 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a98517f3so1211669e87.0
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700146648; x=1700751448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2qm6+TcZATgQarLkFPr2m70njnzL9o/f7Hp6WMIMx4=;
        b=LpNhPV8XgZJEBU1fsL1JKZk8Pcc9bHWXPFANIxirGhXREZOnwCpLqNH690Be8I3VR0
         zE5j3R510vHKhyM2LcbE7btNjpvsySiY7icNFG1qITLiCCiq5voBzmT4TZVqB3w2LVU8
         PEdPPM27eqEL28PArLZn+VWmRv0w7zdq/2kZWKNR4jmiwG+71t8TpkTNyITpLW/HcDB5
         ujwfE4xjva3U00rwEilZHGETPaWnLjR005W8fTctHLix0+VUvJcV5GfxHma9fTMhTvmz
         c/Mb0dDWO03Swx7MFspr6kS2lzw2tUzzp/e7Ev1jB+k1L9bsXsMchPWGwk9D7TO3wMfE
         d/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146648; x=1700751448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2qm6+TcZATgQarLkFPr2m70njnzL9o/f7Hp6WMIMx4=;
        b=l0365uw456U/KPDbNBB9ErwbMSUF0sPC0synEe6DjQdHsUzbol4jdXj/+Me9FYPHJT
         7n0s70ML0g8PK9C7dn8ibLHkAgyutq/0lQHWfH2geicJ0uLy4mQweTbjf+/CXRq1WfbY
         LXOMQDCqHO0TJHVfHyooRqNKZQVv3tIgPkGJaJ64FYlIIhg2MAWJjLSq4xpugrzbpi1B
         zqdbzYG/gHCSH27GjKHF2CD3dlitSxxXVkMRgdR9zWgF6+VvtOXa4VlIwjix0qa60bY8
         xcRW1Qu+lUVMHdOHqYiIagRgR51gJzOa2ZB9CF846wUt8yC2RgF9yRMDIQNrAJyV5uWh
         O7rg==
X-Gm-Message-State: AOJu0YytSJsHgZDyRjn8sjT2CwFUuEEXhahKitS4rAy0kjo7DpXD2vyN
        tjus7N1cu6/clqkEq+A5CjXdRvxRfj7SKwPFzERb2PgI
X-Google-Smtp-Source: AGHT+IESK8gLMdElw5YxYD9aKTP1XMBTjsDFw2UKoB/kObxIIHH/IDqxOtcRRLOAe+bqPD0j6IoZ4ip9caNt+u1fNgg=
X-Received: by 2002:ac2:546f:0:b0:509:f68:ed8 with SMTP id e15-20020ac2546f000000b005090f680ed8mr9851890lfn.61.1700146647811;
 Thu, 16 Nov 2023 06:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20231113192632.22509-1-cgzones@googlemail.com> <CAP+JOzRbkFiQWLpxFi+VgRU3gxDSZNuXx2W1Hnk8r01NKjCOfg@mail.gmail.com>
In-Reply-To: <CAP+JOzRbkFiQWLpxFi+VgRU3gxDSZNuXx2W1Hnk8r01NKjCOfg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 16 Nov 2023 09:57:16 -0500
Message-ID: <CAP+JOzSG6-G6vfoJgzarjCpoRgKW0im+Q47UCGFYcuHG_6Z8Og@mail.gmail.com>
Subject: Re: [PATCH] libsepol: validate common classes have at least one permissions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 14, 2023 at 3:40=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Nov 13, 2023 at 2:26=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The traditional language and CIL permit common classes only to be
> > defined with at least one permission.  Thus writing a common class
> > without one will fail.
> >
> > Reported-by: oss-fuzz (issue 64059)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

This patch has been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb_validate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 016ab655..1121c8bb 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -369,7 +369,7 @@ static int validate_common_datum(sepol_handle_t *ha=
ndle, const common_datum_t *c
> >  {
> >         if (validate_value(common->s.value, &flavors[SYM_COMMONS]))
> >                 goto bad;
> > -       if (common->permissions.nprim > PERM_SYMTAB_SIZE)
> > +       if (common->permissions.table->nel =3D=3D 0 || common->permissi=
ons.nprim > PERM_SYMTAB_SIZE)
> >                 goto bad;
> >
> >         return 0;
> > --
> > 2.42.0
> >
