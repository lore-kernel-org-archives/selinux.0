Return-Path: <SRS0=e4om=ZB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D009C43331
	for <selinux@archiver.kernel.org>; Sat,  9 Nov 2019 23:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2211E207FF
	for <selinux@archiver.kernel.org>; Sat,  9 Nov 2019 23:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pms9Fk0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfKIXHh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 9 Nov 2019 18:07:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36658 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726530AbfKIXHh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 9 Nov 2019 18:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573340855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nM/QlBuwgFsk9POi3L9W4gfZTnhffjaZ1rya0qjcHXg=;
        b=Pms9Fk0TkPDCeYYTUEEbcYQoS7EIvFQDPsLwIFl5ub/ZTa7r8ZINHDsIeKPcgUy1de7sgZ
        cxCmzRqyBrAFliYSYqyhS2fXd3/DO6KR//khogZfZ72W58wNpItvAb/U9ix+zL6SasILwe
        dIsJnuJ9CWxV1b7TB722qAKvaWJQ5uo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-nb195IxVMbuP5H08-u6p7w-1; Sat, 09 Nov 2019 18:07:32 -0500
Received: by mail-oi1-f197.google.com with SMTP id j23so7928950oii.21
        for <selinux@vger.kernel.org>; Sat, 09 Nov 2019 15:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joVZUMPvUOgWVUGh3XNj6yKcnBUM0ZIbNDOvlvl0Y3s=;
        b=STc0aLbhDfIdxkkUT6Ff1NM5dy3gkLsoW8vAbXjmM2cmrUsVvCHa8sCjHM/SNx/gmz
         laQgoTXOQ2Rva6cHhy8UCFFI5W2aNwnYicnMgF1SL6ogQQ2EJRawWMQIYQWdw6P7ixIn
         JVFAs9+XonZ5kXWqUwKLSF1Jolf7zKNmigLbxicUXGOSgNbF/Y87k/hKTtT1EwVx9P81
         Ya+1uEmybf4f4oRBEf7sO/e4q1rEHFNixlcCVv8ivZ4kfC+OuXIHjrO+ZRGSc/ZhUPSJ
         g0faqTQ0NRi0GUPP6VYb9V1jZbKBqun8vNVfKQ6i8667qN6U9XBT3/F5h5VeYUXpNR8T
         +HLA==
X-Gm-Message-State: APjAAAX3jAKQGjueKWHNt+TmwjDzcT4etJTxhO6w3Xbw9o6dIxaCA6dV
        IrRKnzC/CiAZ6Pdm7asEktBVjiiUaBKnPvp1ZfgBt68sUkf41iaPjqQJ0+8xl2O+h9mqOV9kAgH
        ULRPbK7Yhui/okIyTRWqi+1uoQg7sFlpqjw==
X-Received: by 2002:aca:ecd0:: with SMTP id k199mr17121165oih.166.1573340851730;
        Sat, 09 Nov 2019 15:07:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPG+slhOAaUZlQmRXbIknpOfUNqhnDz7x+YaHmJ0gB074zuMPBX0TM8nkmK+qgiZAPAXBiBhxHkEnU0Z4aVdA=
X-Received: by 2002:aca:ecd0:: with SMTP id k199mr17121146oih.166.1573340851438;
 Sat, 09 Nov 2019 15:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-11-arnd@arndb.de>
 <CAFqZXNuevxW9d91Zpy6fw3LKrF=xtajAiB61soGQLxgP4xRnFg@mail.gmail.com> <CAK8P3a38eZijQH=vChgm5fZBzOuV2Oi2c0LEdrMy4nKpL7QLbQ@mail.gmail.com>
In-Reply-To: <CAK8P3a38eZijQH=vChgm5fZBzOuV2Oi2c0LEdrMy4nKpL7QLbQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sun, 10 Nov 2019 00:07:20 +0100
Message-ID: <CAFqZXNsp3JxqW-ahCvtiZBECX5PWonpzMRK0MOn=6a28WzF4cA@mail.gmail.com>
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
X-MC-Unique: nb195IxVMbuP5H08-u6p7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Nov 9, 2019 at 10:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Nov 9, 2019 at 2:43 PM Ondrej Mosnacek <omosnace@redhat.com> wrot=
e:
>
> > > -struct itimerval;
> > > -extern int do_setitimer(int which, struct itimerval *value,
> > > -                       struct itimerval *ovalue);
> > > -extern int do_getitimer(int which, struct itimerval *value);
> > > +#ifdef CONFIG_POSIX_TIMERS
> > > +extern void clear_itimer(void);
> > > +#else
> > > +static inline void clear_itimer(void) {}
> > > +#endif
> > >
>
> > > @@ -249,6 +249,17 @@ int do_setitimer(int which, struct itimerval *va=
lue, struct itimerval *ovalue)
> > >         return 0;
> > >  }
> > >
> > > +#ifdef CONFIG_SECURITY_SELINUX
> >
> > Did you mean "#ifdef CONFIG_POSIX_TIMERS" here to match the header?
>
> No, this part is intentional, CONFIG_POSIX_TIMERS already controls
> whether itimer.c is
> compiled in the first place, but this function is only needed when called=
 from
> the selinux driver.

All right, but you declare the function in time.h even if
CONFIG_SECURITY_SELINUX is not enabled... it is kind of awkward when
it can happen that the function is declared but not defined anywhere
(even if it shouldn't be used by new users). Maybe you could at least
put the header declaration/definition inside #ifdef
CONFIG_SECURITY_SELINUX as well so it is clear that this function is
intended for SELinux only?

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

