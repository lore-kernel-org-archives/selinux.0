Return-Path: <SRS0=e4om=ZB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A368C17443
	for <selinux@archiver.kernel.org>; Sat,  9 Nov 2019 13:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D6921882
	for <selinux@archiver.kernel.org>; Sat,  9 Nov 2019 13:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpVahVmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfKINnV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 9 Nov 2019 08:43:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25166 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbfKINnV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 9 Nov 2019 08:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573306999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Up5s8EpS5D7kkDC57nzXWxivAHhovvLoHXVf8DG9Twg=;
        b=TpVahVmQBbsLouIMQB9scu+ZX41B28IwbtA39ORdf4Cl7gc5F1h0fApbmZZ+Rd0I+o+0qq
        1Q1Q3y7TY8t3QcxO0o8kUl+KOQb3gr24wd1aD7Bf9tz+vs4wcAH9u3NBUSkrzwmqbe6Z2n
        gc1JPj1yyh7UIeNXddlWw1waU2w3EAU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-dUleG7q2M6ioAb9RU_Guxw-1; Sat, 09 Nov 2019 08:43:18 -0500
Received: by mail-ot1-f71.google.com with SMTP id m7so2596572otr.12
        for <selinux@vger.kernel.org>; Sat, 09 Nov 2019 05:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEmiWvgrHzBy2uEipunGX3PtOc+nxMNrW4xVu/URLUE=;
        b=r4zFwoZSwp9UgReX6QsfVqY4cODSzvhlMN+iH9GS4xUa/mIxgmEeFDiDRBaJ6m+aYO
         mx2il3q1EJ8s3PBQCNJWFEuJwiR+rhxtKuxiPCyyIc4KQAEeGJJoSAImieFGvNalx9CD
         QiTPMahe1byh2MGWqsm+I4Qz9HofYFC4rBgY1exTM8pODr1a5r24dWee9ctnq5Zeg3eg
         9GaNaWFwPbQ0p4CCs/UAV6oJqeCaYvA5GwQ+EZLuaoXFHi/7iO5ZN2rMC3GmsOVVu4Nj
         9AuT4JK0z1V7x3WBd2teYWWrz+fhPPus2d2HVTGXQRr6Tmvfp9/gC6aWx6gntj3fQ/uR
         IFkw==
X-Gm-Message-State: APjAAAWbVqrMGe/Ye0yIN1kepTIkb3D9CQ7FXEHoYUyeURv8IsUBoPPB
        M9+A89PyTEg7UdYW2JSAlNNhk68IwY+Z1L3kBQsHwxEENNjOQZq3kz6O3ePVmdVnuYegOxUHpXE
        K4NJgU7kPPXaLo7Iwe1pQnEWeH9KobunoDg==
X-Received: by 2002:aca:7595:: with SMTP id q143mr15605497oic.103.1573306997653;
        Sat, 09 Nov 2019 05:43:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEAIKoO0PorChSjh8mXo4pFYXDvotABIq5sy0WipLpRcgXKIuI7ufDvUrW9RgtQJB61KjLDtlqvynXSHfenbE=
X-Received: by 2002:aca:7595:: with SMTP id q143mr15605470oic.103.1573306997218;
 Sat, 09 Nov 2019 05:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-11-arnd@arndb.de>
