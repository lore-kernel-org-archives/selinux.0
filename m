Return-Path: <SRS0=VxLC=ZD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B755C17446
	for <selinux@archiver.kernel.org>; Mon, 11 Nov 2019 10:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F078821783
	for <selinux@archiver.kernel.org>; Mon, 11 Nov 2019 10:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfKKK6L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:58:11 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:50599 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfKKK6L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Nov 2019 05:58:11 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MzCMN-1hiBRi44ah-00wA8T; Mon, 11 Nov 2019 11:58:10 +0100
Received: by mail-qk1-f182.google.com with SMTP id q70so10718563qke.12;
        Mon, 11 Nov 2019 02:58:09 -0800 (PST)
X-Gm-Message-State: APjAAAVGs/HLw5w5QN7PdknxvBbPPa+/ga1tchoz59C0U9Znw6TnUbO3
        UsyHt/OO8nyJKMh2suz6LlEXAm9EtYZ0RAhH2AE=
X-Google-Smtp-Source: APXvYqwtj3vQp0nBoe8lUhBg7fu+umYPtBqAlXL7Ou/7zD2CSxh8G+dzFTQnCdpIa8Cx3MCrbYL6C7CzieMWIfRccMU=
X-Received: by 2002:a37:4f0a:: with SMTP id d10mr9793076qkb.286.1573469888741;
 Mon, 11 Nov 2019 02:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-11-arnd@arndb.de>
 <CAFqZXNuevxW9d91Zpy6fw3LKrF=xtajAiB61soGQLxgP4xRnFg@mail.gmail.com>
 <CAK8P3a38eZijQH=vChgm5fZBzOuV2Oi2c0LEdrMy4nKpL7QLbQ@mail.gmail.com> <CAFqZXNsp3JxqW-ahCvtiZBECX5PWonpzMRK0MOn=6a28WzF4cA@mail.gmail.com>
In-Reply-To: <CAFqZXNsp3JxqW-ahCvtiZBECX5PWonpzMRK0MOn=6a28WzF4cA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Nov 2019 11:57:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2FZ2_v6uUJJOurMAE7xYG6wq7T7ZvpLVAPA6FG2pm0dQ@mail.gmail.com>
Message-ID: <CAK8P3a2FZ2_v6uUJJOurMAE7xYG6wq7T7ZvpLVAPA6FG2pm0dQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:talTFI+q4JcUPtrySBmEjOPKUX09D5LJWAeHUZ9hJvNb739cZt9
 beNlgaGDcvAG6HfQekZh9C1WXKFXZVY+PnMf1cp+rBsPF8iCawUpVm/+B2VsDIcvrmW9DoX
 S+TTeCJIJP+aLnKW6OXhOQJ1UlI5VO1bs1T97GHY/AAVcxY5xwsuYi3cCkEP3kwKO6yJXOd
 ppjy5hRI3OLgEMEj8GOqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kVY/Hkf8KzU=:pIeNep2ZsiaPrEk1sTX9vl
 UgWYRr7g53x76Rco7DZ7BQVwqeNBhsZsmtWe++MfRbgJ55SxQOf7QGjcLlMDMEwuzRFJ1d7bm
 ioY3q7iNCYVBPzdyXgG5wGf9446ceDEr9m3AGZj26nCfckAfr8Pcf58WRom4V352d3A7SJ5J+
 R1PwWR29vwIxV3PnNVYjGfo8ao9i3oOkQDOHJFc3bK3zVkoxmUmq8S5u8kUvTuUIGxAsO6WGR
 UyP/uhYziM87FY8YflxQNBQBSAu/nhHO/um3mUQHN3ACDoZ2FAEJx+RkaKLDgiOxWseMUBxFQ
 X14OWzQ1k6M2sFPFkiUjvOvjXFvhmw5CaZHV2Y0MWIMO+5KQ+qa3C1azxaT4BMAWAWBda84sf
 GN1qbWtJd1/fagJxkA+7p2fDf22TbK0gZRHh4a5sTP/UD+q+IK6b9Sr2eXIRIfTFkHplvPfbu
 j224YhRg+sabtqCQKv60QVYT2XmKnp//Qq9+TMCDWUktsO/l1IkUCp0FR8MABhLz3YZnCtYMI
 bQ31NS2SVhS3ShQkE8wVDJVo3Wrj/O9oJUpJ9jdP6cVb1pARgTAQCBn2OOKuNBKsrqYfkoJJs
 F/XVqvSVzQiPtW3du8a41o5n9/dOpehRpVx5ts1iea32YrkqMVT0XhVBue/d4zEC2NCgVsYWX
 mRO2YmELI7uNwyVvKQjxGcC1DGJsdnWlsITP/QoFXEFrLJAI7yT4BlglBIJWV/NZpV0sOomPB
 /BBnDDjg2sPTX97yhQJnvQ74fkqpOLc573MnLdKRyhqyoti01trSoGuob1TZ6LI3fv3yhlh6A
 S6tcfVTFRmOFj6W09hA28klBnJhPES5sOxEi5tJD6zjc8wAGVsdOu+258i4dZrk1ebqEKohMS
 tYGZ1AsqLEKvpuBjfv5g==
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Nov 10, 2019 at 12:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Sat, Nov 9, 2019 at 10:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Nov 9, 2019 at 2:43 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > > > -struct itimerval;
> > > > -extern int do_setitimer(int which, struct itimerval *value,
> > > > -                       struct itimerval *ovalue);
> > > > -extern int do_getitimer(int which, struct itimerval *value);
> > > > +#ifdef CONFIG_POSIX_TIMERS
> > > > +extern void clear_itimer(void);
> > > > +#else
> > > > +static inline void clear_itimer(void) {}
> > > > +#endif
> > > >
> >
> > > > @@ -249,6 +249,17 @@ int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
> > > >         return 0;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_SECURITY_SELINUX
> > >
> > > Did you mean "#ifdef CONFIG_POSIX_TIMERS" here to match the header?
> >
> > No, this part is intentional, CONFIG_POSIX_TIMERS already controls
> > whether itimer.c is
> > compiled in the first place, but this function is only needed when called from
> > the selinux driver.
>
> All right, but you declare the function in time.h even if
> CONFIG_SECURITY_SELINUX is not enabled... it is kind of awkward when
> it can happen that the function is declared but not defined anywhere
> (even if it shouldn't be used by new users). Maybe you could at least
> put the header declaration/definition inside #ifdef
> CONFIG_SECURITY_SELINUX as well so it is clear that this function is
> intended for SELinux only?

I don't see that as a problem, we rarely put declarations inside of an #ifdef.
The main effect that would have is forcing any file that includes linux/time.h
to be rebuilt when selinux is turned on or off in the .config.

     Arnd
