Return-Path: <SRS0=e4om=ZB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C870BC17444
	for <selinux@archiver.kernel.org>; Sat,  9 Nov 2019 21:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E9E21882
	for <selinux@archiver.kernel.org>; Sat,  9 Nov 2019 21:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfKIVDJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 9 Nov 2019 16:03:09 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:34273 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfKIVDJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 9 Nov 2019 16:03:09 -0500
Received: from mail-qv1-f45.google.com ([209.85.219.45]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N5VTm-1hrmS02jko-016stv; Sat, 09 Nov 2019 22:03:06 +0100
Received: by mail-qv1-f45.google.com with SMTP id w11so3519335qvu.13;
        Sat, 09 Nov 2019 13:03:06 -0800 (PST)
X-Gm-Message-State: APjAAAV2k8JvymMxplEpZ4LWlhRJ12lcRL5DPKRX91lIzt3uALcIcpi0
        St2XKjMdDm8nFqDWlv08kWalMFSW0AXhnL8fwMw=
X-Google-Smtp-Source: APXvYqzVWdaWa9r60I/4Z9hpe05+E921xzLR8H/PZkF7j6E78aa0x1vFwmnnWC69tXfwFmEaoi/5dhGDrttFdJdYruM=
X-Received: by 2002:a0c:fde8:: with SMTP id m8mr16974889qvu.4.1573333385442;
 Sat, 09 Nov 2019 13:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-11-arnd@arndb.de>
 <CAFqZXNuevxW9d91Zpy6fw3LKrF=xtajAiB61soGQLxgP4xRnFg@mail.gmail.com>
In-Reply-To: <CAFqZXNuevxW9d91Zpy6fw3LKrF=xtajAiB61soGQLxgP4xRnFg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 9 Nov 2019 22:02:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a38eZijQH=vChgm5fZBzOuV2Oi2c0LEdrMy4nKpL7QLbQ@mail.gmail.com>
Message-ID: <CAK8P3a38eZijQH=vChgm5fZBzOuV2Oi2c0LEdrMy4nKpL7QLbQ@mail.gmail.com>
Subject: Re: [PATCH 20/23] y2038: move itimer reset into itimer.c
To:     Ondrej Mosnacek <omosnace@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Gl1fFRfO9j2DtrAd5m3vLUZBvw9/Qo04K69D9QBhEGuOD3kC6Ny
 oJrNEFUAUBLNcpyJd2NO/dlDsQfw9Sx0x1h/mb2qXrr25t9QyHsazOvrdCPsRHKjBDxl844
 lLTq5Rdq8mkxH+Z5ZBX6DsSnrGRaVSmGFaY66BoLJi6JMnwp6zjC0bGDz5RmAJpWHhSHKhu
 gn5MdMPpuQPw6FkLwB1lQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ut+WqSDbMvI=:qi5JdruNp2M1RiCv44NEpL
 NClrdIpdVHDSulBhWPNKUy5IgZNyGwnR20PN7pXrApDtHKovD3EfNtslqN2/jYr0B4eH9CzcT
 y8YjI8eky82YrPxm2jMwRPZ2QNpsH/u4qYD7SexAYPhURFPANKx8/4bFv22KMM0/N2c8/mHBA
 fOqyMWHyPAJgejXwt57yHWDgKcz3wHziYlErVJXitZo/FsMFSrK24BCEsphqkKorbuQ3pgay6
 wgrj0V1NFXlgSCS5GNu/uoarBsn2vISyJ8RBc72IJUWSdVVvvappxtPKl3NW1NA6PQ2F104uo
 GwNyeos9tJ7IDP7PSf5IOvP6U4n2tafCh8rHVFLNUhz3WUcOcUEpmZXRM8lGc48bvIXTXT+zr
 P6jlJ9DxeY4gas5oxVmABJiEnrCLNPmRz/dAGf+BBabZAdAC7OhCVQCFGSPE13h39/j5xPGfR
 u4mfQSoyPwZ4hT9tGgADLv1ljE3Hzw5PSCJLyhUmKwanoqhfDm0hcYB78ulb00rr4ngBXfb25
 MVeAwHfhHQ5uoM9SC1tqjiWNF5yh2tgHrOiYPisTVqqgSHrbnpIUEjUblJygy5U+FHGGXD27S
 0F/QqLs3FYOuLOfun6Pz7nOvRrCZX448Ir0R7aEfg4TTaQ/n4MVRHRGLMgemP2gzHn8Vh4j2K
 xKn5811CPZA/NanWNOOOyYH3kaBJJn3U6uPobs4iAd8yEstZKL6jdlscaR9s67gQwGIatJl2v
 eKUIcMGGY3kjGOBcWQBdYQU8V6YGTxP5LfQtRgGXm6egfA06cbOEXWvToPTG+jd+vt27lTqec
 A/vGneTmMHiJeyUb5ydqIrgU49cdvLQmEGh6XC54TqVfC+HJOWn7fNSOv66cZONFJ6mF8FX0V
 UmGEuS8UyAaAWkjhy4Vw==
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Nov 9, 2019 at 2:43 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:

> > -struct itimerval;
> > -extern int do_setitimer(int which, struct itimerval *value,
> > -                       struct itimerval *ovalue);
> > -extern int do_getitimer(int which, struct itimerval *value);
> > +#ifdef CONFIG_POSIX_TIMERS
> > +extern void clear_itimer(void);
> > +#else
> > +static inline void clear_itimer(void) {}
> > +#endif
> >

> > @@ -249,6 +249,17 @@ int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_SECURITY_SELINUX
>
> Did you mean "#ifdef CONFIG_POSIX_TIMERS" here to match the header?

No, this part is intentional, CONFIG_POSIX_TIMERS already controls
whether itimer.c is
compiled in the first place, but this function is only needed when called from
the selinux driver.

> > -               }
> > +               if (IS_ENABLED(CONFIG_POSIX_TIMERS))
> > +                       clear_itimer();
>
> Since you already define a no-op fallback for the case of
> !IS_ENABLED(CONFIG_POSIX_TIMERS) in time.h, why not simply call
> clear_itimer() unconditionally?

Ah right, that was indeed my plan here when I changed the declaration
in the header, I just forgot to remove the if(). Fixed now.

Thanks for the review!

      Arnd
