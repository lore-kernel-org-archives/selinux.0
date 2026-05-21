Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7426ED25
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373440; cv=pass; b=aXkD5DQxLzv9Amu75ICWhkcItHxlX8Y/PTNyiFwQs2SXubNRZc2GALRJLkjBoO/DogsyAfMcrQ2JHlVbYpgSSCCdZURilcZ1G21DKI8plZFns9NrbdgOYo8h4eZ9rKi/cIEVbyfTRYy5brpCjyyMinHx9jW8K2GtvLBO6PsY4Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373440; c=relaxed/simple;
	bh=VZiRvknE72zQeMYYnj/eHpO2iLl3+QE60G964F0tHN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLuJ4+UfRYidH30NV8YB75VFZiwSqjEx04tR8C6T+EFNAwgwWeyQGLpWINlIExMy1mRwguwIagg7WEE7sGANVmDA3fmoQtzcGqmiSLFBRZT8cL/yIZ/O4kjWJ+eBz7hbg+Qrp7wtD7HPQ4foIKr+70S0/C0oj8j4wDPk23N5B3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg0AWSoE; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg0AWSoE"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3939d2bd7ecso50982201fa.0
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 07:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373437; cv=none;
        d=google.com; s=arc-20240605;
        b=AWq7ypsvUFGro6Ak2eNnoUPxIUbsA6NlP/lG0x42CumyFPkpqqbaJepP/RI3rV3GYC
         P3JGGDOJCHE5FISgXwFpsYnbAn0k7WC7ia9btd1pRINeUXZ9Fg29y+QjTv5eg9zlgYfJ
         KtlS83zSgsBbPY904wWbwKYV34bD5ScEt9KUiPvEzj+ug7rnAKjuW1hJoc/m5qwupk9l
         GGSL35s2IVAbkqLKKGfMbUCCxz1RuIKdJ6TOBB8IzGMIAL7xHk/cMjfGequcKJd3sIIx
         sC21U1NTpSo/HIroP1q2XmJ/LtJt7/QFouKv84gUaMg9BrmD2T9JWtEJAX+RhzBHA8QS
         /PSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BA8BCZBOMqras2htS7AeaNNHzMd+OT1F7u5wUZF1bNQ=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=bTUm2pwAg3sKvHjJnF1diqgKj82ecIb7fEj9AE4LErx/Iib9aOg69aKL2X8g1Q8o/K
         Vu6WX1cpPCGuhr9m3W5QzoF+HSRV3SdAgl4iLIl/bWfX2kKZlRO9+zvRvYJZyZC83YDv
         R/9MCbvxddI0GImkf347ZWSJ9T5KAna+k3zCnufr8JP9AoorcBL/oLuFWo2YPOgpxg2k
         JWh4/t1m6gDrD2vDqQ3g05aT4+ohUeVQ40DoWosSHd8a4BEOF5kQnlB7DacJ1kFfnfb1
         HWM27sDONQ0HaOETFv8DmkHZfAEWp4EMe4Ko8scj2KeJU7YbkiE4CzYk0gGMZW6+AOwz
         5fqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779373437; x=1779978237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA8BCZBOMqras2htS7AeaNNHzMd+OT1F7u5wUZF1bNQ=;
        b=Sg0AWSoERt/iTlhX/RntV/Kmwq0KrkJy/M2eobwI32LbfH6R9vKElM1MnJYlaCkXOv
         QykL8LMgvfAKUc3jtyZEGaNHlavZQGYxBBdJqrn6yoQn2oBXSp4IhLoDWeIZ3h/Yfnlg
         VyOPig8APuz7yHmUdxbpT8/AdrE0pCpKdYq12sN9DtJfU7C1srCPFPjVAVBbk/YWKMBg
         frtnWqzMqGQFffzBuyEMNe+ckb/ZW7NKhbiUuI8pCdb32H3o1RVQTAhRXqkEkWzRrBD5
         P36+9TXnc6MlcIjh3Gwr8p2JCoK2U4dLytZWojpreNxgxt00GKSuU8OjxdxJ1J67rMOk
         sWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373437; x=1779978237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BA8BCZBOMqras2htS7AeaNNHzMd+OT1F7u5wUZF1bNQ=;
        b=iQSdx2AENeJ2djcBiQcLT0j5mWr2AugAAeq3maA1WBGfQiSjhd+HsCHrg5fZcDYUvt
         3kyewsCwpw+4LS6T73WZeW0upKDom/og3vQ/nkjddYXQqDEfOWXgdTcGgSiSrf5OwJ3l
         Rvr2EB7O4hOc7aoRGIwxArQVPjF0rIF8FDY+OvpGfKsXbH2rtY3LlJypNMiWxMaE2wIR
         kNVKkzEmRUjq/W6w+yt22h9S8pm1fRNQq6bR/HzRebAAHhr3FQ8HFjhsSESgI+u7XTGn
         dOnM5SVpzHoTUNzhfOaz1Fro2VQ3AENVaBC+TVVAbNcZ8+H4u/prw38MHljcVYGQeRtt
         UoEQ==
X-Gm-Message-State: AOJu0Yy/8yZRBh8vtpfJ5qQFIjJdzuNjuxGaVSGt8D5DvE9wvmTxv58c
	h6lnrFIn3VCLnO+EzIOVU2djdIU/7coZY16iPNsIvAhW5YXlGuU+VK1j5iY7OFp1q+7hFii4os1
	OTZRMRMB725VZAw3CHAMWxD/n2SqCL+DkeA==
