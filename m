Return-Path: <SRS0=VlsA=TQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12E1C04E53
	for <selinux@archiver.kernel.org>; Thu, 16 May 2019 01:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C3E20843
	for <selinux@archiver.kernel.org>; Thu, 16 May 2019 01:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb/Y6475"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfEPBqd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40893 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfEPAgG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 May 2019 20:36:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id u11so1803734otq.7
        for <selinux@vger.kernel.org>; Wed, 15 May 2019 17:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g3Iq5snhvQ0Bs/Xgt8lZrLU8oAvAHpcWLpGSk/lnZrY=;
        b=Nb/Y6475LD6/ufXabUybH2q1l2PtXhKnJLTsbaJ/p8l3V6/TNrhIBn1odlP7kD+jfV
         uDzQ3RFUG7nn3e8iM/LJb+QT/vHKx75Z78uNS4rFwnBhRjCET+zGLFbvLH6J1Ubb1f6E
         PXH9XWn5wV46P8YEVArdRynzfRFYz1k7WI7A90iJE8hvO2KjLWCSdg8LHr38E13+DVYp
         +GehS9EUgL/Y5AnjtyHCiMT7JEbDjGYJwUv+/DuJ3WVRUKWpzGNklul5qK5Osriri/gF
         89dflCTErbAGtcrhJNsye7fH6LbWAwPcsy6B9mtsZVCZIGfUsAF4QtslpKLu4Y5qvFP6
         LBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g3Iq5snhvQ0Bs/Xgt8lZrLU8oAvAHpcWLpGSk/lnZrY=;
        b=N8leixGBhwqOtR+jFuDG62NDWecBWxFn11RHQiw8mDX2Xtp5gJTxagYogCEwDMkQfG
         jFzVUwog/eZ4hdfaUCuWwe5TEHQu3OFYDmbKTL8l7C10fV31yvcPwi3Ggt9T/Jw5NMZI
         9FG8pMu4/R9yVxHICcJHvaPheWFIhNGYGKUtgYzQfMFJu2rTxhqMDBeB0r0fm0pl6dkl
         L+xYrQLlKSFy71SDsO8seletLo9YX8sgo93Qv+hj2a37knpuo5m6t1sC/0Jkl0ACCN3s
         LxgCjG3iknJ5Jg7P/VQJLkvjAxNsfHzl5UiQ0MsSOMV4u1ZoKZmUrchHLoXJuRi7Q7bW
         Uj/w==
X-Gm-Message-State: APjAAAXbPz1DAjYYgVVNDCabP9DxbNB2HOgJKpdKrv+ZojpfXAsO/Nt0
        SOlpkIwp2x5kKmyXACDX7KIURLCeeG95Y7E71Vo=
X-Google-Smtp-Source: APXvYqxzaIC2qY09XfyeIGHdn3qpniNiOy8Ng3GHAy11MBDD6oURfajwcgBv7W07Hrzs/Q9V1Sl/PzG6NyBDY9uDRDw=
X-Received: by 2002:a9d:4b17:: with SMTP id q23mr4282677otf.130.1557966965967;
 Wed, 15 May 2019 17:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1905102116350.16225@34-41-5D-CA-59-C7> <CAFftDdpJe1Yd_MdiNO=D+=pK6bbg3-G+a0aM_Ck=cz7dzJdsgA@mail.gmail.com>
In-Reply-To: <CAFftDdpJe1Yd_MdiNO=D+=pK6bbg3-G+a0aM_Ck=cz7dzJdsgA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 15 May 2019 17:35:54 -0700
Message-ID: <CAFftDdrvC3YxzZti+zQuLBpz+e7k-1-HdkihH-v1y-mekmy8CQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] another style fix
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

merged: https://github.com/SELinuxProject/selinux/pull/147

On Fri, May 10, 2019 at 1:51 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, May 10, 2019 at 12:03 PM Jokke H=C3=A4m=C3=A4l=C3=A4inen
> <jokke.hamalainen@kolttonen.fi> wrote:
> >
> >
> >
> > ---
> >  libselinux/utils/matchpathcon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpa=
thcon.c
> > index 9756d7d9..eb39a188 100644
> > --- a/libselinux/utils/matchpathcon.c
> > +++ b/libselinux/utils/matchpathcon.c
> > @@ -25,7 +25,7 @@ static int printmatchpathcon(const char *path, int he=
ader, int mode)
> >         int rc =3D matchpathcon(path, mode, &buf);
> >         if (rc < 0) {
> >                 if (errno =3D=3D ENOENT) {
> > -                       buf=3Dstrdup("<<none>>");
> > +                       buf =3D strdup("<<none>>");
> >                 } else {
> >                         fprintf(stderr, "matchpathcon(%s) failed: %s\n"=
, path,
> >                                 strerror(errno));
> > --
> > 2.21.0
> >
>
> ack
