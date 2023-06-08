Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53010C7EE29
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjFHTw2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjFHTw2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Jun 2023 15:52:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3472733
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 12:52:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f642a24555so1259121e87.3
        for <selinux@vger.kernel.org>; Thu, 08 Jun 2023 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686253945; x=1688845945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccvhZqcWVMzvy4J9b25guBRPHxiClPTDiSqH9WZozM4=;
        b=AJpK3mdFNb7To+wK2QHHo5xQgbizKRY6JAphPJn8GOCcCKyqfuzGso6yMvNXVkcNrB
         MEmdhVq+ngBwVmg7zeTQbgniFB4WNXjVNUD2dgEj2vvGzjIGJ74erZt/2IYpPANYu1jn
         GqeNR9XIn+yGsN5WkJjyhk+2aG0iQ+l2BbXFldk/BsNLdaoa5Ej5vupG83NWaQRgm4ZY
         L/BppzdWXJnvvVL+phawb0A4PyUNpb17OZICBwQoqNc8VrXKMndAWK1WKtqgF3h0BWx7
         4Kiq6XkyEI0I5Xg/bMgCt2Qpte5Thes65EdKfo6i/3UtXOkKUHefBvBazsIHF1aRojzI
         /KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686253945; x=1688845945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccvhZqcWVMzvy4J9b25guBRPHxiClPTDiSqH9WZozM4=;
        b=YrCIHoObfqPzBd+wel+Epl2isERO061lT/JlgOqN9MK/biA97tIhkWpxitARv7jzd8
         tg4mInHE8yCG7/JW6UD9gDoDGPSEp5f4QlgLALvmiVcWVYXRS+zToZ6JTUF8Ex8mmPcf
         +DconDvRElA55AdIXtIW1tK/z8a1mCrTp/ufNB6/bGU6A0jmRe0bVFtNd/e6JbeNlob+
         BJhedZ6jMzJuApVY7WC8ZiiFUcJ7xEUCJokrfgHdc2Gern+/yLl0CwJhdkCzW015Hkb8
         6SHhHeoBJDldxHwp9h0xJLxJIoCILQp6Au9Hmf+b8UQhCFz3naWbZSty0q+Fg2D5i1gR
         IRMQ==
X-Gm-Message-State: AC+VfDyA0RXQPR7/YFbz3DD4RNh+s4h9qzW4nKmVIhPk6/BZ5tj3CdMB
        Z/E6GacjgcuW6yLYmB2G7f6ZNcIySFGe03+ZNc8=
X-Google-Smtp-Source: ACHHUZ5ZpXDWcksAMjL8TyqRmmt3VaGWKGi8bhF23spKFLsal8iHwnW/5zT9jZ7CpgszZQ2c0mqyVO5DMyewyNM1Hf0=
X-Received: by 2002:a2e:3317:0:b0:2b1:e369:f98 with SMTP id
 d23-20020a2e3317000000b002b1e3690f98mr3729243ljc.11.1686253945158; Thu, 08
 Jun 2023 12:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230604115726.11247-1-toiwoton@gmail.com> <877csijnj0.fsf@redhat.com>
In-Reply-To: <877csijnj0.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 8 Jun 2023 15:52:13 -0400
Message-ID: <CAP+JOzS9Z6+TSbZe+oM9fnT9CzYPa3Sg+MrMWzNqL7EY1ZwbZw@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: clarify manual page of sepolicy interface
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 5, 2023 at 5:17=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Topi Miettinen <toiwoton@gmail.com> writes:
>
> > Expand the description to make it more clear what "interfaces" mean
> > here. They're different from network interfaces used by SELinux
> > command `semanage interface`.
> >
> > Add a note that the information comes from on-disk file which has been
> > installed and it doesn't necessarily match the policy loaded to the
> > kernel.
> >
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

Merged.
Thanks,
Jim

> Thanks!
>
> > ---
> >  python/sepolicy/sepolicy-interface.8 | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/python/sepolicy/sepolicy-interface.8 b/python/sepolicy/sep=
olicy-interface.8
> > index 3e74ea62..c8985afb 100644
> > --- a/python/sepolicy/sepolicy-interface.8
> > +++ b/python/sepolicy/sepolicy-interface.8
> > @@ -8,7 +8,11 @@ sepolicy-interface \- Print interface information base=
d on the installed SELinux
> >  .B sepolicy interface  [\-h] [\-c] [\-v] [\-a | \-u | \-l | \-i INTERF=
ACE [INTERFACE ... ]]
> >
> >  .SH "DESCRIPTION"
> > -Use sepolicy interface to print interfaces information based on SELinu=
x Policy.
> > +Use sepolicy interface to print information of interface macros
> > +between domains in SELinux policy modules, as used in Reference
> > +Policy. The information is based on installed on-disk representation
> > +of the SELinux Policy and it may be different from the policy which is
> > +currently loaded.
> >
> >  .SH "OPTIONS"
> >  .TP
> > --
> > 2.39.2
>
