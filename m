Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9185C433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 19:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4A3C207DA
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 19:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGzmG9Tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgHSTH2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgHSTH0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 15:07:26 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34502C061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 12:07:24 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o21so21943333oie.12
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6fdd9oTzfMFul8Hpp4Vyzs5lGC3VOBUQCp4MlViFTs=;
        b=ZGzmG9Tm3ohMMwTrfIT+cxBS0xurFgvSeSsy4YmCdBGRYLCUfi3oUK53UFhB08feIU
         MH8k+m/rqsCwfpFXkPMbkfmb34EgKGQnUpOlfAOAhQuvwU9AnaGv3cfujzrn6K/YofiQ
         QYH/pBhyFEnsWsUuWwAOpcrvoIaa1+xcK8XLOIH5DhWt/4WJ1TDpqiNkxq02bsZYFB7x
         DdgNVei7Deafo2ew60mlQRWIU1ymv+XtQ3Kz3o7FdKDE27ZgarlJax8uZJm3oKj1ReWL
         nz5jyDqKOAUt/si5Bg64gFU+Afn1fvAa5sl7Q0S/aCtooYp2yqHsSSqKImtmaBYBuZvm
         r17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6fdd9oTzfMFul8Hpp4Vyzs5lGC3VOBUQCp4MlViFTs=;
        b=iOZjfLtukP5OYOZcSLt7JQwToVO/gyml/UyEgxI8M1d7TwOMMu1U5+VECLYMisUBcx
         kkElkqb7h6oIzlKchpL2ZR26e38moVtH90njMTyx5VjSCzZqMmGU64p7qWUftkcM2y/O
         awa+l+zLPbfitxYGs4wfKk8Y95Wct4uOWfr9uChUe2A7K6XpsoYU8gBkImqmpFVBmgVj
         TIViezWB0orS46+7KSY00jJDo5au7uzlvA86+nrVblMdGpJpDr1x6qhDs2lMLMY7hFFG
         Yxk2ow6LNMEhmmLe+voluzuFgRKlf9ErpERWhyjuyP48P94LZcJcyWJvtFedtV94o+pt
         foGg==
X-Gm-Message-State: AOAM533PXb7dE059YCodlFCpq6xjtcbtVYsiRL3ThgOlJ4MpTDZvcXDH
        bKbX1VRPuCTzCPZt7jjp4lh2/KuNwsEClq74XMA=
X-Google-Smtp-Source: ABdhPJyu80YaCmY3jFUA5m08EBcycv5BCr2FBILzjlwGWjOvFK6Lt9Tt4g3ESHjfpUOk6BSBAMl9zVw6Ngd1Bd9TI78=
X-Received: by 2002:a54:4817:: with SMTP id j23mr4233111oij.140.1597864043987;
 Wed, 19 Aug 2020 12:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
 <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
 <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
 <CAHC9VhQ25U5PLYMAA1onNssWrOMYrUXhfJ_SRpzM1qNXeavfuw@mail.gmail.com> <20200819171459.GA57975@localhost.localdomain>
In-Reply-To: <20200819171459.GA57975@localhost.localdomain>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 19 Aug 2020 15:07:12 -0400
Message-ID: <CAEjxPJ54j6PD6oBMWj7wOVskJuUY=BLpMCkdmmqwrP1DGJ0VqA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 1:15 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> I've used kernel built without CONFIG_SECURITY_SELINUX_DISABLE from Ondrej's COPR
> https://copr.fedorainfracloud.org/coprs/omos/drop-selinux-disable/ and tried few
> scenarios:
>
> 1. selinux=0 on kernel command line
>
> everything works as expected
>
> 2. SELINUX=disabled in /etc/selinux/config
>
> system boots, userspace considers SELinux disabled, /sys/fs/selinux is not
> mounted. The only noticeable change
> is in process list:
>
> $ ps Z
> LABEL                               PID TTY      STAT   TIME COMMAND
> kernel                              552 pts/0    Ss     0:00 -bash
> kernel                              574 pts/0    R+     0:00 ps Z

Hmm...is ps checking is_selinux_enabled()?  Or just always reading
/proc/pid/attr/current (or calling getpidcon(3))?  Under what
conditions was it displaying "-" here before?

> If I get it right, SELinux is enabled but it's not initialized and SELinux
> checks are not processed - always return 0 as allowed. So there should be no
> real externally visible difference between selinux=0 and SELINUX=disabled

There are some corner cases currently, e.g. you can't remove the
security.selinux xattr if SELinux is enabled currently, and there are
various hardcoded error cases in the SELinux hook functions that could
potentially occur.  Beyond that there is the memory and runtime
overhead.  Getting people to start using selinux=0 if they want to
disable SELinux is definitely preferable.

> 3. no /etc/selinux/config
>
> SELinux is disabled in userspace but /sys/fs/selinux in mounted. It's due to
> check in libselinux which doesn't umount /sys/fs/selinux when there's no config
> file. Maybe this could be improved.

Yes, we should fix that.

> So I my findings are correct, it should be quite straight and easy change for
> the distribution. Even though userspace tools like anaconda and ansible still
> uses /etc/selinux/config to disable SELinux, it will have similar effect as
> selinux=0. But it doesn't mean we will not try to change them to set selinux=0.
>
>
> So I've started to compose Fedora Change proposal
>
> https://fedoraproject.org/wiki/SELinux/Changes/Disable_CONFIG_SECURITY_SELINUX_DISABLE
>
> It's not complete yet, but I believe it contains basic information. I'd
> appreciate if you can help me with text, phrases and references so that it would
> be easy to sell it as security feature to Fedora community :)

I'd simplify the Summary to be something like "Remove support for
SELinux runtime disable so that the LSM hooks can be hardened via
read-only-after-initialization protections.  Migrate users to using
selinux=0 if they want to disable SELinux."
