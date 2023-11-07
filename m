Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE5C4167B
	for <selinux@archiver.kernel.org>; Tue,  7 Nov 2023 21:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjKGVjk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 16:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbjKGVjk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Nov 2023 16:39:40 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD76110E4
        for <selinux@vger.kernel.org>; Tue,  7 Nov 2023 13:39:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a98517f3so7699218e87.0
        for <selinux@vger.kernel.org>; Tue, 07 Nov 2023 13:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699393176; x=1699997976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nM+focZ6hNq1M+DwrGIG8kg83hVbon92X8udPuYIBVg=;
        b=BlVKQtwuO3ZbAqTudZ1SA7ZRePKbUEk1oNchgou5mM+DYksmF9NH3Z9eua/5mHE1i9
         DODZNSxWbryo1nNRrWO/RWHP44mYTK0/3S2SdPcpmc50AYLPitsM8hRBjduV59WL8Ksz
         AvBZ9WPfbShVwlb2rX8f8lO7WTKK+4j2IK5+jwX4j0TtoN01QFmPrUi0OK7apkEsuCdI
         m4ZofTpkUn+wE+noIPbQYS/PT5AxbV2u/KITBp7mj701bSP2Rrml3zKB15Y79KW3ogUX
         Ml8tsXreDBQmpf7R2x++0kuy+BbmQiL5TDWhHaO33Ru94d7dQBiZw+ZOHKtwcbRAxKr9
         89Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393176; x=1699997976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nM+focZ6hNq1M+DwrGIG8kg83hVbon92X8udPuYIBVg=;
        b=POA+GB5oMVLvUrhRZgQAPr/0kS0wTWwM0yXUC4+/c5WqHtaN3bk9SmqAGsyTk6KPKL
         XSOJRiVbjmCt75VQbJa9rsFQHps/4Kis3OIr9AWEajs15Y6gbOYKs2S6TBWZm1+xVbT4
         CB3Efx+BHOpIY4W+Q8OxgIR8FtQKN19gO5Jsi2AAtgLBOGEzVlw+q6o9xU3OBnsKiI5z
         aSGxpfpuzN3kolsZkhppFjyqsEQuoDbnGIs2MNPL+sRdfRYdN09TPPKJSZ4bosiut/nT
         4utPgAQmAkAaOGz5/m4DALM+qhVkT0tgsuYdk8u+ggbgwxdrVe8GRX9xBjI4mzkCxC0b
         UWJw==
X-Gm-Message-State: AOJu0YwI6QOjFIERHCWpmpTUElw6IeXBXfCQWN6mCK6lDxUQ1OevS3KZ
        ltMUcAqu0U1D7wjy0WbTKTKS0upVMGsrVVA6+YWQOaKC
X-Google-Smtp-Source: AGHT+IEQ6a9l6snIKz/Fc1nwksl1CsN7msTiDKdPmCctApreHRiBBKWfPhlh2pdua82QsXmiZGziK4gVQjhig+GXTEA=
X-Received: by 2002:a05:6512:ad5:b0:509:11fa:a208 with SMTP id
 n21-20020a0565120ad500b0050911faa208mr28016983lfu.43.1699393175839; Tue, 07
 Nov 2023 13:39:35 -0800 (PST)
MIME-Version: 1.0
References: <8734xzhtvh.fsf@redhat.com> <20231025131903.12044-1-cahu@suse.de> <87pm0vgkzf.fsf@redhat.com>
In-Reply-To: <87pm0vgkzf.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Nov 2023 16:39:24 -0500
Message-ID: <CAP+JOzQD4SQ8amDWz4SoAEyRT4L4g0BfS60=32HuZMNkHznETw@mail.gmail.com>
Subject: Re: [PATCH v2] sepolicy/manpage.py: make output deterministic
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org, selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 31, 2023 at 6:12=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Cathy Hu <cahu@suse.de> writes:
>
> > The list entries in the alphabetically grouped dict are
> > not sorted, which results in non-deterministic output for
> > index.html.
> >
> > Sort entries of those lists to make the output deterministic
> > to be able to have reproducible builds.
> >
> > See https://reproducible-builds.org/ for reasoning.
> > This patch was done while working on reproducible builds for openSUSE.
> >
> > Signed-off-by: Cathy Hu <cahu@suse.de>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

Merged.
Thanks,
Jim

> > ---
> >  python/sepolicy/sepolicy/manpage.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepo=
licy/manpage.py
> > index a488dcbf..62999019 100755
> > --- a/python/sepolicy/sepolicy/manpage.py
> > +++ b/python/sepolicy/sepolicy/manpage.py
> > @@ -156,7 +156,7 @@ def get_alphabet_manpages(manpage_list):
> >              if j.split("/")[-1][0] =3D=3D i:
> >                  temp.append(j.split("/")[-1])
> >
> > -        alphabet_manpages[i] =3D temp
> > +        alphabet_manpages[i] =3D sorted(temp)
> >
> >      return alphabet_manpages
> >
> > --
> > 2.42.0
>
