Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C65DC433EF
	for <selinux@archiver.kernel.org>; Fri,  1 Jul 2022 09:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiGAJ1N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbiGAJ0v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Jul 2022 05:26:51 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2E876965
        for <selinux@vger.kernel.org>; Fri,  1 Jul 2022 02:26:31 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h65so2740384oia.11
        for <selinux@vger.kernel.org>; Fri, 01 Jul 2022 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgIHzUm25ppwWhBnafZ0FEvF0E7MfJqpn9HJYdfXNIc=;
        b=l+pQ6UxFj4vK9uYR4qkR1dPYVrW3ptWmxfeWXljkCpmEXpz5SKtb0tcYiPPFp3TwUJ
         YxYtEwDsR64K55+lkS/3+ci0zvTdmiqoZITinNFicXucDRUzFvtigvjEsKc2djTqfX0J
         uzHegUsUmz3Ign6HNlFQIZTSwuR/QUUvNDAMorU+zWOt7m7nxU/aVa/Mgr1yZpJXnv6U
         9srALi797SYp9VA4kbtjGUT7ux+dcYfu1+NTcE1K2wC79928x5MW6ddVbV5VbAZdiBbS
         FaVyCIC//Bkxs25dsJcKGC3hV909RSRkKB4Gyq5GoCiqapmRz4JxI8B9af1pBrExPxEO
         xGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgIHzUm25ppwWhBnafZ0FEvF0E7MfJqpn9HJYdfXNIc=;
        b=3vthc2iqL6rM2th7rV3ItWBfBjdrfr+xyhitFG41VeWrBpVquV0SfBb+RaPgkoO5w/
         c91FGjND/pEB6Pvc1YlNIBCcEMdg4iWH2WLKtFfhrgbyt+FK3R1TPByZZDDg72JwWOKc
         al3If3FlAfv7Mhu0lUQhPbTh9sU5RXnnRnTA7jfZr2eTLYhZmOWNhYKkeIL39QTcw2kT
         WFsyVbz0sm3JXtTgw1ewvXVlIyQhTANE8xPue0uBTN5yHdd5eCtR3xfhW1sfE8xrwm7w
         ddU97z4L5/u1XDnfnGHXbcX/LzhfKZy7yXtxXx3B7egwsNWujMKjaPwRPlvB+EFS8nws
         jZ+g==
X-Gm-Message-State: AJIora/pzcY0nmtaJ829JsXlmmcQVb81EEpRB8kR88MJCd0b1hDB2CiW
        NmY+9TzkaOAGpEBxuNPp+mg1hJdXzoac/L4pQrY=
X-Google-Smtp-Source: AGRyM1uf+o9XYSg/INpV2lWVIGevxhNP2nsaZ2jOFWxyBcAnGLsT83DWXJq/E4bjxnGtcbWeLWXBGadiCQWiU3Y9Zgc=
X-Received: by 2002:a05:6808:1509:b0:336:77e:d668 with SMTP id
 u9-20020a056808150900b00336077ed668mr3478196oiw.71.1656667590559; Fri, 01 Jul
 2022 02:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7=mP2eJaq2BfO3y0VnwUJaY2cS2p=HZMN71z1pKjzaT0Eg@mail.gmail.com>
 <CA+EEuAiG1B8i1xTt+K1QO1UPgynZVYiRkiLTY6nTVi9Rm4uA1A@mail.gmail.com>
In-Reply-To: <CA+EEuAiG1B8i1xTt+K1QO1UPgynZVYiRkiLTY6nTVi9Rm4uA1A@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 1 Jul 2022 11:26:19 +0200
Message-ID: <CAJ2a_De9=CoyWS=EEgWHpbzoXK6O1H21Lwf_hMFfFUtGBMUfJg@mail.gmail.com>
Subject: Re: What is "fscon" statement in a base policy?
To:     Karl MacMillan <karl@bigbadwolfsecurity.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 1 Jul 2022 at 03:58, Karl MacMillan <karl@bigbadwolfsecurity.com> wrote:
>
> Hi Nicolas,
>
> I believe these are described on page 19 of the old "A Security Policy
> Configuration for the Security-Enhanced Linux" [1].