In-Reply-To: <20191108211323.1806194-11-arnd@arndb.de>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 9 Nov 2019 14:43:06 +0100
Message-ID: <CAFqZXNuevxW9d91Zpy6fw3LKrF=xtajAiB61soGQLxgP4xRnFg@mail.gmail.com>
Subject: Re: [PATCH 20/23] y2038: move itimer reset into itimer.c
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
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
X-MC-Unique: dUleG7q2M6ioAb9RU_Guxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 8, 2019 at 10:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Preparing for a change to the itimer internals, stop using the
> do_setitimer() symbol and instead use a new higher-level interface.
>
> The do_getitimer()/do_setitimer functions can now be made static,
> allowing the compiler to potentially produce better object code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/time.h     |  9 +++++----
>  kernel/time/itimer.c     | 15 +++++++++++++--
>  security/selinux/hooks.c | 10 +++-------
>  3 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/time.h b/include/linux/time.h
> index 27d83fd2ae61..0760a4f5a15c 100644
> --- a/include/linux/time.h
> +++ b/include/linux/time.h
> @@ -35,10 +35,11 @@ extern time64_t mktime64(const unsigned int year, con=
st unsigned int mon,
>  extern u32 (*arch_gettimeoffset)(void);
>  #endif
>
> -struct itimerval;
> -extern int do_setitimer(int which, struct itimerval *value,
> -                       struct itimerval *ovalue);
> -extern int do_getitimer(int which, struct itimerval *value);
> +#ifdef CONFIG_POSIX_TIMERS
> +extern void clear_itimer(void);
> +#else
> +static inline void clear_itimer(void) {}
> +#endif
>
>  extern long do_utimes(int dfd, const char __user *filename, struct times=
pec64 *times, int flags);
>
> diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
> index 4664c6addf69..ce9cd19ce72e 100644
> --- a/kernel/time/itimer.c
> +++ b/kernel/time/itimer.c
> @@ -73,7 +73,7 @@ static void get_cpu_itimer(struct task_struct *tsk, uns=
igned int clock_id,
>         value->it_interval =3D ns_to_timeval(interval);
>  }
>
> -int do_getitimer(int which, struct itimerval *value)
> +static int do_getitimer(int which, struct itimerval *value)
>  {
>         struct task_struct *tsk =3D current;
>
> @@ -197,7 +197,7 @@ static void set_cpu_itimer(struct task_struct *tsk, u=
nsigned int clock_id,
>  #define timeval_valid(t) \
>         (((t)->tv_sec >=3D 0) && (((unsigned long) (t)->tv_usec) < USEC_P=
ER_SEC))
>
> -int do_setitimer(int which, struct itimerval *value, struct itimerval *o=
value)
> +static int do_setitimer(int which, struct itimerval *value, struct itime=
rval *ovalue)
>  {
>         struct task_struct *tsk =3D current;
>         struct hrtimer *timer;
> @@ -249,6 +249,17 @@ int do_setitimer(int which, struct itimerval *value,=
 struct itimerval *ovalue)
>         return 0;
>  }
>
> +#ifdef CONFIG_SECURITY_SELINUX

Did you mean "#ifdef CONFIG_POSIX_TIMERS" here to match the header?

> +void clear_itimer(void)
> +{
> +       struct itimerval v =3D {};
> +       int i;
> +
> +       for (i =3D 0; i < 3; i++)
> +               do_setitimer(i, &v, NULL);
> +}
> +#endif
> +
>  #ifdef __ARCH_WANT_SYS_ALARM
>
>  /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9625b99e677f..c3f2e89acb87 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2549,9 +2549,8 @@ static void selinux_bprm_committing_creds(struct li=
nux_binprm *bprm)
>  static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
>  {
>         const struct task_security_struct *tsec =3D selinux_cred(current_=
cred());
> -       struct itimerval itimer;
>         u32 osid, sid;
> -       int rc, i;
> +       int rc;
>
>         osid =3D tsec->osid;
>         sid =3D tsec->sid;
> @@ -2569,11 +2568,8 @@ static void selinux_bprm_committed_creds(struct li=
nux_binprm *bprm)
>         rc =3D avc_has_perm(&selinux_state,
>                           osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, N=
ULL);
>         if (rc) {
> -               if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
> -                       memset(&itimer, 0, sizeof itimer);
> -                       for (i =3D 0; i < 3; i++)
> -                               do_setitimer(i, &itimer, NULL);
> -               }
> +               if (IS_ENABLED(CONFIG_POSIX_TIMERS))
> +                       clear_itimer();

Since you already define a no-op fallback for the case of
!IS_ENABLED(CONFIG_POSIX_TIMERS) in time.h, why not simply call
clear_itimer() unconditionally?

>                 spin_lock_irq(&current->sighand->siglock);
>                 if (!fatal_signal_pending(current)) {
>                         flush_sigqueue(&current->pending);
> --
> 2.20.0
>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

