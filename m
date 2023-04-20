Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B33C77B7C
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 14:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjDTOvK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 10:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjDTOvJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 10:51:09 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3722D4C18
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 07:50:59 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-552ae3e2cbeso44146067b3.13
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682002258; x=1684594258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yihRpVK9Q8PG89zuuDpTK3RZh46S33o6aRKunfvImS0=;
        b=ZG2L68hQqI01c4KzAngIo5vnQIOlefnieX6oWx+4zLt8mD0CQpPe79dwDfjEkQEyjk
         9IYMQ1mVt7VJNIcpjbLinULQTTXecJsbk31ExpTPT1ZDfEVdmFbqxSoF1tjsx/C9GMIe
         /WNtcj0mOG5673tpdPPkKWStsFILRZKc61lbdT4qUlWO91zSmD6BmP3NIeJgD9qG76jv
         zSVvN0hbwOedntghgJp94d74BGn2a/XA96beTwT4okHK0klC4f2/PbdhOOHEZgxX2pns
         1a61TwjqEEI0jU3Oh/XVk9EhoZHWhjx7pbhaOLl8r2qZwoTdh5IbP4ZCvYO+339Y2HGx
         fdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682002258; x=1684594258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yihRpVK9Q8PG89zuuDpTK3RZh46S33o6aRKunfvImS0=;
        b=h7QUX64+/gAe1bcH8NBVQvbJ943Tis+I3INchNS7JZDmICpc39oghripx+3zIqJrkS
         9sb6+J7T7o4xjGLCBQE7cNIUw2ab4If5eqKmhWLYu7m83tcK0ZYykDV/gqqEcmJ2fb6w
         zh7WOTooJmadkY4WkVmkRawWKfJhaeON+Dym8K9OepYpPWr6pa15kEm4jSfXcpn1I2Hv
         gah07SrCLKgAwA9jTxl0txhIOajWivMEl3bYfYIUV1fmPEU9Jj6Q2in/ydOdw0fnk/jX
         v7RRi2b20KvYSmC+mOM0khXjOf8/Jx04ykAv1v4eeT7H2wZfd02KCuo1+1kTuDl+R7vV
         USrw==
X-Gm-Message-State: AAQBX9fG+uhBA7zuCL6unRoVLSFfp2UQESVi0lZiX3OxSDBiQtTnRmPA
        TdDykv0r0AsUhuffjrhourTAYfE6u6y4ZrrKyEIQ/97p3M/cLjM=
X-Google-Smtp-Source: AKy350ZeCgPrfH1kxqZ03On5N5WJTdGk5Ou5yS+xB5Ghsi2Phex/i6V2HihOjSwFaWstcg91/VCrMnzYu3IJCwKicZM=
X-Received: by 2002:a81:4902:0:b0:552:6ffc:6688 with SMTP id
 w2-20020a814902000000b005526ffc6688mr1214611ywa.12.1682002258341; Thu, 20 Apr
 2023 07:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230412205429.389382-1-paul@paul-moore.com> <CAFqZXNtjnHtDXp-dS6tpHp8bDdSYHhZLu-KRVYx1wrXe4ZbKvw@mail.gmail.com>
 <CAHC9VhQ6MTCcgVvy2SH-01codHFbYUj2knqDphN-JpBOvdAmNw@mail.gmail.com> <CAFqZXNt3J4h=7Knu6f3JS_gwZaHfae11kU482epxBdNnwbFdog@mail.gmail.com>