X-Gm-Gg: Acq92OHg9QE3PA1Ee/LOzhISg2nRXweTbryXrdefTYlLWZHavxKDj22KRqpMKgzh42h
	vyy8HXl/8xcf5sGu++Pj/sp8qick11MdXpHtQndE05XD2PayTsYiAKSuVlQno49CP3oFS20MJNO
	h/SGetkZv5gDIqwGqR0akYuSo6FKK9E8uWZYu7kEWSW/RCXopn6x4w5U1Jc6dYTNoEiCH2bpyZR
	flNzTiirP8ScEZP4lyjPhFvk6AdhuQqkF84/lcZIBfFOlvttdurlT3WQ87pGFhK0hiiAMqghinA
	hSx7
X-Received: by 2002:a05:651c:ca:b0:393:a39f:5826 with SMTP id
 38308e7fff4ca-395ca560228mr10111821fa.21.1779373436724; Thu, 21 May 2026
 07:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514205631.76858-1-kalevi@kolttonen.fi> <CAP+JOzRfnG-fS3Ef=-DZf81Y6YvBKfE8uWB9PpC8nu=yDqqd+Q@mail.gmail.com>
In-Reply-To: <CAP+JOzRfnG-fS3Ef=-DZf81Y6YvBKfE8uWB9PpC8nu=yDqqd+Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 21 May 2026 10:23:45 -0400
X-Gm-Features: AVHnY4Kg7p80F_g10qDE0VAzRKhjMp8Ljbb75db5ExeLbfiwUpVvHZb_7XE8l5U
Message-ID: <CAP+JOzQSB5wjvDiQR2aLZgLOeRV6aD2CTCcTDwHTDw8Jvw2wAw@mail.gmail.com>
Subject: Re: [PATCH v3] libsemanage: make expand-check a proper boolean option
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:01=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, May 14, 2026 at 4:56=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttone=
n.fi> wrote:
> >
> > Make expand-check configuration option accept values
> > 'true' and 'false' for consistency with the rest of
> > the boolean options. Preserve backwards compatibility
> > with old configuration file settings by still accepting
> > the values "1" and "0". Edit man page to reflect the changes.
> >
> > Add missing <stdbool.h> include.
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/man/man5/semanage.conf.5 |  2 +-
> >  libsemanage/src/conf-parse.y         | 22 +++++++++++++---------
> >  libsemanage/src/semanage_conf.h      |  3 ++-
> >  3 files changed, 16 insertions(+), 11 deletions(-)
> >
> > diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man=
5/semanage.conf.5
> > index b22e65bd..74f0d34f 100644
> > --- a/libsemanage/man/man5/semanage.conf.5
> > +++ b/libsemanage/man/man5/semanage.conf.5
> > @@ -59,7 +59,7 @@ The target platform to generate policies for. Valid v=
alues are "selinux" and "xe
> >  .B expand-check
> >  Whether or not to check "neverallow" rules when executing all
> >  .BR semanage
> > -command. It can be set to either "0" (disabled) or "1" (enabled) and b=
y default it is enabled. There might be a large
> > +command. It can be set to either "0" / "false" (disabled) or "1" / "tr=
ue" (enabled) and by default it is enabled. There might be a large
> >  penalty in execution time if this option is enabled.
> >
> >  .TP
> > diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.=
y
> > index b69ac75b..70691fa5 100644
> > --- a/libsemanage/src/conf-parse.y
> > +++ b/libsemanage/src/conf-parse.y
> > @@ -29,6 +29,7 @@
> >
> >  #include <errno.h>
> >  #include <unistd.h>
> > +#include <stdbool.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > @@ -168,15 +169,18 @@ target_platform: TARGET_PLATFORM '=3D' ARG  {
> >          ;
> >
> >  expand_check:   EXPAND_CHECK '=3D' ARG  {
> > -                        char *endptr;
> > -                        long value;
> > -                        errno =3D 0;
> > -                        value =3D strtol($3, &endptr, 10);
> > -                        if (*endptr !=3D '\0' || errno !=3D 0 || (valu=
e !=3D 0 && value !=3D 1))
> > -                                yyerror("expand-check can only be '1' =
or '0'");
> > -                        else
> > -                                current_conf->expand_check =3D value;
> > -                        free($3);
> > +                       if (strcasecmp($3, "true") =3D=3D 0)
> > +                               current_conf->expand_check =3D true;
> > +                       else if (strcmp($3, "1") =3D=3D 0)
> > +                               current_conf->expand_check =3D true;
> > +                       else if (strcasecmp($3, "false") =3D=3D 0)
> > +                               current_conf->expand_check =3D false;
> > +                       else if (strcmp($3, "0") =3D=3D 0)
> > +                               current_conf->expand_check =3D false;
> > +                       else {
> > +                               yyerror("expand-check can only be 'true=
', '1', 'false' or '0'");
> > +                       }
> > +                       free($3);
> >                  }
> >          ;
> >
> > diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage=
_conf.h
> > index 2388faad..f9e330b7 100644
> > --- a/libsemanage/src/semanage_conf.h
> > +++ b/libsemanage/src/semanage_conf.h
> > @@ -21,6 +21,7 @@
> >  #define SEMANAGE_CONF_H
> >
> >  #include <semanage/handle.h>
> > +#include <stdbool.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> >
> > @@ -36,7 +37,7 @@ typedef struct semanage_conf {
> >         int server_port;
> >         int policyvers;         /* version for server generated policie=
s */
> >         int target_platform;
> > -       int expand_check;
> > +       bool expand_check;
> >         int save_previous;
> >         int save_linked;
> >         int disable_genhomedircon;
> > --
> > 2.54.0
> >
> >
