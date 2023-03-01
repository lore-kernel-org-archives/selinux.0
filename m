Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC72C64ED6
	for <selinux@archiver.kernel.org>; Wed,  1 Mar 2023 15:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCAPWA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Mar 2023 10:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCAPWA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Mar 2023 10:22:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888A143913
        for <selinux@vger.kernel.org>; Wed,  1 Mar 2023 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677684074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZEp6MHblad6ejoH5fVY5NtiRPZfunn03mlMrfTGJAE=;
        b=Ol90OIDjORvsWGbIQeXX6TBgFMLHlsobXCzgqXtDBcQE5Ce+yIbdsnw/b4K5OygvjjHpBq
        PGS5JQABrK67+Yl6vtPg8m0w6tsBiEFNw19CbyIwDY8892LHDlYbebYXLmgz9iATgUSkPf
        RdnnjS/w50WOqMuTOwBsBeA0u2mpvYQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-kGE2mUIbPIyvlkZjG3bkyQ-1; Wed, 01 Mar 2023 10:21:13 -0500
X-MC-Unique: kGE2mUIbPIyvlkZjG3bkyQ-1
Received: by mail-pf1-f199.google.com with SMTP id a25-20020a056a001d1900b005e82b3dc9f4so7032512pfx.1
        for <selinux@vger.kernel.org>; Wed, 01 Mar 2023 07:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZEp6MHblad6ejoH5fVY5NtiRPZfunn03mlMrfTGJAE=;
        b=u4l8SZh1SWIYv/vJlk/euaIESMNm8LIUxWEusdFHL54hivbnw4niIm6jdMNfMOKqv/
         9o1qOZe7mrNlq2MRxldOpYHBjvNA0Stfs2pcmPclbG8D93I/SyzxFYw8gwPPSj06ushp
         rhbUk1n9U0jpCJvPEErJjeTkPkmoBK4+Q0klywYDMakHGuwommaqmiSXmfeLHgM8m6on
         gak+yRlNb6/J/cZ69YQv0UfQFIi4pfTpUZWUMMKJf4RUglSCK6sUV9QsJ0LaxjZFCFik
         ZRp1K/9hsv+lwbN1Ji8846tWouv8qbmvOTl/K1qSd72wqf/1fEnU6hl3IMy38EIa/ENI
         xZFQ==
X-Gm-Message-State: AO0yUKW8Y527ToFZjovDayA7sBKLEKePWY3LV3a87D7RKeUvI3MSM2zQ
        8tdxkbzAIXE0KYVIOuKe6Uitf5ad7nTElaNe8TCZuE9o9vrvVXFncX1nZ7RXIcrbMzBhruxyUY9
        XfwC8DkA9G5vEHiQeBrC8lKZlpGDy77vVdg==
X-Received: by 2002:a17:90a:94cc:b0:231:1d90:7b1b with SMTP id j12-20020a17090a94cc00b002311d907b1bmr2692425pjw.2.1677684072023;
        Wed, 01 Mar 2023 07:21:12 -0800 (PST)
X-Google-Smtp-Source: AK7set88bdaBSZ2PWL4y1PAKAMUccMATF9fF0P1iPUSrdd485waFykfYuFMxVpqOcDYBrs6/yiBTioPJNzcgho/11nk=
X-Received: by 2002:a17:90a:94cc:b0:231:1d90:7b1b with SMTP id
 j12-20020a17090a94cc00b002311d907b1bmr2692418pjw.2.1677684071573; Wed, 01 Mar
 2023 07:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20230228141247.626736-1-omosnace@redhat.com> <20230228141247.626736-2-omosnace@redhat.com>
 <CAHC9VhQnCchbn+kgZQ4cxUQKWCKd=H02R++qeKtqR75BpZETxQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQnCchbn+kgZQ4cxUQKWCKd=H02R++qeKtqR75BpZETxQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 1 Mar 2023 16:21:00 +0100
Message-ID: <CAFqZXNuRMpLm1bAij=6VjRk2Ax8XLe_qnnx1n2csVPu+cESQmQ@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/3] policy: make sure test_ibpkey_access_t can
 lock enough memory
To:     Paul Moore <paul@paul-moore.com>
Cc:     Chris PeBenito <pebenito@ieee.org>, selinux@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 28, 2023 at 5:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Feb 28, 2023 at 9:13=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > The ibv_create_cq() operation requires the caller to be able to lock
> > enough memory (RLIMIT_MEMLOCK). In some environments (such as RHEL-8)
> > the default resource limits may not be enough, requiring CAP_IPC_LOCK t=
o
> > go above the limit. To make sure the test works also under stricter
> > resource limits, grant CAP_IPC_LOCK to test_ibpkey_access_t.
> >
> > Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  policy/test_ibpkey.te | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
> > index 863ff16..97f0c3c 100644
> > --- a/policy/test_ibpkey.te
> > +++ b/policy/test_ibpkey.te
> > @@ -10,6 +10,8 @@ type test_ibpkey_access_t;
> >  testsuite_domain_type(test_ibpkey_access_t)
> >  typeattribute test_ibpkey_access_t ibpkeydomain;
> >
> > +allow test_ibpkey_access_t self:capability ipc_lock;
>
> FWIW, I brought this up back in 2019 and have been carrying a local
> selinux-testsuite patch for this ever since (it's the only way to get
> a clean run of the IB tests).  While it can be fixed in the
> selinux-testsuite policy, I believe this is a more general problem and
> should probably be fixed in refpol.
>
> https://lore.kernel.org/selinux/CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbgxS=
L1v04mouWw@mail.gmail.com/

I don't understand how you'd like this to be fixed in the system
policy... I don't think there is any policy interface that would
semantically match "any users of the SELinux IB hooks" or "callers of
ibv_create_cq()" that we could stick the capability rule into. At
least the testsuite policy doesn't use any such interface. Closest to
it would be dev_rw_infiniband_dev(), but that doesn't seem like the
right place.

Not to mention that the fact whether the capability is required or not
depends on the resource limits imposed on the process. If its
RLIMIT_MEMLOCK limit is sufficient, a process is perfectly able to
create the cq without CAP_IPC_LOCK. Automatically granting it to all
domains that use InfiniBand in some way "just in case" would
potentially grant it also to domains that don't actually need it,
violating the principle of least privilege.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

