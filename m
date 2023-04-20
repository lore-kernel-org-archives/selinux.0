Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0723FC77B72
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 13:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjDTNgw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 09:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDTNgv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 09:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E1049F5
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681997766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wWuwBNIBqszgmpaomKkPTJ0mZyy8RyGPna6xBQla1w=;
        b=iKL0AUUNN9y1RvKZhCAlboQhLo4xBSp2gNPq6Pup51oD/bYVvbkYAUf6qKtp3mQ2mfu8CU
        g4bPbYS+v6rgTvvBUeonxBCsUWYnHYNyNafvuYE8+liraM18y9Q/8X+yzl9Dzcvf+Hr2ob
        dY+KuDraTMLwVGOUz59rUM5tLAim3bc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-HXQwxbOYNB6wZYNeIELktA-1; Thu, 20 Apr 2023 09:36:04 -0400
X-MC-Unique: HXQwxbOYNB6wZYNeIELktA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-24b25d3538eso523585a91.1
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 06:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681997763; x=1684589763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wWuwBNIBqszgmpaomKkPTJ0mZyy8RyGPna6xBQla1w=;
        b=D0g2Yn1x8u69184I9U00XTqnrBAw15jMq/Z4xIBrHtVSc6eyqB5n692T8KH1UaW47+
         9cpy1vkG+XtaGWt5Nnd8PZ1moGuIvXkJKi97C97iPZ5Py4exehdlXrPnsIupZsCgASPX
         Fv5LdRvJswUxZY5uXiqjRNCWPorNIk8kaDc899fEKbKChgMl5KReFoLeOdCYTXVRKIOX
         rsMY8Ltv6KLFTgahAKnwlCNZqhXjYoYlDu2RapuGNl3URB1VzyAs+A0ERUg0u1gJkgK/
         Xahe+p48hVjUwIvalHw30NNBj+OqAQafNr0s/YLZjkNIrMaOqWNYt7xjvyBrU94rUZa6
         tLWw==
X-Gm-Message-State: AAQBX9cuVRNNMem1PS5IL46lZrknT9u50fM0nb3rKAf/JXGXBNeT/h0N
        oBfh5Ms+5qMJDkafiUdzjqazDV3R5/XYzTlGpYkhrLlzuZLZHspMVzBkAl7LrY4cqzzeJAIPTqn
        YZBayyILqBaqApGv9GmoNF/9SdaHaeEmpLi8lXjC4xhbvVjM=
X-Received: by 2002:a17:90a:f48d:b0:246:fd10:a652 with SMTP id bx13-20020a17090af48d00b00246fd10a652mr1686327pjb.33.1681997763401;
        Thu, 20 Apr 2023 06:36:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350bMXdvy/rytoRnsGamIZCg1tM6Dreol8wEDega/UGpu+2eDnXfiMT4qmkmibwwJiWqwcGgLiZChzZkjHUBRDKQ=
X-Received: by 2002:a17:90a:f48d:b0:246:fd10:a652 with SMTP id
 bx13-20020a17090af48d00b00246fd10a652mr1686307pjb.33.1681997763030; Thu, 20
 Apr 2023 06:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230412205429.389382-1-paul@paul-moore.com> <CAFqZXNtjnHtDXp-dS6tpHp8bDdSYHhZLu-KRVYx1wrXe4ZbKvw@mail.gmail.com>
 <CAHC9VhQ6MTCcgVvy2SH-01codHFbYUj2knqDphN-JpBOvdAmNw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ6MTCcgVvy2SH-01codHFbYUj2knqDphN-JpBOvdAmNw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 20 Apr 2023 15:35:51 +0200
Message-ID: <CAFqZXNt3J4h=7Knu6f3JS_gwZaHfae11kU482epxBdNnwbFdog@mail.gmail.com>
Subject: Re: [PATCH] selinux: ensure av_permissions.h is built when needed
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 13, 2023 at 1:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Apr 12, 2023 at 6:00=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > On Wed, Apr 12, 2023 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > The Makefile rule responsible for building flask.h and
> > > av_permissions.h only lists flask.h as a target which means that
> > > av_permissions.h is only generated when flash.h needs to be
> >
> > Typo: flash.h -> flask.h
>
> Thanks.  Spell checkers don't work very well when you typo one word
> into another wrong, but correctly spelled, word :)
>
> > > generated.  This patch fixes this by adding av_permissions.h as a
> > > target to the rule.
> > >
> > > Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel b=
uild")
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/selinux/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> > > index 103c2776478a..df35d4ec46f0 100644
> > > --- a/security/selinux/Makefile
> > > +++ b/security/selinux/Makefile
> > > @@ -26,5 +26,5 @@ quiet_cmd_flask =3D GEN     $(obj)/flask.h $(obj)/a=
v_permissions.h
> > >        cmd_flask =3D $< $(obj)/flask.h $(obj)/av_permissions.h
> > >
> > >  targets +=3D flask.h av_permissions.h
> > > -$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
> > > +$(obj)/flask.h $(obj)/av_permissions.h: scripts/selinux/genheaders/g=
enheaders FORCE
> >
> > I had something like this in my patch originally, but then I couldn't
> > come up with a scenario where it would matter, so I dropped it... Are
> > you sure it's really needed?
>
> Yep.  I don't hit this very often, but it does happen.  Here is a
> forced example:
>
> % rm security/selinux/av_permissions.h
> % make security/selinux/
>  CALL    scripts/checksyscalls.sh
>  DESCEND objtool
> make[3]: 'install_headers' is up to date.
>  CC      security/selinux/avc.o
> In file included from security/selinux/avc.c:30:
> ./security/selinux/include/avc.h:20:10: fatal error: av_permissions.h: No=
 such f
> ile or directory
>   20 | #include "av_permissions.h"
>      |          ^~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:252: security/selinux/avc.o] Error 1
> make[2]: *** [scripts/Makefile.build:494: security/selinux] Error 2
> make[1]: *** [scripts/Makefile.build:494: security] Error 2
> make: *** [Makefile:2028: .] Error 2
>
> > (See also the "$(addprefix
> > $(obj)/,$(selinux-y)): $(obj)/flask.h" rule above.)
>
> Yes, I know, but since there are only two files/targets I felt it was
> clearer to add the file without the function-mangling.  If people feel
> strongly about it I can change it, but I'd just assume leave it as-is.
> If there were a number of files, yes, using 'addprefix' would be the
> way to go.

Sorry, that's not what I meant. My point was that that line makes the
whole SELinux code dependent on (only) flask.h, and that flask.h is
being used to establish the link between SELinux code and the
genheaders invocation. I don't quite understand how you would end up
with fresh flask.h, but missing/outdated av_permissions.h (other than
forcibly removing it as in your example).

Nonetheless, I agree it's better to list both as a grouped target to
avoid confusion and broken corner cases. However, we should then also
adjust the "addprefix" rule to depend on both flask.h and
av_permissions.h to keep the symmetry and completeness. Since you
already merged the v2 without it - do you want to send another patch
to close the gap or should I?

> > If it is, then I think you want to use "grouped targets" instead:
> >
> >     $(obj)/flask.h $(obj)/av_permissions.h &: [...]
> >
> > See:
> > https://www.gnu.org/software/make/manual/html_node/Multiple-Targets.htm=
l
>
> Thanks, I wasn't aware of that.
>
> --
> paul-moore.com
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

