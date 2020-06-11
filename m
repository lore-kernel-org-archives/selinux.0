Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5B0C433DF
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9357620760
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkRHInpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgFKMNh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:13:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22659 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727769AbgFKMNg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 08:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591877615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0hiLrEUjhDnfNPxbZlUvvYkYwePJEaiEMrr2RrPWnuQ=;
        b=SkRHInpJ/o3J2FzfPZcDPGLREdT9KFPdttgxqcopZEiHyBEmQ/8HySTA2RuIbJDmrxNcfs
        h0/4/dtHgNxCteuthJ8m8BzTFYPCJVTXJGz55aDHniqKw1N2QXE5vEKuaYaxLMUXsHCw0G
        V7ZWKm6GDI/Vt9VA6mLATCBfaE5RqzI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-A2znzicjOcuBiY6bg6_Ymg-1; Thu, 11 Jun 2020 08:13:33 -0400
X-MC-Unique: A2znzicjOcuBiY6bg6_Ymg-1
Received: by mail-lj1-f200.google.com with SMTP id g11so965783lja.15
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 05:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hiLrEUjhDnfNPxbZlUvvYkYwePJEaiEMrr2RrPWnuQ=;
        b=qT8YBa9QtOgVC1kGiqnMFFHL5tn+75KYYFrZu3KO5HviyfilEt+Np1qmBL7nCpzayF
         hyfwGEjvzKFedANvu/9M6kaxpGnniI/CKRtZs+j2jOYrb1AGIMzV7BxdrI0K3NwlfpeQ
         zAFzQKssztaW8pRpaxkYvanS9Odul81xi+Q0EN2YqLOuAihphK16KUzG/0j/Io/MrvmC
         zLd/cxbd0k2syOPTJNuNLPrPkNq+aUbQFYfBFU4CCeVbJpAyuY8CiaG518amjynwOoiN
         wPBWevNrmXEcZrhW5g3Q/jBc9bX1NlvWl2KpJEMdnrdlb22zsaCliprffv4CBdffX2GN
         GAxA==
X-Gm-Message-State: AOAM532gy3hvww5CDMYfaeb93vW+ImwvJxixIAFLA/5fXYoNX0bgZcj3
        d5Fm5QCMLib7M1A2plKiCJ+x/YRAx1NvcxD2DPPS7GyEP+ste9dnvyV5XEjgqLlDcx443Rd/xJI
        icvLDVQWqV0zxW035SxYdUxMXQVeC6G03Vg==
X-Received: by 2002:a05:651c:30e:: with SMTP id a14mr4416540ljp.311.1591877611636;
        Thu, 11 Jun 2020 05:13:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO9Ug2Lasf0eCm7Ip2Oabx5FlG/uKc9IOSbvt8Q3HtYJlDs6WF6l2haluNTSKnhY0joghLvpq7AwvYuxV7Edg=
X-Received: by 2002:a05:651c:30e:: with SMTP id a14mr4416525ljp.311.1591877611379;
 Thu, 11 Jun 2020 05:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200520163421.27965-1-william.c.roberts@intel.com>
 <20200602191856.5040-1-william.c.roberts@intel.com> <20200602191856.5040-2-william.c.roberts@intel.com>
 <20200611120145.GA453655@localhost.localdomain>
In-Reply-To: <20200611120145.GA453655@localhost.localdomain>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 11 Jun 2020 14:13:20 +0200
Message-ID: <CAFqZXNvnkVkx68SdHa18x_eSpA1Kc6Dq4aiGCoMdFZz0Z=4Wsg@mail.gmail.com>
Subject: Re: [PATCH v3] ci: run SELinux kernel test suite
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 11, 2020 at 2:02 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> On Tue, Jun 02, 2020 at 02:18:56PM -0500, bill.c.roberts@gmail.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > The current Travis CI runs the userspace tooling and libraries against
> > policy files, but cannot test against an SELinux enabled kernel. Thus,
> > some tests are not being done in the CI. Travis, unfortunately only
> > provides Ubuntu images, so in order to run against a modern distro with
> > SELinux in enforcing mode, we need to launch a KVM with something like
> > Fedora.
> >
> > This patch enables this support by launching a Fedora32 Cloud Image with
> > the SELinux userspace library passed on from the Travis clone, it then
> > builds and replaces the current SELinux bits on the Fedora32 image and
> > runs the SELinux testsuite.
> >
> > The cloud image run can be controlled with the TRAVIS env variable:
> > TRAVIS_CLOUD_IMAGE_VERSION. That variable takes the major and minor
> > version numbers in a colon delimited string, eg: "32:1.6".
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> I pushed all Acked bugs to my fork's branch 3.1-rc2 and the travis jobs failed:
>
> https://travis-ci.org/github/bachradsusi/SELinuxProject-selinux/jobs/697177370
>
> ~~~
> #
> # Great we have a host running, ssh into it. We specify -o so
> # we don't get blocked on asking to add the servers key to
> # our known_hosts.
> #
> ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
> bash: /root/selinux/scripts/ci/fedora-test-runner.sh: No such file or directory
> The command "scripts/ci/travis-kvm-setup.sh" exited with 127.
>
> Done. Your build exited with 1.
> ~~~

That'll be because your fork is named "SELinuxProject-selinux" instead
of "selinux". Or rather because the CI script hardcodes the project
name of "selinux".

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

