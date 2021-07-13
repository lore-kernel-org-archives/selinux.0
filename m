Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1850C07E9A
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 03:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77826610D1
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 03:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhGMDnS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 23:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhGMDnR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 23:43:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C276AC0613DD;
        Mon, 12 Jul 2021 20:40:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b12so18296361pfv.6;
        Mon, 12 Jul 2021 20:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MDHUlVkLSTR1eihtdaIEviPaD2WU9UjDNKrmcbar99Y=;
        b=pyFz3IC6432wOadBp7mjKJpkIjZYaXvGBnwP64SBKU3BSb+nxbh+FoDd9gIulQ86lr
         Zd55gDWWJB1lxXrp0mce0s7Kbmfdbb4Y8tZGtVpLD+hIL8AdbjwQAZOmEOB7NspatkD9
         GQbaJM08sxX7vgEEEQ1DaexEMTW8QzPAcyAOdErM9FuBNBhEs3POevc314usF8bjoFPB
         QeDShhlFlt/KTuP4vP/1qcwOyRe+IGzmOxITGkxeyZYnW6Ge9lPlOF0TqbtGW1+4q3/8
         ZtdsgBpCH4jov1tqnoBephUPjrCv0n00pYUlF+2usb2PgcWRi2dCU+vS6VYxyAvpElEq
         fvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MDHUlVkLSTR1eihtdaIEviPaD2WU9UjDNKrmcbar99Y=;
        b=HLW9HlKonaRguJVlyWsACcZN2Ayg13JOtnZX3jneCpYIdK9k+IZaXBjE8EKAhvadvv
         gHYunTJFeL9rEQbYhr/ZwDGjaupbI/2oY3DO2JaadfLNAgpG27uqCe/SsTN9SLWchk/t
         29WGUKsyL4spfqZPimSfXeMIN4uLohjKcf7LusI1by+viQC01fAHA6ORVdFat4T5r/2N
         Sgn/XYOEWTQwaVn7Hjv2EhhS88zCvOsqTa3R17wwQZ2oPcjkzdp4q3x5LhJ8/xYrAkLo
         TS+S4kmerJ8PYEutSjHVN2Dn2Hj4LE5wnjB49rTVndKrgwzxE8aJaUH2n3cecKaouW76
         8h3Q==
X-Gm-Message-State: AOAM532CBRJSNii32utNEVA8zhqM7Iw/xTekJzB6kdEELa2VSa66vWmv
        QXgH7FpPW3U+l46cz+t22RlX2tT5zyySTr/Zu9k=
X-Google-Smtp-Source: ABdhPJyUa65a80O+n1mXBoo4j0MBIZz6zopfw+uBkk88UIjosvEwrx5ZdCUJP/viVHuArxZmLNll5lAk7sm/Vz2oVFM=
X-Received: by 2002:a63:a18:: with SMTP id 24mr2269233pgk.309.1626147627241;
 Mon, 12 Jul 2021 20:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210712234801.GA29226@raspberrypi> <CAHC9VhTO=EubNyYJ5eOfpWPW2HGuVP-WFTm42mfiwtfWapt3tQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTO=EubNyYJ5eOfpWPW2HGuVP-WFTm42mfiwtfWapt3tQ@mail.gmail.com>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Tue, 13 Jul 2021 12:40:16 +0900
Message-ID: <CADLLry7oDgOfEg9ZbfGcEH6J1xj8i0MqdD1Kyje4zqxoJCfdmQ@mail.gmail.com>
Subject: Re: [PATCH] lsm_audit,selinux: add exception handling for possible
 NULL audit buffers
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

2021=EB=85=84 7=EC=9B=94 13=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 11:49, =
Paul Moore <paul@paul-moore.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Jul 12, 2021 at 7:48 PM Austin Kim <austindh.kim@gmail.com> wrote=
:
> > From: Austin Kim <austin.kim@lge.com>
> >
> > It is possible for audit_log_start() to return NULL on error.
> > So add exception handling for possible NULL audit buffers where
> > return value can be handled from callers.
>
> Hi.
>
> The patch looks fine to me, but I think the description doesn't tell
> the full story and I'm worried that people might misunderstand why
> this patch is worthwhile.  I would suggest you revise the commit
> description to explain that in these cases it is safe to return early
> when audit_log_start() returns NULL because the only non-cleanup
> processing left in these functions is to generate an audit record.

Thanks for valuable feedback.
Let me resend the patch with revised 'commit description',
as you recommended.

> Returning early in these cases is a performance optimization and not a
> correctness issue; the audit_log_*() functions can support being
> passed a NULL audit_buffer argument.
>
> > Signed-off-by: Austin Kim <austin.kim@lge.com>
> > ---
> >  security/selinux/hooks.c       | 4 ++++
> >  security/selinux/ss/services.c | 2 ++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index b0032c42333e..9e84e6635f2f 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3325,6 +3325,8 @@ static int selinux_inode_setxattr(struct user_nam=
espace *mnt_userns,
> >                         }
> >                         ab =3D audit_log_start(audit_context(),
> >                                              GFP_ATOMIC, AUDIT_SELINUX_=
ERR);
> > +                       if (!ab)
> > +                               return rc;
> >                         audit_log_format(ab, "op=3Dsetxattr invalid_con=
text=3D");
> >                         audit_log_n_untrustedstring(ab, value, audit_si=
ze);
> >                         audit_log_end(ab);
> > @@ -6552,6 +6554,8 @@ static int selinux_setprocattr(const char *name, =
void *value, size_t size)
> >                                 ab =3D audit_log_start(audit_context(),
> >                                                      GFP_ATOMIC,
> >                                                      AUDIT_SELINUX_ERR)=
;
> > +                               if (!ab)
> > +                                       return error;
> >                                 audit_log_format(ab, "op=3Dfscreate inv=
alid_context=3D");
> >                                 audit_log_n_untrustedstring(ab, value, =
audit_size);
> >                                 audit_log_end(ab);
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index d84c77f370dc..e5f1b2757a83 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1673,6 +1673,8 @@ static int compute_sid_handle_invalid_context(
> >         if (context_struct_to_string(policydb, newcontext, &n, &nlen))
> >                 goto out;
> >         ab =3D audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_SELIN=
UX_ERR);
> > +       if (!ab)
> > +               goto out;
> >         audit_log_format(ab,
> >                          "op=3Dsecurity_compute_sid invalid_context=3D"=
);
> >         /* no need to record the NUL with untrusted strings */
> > --
> > 2.20.1
>
> --
> paul moore
> www.paul-moore.com
