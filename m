Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C70EC07545
	for <selinux@archiver.kernel.org>; Wed, 25 Oct 2023 01:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjJYBnm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Oct 2023 21:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJYBnl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Oct 2023 21:43:41 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDA01B3
        for <selinux@vger.kernel.org>; Tue, 24 Oct 2023 18:43:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b3f6f330d4so2879834b6e.2
        for <selinux@vger.kernel.org>; Tue, 24 Oct 2023 18:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698198217; x=1698803017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWtuDj+dMYEuR0jO7fp22plYarFYfYohR8mIhmBTCiU=;
        b=U0INWITUlPl9AZeiQ4uu19QC5xtLGsi7vRDhfZxoHw6I1TgQrrcGH8pZJtRSt9fVs1
         Kq6j2/XH269ubLxcTDTO0H9oGAvdHKBQyzodV811mFWsCaQ34SBVyBUbQ4lDw8OEePoe
         R+c8Kyp2xupH9O8ITZma4vp8HQDex+5DpuuO1szFYbT4UURMBA7ffnHfN+OrI62LFQbk
         A0gGINENzYHrtOo+ielpw2L5S7W7ETqNUv034d1Dbe/lIvGclGhLG6oJLPpj5FPeyTQU
         AlylC60DiOPavpssTN0NXLRYweLrrekkqPk2Lz0zxjfpcLXyB8rxXbFyG5jp9o5I5cPZ
         KN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698198217; x=1698803017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWtuDj+dMYEuR0jO7fp22plYarFYfYohR8mIhmBTCiU=;
        b=g3ZOA/a+280W6HzIEkdEzmaCpQ7XSdlV7cBA6P/Vg5O9utMJEpJtiNGXRLscQEqmQo
         is+ZBIHGG1tEdxwXs53e0IQ683dA06y3nTbepfWnHUTZFzZTOxKWadlJZ2rlp9Y8VxIp
         IyfaZNmDRXArJyIef0I8psUGzJAspAy0Gr0w4jd8Zc+SkRZe5W8qovLlulvzgy7lOWfQ
         OGSsOdCrF/NJAxzrQSAsa1HFnVgcgIjt08fcYUNdRxZtHOLCgk1RWfojb/xy82+8mb3d
         2f9C5bgs2f9VuMe3g2yHlC8n16ExtaAAFVVQ8QegDYC7h4qKH8KI2OcV6dSns0HJ0lBy
         qpTw==
X-Gm-Message-State: AOJu0YxE0Uz0j/DUB7rmGejkLZbGnNf9kxgOHef4/JN81CMe7EE0zX3t
        JNC2dW1RAg16dNuslJc3KIVp4hsR/bs2a33uKqoqmvIgD1nv8VFaQ8zJ
X-Google-Smtp-Source: AGHT+IFHuiLVHYnPlMkFE/exb9ahyrfxEZzvscztHHLfxhHk6O+UTMOPvfRGkZT0z+1SnsWl6X7ZF5/6g8g7QgY8NmU=
X-Received: by 2002:a05:6808:90:b0:3b2:f54b:8b3a with SMTP id
 s16-20020a056808009000b003b2f54b8b3amr15140460oic.27.1698198217069; Tue, 24
 Oct 2023 18:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231024213525.361332-4-paul@paul-moore.com> <20231024213525.361332-5-paul@paul-moore.com>
 <8fcaab11-6340-4056-b9e0-4650be05b270@schaufler-ca.com>
In-Reply-To: <8fcaab11-6340-4056-b9e0-4650be05b270@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Oct 2023 21:43:26 -0400
Message-ID: <CAHC9VhR_Mm0aZKafhhaQHnasU_30Uvy9zUvEMs9COzh22QSNWw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] lsm: cleanup the size counters in security_getselfattr()
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 24, 2023 at 6:23=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 10/24/2023 2:35 PM, Paul Moore wrote:
> > Zero out all of the size counters in the -E2BIG case (buffer too
> > small) to help make the current code a bit more robust in the face of
> > future code changes.
>
> I don't see how this change would have the described effect.
> What it looks like it would do is change the return from -E2BIG
> to 0, which would not have the desired result.

When @toobig is true, which it will be when one of the individual LSMs
return -E2BIG, the return value of security_getselfattr() is fixed to
-E2BIG (check the if-statements at the end of the function).  Setting
@rc to zero as in this patch simply preserves some sanity in the
@count variable as we are no longer subtracting the E2BIG errno from
the @count value.  Granted, in the @toobig case, @count doesn't do
anything meaningful, but I believe this does harden the code against
future changes.

Look at the discussion between Micka=C3=ABl and I in the v15 04/11 patch
for more background.

https://lore.kernel.org/linux-security-module/20230912205658.3432-5-casey@s=
chaufler-ca.com

> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/security.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 988483fcf153..9c63acded4ee 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -3951,8 +3951,9 @@ int security_getselfattr(unsigned int attr, struc=
t lsm_ctx __user *uctx,
> >                       continue;
> >               }
> >               if (rc =3D=3D -E2BIG) {
> > -                     toobig =3D true;
> > +                     rc =3D 0;
> >                       left =3D 0;
> > +                     toobig =3D true;
> >               } else if (rc < 0)
> >                       return rc;
> >               else

--=20
paul-moore.com