In-Reply-To: <CAFqZXNt3J4h=7Knu6f3JS_gwZaHfae11kU482epxBdNnwbFdog@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Apr 2023 10:50:47 -0400
Message-ID: <CAHC9VhSnO8Jxb7WDK2pjbHmRfbn-OCXqZXxNMa88WAj-vFMoPA@mail.gmail.com>
Subject: Re: [PATCH] selinux: ensure av_permissions.h is built when needed
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 20, 2023 at 9:36=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Thu, Apr 13, 2023 at 1:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Apr 12, 2023 at 6:00=E2=80=AFPM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > > On Wed, Apr 12, 2023 at 10:56=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > The Makefile rule responsible for building flask.h and
> > > > av_permissions.h only lists flask.h as a target which means that
> > > > av_permissions.h is only generated when flash.h needs to be
> > >
> > > Typo: flash.h -> flask.h
> >
> > Thanks.  Spell checkers don't work very well when you typo one word
> > into another wrong, but correctly spelled, word :)
> >
> > > > generated.  This patch fixes this by adding av_permissions.h as a
> > > > target to the rule.
> > > >
> > > > Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel=
 build")
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > ---
> > > >  security/selinux/Makefile | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> > > > index 103c2776478a..df35d4ec46f0 100644
> > > > --- a/security/selinux/Makefile
> > > > +++ b/security/selinux/Makefile
> > > > @@ -26,5 +26,5 @@ quiet_cmd_flask =3D GEN     $(obj)/flask.h $(obj)=
/av_permissions.h
> > > >        cmd_flask =3D $< $(obj)/flask.h $(obj)/av_permissions.h
> > > >
> > > >  targets +=3D flask.h av_permissions.h
> > > > -$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
> > > > +$(obj)/flask.h $(obj)/av_permissions.h: scripts/selinux/genheaders=
/genheaders FORCE
> > >
> > > I had something like this in my patch originally, but then I couldn't
> > > come up with a scenario where it would matter, so I dropped it... Are
> > > you sure it's really needed?
> >
> > Yep.  I don't hit this very often, but it does happen.  Here is a
> > forced example:
> >
> > % rm security/selinux/av_permissions.h
> > % make security/selinux/
> >  CALL    scripts/checksyscalls.sh
> >  DESCEND objtool
> > make[3]: 'install_headers' is up to date.
> >  CC      security/selinux/avc.o
> > In file included from security/selinux/avc.c:30:
> > ./security/selinux/include/avc.h:20:10: fatal error: av_permissions.h: =
No such f
> > ile or directory
> >   20 | #include "av_permissions.h"
> >      |          ^~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[3]: *** [scripts/Makefile.build:252: security/selinux/avc.o] Error=
 1
> > make[2]: *** [scripts/Makefile.build:494: security/selinux] Error 2
> > make[1]: *** [scripts/Makefile.build:494: security] Error 2
> > make: *** [Makefile:2028: .] Error 2
> >
> > > (See also the "$(addprefix
> > > $(obj)/,$(selinux-y)): $(obj)/flask.h" rule above.)
> >
> > Yes, I know, but since there are only two files/targets I felt it was
> > clearer to add the file without the function-mangling.  If people feel
> > strongly about it I can change it, but I'd just assume leave it as-is.
> > If there were a number of files, yes, using 'addprefix' would be the
> > way to go.
>
> Sorry, that's not what I meant. My point was that that line makes the
> whole SELinux code dependent on (only) flask.h, and that flask.h is
> being used to establish the link between SELinux code and the
> genheaders invocation. I don't quite understand how you would end up
> with fresh flask.h, but missing/outdated av_permissions.h (other than
> forcibly removing it as in your example).

Sometimes strange things happen during development and code review :)
It happens so rarely, and not recently, that I can't say what
triggered it - it may have been me manually cleaning up some files due
to odd directory state - but it *has* happened, and we might as well
make the Makefile do the right thing.

> Nonetheless, I agree it's better to list both as a grouped target to
> avoid confusion and broken corner cases. However, we should then also
> adjust the "addprefix" rule to depend on both flask.h and
> av_permissions.h to keep the symmetry and completeness. Since you
> already merged the v2 without it - do you want to send another patch
> to close the gap or should I?

Agreed.  If you had replied sooner I would have been okay with merging
a patch before the merge window opens, but with the merge window
opening in a few days I'm not going to merge anything that isn't
critical.  Yes, the risk is low, but the advantage gained is even
lower.

I can send a patch after the merge window closes, or you can do it; I
don't care much either way.

--=20
paul-moore.com
