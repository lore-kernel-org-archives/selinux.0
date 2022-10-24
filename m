Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7BBC38A2D
	for <selinux@archiver.kernel.org>; Mon, 24 Oct 2022 20:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiJXUnH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiJXUmi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Oct 2022 16:42:38 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CBD170DD7
        for <selinux@vger.kernel.org>; Mon, 24 Oct 2022 11:51:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i3so9698606pfc.11
        for <selinux@vger.kernel.org>; Mon, 24 Oct 2022 11:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw0EQk96e8PgIdq063hoyVOX6G9C4s/eA/tfD0DyP5E=;
        b=PuQDuJNc0NH6bI3SR/i/TbZtDWFl3bQWtUDisIe7vScgaxiiSzAY8S34behgwfLg63
         fsxVmYPlFmMyGEvZJj0G4rcPWZa0DdYw85a06h8rOOKGV3uwGMk91VTjHFW0Ks8K3/u8
         hUIESUvOg2/3elntAlVsHILYQBNWpc39SvZBY8tsBfi17shGdaWOuDQ84P7gQ2vVTZ+h
         JMO6YZ6Oe9JJqmub9bfNeaLG+co5mf516GqzhKQxbFS3JxMK07Vn2zRxiHwNS/SlMLWU
         8M44I8oziKhx44EQQNslhE+c+v0V0wRYVJuVaqsTYS2JZa6Msa17zlQG1/95iYaE6u5U
         zxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kw0EQk96e8PgIdq063hoyVOX6G9C4s/eA/tfD0DyP5E=;
        b=0d+RhLY6sP8O6cEY0jEg9B7KEW9xTX4W1WLMOxPov3vxt3p6Zgvbq26ulfzAof+hD9
         xLB9VtSJiBkv5NkygNoQa9h2Rgv2Dxem963VrWq/d2Uf/C8nx+og6XT/9PyEJhMadzaE
         CQyaOX61lE05Mv38pxxbCkDN6DB7MijdHONDglrOzivECsXDxGh0byZvDUedAndRPe5b
         doH27NdPpCOx847T81nkzKtHz4cwxJzxHrR/UV3zXJ9nQNi1BY9Rma5xEiG/Zhxr1nHJ
         eY3Lv0PueYHRIv3/j/HdhGwaaR1Ty4KuQ5OZvigV1Uyc5Hc6kzFk1kMPV6CHXoZYia3u
         WuYw==
X-Gm-Message-State: ACrzQf1UzSShW48SUb+jc1dsqsfRJmTLNl/sR7hhm3H8rBH6us1d4K60
        UhtplTQ7wu6HpQFebxFLs/9/g7fVNk5vNW0nk4ePU6ly
X-Google-Smtp-Source: AMsMyM5k17eWxnbPuXOPOQmzn01Vemhz8k+/4CD4dtZ0GXFffdUSmqf89g1TVyoNGbwyt/u+L5LxNLSqXM+90H0xhAQ=
X-Received: by 2002:a05:6a00:1a07:b0:541:6060:705d with SMTP id
 g7-20020a056a001a0700b005416060705dmr35306166pfv.61.1666637412090; Mon, 24
 Oct 2022 11:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221017122151.2837373-1-jwcart2@gmail.com> <CAHC9VhRkX17eXYqhA4-E1SxoXhqVr0j7NM3uHPBbRyG6c5CROw@mail.gmail.com>
In-Reply-To: <CAHC9VhRkX17eXYqhA4-E1SxoXhqVr0j7NM3uHPBbRyG6c5CROw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 24 Oct 2022 14:50:01 -0400
Message-ID: <CAP+JOzSTM5R9zUmrXDabhvBV26QhSVoD_ROS41CkvResPhAxLA@mail.gmail.com>
Subject: Re: [PATCH V2] docs: Add GPG fingerprints
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, perfinion@gentoo.org,
        nicolas.iooss@m4x.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 17, 2022 at 1:51 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Oct 17, 2022 at 8:23 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > For Nicolas Iooss, James Carter, and Jason Zaman.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> > v2: Removed Ondrej Mosnacek's GPG fingerprint
> >
> >  SECURITY.md | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Nicolas, James, and Jason's keys all match keys that I have verified with them.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
>

This has been merged.
Jim

> > diff --git a/SECURITY.md b/SECURITY.md
> > index c817eac9..4f624f5d 100644
> > --- a/SECURITY.md
> > +++ b/SECURITY.md
> > @@ -26,12 +26,15 @@ the issue as quickly as possible and shorten the disclosure window.
> >
> >  * Petr Lautrbach, plautrba@redhat.com
> >  * Nicolas Iooss, nicolas.iooss@m4x.org
> > +  *  (GPG fingerprint) E25E 254C 8EE4 D303 554B  F5AF EC70 1A1D A494 C5EB
> >  * Jeffrey Vander Stoep, jeffv@google.com
> >  * Joshua Brindle, brindle@gmail.com
> >  * James Carter, jwcart2@gmail.com
> > +  *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 62AE
> >  * Paul Moore, paul@paul-moore.com
> >    *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8A
> >  * Jason Zaman, perfinion@gentoo.org
> > +  *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
> >  * Steve Lawrence, slawrence@tresys.com
> >  * William Roberts, bill.c.roberts@gmail.com
> >  * Ondrej Mosnacek, omosnace@redhat.com
> > --
> > 2.37.3
>
> --
> paul-moore.com
