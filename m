Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F74C41513
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347392AbjJLR5r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347384AbjJLR5h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:57:37 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA1BFF
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:57:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so1671295e87.1
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133448; x=1697738248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXRrirR6oZW20BQ+kLYPQ8hYITiLdG+6fzLZNZO/+DA=;
        b=jPNXIsjUV8zyB+LZ0i1gqSSQdwV3XPijeRo9o6/Wz8MvrxCZrk2Rb9aoSW7zTNyST1
         phk8g40wa7ugTVaa6tIpRKXO2GLoJ1Tz5MZ4L8TKPZ5I2RglXdxRpPNN16yjKnHlFkpl
         yQ6toLUZtpBTHRKlMwB2ahDD/+Mn/RSEkBeCSoOEMoUNXG6BKNIhWAam1BQwPSjyBOst
         Vxa9LRoXsNLaBAoH61KcrPD8PAw+ZAcv1fpVJ1mfg2onfF+zj07mBaRO1ESkzgmg9LH2
         6dyzvW7gruMHJG7JXNyZHN5zOqqHfs4PqQk3++WUzRAVU81EKFafHbhpMIBhXLGiSq11
         bnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133448; x=1697738248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXRrirR6oZW20BQ+kLYPQ8hYITiLdG+6fzLZNZO/+DA=;
        b=dny5/3A4ZBmz0wepIO2A55koojbPKd7RkP0352X/IkHO2rqoNRTq1nYcYCeCVp1YpB
         INedDsOxzpxJF5+PZa3iiOtQWNO/mj+9fu52RaRbmK7PHY8gBozMvM4zZbbBVYAR/N8l
         FgVbqn2SCRGrC1+IWjPl1op0UbbKKgT4LPufd6JmUhzF1zvAl60dYOmnEWkDf3/pyh8V
         YiYUwNATG/ofDlqN6cPtyS7tXkk0BAyEHcfzMQq2GAEnCfAUzMNHRCDn7jrg0LlbL6Pp
         fbvpNQurM0oTdwQv8hkLyEMAmfsrxUlYawFTQc9E+lgagHQnTnNclKUNlzU9edDnNW6G
         oBNQ==
X-Gm-Message-State: AOJu0YwUhk7KSfEQ4hyQCNVkzZccbvAsoOP8tKHkSGgtrtuo91LYrVJw
        ZDxFpV0telHDrwqGsuwoDECrMVRuLVAetI09/cc=
X-Google-Smtp-Source: AGHT+IHvyVpkhprdt3dqhzQ+uNn2uAy/1UglV0qEOVFFpjQbglU1jHVG1ZFpxR0034qly3xGx+XMt5FABmO288Oxk1c=
X-Received: by 2002:ac2:5f0a:0:b0:503:905:c5a3 with SMTP id
 10-20020ac25f0a000000b005030905c5a3mr17617644lfq.35.1697133448137; Thu, 12
 Oct 2023 10:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-25-cgzones@googlemail.com> <CAP+JOzQqBMVBdtcyZmci2DFgdtHkhKfXBpnpgPqLXGhWbRrDPA@mail.gmail.com>
In-Reply-To: <CAP+JOzQqBMVBdtcyZmci2DFgdtHkhKfXBpnpgPqLXGhWbRrDPA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:57:17 -0400
Message-ID: <CAP+JOzRF3qX86VOQczAuWDV4hRm-XHuRXK_F7BFqQRTEcSuuBg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/27] libselinux: set errno on label lookup failure
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 11, 2023 at 2:50=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > selabel_lookup(3) is expected to set errno on lookup failure, i.e. when
> > it returns NULL.  Set errno if a regular expression failed to compile i=
n
> > compile_regex().
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> > v2: add patch
> > ---
> >  libselinux/src/label_file.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index 3827b5c0..5365086b 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -407,6 +407,7 @@ static inline int compile_regex(struct spec *spec, =
const char **errbuf)
> >                         *errbuf =3D &regex_error_format_buffer[0];
> >                 }
> >                 __pthread_mutex_unlock(&spec->regex_lock);
> > +               errno =3D EINVAL;
> >                 return -1;
> >         }
> >
> > --
> > 2.40.1
> >
