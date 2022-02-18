Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F466C433F5
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 17:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiBRRZJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:25:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbiBRRZI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 12:25:08 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE7F2B5231
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 09:24:51 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so4300042ooi.2
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 09:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e48rbRghZ1DHjEo5oAQPObeUfspj3j2bBv68xgwxZDg=;
        b=B6b07vv9/aGPNg6S485OaHdVCheTvWziFVBg71SY0DOhjK7WDiRUJjBrnomP+yCPKi
         beF4zz1XqIgM7q5h2UVDA+K8EpzE3Sl+CMTCJsteOe3Uff1qUlw2cMEnQbQdzGIJxrky
         h5S4rMM94onJIbUS4+dMB/YhGIoP9j4x5M9nwUrrPXfqWDeBDAMIELL3VvvxGvWgqMyN
         2sDxR/EXKyqEFQuyCKBLH5dt6DZfY+nJuWLYklzfI6v5JzlhIXSdACTerkZmhXouMGIK
         Sr3GDvB6hVLLANmcqhh1hmdwzXn9Dh8nOcvYbLVllThUGCpHBQn80TLrYsdpNN2UshO2
         C4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e48rbRghZ1DHjEo5oAQPObeUfspj3j2bBv68xgwxZDg=;
        b=qs6TpGcDw72ZV4idrdxcaxzPE1adFrzwKKv7RnXSTX2vM5qFj6FgWr0Kkcs74/gXJj
         /G/bVeiz2Uj891YRi8nUd7cPhnJkPxkEQv2lwVQG1kaEGkjXcabPDOHu6Y4Q0tCevLaV
         pcMLhLvGgv3LnTXBVv+lu4Iwsd4ONNhA9Yk8v09T9v+iFWDr8dKrbDn3Ct1MpjGAzE0G
         fm/Vcfjyv4XrXQRuEQp/SIFhgBe//rHKpPJBkSRoLKmsViqAtZetcJ18bfqYRM9f0Bre
         mILS1Uixuln/rRc9Q1AX9LHVflGihjaCFRJwj2cT3n4RHcxgaCdmRgVurw35u11CvKuu
         pfIA==
X-Gm-Message-State: AOAM532VGs7XH53kbwJ1sF+ZNxnQ65q0ffN8vzD2YmFjhl1/64wPAt4u
        nlzToS0b18bsLYRm+cpN3bnkQC9+DVTP3F0ST6b9sxFFyl0=
X-Google-Smtp-Source: ABdhPJxeMGrNQo5p4UItQyXTMpqQBxLO8zARxmITPMT0p8OolI64JRzNUI3LaxZS0U2ddwM3nEFeutNzi0O3h5nsuGI=
X-Received: by 2002:a05:6870:3491:b0:d2:48b5:7a4c with SMTP id
 n17-20020a056870349100b000d248b57a4cmr4553827oah.288.1645205090740; Fri, 18
 Feb 2022 09:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
 <20220217142133.72205-3-cgzones@googlemail.com> <CAHC9VhT77Ft4+5LmNP0dwtaeNzF+r0b=9M5vh7qA1poY9jesJA@mail.gmail.com>
In-Reply-To: <CAHC9VhT77Ft4+5LmNP0dwtaeNzF+r0b=9M5vh7qA1poY9jesJA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Feb 2022 09:24:39 -0800
Message-ID: <CAKwvOdkioR+7aebgzPu2Exe0oD9rwAeHK=CgM6vAkpBWdHnF2Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] selinux: declare data arrays const
To:     Paul Moore <paul@paul-moore.com>
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

On Fri, Feb 18, 2022 at 8:13 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Feb 17, 2022 at 9:21 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > diff --git a/security/selinux/include/initial_sid_to_string.h b/securit=
y/selinux/include/initial_sid_to_string.h
> > index 5d332aeb8b6c..915283cd89bd 100644
> > --- a/security/selinux/include/initial_sid_to_string.h
> > +++ b/security/selinux/include/initial_sid_to_string.h
> > @@ -1,5 +1,12 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > -static const char *initial_sid_to_string[] =3D
> > +
> > +#ifdef __SELINUX_GENHEADERS__
> > +# define const_qual
> > +#else
> > +# define const_qual const
> > +#endif
> > +
> > +static const char *const_qual initial_sid_to_string[] =3D
> >  {
> >         NULL,
> >         "kernel",
>
> Thanks for this Christian.  I generally like when we can const'ify
> things like this, but I'm not excited about the const_qual hack on
> core SELinux kernel code to satisfy genheaders.c.  I understand why it
> is needed, but I would rather clutter the genheaders.c code than the
> core SELinux kernel code.  If we can't cast away the const'ification
> in genheaders.c could we simply allocate duplicate arrays in
> genheaders.c and store the transformed strings into the new arrays?

Note: casting off const is UB. I've had to fix multiple bugs where
clang will drop writes to variables declared const but had const'ness
casted away.
--=20
Thanks,
~Nick Desaulniers
