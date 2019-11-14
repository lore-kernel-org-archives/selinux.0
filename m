Return-Path: <SRS0=pcBM=ZG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E81C43141
	for <selinux@archiver.kernel.org>; Thu, 14 Nov 2019 08:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7612206DB
	for <selinux@archiver.kernel.org>; Thu, 14 Nov 2019 08:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNUlRia8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKNIwH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:52:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23930 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725976AbfKNIwH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Nov 2019 03:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573721526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFTDXu5KLCx/NgGlQEs4Px8yUQfHFzlFH/OlFo2n0ok=;
        b=QNUlRia8af3RuBF49reGaCHPrQyGuFiTqVqoJ9xc8EfFn14OAOBySPOXbe3frQKpNSJYba
        0q9xyqgkVAOZxWa0q28QHoZ6L6Imm3u+jhO/85/zf5dhP+pkpAja3rBHn3ecN+VUENlggy
        Kt8DfOi1pUnj/3d6r6t0BIfZ84vkuAw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-4n-WeFkrMRuUqUTDP4kBzQ-1; Thu, 14 Nov 2019 03:52:04 -0500
Received: by mail-oi1-f198.google.com with SMTP id v130so2716433oib.5
        for <selinux@vger.kernel.org>; Thu, 14 Nov 2019 00:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEwBZHA4L5rrNOG3OYpSp+PIcgka4zs8smBH6QqTobU=;
        b=cJmCWwVU5nc+GqxxKgjd+b7OxWBKV/fPl/5s6RQhIyOsZ+38DTc+z0w1WKA7bBBiRP
         13OW48pfbqPwG4Y52oQmaTqRGt2aCRq+wzsYrAF1CbjrrDyboWqcOzn3ShrhN1Q8MxHc
         mfYqOGmokG59BC+6u+2+gZFjCni/lshEHvuAv5ZdBqScqbfRUKKzZitWBZsipYwJHpxJ
         vD7ek1DdPWkmgf5OIwZCuzo/lMfvlUv8r8mErY/Y1tbrVDA4dmYhn6DR5fMDDO4WwLx3
         n5WpdKzQtZXyYqNs5yUCWbcXcqX+lqX7WQrGTkDZbyqzwRGIeoqIXZ2VtEjP9P3uhcJ9
         OHqg==
X-Gm-Message-State: APjAAAVeVCXUYtSqH4WacTbj+oJ1S5sgnzNkOwN6qjh7G879KtGzCrGb
        dWl4cocMigzmLb/1/J3n8Wh3WihFv4wSL8FkpoY5S6nIsQT04mXYbobKAlb5GqziS67evFnXXln
        VI0btQ3wJS2o55I5sb82iIsaB8F//IrQt1g==
X-Received: by 2002:a05:6808:2d8:: with SMTP id a24mr2573371oid.127.1573721524144;
        Thu, 14 Nov 2019 00:52:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1QDcDJLBPEsL/ncLIzgR6bS6OfTcJGtgLAB78T6NUoGPLrobtbWs6KSmYiwSL2HMp898O1D+tw+M5jgBSME0=
X-Received: by 2002:a05:6808:2d8:: with SMTP id a24mr2573349oid.127.1573721523827;
 Thu, 14 Nov 2019 00:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-11-arnd@arndb.de>
 <CAFqZXNuevxW9d91Zpy6fw3LKrF=xtajAiB61soGQLxgP4xRnFg@mail.gmail.com>
 <CAK8P3a38eZijQH=vChgm5fZBzOuV2Oi2c0LEdrMy4nKpL7QLbQ@mail.gmail.com>
 <CAFqZXNsp3JxqW-ahCvtiZBECX5PWonpzMRK0MOn=6a28WzF4cA@mail.gmail.com> <CAK8P3a2FZ2_v6uUJJOurMAE7xYG6wq7T7ZvpLVAPA6FG2pm0dQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2FZ2_v6uUJJOurMAE7xYG6wq7T7ZvpLVAPA6FG2pm0dQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 14 Nov 2019 09:51:52 +0100
Message-ID: <CAFqZXNu4Tk4H3b_FS8=EA5QMi10kEgT22uD=61aDryHp-fXnig@mail.gmail.com>
Subject: Re: [PATCH 20/23] y2038: move itimer reset into itimer.c
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: 4n-WeFkrMRuUqUTDP4kBzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 11, 2019 at 11:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Nov 10, 2019 at 12:07 AM Ondrej Mosnacek <omosnace@redhat.com> wr=
ote:
> >
> > On Sat, Nov 9, 2019 at 10:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Sat, Nov 9, 2019 at 2:43 PM Ondrej Mosnacek <omosnace@redhat.com> =
wrote:
> > >
> > > > > -struct itimerval;
> > > > > -extern int do_setitimer(int which, struct itimerval *value,
> > > > > -                       struct itimerval *ovalue);
> > > > > -extern int do_getitimer(int which, struct itimerval *value);
> > > > > +#ifdef CONFIG_POSIX_TIMERS
> > > > > +extern void clear_itimer(void);
> > > > > +#else
> > > > > +static inline void clear_itimer(void) {}
> > > > > +#endif
> > > > >
> > >
> > > > > @@ -249,6 +249,17 @@ int do_setitimer(int which, struct itimerval=
 *value, struct itimerval *ovalue)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_SECURITY_SELINUX
> > > >
> > > > Did you mean "#ifdef CONFIG_POSIX_TIMERS" here to match the header?
> > >
> > > No, this part is intentional, CONFIG_POSIX_TIMERS already controls
> > > whether itimer.c is
> > > compiled in the first place, but this function is only needed when ca=
lled from
> > > the selinux driver.
> >
> > All right, but you declare the function in time.h even if
> > CONFIG_SECURITY_SELINUX is not enabled... it is kind of awkward when
> > it can happen that the function is declared but not defined anywhere
> > (even if it shouldn't be used by new users). Maybe you could at least
> > put the header declaration/definition inside #ifdef
> > CONFIG_SECURITY_SELINUX as well so it is clear that this function is
> > intended for SELinux only?
>
> I don't see that as a problem, we rarely put declarations inside of an #i=
fdef.
> The main effect that would have is forcing any file that includes linux/t=
ime.h
> to be rebuilt when selinux is turned on or off in the .config.

OK, but with this patch if someone tries to use the function
elsewhere, the build will succeed if SELinux is enabled in the config,
but fail if it isn't.  Is that intended?  I would suggest at least
clearly documenting it above the declaration that the function isn't
supposed to be used by new users and doing so will cause build to fail
under CONFIG_SECURITY_SELINUX=3Dn.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

