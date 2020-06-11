Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA4C433DF
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DEE2072F
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwlt14V7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgFKMXW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgFKMXW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 08:23:22 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46069C08C5C1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 05:23:22 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a13so5212664ilh.3
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 05:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGOXDIsfxqAkhYPk1kYUcRo9ymlzrseiOCOiq6aI1x4=;
        b=qwlt14V7aPgiU+8f54HnLocEAXO11iHUsQv4R3QyHVognq9f32Q6NNbUzZqREB2f2g
         u5oIxvOITZVfdwMyYQVH+Po2Sj/4HPXxbVGFLsx0ObU4FGiyf+yGFj8GGw2bYen3KE3l
         DnX/FhYnnleklV7fMHqI6YxboGcvAxBHP5QU90IyLrEEwbPkg2isYsPQNf3rdQ0KwnGX
         3q9eXiybkkrDksC07dIuF8p0FSU6SHPzOh/olGV+Tpozj2AcLUB9BlqT2AQrlf+PTr7F
         14Aaf6I7x8OyMgHJwvLxo4AoBzz7yAe28MDjo47gnZ7iOQ5IiBb/0MtpzFAIbDFBOlzb
         LEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGOXDIsfxqAkhYPk1kYUcRo9ymlzrseiOCOiq6aI1x4=;
        b=jkOaKbGd0hKk/TYBzkC/S48DifOYVpjuAMcAO7zsCt4yVQaswO+p+6v9XHGgA27Hon
         kP3n7a4KfiRtY39sGLIlpQem3i2JlrhCpzWW0rzX73Km/uKa3JTw3ZO6zs1GjAnsiOlA
         pps33r76HjQHlocQ1R2mbsbvRkPTKr6A/L6PY6oA9M4VC7V0ewPccr+F7tAMJPoM3mEL
         RZZ/i3ky+xI8SsHdzYg3LdHhnA2KWWPY0GVFn1OtNbD883+zYCMQEiMwrQdGIIY3zKlh
         /awNVqRwcTVp7oetE0hEr4AWvWcnt2JuJWjs/3iML73zbWN5utvzl1p3y/mhd+WuUL41
         qW5Q==
X-Gm-Message-State: AOAM530szD8ohmafo3lSlUd8VN0Ib3FrTKL7k9ZqY9AaH6la16Dtb8B0
        E0THXaZNKLQ3DkxCeBq1QVg1N9ZTmXzMAWVmpFE=
X-Google-Smtp-Source: ABdhPJyAD4A2hCNnN73Z6fp0QGiUz2Dp6srhakA+ZVMsR3BNV7TIaU0J1FF6pzdkdK2oD0rFn7ULNC4TvhiS5Ct2GZE=
X-Received: by 2002:a92:b704:: with SMTP id k4mr7537730ili.129.1591878201385;
 Thu, 11 Jun 2020 05:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200520163421.27965-1-william.c.roberts@intel.com>
 <20200602191856.5040-1-william.c.roberts@intel.com> <20200602191856.5040-2-william.c.roberts@intel.com>
 <20200611120145.GA453655@localhost.localdomain> <CAEjxPJ4+0ct9ZmTxgX9zjer7OGzYY_bWRNMEF0PDe9emVx8SXA@mail.gmail.com>
 <CAFftDdokne7s_RW_XrYX21bgB5Eni38Leg5kxq3evpyrQw_qdQ@mail.gmail.com>
In-Reply-To: <CAFftDdokne7s_RW_XrYX21bgB5Eni38Leg5kxq3evpyrQw_qdQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 11 Jun 2020 07:23:10 -0500
Message-ID: <CAFftDdqrAhkkeVpm9vExEL8ecnTEz5yeqVj27Zs7PC5_1NVxdg@mail.gmail.com>
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

On Thu, Jun 11, 2020 at 7:15 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Jun 11, 2020 at 7:14 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Jun 11, 2020 at 8:03 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > >
> > > On Tue, Jun 02, 2020 at 02:18:56PM -0500, bill.c.roberts@gmail.com wrote:
> > > > From: William Roberts <william.c.roberts@intel.com>
> > > >
> > > > The current Travis CI runs the userspace tooling and libraries against
> > > > policy files, but cannot test against an SELinux enabled kernel. Thus,
> > > > some tests are not being done in the CI. Travis, unfortunately only
> > > > provides Ubuntu images, so in order to run against a modern distro with
> > > > SELinux in enforcing mode, we need to launch a KVM with something like
> > > > Fedora.
> > > >
> > > > This patch enables this support by launching a Fedora32 Cloud Image with
> > > > the SELinux userspace library passed on from the Travis clone, it then
> > > > builds and replaces the current SELinux bits on the Fedora32 image and
> > > > runs the SELinux testsuite.
> > > >
> > > > The cloud image run can be controlled with the TRAVIS env variable:
> > > > TRAVIS_CLOUD_IMAGE_VERSION. That variable takes the major and minor
> > > > version numbers in a colon delimited string, eg: "32:1.6".
> > > >
> > > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > >
> > > I pushed all Acked bugs to my fork's branch 3.1-rc2 and the travis jobs failed:
> > >
> > > https://travis-ci.org/github/bachradsusi/SELinuxProject-selinux/jobs/697177370
> > >
> > > ~~~
> > > #
> > > # Great we have a host running, ssh into it. We specify -o so
> > > # we don't get blocked on asking to add the servers key to
> > > # our known_hosts.
> > > #
> > > ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
> > > bash: /root/selinux/scripts/ci/fedora-test-runner.sh: No such file or directory
> > > The command "scripts/ci/travis-kvm-setup.sh" exited with 127.
> > >
> > > Done. Your build exited with 1.
> >
> > Hmm..worked for me.  I looked at your travis log file and it showed
> > the culprit: your repository is named SELinuxProject-selinux rather
> > than selinux and the script assumes it is named selinux.  So the
> > script just needs to be a little more general I guess.
>
> You guys are way faster than me, i'm still on my first cup of coffee.
> Let me send something that makes that a tad more general. Ill look
> into the travis variables.

I didn't see anything that just provides the name of the project, but basename
of $TRAVIS_BUILD_DIR i think will give us what we want, so I did:

diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
index 864dbac96a46..ceedaa6f4e27 100755
--- a/scripts/ci/travis-kvm-setup.sh
+++ b/scripts/ci/travis-kvm-setup.sh
@@ -120,6 +120,7 @@ fi
 # we don't get blocked on asking to add the servers key to
 # our known_hosts.
 #
-ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy"
"/root/selinux/$TEST_RUNNER"
+project_dir="$(basename "$TRAVIS_BUILD_DIR")"
+ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy"
"/root/$project_dir/$TEST_RUNNER"

 exit 0

----

Im testing now.
