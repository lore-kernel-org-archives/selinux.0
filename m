Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3B8C433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9873B20760
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olqxrdiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFKMPj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFKMPj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 08:15:39 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84ACC08C5C1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 05:15:38 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s18so6047782ioe.2
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gg6AOuEeuTkF5FquUFT4PmHGJniuZXaBkU15qxH9284=;
        b=olqxrdiNm1FPFggmobcgXFdHsZhnVb+k7ZdcYCwa0qglTUCYzqIi9xMnbQziCfwJ24
         oQbEl5jR50mF4HJG9A29wMU7BxncjhcNp2mqChtEK7cQMeB45qOIsZPUlVQs9SvNH/fw
         HWfGUT0SCHeLSmwaFB4nM2oPi8jntavfQQwEHx4wHLto1QM05735/l0CNOL202yoZVm0
         6ZKw6lpPB028o+5K71P22R7qDPgJyvpYWc945NmUra5gdP9WwGXgyv+J7w0ST5FazrdL
         llbO1+pD/1N3C4k6Be5p1BGdO+eJWU5q9nqYJc3PUe84VRiO4baaG7h/11AN6Nflhwmo
         928w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gg6AOuEeuTkF5FquUFT4PmHGJniuZXaBkU15qxH9284=;
        b=L1t0300Tp5Xi/wvowtZGQkBUvmnqeSQMP21YwxI4AVmDrQcZq2wMNMDhzGKixV85bg
         ZBKLv3ToW3a39HCwbwAcnEWzEsf4BDouVU58icrDsNkydDPW0qTIzcqn2pKtBxOS1pyd
         pusRC61+XG+rreZjPW2ozzpMyiDE33CkrYhHN7JpPCvfK8MEcsHEUqd3T6BhxY8lLdRP
         +iPwYtBmUPQrvpDeG5FWwV9cs93Ofbho5zhukoCuhgFCOA5rFiwOWnwNEJMmNAizvtNp
         V4H/qHG2rV+uh9rxJX4jauRVHy/S4CJllOsXAkFlilwN6hULM91jAIouZOl+IlM2bxBl
         kHNQ==
X-Gm-Message-State: AOAM530kyUM5d5x+Opkmaltyi4ehK+ZwYBcbnlSfbQvHU0e1yZvIJvSx
        JBoh3kjZUbqZ23E4Vtgr1aU78sdxtBPtSmlzVuw=
X-Google-Smtp-Source: ABdhPJySumVN/7yipsb+/XkB7wJx++Cewk7tEQ7/SOVKier2Vrsr1m2z++PTeKk5Jnd3KsBctj1eC8iFw92Jids85h0=
X-Received: by 2002:a6b:5f06:: with SMTP id t6mr7920432iob.88.1591877737904;
 Thu, 11 Jun 2020 05:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200520163421.27965-1-william.c.roberts@intel.com>
 <20200602191856.5040-1-william.c.roberts@intel.com> <20200602191856.5040-2-william.c.roberts@intel.com>
 <20200611120145.GA453655@localhost.localdomain> <CAEjxPJ4+0ct9ZmTxgX9zjer7OGzYY_bWRNMEF0PDe9emVx8SXA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4+0ct9ZmTxgX9zjer7OGzYY_bWRNMEF0PDe9emVx8SXA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 11 Jun 2020 07:15:26 -0500
Message-ID: <CAFftDdokne7s_RW_XrYX21bgB5Eni38Leg5kxq3evpyrQw_qdQ@mail.gmail.com>
Subject: Re: [PATCH v3] ci: run SELinux kernel test suite
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 11, 2020 at 7:14 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 11, 2020 at 8:03 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > On Tue, Jun 02, 2020 at 02:18:56PM -0500, bill.c.roberts@gmail.com wrote:
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > The current Travis CI runs the userspace tooling and libraries against
> > > policy files, but cannot test against an SELinux enabled kernel. Thus,
> > > some tests are not being done in the CI. Travis, unfortunately only
> > > provides Ubuntu images, so in order to run against a modern distro with
> > > SELinux in enforcing mode, we need to launch a KVM with something like
> > > Fedora.
> > >
> > > This patch enables this support by launching a Fedora32 Cloud Image with
> > > the SELinux userspace library passed on from the Travis clone, it then
> > > builds and replaces the current SELinux bits on the Fedora32 image and
> > > runs the SELinux testsuite.
> > >
> > > The cloud image run can be controlled with the TRAVIS env variable:
> > > TRAVIS_CLOUD_IMAGE_VERSION. That variable takes the major and minor
> > > version numbers in a colon delimited string, eg: "32:1.6".
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> >
> > I pushed all Acked bugs to my fork's branch 3.1-rc2 and the travis jobs failed:
> >
> > https://travis-ci.org/github/bachradsusi/SELinuxProject-selinux/jobs/697177370
> >
> > ~~~
> > #
> > # Great we have a host running, ssh into it. We specify -o so
> > # we don't get blocked on asking to add the servers key to
> > # our known_hosts.
> > #
> > ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
> > bash: /root/selinux/scripts/ci/fedora-test-runner.sh: No such file or directory
> > The command "scripts/ci/travis-kvm-setup.sh" exited with 127.
> >
> > Done. Your build exited with 1.
>
> Hmm..worked for me.  I looked at your travis log file and it showed
> the culprit: your repository is named SELinuxProject-selinux rather
> than selinux and the script assumes it is named selinux.  So the
> script just needs to be a little more general I guess.

You guys are way faster than me, i'm still on my first cup of coffee.
Let me send something that makes that a tad more general. Ill look
into the travis variables.
