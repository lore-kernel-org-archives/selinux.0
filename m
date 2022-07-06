Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4E6C433EF
	for <selinux@archiver.kernel.org>; Wed,  6 Jul 2022 20:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiGFUMb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jul 2022 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiGFUM0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jul 2022 16:12:26 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207731F639
        for <selinux@vger.kernel.org>; Wed,  6 Jul 2022 13:12:26 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id s188so20910814oib.6
        for <selinux@vger.kernel.org>; Wed, 06 Jul 2022 13:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xAsiEn8cnErGuhmKEetvUrcv8kaLZj7TLlWuwcm45jw=;
        b=mwYBgVydLY0LAboFL8hcyFMMJCwYmU9zSkcLPJPmfir4GLvlsWbsLevw6IMZoXbSxi
         H6XPt2uC3u8gxA+Yad2kMfzOo+QUcFSvIc3irKTKTrOBC0lhquRpau6ZHu6CMeMgJbp6
         WWdK/5O4OiZEvPhwfYZAn04ez5pN9ak/dGxOSWRjC/7TvyAyqdx6tVSEbbJuMtcB//PC
         qxUicmT6SdcPzpvfM/IAAIfCSwzgKnCzm3HWCRzkXhpRd6vL1Unrp72Be91OGrtf91jj
         xeQxXsiq7QMMj883uM0p2n9yQx2KnjehkHeYw4z203DieUSUES4eJ68kSKU7gBLWW6lo
         7t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xAsiEn8cnErGuhmKEetvUrcv8kaLZj7TLlWuwcm45jw=;
        b=StNtRMs0y7zTPsLfz5getwj9/gNpBOkGt72nGn+fkt7FplIGRbIxMImOKUJS9eBvkQ
         7h8pNswcneswqraxZEZirE/OTfZXAN0Y9tTMg4+7x1Icr2zZL+KncEN3Vj/NZoX0W3dv
         ZWLeZp0Fr5qAEPKg7DHX5qR0VhwPqgXnqdS6Xnb2KIIIryzWjOZ/bQLroQurV2eSzIiQ
         oZ42ViXu/EQ/et0EFdDfU7MVwJRAAX8ao9sW0V2lEIT253ghdqpIFSEoibgNr09Z9xAz
         mr6fcOpZ4Ms6zv9sl3Y1YIFw4ufbf6A0ZUWUEQllnDSMtYQ8WX7/AtHhx7Ypb+6Iq87L
         l75g==
X-Gm-Message-State: AJIora8k0rRuQn8EQOZ+Ii6Vrn5lsszGrT/CGVxNonRX1FHLU8ZOwWz0
        081GbCS0WSFT8MTS1HYbEJKLvHACOk3MqnKPlgyx2lHh
X-Google-Smtp-Source: AGRyM1u0MoklIZAZQRBhhcukbKFI5DBebLs+8a3guBAFWxHEsXf7HhU0apIbC1pHRjFGVKWnh70WjR8MFEX0BMXEO2k=
X-Received: by 2002:aca:1117:0:b0:337:c231:a3c8 with SMTP id
 23-20020aca1117000000b00337c231a3c8mr251464oir.156.1657138345530; Wed, 06 Jul
 2022 13:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220629110512.5067-1-cgzones@googlemail.com> <CAP+JOzSiHaokD7P8aXa-qUB5vCvx6kOC2zs1on4e4a+f0YRvww@mail.gmail.com>
In-Reply-To: <CAP+JOzSiHaokD7P8aXa-qUB5vCvx6kOC2zs1on4e4a+f0YRvww@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 6 Jul 2022 16:12:14 -0400
Message-ID: <CAP+JOzSeoo_PGo1=LkyvvtN84a7o6esA2CKWq_50NJoZJvMQBg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/utils: improve wording
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 30, 2022 at 2:30 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jun 29, 2022 at 7:06 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > A request is denied with SEPOL_COMPUTEAV_RBAC if the source role is not
> > allowed to transition to the target role, granted via a
> >
> >     allow source_role target_role;
> >
> > statement.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/utils/sepol_check_access.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/utils/sepol_check_access.c b/libsepol/utils/sepol=
_check_access.c
> > index bd2ea896..5d2bf679 100644
> > --- a/libsepol/utils/sepol_check_access.c
> > +++ b/libsepol/utils/sepol_check_access.c
> > @@ -109,7 +109,7 @@ int main(int argc, char *argv[])
> >         if (reason & SEPOL_COMPUTEAV_RBAC) {
> >                 if (i > 0)
> >                         printf(", ");
> > -               printf("transition-constraint");
> > +               printf("role-transition");
> >                 i++;
> >         }
> >         if (reason & SEPOL_COMPUTEAV_BOUNDS) {
> > --
> > 2.36.1
> >
