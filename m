Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B413C77B6C
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 23:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDLXqe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 19:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLXqd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 19:46:33 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15AB10CF
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 16:46:31 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id q5so16461045ybk.7
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 16:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681343191; x=1683935191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOQBywUPsDETioSArR6r96GQPA8/EkDHY0+ExzX0iu0=;
        b=OXLAWsNQyemkKlzYuWaIvIrCjXa2ej8AWCBJCqwuJrqMyG8o5fxGdtJj624DgQyCBw
         YxNLMRK8ghnsoUn1mNkDir3/dGCqgX+9kpGq5ui7xboeLlUK5XMrvMWJR8uJKH12ad1p
         Q/uWKtdbKxTvR9JRmRmK1AgWxobbV8F45QpLq2dZdPLWbverN4Hjj9Js8b1exfLKIHBb
         vBLEzKY2EM12ikAJ9WsdRwGs9DZolgMTmYNW7wn7R/nKbLurpl/ONdFe9yYDxUOcKCNx
         1V5bro7l/TLHVlXo0GKXINaCOxEkI/avNj5Z527LGSGE2zSOSRfIAZ8d0u4BpDAnDg/b
         c45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681343191; x=1683935191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOQBywUPsDETioSArR6r96GQPA8/EkDHY0+ExzX0iu0=;
        b=CBy5TeewZZQq6xvu3G3VtCeBen2+MOPs49JSo0eatjVXIZU+rLVp+FjHLErpQ5pWDw
         H3FM6BBfoX5Io2NnFZ4KnaH+nMh3aT7tloKlosgi2/foWbwmljG5rlvqfUePSp6WGAlX
         U0N1XKoRpPL6u1a4UGEkMYMAI/HD1XAvED6O8XeKtBiEk48t7/HdWZML8/nUc6LfFP/f
         UhDh1w6W3hU1VWuI/73N/Kum9FO8UfKvBkgQhBnHRRpyD3QMoOaDXjGPAIVqOeZ6N56f
         h/Uf8RvcPKeBtVc4ER3zvgQN1COY9qMM241o9NBHXh3sBd/IcHE/e3z99tMPWf9b1qT2
         h6aA==
X-Gm-Message-State: AAQBX9fShtdguWBREenxD8WgYmMxCm/vBSiyUBXZO4h94+RzB9dIfLJB
        tWNy9fkYIKCgE44BhWEOL9xOmnIvZm4tCVzCt8iY9JKwv8SxZ6rXPg==
X-Google-Smtp-Source: AKy350bqI7iwixVJhUdCeq9rTxEb5wLUYIvMQnD3ouhv0SCufmE0lbQFnviDeuRAni784+D9vcFGsxBjSavms+d9Qb0=
X-Received: by 2002:a25:e0c5:0:b0:b75:8ac3:d5d9 with SMTP id
 x188-20020a25e0c5000000b00b758ac3d5d9mr225639ybg.3.1681343191029; Wed, 12 Apr
 2023 16:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230412205429.389382-1-paul@paul-moore.com> <CAFqZXNtjnHtDXp-dS6tpHp8bDdSYHhZLu-KRVYx1wrXe4ZbKvw@mail.gmail.com>
In-Reply-To: <CAFqZXNtjnHtDXp-dS6tpHp8bDdSYHhZLu-KRVYx1wrXe4ZbKvw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Apr 2023 19:46:20 -0400
Message-ID: <CAHC9VhQ6MTCcgVvy2SH-01codHFbYUj2knqDphN-JpBOvdAmNw@mail.gmail.com>
Subject: Re: [PATCH] selinux: ensure av_permissions.h is built when needed
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 12, 2023 at 6:00=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Wed, Apr 12, 2023 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > The Makefile rule responsible for building flask.h and
> > av_permissions.h only lists flask.h as a target which means that
> > av_permissions.h is only generated when flash.h needs to be
>
> Typo: flash.h -> flask.h

Thanks.  Spell checkers don't work very well when you typo one word
into another wrong, but correctly spelled, word :)

> > generated.  This patch fixes this by adding av_permissions.h as a
> > target to the rule.
> >
> > Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel bui=
ld")
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> > index 103c2776478a..df35d4ec46f0 100644
> > --- a/security/selinux/Makefile
> > +++ b/security/selinux/Makefile
> > @@ -26,5 +26,5 @@ quiet_cmd_flask =3D GEN     $(obj)/flask.h $(obj)/av_=
permissions.h
> >        cmd_flask =3D $< $(obj)/flask.h $(obj)/av_permissions.h
> >
> >  targets +=3D flask.h av_permissions.h
> > -$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
> > +$(obj)/flask.h $(obj)/av_permissions.h: scripts/selinux/genheaders/gen=
headers FORCE
>
> I had something like this in my patch originally, but then I couldn't
> come up with a scenario where it would matter, so I dropped it... Are
> you sure it's really needed?

Yep.  I don't hit this very often, but it does happen.  Here is a
forced example:

% rm security/selinux/av_permissions.h
% make security/selinux/
 CALL    scripts/checksyscalls.sh
 DESCEND objtool
make[3]: 'install_headers' is up to date.
 CC      security/selinux/avc.o
In file included from security/selinux/avc.c:30:
./security/selinux/include/avc.h:20:10: fatal error: av_permissions.h: No s=
uch f
ile or directory
  20 | #include "av_permissions.h"
     |          ^~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:252: security/selinux/avc.o] Error 1
make[2]: *** [scripts/Makefile.build:494: security/selinux] Error 2
make[1]: *** [scripts/Makefile.build:494: security] Error 2
make: *** [Makefile:2028: .] Error 2

> (See also the "$(addprefix
> $(obj)/,$(selinux-y)): $(obj)/flask.h" rule above.)

Yes, I know, but since there are only two files/targets I felt it was
clearer to add the file without the function-mangling.  If people feel
strongly about it I can change it, but I'd just assume leave it as-is.
If there were a number of files, yes, using 'addprefix' would be the
way to go.

> If it is, then I think you want to use "grouped targets" instead:
>
>     $(obj)/flask.h $(obj)/av_permissions.h &: [...]
>
> See:
> https://www.gnu.org/software/make/manual/html_node/Multiple-Targets.html

Thanks, I wasn't aware of that.

--=20
paul-moore.com
