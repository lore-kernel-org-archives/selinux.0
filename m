Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C102EE01FD
	for <selinux@archiver.kernel.org>; Wed, 13 Sep 2023 18:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjIMSIH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Sep 2023 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIMSIG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Sep 2023 14:08:06 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B73F19AE
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 11:08:02 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59bbdb435bfso1091427b3.3
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694628482; x=1695233282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6p7tbPnNvlpg9xblNmKJQDZftsfkQOleUTpRaGHhOQ=;
        b=D/zZMzn3quzXBOp7hhi+83UVtfEZE+amUwPJvrNUHSb6mmbzOWlx2jNfDhPiSkbn5Q
         rAmXnPZIwzVaTNb3buy0+7xfPn+7alGqdG1Zxo1BYACF21E8SVi6dpGpgHqtyAAus4p6
         mONWdR+fDPqDAFnFLI10xZkOREUOlSRJlQBO0+xd/yGTDEVjPxT/X91pqSwUf0TFIxV+
         VOeNzjK/KLqVWqJDwmCw2OGH80OBQWxuJFl6P/D09HE0r+c6kPBdQEJCwU2ahHLDmOXJ
         FpSIVKvJAbvMq7XmU2bH6SBRhFDEALmzF30CjFXAMlURGCkn/oLMdofIsbshBT2KvX63
         xTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694628482; x=1695233282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6p7tbPnNvlpg9xblNmKJQDZftsfkQOleUTpRaGHhOQ=;
        b=M3itbeXilR0Ye9ETYXkAGTs49sELx1ZHFJhLqJUw+UO4eeVd61FdFRbNFDhN/2fhdR
         YaVxYK7RHOBRjt+bZIxRLXsr5P9DsqswdO2YltfcnGJe6KGP+2ZTfmQB+ZQi4fbrv27i
         fKhbpl1CtBWn/Gb0VwrVHv/mJv03jkIUVBPZ8iT/lH+KeICcNE8DulVtl06lEkXGYwUx
         qL+5NGTfJ/yiMnfA+OHMZQxSHcVlaTGnnMrQHYsyIWFoebv1+8iOZrpt022GV9R6gSyf
         ftSKCy7vANr/8nIkwZmjlb+nHwy2Q3nua4djFiaLOiZ2MuV+0P3kEeqlQrCr5gintosA
         ecCA==
X-Gm-Message-State: AOJu0YyxQAuI1cNOcQHtGxON85VU7brj89Xh33tQLz/wcyVm/kJjDtYJ
        47DIc9lBzSDm7mKJ3OCkbTQCqW6EOyHfckwjVqun
X-Google-Smtp-Source: AGHT+IGr/m1hyc4o4APGIfiTAia1ePxK8DO5U7tgx893pHWObgaCGyeOCxpAQq8syxb7Tu0KA7RCu08gfsZoff3PVbw=
X-Received: by 2002:a0d:cb15:0:b0:59b:5275:800a with SMTP id
 n21-20020a0dcb15000000b0059b5275800amr3432151ywd.2.1694628481746; Wed, 13 Sep
 2023 11:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151220.166215-1-cgzones@googlemail.com>
 <CAEjxPJ7_CMFvRHFp1HVV+ppZEXPkWG6oH1MMEbjFESH44wZukg@mail.gmail.com>
 <CAHC9VhTiuZRCm2E3DkB=zD8R1OZccSCpsbr2mB=aOPGXkjUhhw@mail.gmail.com> <CAEjxPJ5PVAK2LnzzkjjwZ-FtiXPeyrE8ZGCDxxCpY_AvTY3M4w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5PVAK2LnzzkjjwZ-FtiXPeyrE8ZGCDxxCpY_AvTY3M4w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Sep 2023 14:07:51 -0400
Message-ID: <CAHC9VhTfoM0Z1uKbBE9KVY4LAHUB=YOOEUGxrsZUh4ZyZG=PDA@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 2:03=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Sep 13, 2023 at 12:12=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Thu, Sep 7, 2023 at 1:42=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Fri, Aug 18, 2023 at 11:12=E2=80=AFAM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > Dump in the SELinux debug configuration the statistics for the
> > > > conditional rules avtab, the role transition, and class and common
> > > > permission hash tables.
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > >
> > > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/p=
olicydb.c
> > > > index 84f02d4f8093..932e383bcad6 100644
> > > > --- a/security/selinux/ss/policydb.c
> > > > +++ b/security/selinux/ss/policydb.c
> > > > @@ -1158,6 +1158,8 @@ static int common_read(struct policydb *p, st=
ruct symtab *s, void *fp)
> > > >                         goto bad;
> > > >         }
> > > >
> > > > +       hash_eval(&comdatum->permissions.table, "common_permissions=
");
> > > > +
> > > >         rc =3D symtab_insert(s, key, comdatum);
> > > >         if (rc)
> > > >                 goto bad;
> > > > @@ -1339,6 +1341,8 @@ static int class_read(struct policydb *p, str=
uct symtab *s, void *fp)
> > > >                         goto bad;
> > > >         }
> > > >
> > > > +       hash_eval(&cladatum->permissions.table, "class_permissions"=
);
> > > > +
> > > >         rc =3D read_cons_helper(p, &cladatum->constraints, ncons, 0=
, fp);
> > > >         if (rc)
> > > >                 goto bad;
> > >
> > > Do we want to embed the actual common and class keys in the output to
> > > distinguish among the multiple common and class permissions tables?
> >
> > That seems reasonable, were you thinking of just adding it to the
> > hash_eval()'s hash name string, e.g. "common_permissions[XXX]"?
>
> Yes, otherwise you get a bunch of common_permissions and
> class_permissions lines with no way to correlate.

Agreed, I was asking more to determine how you envisioned the keys in
the output.

Christian, instead of creating the combined string in the caller I
would suggest adding a third parameter to the hash_eval() function and
having hash_eval() add the extra info (if present, NULL should be
acceptable) to the output.  This should ensure no extra work is done
when debug is disabled.

--=20
paul-moore.com
