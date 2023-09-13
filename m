Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348BCEDEC7C
	for <selinux@archiver.kernel.org>; Wed, 13 Sep 2023 16:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjIMQMI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Sep 2023 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjIMQMH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Sep 2023 12:12:07 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CF6B8
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 09:12:03 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59be6605e1dso1004437b3.3
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694621523; x=1695226323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlCwcmUEoeklmLodotE896hz78hDOYQASBGVLSHek9M=;
        b=QNGffN0wlDFARDvYh4sGAROCnp7YmYYpSb04UpwSCjSjomeEL9U2DY4aauveWqGUUE
         NJG+CeuhSzEqW1DLVJOIfTFCGLBpz6j65QBIfoASIAHylxp5i+mcHkfV4wqcKbCFdnlc
         k3DnGxpIO3Tof+YWXzA/oMPG8p2+WCBWFyQeBePpCdkAScPPPr9VPYJGsPww1JSflYH/
         hLpB4Rit42seZRPiKbvkIio+4wkG4ZQaaIVLMBAInStvMoMZbUxYpcQoN8LER5KLQ7sE
         HFnHAemvTqXdb2tpIwsXmtXJI9kyQoJd4VyIQNjiU3zmYsh/bfIelAV6ocaBHKLtmgz2
         On0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694621523; x=1695226323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlCwcmUEoeklmLodotE896hz78hDOYQASBGVLSHek9M=;
        b=YXD1VCRSbTn7g+AfUfxmdaHeD0nZJ1zDSiGs0kWzPUPDtQJH2xD9V9a8DsmozMXzz5
         CR1vFxRvIoB58yswLT4XW5m7NFI50j+K3+Yv0+0T+bG0lUYcS11uWApt7dT7MIX94s77
         64w+AykQbG4SZoN1A3ehiEgeBhUf2KhfA7EIrtvf61FTLRzu+9Dqp1ZXX/1v1xVl1OvB
         nj8s0iDQQQC8RJLkCbVLI1PIHSAnZgOW/PBF5I67PIK+r/6SnKSKyOiwQMgsOIa959hI
         PUZS0wQEwN8wzcSfR1rPzlOTrC04kLSityKP7/em7wB52ZPPDl3HVEzpRktvuYQCYmvW
         X+bA==
X-Gm-Message-State: AOJu0YxyHXl91DQ+4p6nqOhsZ7NlQTibRwZCg/v25v+AmwBP8J7uw3Et
        l2L1Fuzkxf3v8rcTWclMd+MYE8Ygxy5z/Tvo9PjE
X-Google-Smtp-Source: AGHT+IFsqdaxaKGGMmOWHrFoE/O2srrxrPG26n/7AgIeYncrBB4HMhfIY0VnkHAWQR0o3vt9mSH6r8Dj+ssy2XibnX4=
X-Received: by 2002:a0d:c9c1:0:b0:59b:49a0:eec0 with SMTP id
 l184-20020a0dc9c1000000b0059b49a0eec0mr3538227ywd.12.1694621523053; Wed, 13
 Sep 2023 09:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151220.166215-1-cgzones@googlemail.com> <CAEjxPJ7_CMFvRHFp1HVV+ppZEXPkWG6oH1MMEbjFESH44wZukg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7_CMFvRHFp1HVV+ppZEXPkWG6oH1MMEbjFESH44wZukg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Sep 2023 12:11:52 -0400
Message-ID: <CAHC9VhTiuZRCm2E3DkB=zD8R1OZccSCpsbr2mB=aOPGXkjUhhw@mail.gmail.com>
Subject: Re: [PATCH 2/6] selinux: dump statistics for more hash tables
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 7, 2023 at 1:42=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Aug 18, 2023 at 11:12=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Dump in the SELinux debug configuration the statistics for the
> > conditional rules avtab, the role transition, and class and common
> > permission hash tables.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
>
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/polic=
ydb.c
> > index 84f02d4f8093..932e383bcad6 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -1158,6 +1158,8 @@ static int common_read(struct policydb *p, struct=
 symtab *s, void *fp)
> >                         goto bad;
> >         }
> >
> > +       hash_eval(&comdatum->permissions.table, "common_permissions");
> > +
> >         rc =3D symtab_insert(s, key, comdatum);
> >         if (rc)
> >                 goto bad;
> > @@ -1339,6 +1341,8 @@ static int class_read(struct policydb *p, struct =
symtab *s, void *fp)
> >                         goto bad;
> >         }
> >
> > +       hash_eval(&cladatum->permissions.table, "class_permissions");
> > +
> >         rc =3D read_cons_helper(p, &cladatum->constraints, ncons, 0, fp=
);
> >         if (rc)
> >                 goto bad;
>
> Do we want to embed the actual common and class keys in the output to
> distinguish among the multiple common and class permissions tables?

That seems reasonable, were you thinking of just adding it to the
hash_eval()'s hash name string, e.g. "common_permissions[XXX]"?

--=20
paul-moore.com
