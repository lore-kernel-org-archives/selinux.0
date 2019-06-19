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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8411EC31E5B
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1472187F
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVO1kq/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFSQET (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:04:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41897 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfFSQES (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 12:04:18 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so588526ioc.8
        for <selinux@vger.kernel.org>; Wed, 19 Jun 2019 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UXWCzKBgp4WOFX0Fe23dQSrBFANHKcyRME/FSEx6x70=;
        b=SVO1kq/Ozo/2lMO1mESVg+29z6lSzW5l5Svk0DiAYxFYimfqF4Gicgq3ueXdd4MP5u
         CLQzeGYHVxnQXECOkUXsPCaRDJvwu9LXFP6zXEq9vGWZW+/+16BkksRiytJz4Qi8fkCd
         wIzKivGod+wuiQOYZ0bKAZG/qWR63JEVmyiPN6PEsXkpn02pUQw/jbS8RCcFm6RjZOc0
         9X8CfUOdafJu50MzKiUPsqNW8hQezrueN9Bj6tlfTq9rddVOE8Ek8e0FSYCDSclRJH7T
         xCZboqgFJ2qvozpCCvIu4c03xoQJ9MIWAlymWIEo9C/DlvE7HyNHKQCqDJ036+IjsEJx
         aD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UXWCzKBgp4WOFX0Fe23dQSrBFANHKcyRME/FSEx6x70=;
        b=M4RSdby8b05rLIya3kyTMOYf4oPlgLyg2cyZBp0hXNPzpzuGeEd9LeWGKkAvAB+RaR
         5JVPRqy/bxGbiYfIVRSLWTssncmEI50dJzTTf0CT4MdpHOZUF3ZIzhBUfljMm0QPx52M
         /uvzzTBqm+JJh0J7PP/W8Lkv6dvE/r+zxFBfdBruPUISYsuSKIHDdBYhjnR8h3iFvk7X
         CmhML/ak9zIBXtRZxrrUDORhHUlOM4epFOcUp8Ny84gctU1l6ZQiBa3Y1ShvqWWcEe0F
         QQRaKQB3XX/tO5dGH6Z2gPrOSstbzx21g3PY9iSZilMl3nSaUJGiT2JVyVR5LJEc9iJP
         RVYw==
X-Gm-Message-State: APjAAAWEB0ZULmrA8VmkxPEv0Yevn9Yc5KPM0zvFB+JrJF6wz/6icl2+
        Q3m6FoGTVidtFwDpM7K90Hpa4XLaXajabHhjSLe7ncem
X-Google-Smtp-Source: APXvYqzY7lQQljcn2REv8HmLy97kOtJyvxDO5ulDKs2oswcNrLcfWvvviIMMPXeaP9hGv/yQ8ureOxnMYebDWDWWVOI=
X-Received: by 2002:a02:5a89:: with SMTP id v131mr6802036jaa.130.1560960258086;
 Wed, 19 Jun 2019 09:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1906171502130.6467@34-41-5D-CA-59-C7> <CAFftDdpbvUngYWtdySVyag80y5ZnaioP7RoqWhzJa73cYjq+xg@mail.gmail.com>
In-Reply-To: <CAFftDdpbvUngYWtdySVyag80y5ZnaioP7RoqWhzJa73cYjq+xg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 19 Jun 2019 09:04:43 -0700
Message-ID: <CAFftDdpyVMkhoG7+vdtOz4QjyLkeX-ngtAGGfBhtejMVocVNnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Replace constant with sizeof()
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

On Mon, Jun 17, 2019 at 10:53 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> ack on the series, staged: https://github.com/SELinuxProject/selinux/pull=
/163
>
> On Mon, Jun 17, 2019 at 5:02 AM Jokke H=C3=A4m=C3=A4l=C3=A4inen
> <jokke.hamalainen@kolttonen.fi> wrote:
> >
> >
> > Replace constant 18 with safer use of sizeof()
> >
> > Signed-off-by: Unto Sten <sten.unto@gmail.com>
> > ---
> >  libsepol/src/kernel_to_conf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index 5fb4e838..930bafab 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -448,7 +448,7 @@ static int write_sids_to_conf(FILE *out, const char=
 *const *sid_to_str,
> >                 if (i < num_sids) {
> >                         sid =3D (char *)sid_to_str[i];
> >                 } else {
> > -                       snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> > +                       snprintf(unknown, sizeof(unknown), "%s%u", "UNK=
NOWN", i);
> >                         sid =3D strdup(unknown);
> >                         if (!sid) {
> >                                 rc =3D -1;
> > @@ -2376,7 +2376,7 @@ static int write_sid_context_rules_to_conf(FILE *=
out, struct policydb *pdb, cons
> >                 if (i < num_sids) {
> >                         sid =3D (char *)sid_to_str[i];
> >                 } else {
> > -                       snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> > +                       snprintf(unknown, sizeof(unknown), "%s%u", "UNK=
NOWN", i);
> >                         sid =3D unknown;
> >                 }
> >
> > --
> > 2.21.0
> >
