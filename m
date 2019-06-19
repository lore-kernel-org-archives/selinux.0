Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18466C31E5B
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E094A2187F
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un5cISSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFSQDo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:03:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34996 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfFSQDo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 12:03:44 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so39459665ioo.2
        for <selinux@vger.kernel.org>; Wed, 19 Jun 2019 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L6TVMx+9IVfvvQgdM5F/2YM93lEFZqXtp2X/uLmF32I=;
        b=Un5cISSiqnxtOcsYkHJ7rZOrgPMDSyvyIEJyh0W7arqI8037/VUB/yW40WlQXOjOsL
         NZ5gWg7OSsdy0gAIAbhXn1l1gI4YKrTzGtwm4WsIpSINjv6IGCc7tdMLsPs8YqCc2LuT
         vb7Lk4lv8BND01o6pUy8A+V5cryjcO2IJy/viW81DSqUXxh/Cfws24/oaBC3ap4qKfj8
         bjz8BmRusgS+L8NqIit8fzEPh21ytvdKZ8h2KIedBYy3LcKVcLUcvcs57iHfFaUnCbE7
         BLieusTjSOYYm9zlvYoum62WiqiSxOIWmTrjpKY9bUkHoq5NVNUIgLzOBfGquYaW3dI/
         +hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L6TVMx+9IVfvvQgdM5F/2YM93lEFZqXtp2X/uLmF32I=;
        b=rGz5imUKaNMcvBPPmjXrrAVqCwnz1ElavEE3Gi0c7Hea9QMOSwtBEu6lXrHV5FoqIP
         xnCQeGGHHL1uG48p6FhcDhrtMLP37ZAmp38y1VLuLFiwBAmdsYDGnpuEyQUiHmGoyyGl
         JJGh3e0kJbEL9QwIcTIELizs7ZCCDvDQw5EQ5CpaZ6UAJ8wveng+v+kNpieVhqc4hyQc
         AteVjQ8yu19pn2EWbu8xJIwmR9CShlQcpwj4YJ08coicUeRiXjLAVnk/vkpZzjs+inKA
         gwMK86CNA+TgUKZtYCC5kWG3Kfu+g90uM8uRZfYE7zXam9+48fGWHLD9Esq1PVsAdadO
         CNig==
X-Gm-Message-State: APjAAAU0Kj9hYaaiW64/WzGcpFkcMQTWNy3wMufhsk9n5Z2/RSR3tLKE
        imMPX5J9UqLSktMtO5gCSRGxeVkWhlr5e2z5A8F42ey1
X-Google-Smtp-Source: APXvYqzAEAe6XuRXSCY+B383xttIWUiD5LAI2l/3w9oO3Z9FTKNP1OpjKNq2Vwr1FQK/qGxC/DVIn0TEmwokmsqz5e4=
X-Received: by 2002:a02:a90a:: with SMTP id n10mr82584933jam.61.1560960222288;
 Wed, 19 Jun 2019 09:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1906131859430.5703@34-41-5D-CA-59-C7> <CAFftDdohpm=28pbnJHCVG8PkCevt9=eZvFH5DoW4tOBQ1s5U_A@mail.gmail.com>
In-Reply-To: <CAFftDdohpm=28pbnJHCVG8PkCevt9=eZvFH5DoW4tOBQ1s5U_A@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 19 Jun 2019 09:04:07 -0700
Message-ID: <CAFftDdq0=d-Kf=eGSTU+dU5=T_vPAbuBCQ_OxHu8DukQc6u+eQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: remove unneeded int
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

merged

On Sun, Jun 16, 2019 at 9:35 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> ack on the series
>
> I see these are the three staged here:
> 3/3 uneeded int: https://github.com/SELinuxProject/selinux/pull/154
> 2/3 remove redundant if clause:
> https://github.com/SELinuxProject/selinux/pull/155
> 1/3 more accurate error message:
> https://github.com/SELinuxProject/selinux/pull/156
>
> I will pull them in on Wednesday June 19 if no one objects.
>
> On Thu, Jun 13, 2019 at 9:01 AM Jokke H=C3=A4m=C3=A4l=C3=A4inen
> <jokke.hamalainen@kolttonen.fi> wrote:
> >
> >
> > Replace int ret with a constant 1 because it is
> > only used when returning from function and is
> > never modified.
> >
> > Signed-off-by: Unto Sten <sten.unto@gmail.com>
> > ---
> >  libsepol/src/context.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/context.c b/libsepol/src/context.c
> > index a88937fc..e81b28c6 100644
> > --- a/libsepol/src/context.c
> > +++ b/libsepol/src/context.c
> > @@ -38,7 +38,6 @@ int context_is_valid(const policydb_t * p, const cont=
ext_struct_t * c)
> >         role_datum_t *role;
> >         user_datum_t *usrdatum;
> >         ebitmap_t types, roles;
> > -       int ret =3D 1;
> >
> >         ebitmap_init(&types);
> >         ebitmap_init(&roles);
> > @@ -75,7 +74,7 @@ int context_is_valid(const policydb_t * p, const cont=
ext_struct_t * c)
> >         if (!mls_context_isvalid(p, c))
> >                 return 0;
> >
> > -       return ret;
> > +       return 1;
> >  }
> >
> >  /*
> > --
> > 2.21.0
> >
