Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CCFC4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 13:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiKINsr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 08:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKINsq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 08:48:46 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DF4DEE2
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 05:48:45 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so25691724lfv.2
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 05:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM9ZA3SGKp0HVPAQqgvjQokvmQBaBPiVegZPIlT2oBo=;
        b=iNAcnBMPDdT8u/8Ex7VsfthshUXfpzHfHatffTt9j0qwxuyFk77WNLcmKBjbfAlGY+
         jiFiYbcz2r4AymCal3JYhbPG9OGqJeqcMKyA0AKST4xijG5wb11XHc+XyLl3boq2ejrZ
         0xiu6hkECv+YhUbuX70Qx/LtLhwS1lRmH2+FBs6/3IFOTJef6cKiuG6FW2D+shcuv2Se
         n7Kz+2YGsjd60C+KFp6Z6lRGqz7GwaZB1Tw58ZsdNvoo3k9QPQoZ7UpRjbjqyV4Cnw/f
         mdju7Ovy+N7VVwGl97YRljYbsaGLk6OH0wIbgWckaIFi7AltSEdM1Up6PFOE+VV6RCYt
         jWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cM9ZA3SGKp0HVPAQqgvjQokvmQBaBPiVegZPIlT2oBo=;
        b=uaQOQy0Pkv4vMpaFcrb2sV6asjRjU2UnqF2AdLZisf/HT53nv2oryTdqe9ruFEAYSy
         QUs/6wlwcIe1bhQ5YyToGdTDvYxVwK5yGeiQb3/ZDqJ1oVozb91jhkRyapE9VH3KT9oK
         57+GihDcL/aSYrTpH1OTdwP3drnyn+G3/ZyWSpVWpnsGtbijX6KOtTnhVAZCHMcUqHlO
         rx3kCe8JRN4/WqebKTWk6JnTzfo9WLw5ZDTVr5bFXuCN/+3/qRVB5NYvWDOp8CPfgl1C
         7+2l4P/g51PZwotiiVH+P2Z6Ab8NlEjwcbUz1vqN1nJ+MDGEeyy0YUk+35wUnnxJqn0n
         yzlw==
X-Gm-Message-State: ACrzQf1CMqRoD5OMp4jXgynWdQQbV4fTsQAbAt57rDhZ063REvQ8Seit
        p4yMJLF32/t410I52D26t/yS9Jr7+T2eOhvpLghHRPC1
X-Google-Smtp-Source: AMsMyM7WBh/2umPvyAbkuKfOvfI0/Q+fA2HpVcEyMZceMBeIaIeJV1GUZmNfyZUSUkwwmJrdmtSISOj7ommMNietApQ=
X-Received: by 2002:ac2:5bcd:0:b0:4b0:d503:9afb with SMTP id
 u13-20020ac25bcd000000b004b0d5039afbmr16058087lfn.13.1668001723873; Wed, 09
 Nov 2022 05:48:43 -0800 (PST)
MIME-Version: 1.0
References: <20221024091354.2253669-1-tweek@google.com> <CAP+JOzR6Y-emY+WUZN=wB2QLG_=CdMgO2EjY=9iHCqZmy+wHfA@mail.gmail.com>
In-Reply-To: <CAP+JOzR6Y-emY+WUZN=wB2QLG_=CdMgO2EjY=9iHCqZmy+wHfA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Nov 2022 08:48:32 -0500
Message-ID: <CAP+JOzQT2Ttjo189LaK4b3EtT45G9Lh3=00TjLXAnOzFdCOyzg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: ignore invalid class name lookup
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 8, 2022 at 2:14 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Oct 24, 2022 at 5:14 AM Thi=C3=A9baud Weksteen <tweek@google.com>=
 wrote:
> >
> > selinux_check_access relies on string_to_security_class to resolve the
> > class index from its char* argument. There is no input validation done
> > on the string provided. It is possible to supply an argument containing
> > trailing backslashes (i.e., "sock_file//////") so that the paths built
> > in discover_class get truncated. The processing will then reference the
> > same permission file multiple time (e.g., perms/watch_reads will be
> > truncated to perms/watch). This will leak the memory allocated when
> > strdup'ing the permission name. The discover_class_cache will end up in
> > an invalid state (but not corrupted).
> >
> > Ensure that the class provided does not contain any path separator.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/stringrep.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> > index 2fe69f43..592410e5 100644
> > --- a/libselinux/src/stringrep.c
> > +++ b/libselinux/src/stringrep.c
> > @@ -63,6 +63,9 @@ static struct discover_class_node * discover_class(co=
nst char *s)
> >                 return NULL;
> >         }
> >
> > +       if (strchr(s, '/') !=3D NULL)
> > +               return NULL;
> > +
> >         /* allocate a node */
> >         node =3D malloc(sizeof(struct discover_class_node));
> >         if (node =3D=3D NULL)
> > --
> > 2.38.0.135.g90850a2211-goog
> >
