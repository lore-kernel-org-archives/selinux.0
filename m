Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BF6C433FE
	for <selinux@archiver.kernel.org>; Tue, 22 Feb 2022 23:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiBVXRO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Feb 2022 18:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiBVXRN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Feb 2022 18:17:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A8B8CDAF
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 15:16:46 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw13so47299387ejc.9
        for <selinux@vger.kernel.org>; Tue, 22 Feb 2022 15:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KzvH9ZQaXdUgSyIdwCtFzNEtbBoZxdQVld6HVvqC3h0=;
        b=S/IydQVZc46d4zetWnmQ5U0e/PzMQNOi9DIjYeoinrNryqb/zeu17/TuDGbIX/KWpC
         72p/RUQcIO43sVlxpFBZmQdfy6WJtCivMolKcubjDm1vgXMy8k/BPNGr/UPBh9C4W41h
         4OMcW3ugJLilxrgRaLIAK4YLgo1M1xTJxv0gptrzQotyWQ8BVbQgyOuu/RAZGlM5Bw8P
         JmKxduxWoEh8ZNP3EI0O00LrNVhJlX3v4Rw2jBvCxgmBre2DuzWvIcOX5LuS+YxoHWGU
         YdMkjRgsLGwFaosBa6vzrp7EVsu7uc8gPip0/Bri8/5SM/66BSW/Pl4hxH3OB0jOdfoL
         rEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KzvH9ZQaXdUgSyIdwCtFzNEtbBoZxdQVld6HVvqC3h0=;
        b=ELvjStMTLfJFjGaJadHlwHg4WG+X7sogXEj1w5dOzQzGF+KNqb6VDL3dvZM7YngLAD
         EIz26GXMpto2qG46zQ9Xm2QJHIgKWrqEbIQOq2wQncqq17oJmL+0tC7USb3cnEXOD/Ud
         lMmtQoFZ9TpomNPMrSxncT57WoHBc52jKAaBYBTPoLtrBTT1aSlUeGEJYNUXjZAblSKb
         MVwP5g/TMQqoO4RL+/SYHqWUaMBGur8Y2Df/kZ1uLuwgY1QvnSEejPL97xJOvN5hTe4W
         4KOhLSYArNRQA2MnfgnAGHb7ysPN+vSnzW0/nYJZX35pdpplKASZT8krEUW4gEoXU1ez
         +Ovg==
X-Gm-Message-State: AOAM532DABMxQMfsl5YoX3h6dvxQ88+xTUM7l2H+UDT6HRca054NkHzx
        6+zIoR3XIR+vMG79e7re8o9LVdPwfOFudmTLHK5H
X-Google-Smtp-Source: ABdhPJyC5JfFslCe0iSc7dk6uE4kYr0sXtIjOP3+4cJ8OXdGFLZZdB3wUVrWstGC2q8isedVNDR8Em5of/ldksyZE6c=
X-Received: by 2002:a17:907:2a54:b0:6d5:879d:aca4 with SMTP id
 fe20-20020a1709072a5400b006d5879daca4mr419389ejc.29.1645571804662; Tue, 22
 Feb 2022 15:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
 <20220217142133.72205-3-cgzones@googlemail.com> <CAHC9VhT77Ft4+5LmNP0dwtaeNzF+r0b=9M5vh7qA1poY9jesJA@mail.gmail.com>
 <CAKwvOdkioR+7aebgzPu2Exe0oD9rwAeHK=CgM6vAkpBWdHnF2Q@mail.gmail.com>
In-Reply-To: <CAKwvOdkioR+7aebgzPu2Exe0oD9rwAeHK=CgM6vAkpBWdHnF2Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Feb 2022 18:16:33 -0500
Message-ID: <CAHC9VhSKZes9g_GHMKJdhd_BEt7GT4FKOLeMJ=o=FU8TtOZ-gg@mail.gmail.com>
Subject: Re: [PATCH 4/5] selinux: declare data arrays const
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Austin Kim <austin.kim@lge.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 18, 2022 at 12:24 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Fri, Feb 18, 2022 at 8:13 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Feb 17, 2022 at 9:21 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > diff --git a/security/selinux/include/initial_sid_to_string.h b/secur=
ity/selinux/include/initial_sid_to_string.h
> > > index 5d332aeb8b6c..915283cd89bd 100644
> > > --- a/security/selinux/include/initial_sid_to_string.h
> > > +++ b/security/selinux/include/initial_sid_to_string.h
> > > @@ -1,5 +1,12 @@
> > >  /* SPDX-License-Identifier: GPL-2.0 */
> > > -static const char *initial_sid_to_string[] =3D
> > > +
> > > +#ifdef __SELINUX_GENHEADERS__
> > > +# define const_qual
> > > +#else
> > > +# define const_qual const
> > > +#endif
> > > +
> > > +static const char *const_qual initial_sid_to_string[] =3D
> > >  {
> > >         NULL,
> > >         "kernel",
> >
> > Thanks for this Christian.  I generally like when we can const'ify
> > things like this, but I'm not excited about the const_qual hack on
> > core SELinux kernel code to satisfy genheaders.c.  I understand why it
> > is needed, but I would rather clutter the genheaders.c code than the
> > core SELinux kernel code.  If we can't cast away the const'ification
> > in genheaders.c could we simply allocate duplicate arrays in
> > genheaders.c and store the transformed strings into the new arrays?
>
> Note: casting off const is UB. I've had to fix multiple bugs where
> clang will drop writes to variables declared const but had const'ness
> casted away.

Then let's just memcpy the array in genheaders.c.  I'm okay with
genheaders being a little ugly if it helps keep the core code cleaner.

--=20
paul-moore.com
