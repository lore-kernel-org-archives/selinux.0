Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3377C433EF
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 18:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbiBRSnj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:43:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239511AbiBRSne (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 13:43:34 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE632A0732
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 10:43:02 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso2527540otv.13
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 10:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YFBXoJY/pz6rBi8nH56h4FCedJh4OK/BU+K78Pxz45c=;
        b=KgMdx6PcAz84EqlxE8/97AREtlwH58ZcjFXzL4crxJOIwTtYdB9qSA6nMTDlxGE/5K
         2mAIfTzS46m8a/bj/aRvlNr94Takp+LqknBeuhnzLxFXLCs2OpUoIUQdXhyqLNQMXx/s
         LqK0XN/N3sIxGTmCDAsLW+IHU8TaTzYYtUxTC6KXZM5YJKx+3KqdB3RnYkB/nuiGFDA/
         CLW8e2t5sg+PzWVxTz2gSixeTvddivNml/djTqE+IFAGQvlvzHsSjuRPC3z4+Xyvfuhm
         QKbGq6aYoW/zE5Q2El+BaLUE+7H0if4yxbKDiiv/o3q2/qejL0t5jtPdPI64uAdnSjHe
         rBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YFBXoJY/pz6rBi8nH56h4FCedJh4OK/BU+K78Pxz45c=;
        b=VU0MQSO3CbuaHgiBDwlH3TpDmx1kCMx+m6/kowmLpKerKk1dG2W2lm3ysEkPWieb4G
         JMlgnC2aEAqeBrB2w32bLBnj9q3FGdr+58Lyu2MUFENwrAISOqEHvPdfTANif1eguw04
         GlCr42M0HeVgqM2h4QK0bdFl8IC/h1KlG598hYlzvdkvMtMdpz8BRNnSGDpQDWw1TLq9
         pzw3/YNy1t1Vak2wAd6HtOhNY0CEyBFdDjY2sW/4HK0knaEtANsnCmSFzQFXsrGFPtCt
         X77nXjiJ8YqJ3+KxpDfrUYKVstTgFCVlyzTieDuf+5H9w+nCKXl5K3utFywIfxuqR7yc
         bz6g==
X-Gm-Message-State: AOAM531xC++CDbGxNCMsCOG0MqKiLr9HiXlOIma9j6IuwNEpkqojofr2
        s9VoHZIr8xQk+fHz9wnWD/ig+ciSHnGhSMh0HL9Iput4
X-Google-Smtp-Source: ABdhPJzNx9zswZC+3m56OMZCRibrfESckG2tiiVmkxG1FYWitT1UgRjSIXN7v5+wV38zM4NG60NDqpsLl2JmJJGYL2A=
X-Received: by 2002:a05:6830:2390:b0:5ac:19a3:4888 with SMTP id
 l16-20020a056830239000b005ac19a34888mr2910552ots.53.1645209781873; Fri, 18
 Feb 2022 10:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20220210185234.41362-1-cgzones@googlemail.com> <CAP+JOzQewp4ocnVqMOqHKjvCTUa4ruxav0NRGq9DyZokq51KqQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQewp4ocnVqMOqHKjvCTUa4ruxav0NRGq9DyZokq51KqQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 18 Feb 2022 13:42:51 -0500
Message-ID: <CAP+JOzR6OfoQMzVjsC_ndxzNsyEpTJfNLDUB-ngo7gvSA3K1eA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: use correct error type to please UBSAN
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 14, 2022 at 2:59 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Feb 10, 2022 at 4:09 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The callback function apply in hashtap_map has a return type of int and
> > can return -1 on error.  Use int as type to save the return value to
> > avoid implicit conversions:
> >
> >     hashtab.c:236:10: runtime error: implicit conversion from type 'int=
' of value -1 (32-bit, signed) to type 'unsigned int' changed the value to =
4294967295 (32-bit, unsigned)
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For all three patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/hashtab.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
> > index 2eb35212..3ecaf165 100644
> > --- a/libsepol/src/hashtab.c
> > +++ b/libsepol/src/hashtab.c
> > @@ -224,8 +224,9 @@ int hashtab_map(hashtab_t h,
> >                 int (*apply) (hashtab_key_t k,
> >                               hashtab_datum_t d, void *args), void *arg=
s)
> >  {
> > -       unsigned int i, ret;
> > +       unsigned int i;
> >         hashtab_ptr_t cur;
> > +       int ret;
> >
> >         if (!h)
> >                 return SEPOL_OK;
> > --
> > 2.34.1
> >