Quote from 7.2 File System Contexts:

    Currently, this configuration is unused.

> There is still support for these in the kernel [2], so it seems unwise to me to drop
> them even if they are not used in policies.

git log -S OCON_FS lists

    335c818c5a7a can: mcp251xfd: move chip FIFO init into separate file
    55e5b97f003e can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN
    875347fe5756 can: mcp25xxfd: add regmap infrastructure
    cee74f47a6ba SELinux: allow userspace to read policy back out of the kernel
    1da177e4c3f4 (tag: v2.6.12-rc2) Linux-2.6.12-rc2

and grepping the source shows

    $ grep -Rw OCON_FS security/selinux/
    security/selinux/ss/policydb.h:#define OCON_FS          1 /*
unlabeled file systems */
    security/selinux/ss/policydb.c: if (i == OCON_ISID || i == OCON_FS ||
    security/selinux/ss/policydb.c:                 case OCON_FS:
    security/selinux/ss/policydb.c:                 case OCON_FS:

OCON_FS is only used while parsing a policy and on cleanup, but there
is no actual usage, e.g. for OCON_FSUSE:

    security/selinux/ss/services.c: c = policydb->ocontexts[OCON_FSUSE];

So for me fscon is not used at all.

> Good catch though!
>
> Karl
>
> 1. https://media.defense.gov/2021/Jul/29/2002815735/-1/-1/0/SELINUX-SECURITY-POLICY-CONFIGURATION-REPORT.PDF
> 2. https://github.com/torvalds/linux/blob/master/security/selinux/ss/policydb.h#L228
>
> On Thu, Jun 30, 2022 at 5:05 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Hello,
> >
> > While studying some malloc calls in libsepol and checkpolicy, I
> > stumbled upon function define_fs_context(), which allocates a
> > fixed-size buffer in
> > https://github.com/SELinuxProject/selinux/blob/956bda08f6183078f13b70f6aa27d0529a3ec20a/checkpolicy/policy_define.c#L4631-L4637
> >
> >     newc->u.name = (char *)malloc(6);
> >     if (!newc->u.name) {
> >         yyerror("out of memory");
> >         free(newc);
> >         return -1;
> >     }
> >     sprintf(newc->u.name, "%02x:%02x", major, minor);
> >
> > As major and minor are unsigned int (so 32-bit integers) without any
> > value checking, there seems to be a possible heap buffer overflow
> > issue. This function is called when parsing a fscon statement in a
> > "base" policy. So I copied tmp/base.conf from a build of the Reference
> > Policy, added "fscon 1000 1000 system_u:object_r:unlabeled_t
> > system_u:object_r:unlabeled_t" right after "sid security
> > system_u:object_r:security_t" (the order of the statements matters),
> > and ran:
> >
> >     $ checkpolicy -o test.pol base.conf
> >     *** buffer overflow detected ***: terminated
> >     Aborted (core dumped)
> >
> > For whatever it's worth, the stack trace of this abort tells that the
> > buffer overflow occurs in a call to __sprintf_chk(): my gcc compiler
> > seems to be "smart enough" to find out that the size of newc->u.name
> > was 6, and it replaced sprintf() with __sprintf_chk() to ensure that
> > the buffer was not written past its bounds.
> >
> > Now, I can submit a patch to fix this issue, for example by replacing
> > malloc()+sprintf() with asprintf() and by checking that major and
> > minor are below 256. But before doing so, I was wondering: what is
> > this fscon syntax? I have never encountered it, did not find any
> > policy using it, and I am wondering whether we could instead drop its
> > support and remove function define_fs_context() from checkpolicy.
> >
> > Thanks,
> > Nicolas
> >
