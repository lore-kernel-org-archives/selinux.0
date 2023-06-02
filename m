Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF40C7EE24
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 19:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjFBTgo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjFBTgR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 15:36:17 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69D71A2
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 12:36:15 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-565a022ef06so26629377b3.3
        for <selinux@vger.kernel.org>; Fri, 02 Jun 2023 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685734575; x=1688326575;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wU/zMYtZ/WcTvvmZtHiGX284PgtY1tEYkrtO6sz1xWE=;
        b=a5OWGGYu+3GYIosu8Ib4D5mD2vdKflGcYbC/lvurL1+IS7P2LYad1jycc7vWanY/9f
         1nfZUJnBfcA48BNTRAzxVBnHDJootckuLUBpfQ8FgZlhsR2gWcoeEuEc1NWS0NOwHmWn
         zKSRcvsjBYrxym3wKGUPscGbg34/aUnWsZzYSj35b8n5oW89MWl8QF5ZM1sw8C+kg0pH
         trL4NaC2gkPRcwatCzi/h+AnD+d41HE/opGxxsB4TC0BPq4/0ZdKczcy2aqTT7fazuts
         w/0QmiUVLTaIz4Qbp++vLo5JSZtSfbrp4b7RIM3KGzBRtBln5XMvZp+//PyQWIHHU6pa
         OBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685734575; x=1688326575;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wU/zMYtZ/WcTvvmZtHiGX284PgtY1tEYkrtO6sz1xWE=;
        b=ONO/p3C2vkHHbfIStP/9HtgH0EqSwlTzTl6FlPPMLD7Ne202uAWsEGKOYGgBJaGrhZ
         nDhr8bdCOUDE9gL15dMAe3Kdcym1u8bcwNm3VTK7T8GA9o/eUx/gxgcM2KsFQ0zxIH8y
         /2o2DOdSR3MRLxZAJkcph4wruIiZ+KrVaFNFlM49YS9GywbANErJ8lrdQuFDbN/PuIbE
         Qw1Q5Pbl/eTkRNFXeWlqoS/HU4nUJCcS+arqcmu2GcW38hqqz/2cKvkK0bH77Jhaylev
         G4EbXhCtNvKpOTTBdL9PxApsvTLhuwy5/d+imqTloGg7UUYckyXuGagimj5POnETI9EZ
         QIVA==
X-Gm-Message-State: AC+VfDxbrpJq6dmRmr35WiTwy2ykNVlw1xjhWWpX95cY82mQvph3RdCi
        ZIenvXBb2lxri+dJwfINrpefPloN+RUTEaIeOTZPikLiK6C/djk=
X-Google-Smtp-Source: ACHHUZ6q/11zgq8ZMi8fyUwEN0r116K0yoRN8QeP44hwBk+2bAuFSJv6OEu5OcVxCxW5U+MHklwNhWnXAhsRUGzQBBY=
X-Received: by 2002:a81:8354:0:b0:561:d89:feab with SMTP id
 t81-20020a818354000000b005610d89feabmr1091452ywf.32.1685734574837; Fri, 02
 Jun 2023 12:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230601214751.406786-1-paul@paul-moore.com> <CAHC9VhQ=ysi=sOQbp_ZmZZEze-TJwUfFQ7FRB7mrGTLduQf5AA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ=ysi=sOQbp_ZmZZEze-TJwUfFQ7FRB7mrGTLduQf5AA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 2 Jun 2023 15:36:04 -0400
Message-ID: <CAHC9VhRbY9a-RS-bM_Nqw-+xOruSUhyuwTfrqqn7nEvmDb3s5A@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix Makefile for versions of make < v4.3
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 1, 2023 at 6:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Jun 1, 2023 at 5:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > As noted in the comments of this commit, the current SELinux Makefile
> > requires features found in make v4.3 or later, which is problematic
> > as the Linux Kernel currently only requires make v3.82.  This patch
> > fixes the SELinux Makefile so that it works properly on these older
> > versions of make, and adds a couple of comments to the Makefile about
> > how it can be improved once make v4.3 is required by the kernel.
> >
> > Fixes: 6f933aa7dfd0 ("selinux: more Makefile tweaks")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/Makefile | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> > index ab8c3093d5fd..abf19fee09f8 100644
> > --- a/security/selinux/Makefile
> > +++ b/security/selinux/Makefile
> > @@ -3,6 +3,11 @@
> >  # Makefile for building the SELinux module as part of the kernel tree.
> >  #
> >
> > +# NOTE: There are a number of improvements that can be made to this Ma=
kefile
> > +# once the kernel requires make v4.3 or greater; the most important fe=
ature
> > +# lacking in older versions of make is support for grouped targets.  T=
hese
> > +# improvements are noted inline in the Makefile below ...
> > +
> >  obj-$(CONFIG_SECURITY_SELINUX) :=3D selinux.o
> >
> >  ccflags-y :=3D -I$(srctree)/security/selinux -I$(srctree)/security/sel=
inux/include
> > @@ -19,11 +24,17 @@ selinux-$(CONFIG_IMA) +=3D ima.o
> >
> >  genhdrs :=3D flask.h av_permissions.h
> >
> > -$(addprefix $(obj)/,$(selinux-y)): $(addprefix $(obj)/,$(genhdrs))
> > +# see the note above, replace the dependency rule with the one below:
> > +#  $(addprefix $(obj)/,$(selinux-y)): $(addprefix $(obj)/,$(genhdrs))
> > +$(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
> >
> >  quiet_cmd_genhdrs =3D GEN     $(addprefix $(obj)/,$(genhdrs))
> >        cmd_genhdrs =3D $< $(addprefix $(obj)/,$(genhdrs))
> >
> > -targets +=3D $(genhdrs)
> > -$(addprefix $(obj)/,$(genhdrs)) &: scripts/selinux/genheaders/genheade=
rs FORCE
> > +# see the note above, replace the $targets and $genhdrs dependency rul=
e with
> > +# the lines below:
>
> My apologies, I didn't fully refresh my patch before sending it out so
> there is a slight difference in the comments, below is what I
> currently have in my working branch:

Merged into selinux/next.

> -# see the note above, replace the $targets and $genhdrs dependency rule =
with
> -# the lines below:
> +# see the note above, replace the $targets and 'flask.h' rule with the l=
ines
> +# below:

--=20
paul-moore.com
